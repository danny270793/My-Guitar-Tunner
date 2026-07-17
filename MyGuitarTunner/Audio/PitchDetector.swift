//
//  PitchDetector.swift
//  MyGuitarTunner
//

import AVFoundation
import Accelerate
import Combine

/// Listens to the microphone and publishes the detected fundamental frequency,
/// using autocorrelation over the guitar's fundamental frequency range.
@MainActor
final class PitchDetector: ObservableObject {
    @Published private(set) var frequency: Double?
    @Published private(set) var permissionDenied = false

    private let audioEngine = AVAudioEngine()
    private let minFrequency: Double = 70
    private let maxFrequency: Double = 1_000
    private let minRMS: Float = 0.01
    private var isRunning = false

    func start() {
        guard !isRunning else { return }

        AVCaptureDevice.requestAccess(for: .audio) { [weak self] granted in
            Task { @MainActor in
                guard let self else { return }
                if granted {
                    self.startEngine()
                } else {
                    self.permissionDenied = true
                }
            }
        }
    }

    func stop() {
        guard isRunning else { return }
        isRunning = false
        audioEngine.inputNode.removeTap(onBus: 0)
        audioEngine.stop()
        #if os(iOS)
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        #endif
        frequency = nil
    }

    private func startEngine() {
        #if os(iOS)
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.record, mode: .measurement, options: [])
            try session.setActive(true)
        } catch {
            permissionDenied = true
            return
        }
        #endif

        let inputNode = audioEngine.inputNode
        let format = inputNode.inputFormat(forBus: 0)
        guard format.sampleRate > 0 else { return }

        inputNode.removeTap(onBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 4_096, format: format) { [weak self] buffer, _ in
            guard let self else { return }
            let detected = Self.detectFrequency(
                in: buffer,
                sampleRate: format.sampleRate,
                minFrequency: self.minFrequency,
                maxFrequency: self.maxFrequency,
                minRMS: self.minRMS
            )
            Task { @MainActor in
                self.frequency = detected
            }
        }

        do {
            try audioEngine.start()
            isRunning = true
        } catch {
            inputNode.removeTap(onBus: 0)
        }
    }

    /// Estimates the fundamental frequency via normalized autocorrelation with
    /// parabolic interpolation around the strongest peak.
    nonisolated private static func detectFrequency(
        in buffer: AVAudioPCMBuffer,
        sampleRate: Double,
        minFrequency: Double,
        maxFrequency: Double,
        minRMS: Float
    ) -> Double? {
        guard let channelData = buffer.floatChannelData else { return nil }
        let frameCount = Int(buffer.frameLength)
        guard frameCount > 1 else { return nil }
        let samples = UnsafeBufferPointer(start: channelData[0], count: frameCount)

        var rms: Float = 0
        vDSP_rmsqv(samples.baseAddress!, 1, &rms, vDSP_Length(frameCount))
        guard rms > minRMS else { return nil }

        let minLag = max(1, Int(sampleRate / maxFrequency))
        let maxLag = min(Int(sampleRate / minFrequency), frameCount - 2)
        guard maxLag > minLag + 1, let baseAddress = samples.baseAddress else { return nil }

        var autocorrelation = [Float](repeating: 0, count: maxLag + 1)
        for lag in 0...maxLag {
            var sum: Float = 0
            vDSP_dotpr(baseAddress, 1, baseAddress + lag, 1, &sum, vDSP_Length(frameCount - lag))
            autocorrelation[lag] = sum
        }
        guard autocorrelation[0] > 0 else { return nil }

        var bestLag = -1
        var bestValue: Float = 0
        for lag in minLag..<maxLag {
            let value = autocorrelation[lag]
            if value > autocorrelation[lag - 1], value > autocorrelation[lag + 1], value > bestValue {
                bestValue = value
                bestLag = lag
            }
        }
        guard bestLag > 0, bestValue / autocorrelation[0] > 0.3 else { return nil }

        let y0 = autocorrelation[bestLag - 1]
        let y1 = autocorrelation[bestLag]
        let y2 = autocorrelation[bestLag + 1]
        let denominator = y0 - 2 * y1 + y2
        let shift = denominator != 0 ? 0.5 * (y0 - y2) / denominator : 0
        let refinedLag = Double(bestLag) + Double(shift)
        guard refinedLag > 0 else { return nil }

        let detectedFrequency = sampleRate / refinedLag
        guard detectedFrequency >= minFrequency, detectedFrequency <= maxFrequency else { return nil }
        return detectedFrequency
    }
}
