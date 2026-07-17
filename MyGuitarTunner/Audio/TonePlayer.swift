//
//  TonePlayer.swift
//  MyGuitarTunner
//

import AVFoundation

/// Plays a short reference sine tone at a given frequency, so a user can hear what a
/// string should sound like when they tap it.
@MainActor
final class TonePlayer {
    private let engine = AVAudioEngine()
    private var sourceNode: AVAudioSourceNode?
    private var stopTask: Task<Void, Never>?
    private var onFinish: (() -> Void)?

    func play(frequency: Double, duration: TimeInterval = 1.5, onFinish: (() -> Void)? = nil) {
        stop()

        #if os(iOS)
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(.playback, mode: .default, options: [])
        try? session.setActive(true)
        #endif

        let format = engine.outputNode.inputFormat(forBus: 0)
        let sampleRate = format.sampleRate
        guard sampleRate > 0 else { return }
        let oscillator = ToneOscillator()

        let node = AVAudioSourceNode { _, _, frameCount, audioBufferList in
            Self.render(
                oscillator: oscillator,
                frequency: frequency,
                sampleRate: sampleRate,
                frameCount: frameCount,
                audioBufferList: audioBufferList
            )
        }

        engine.attach(node)
        engine.connect(node, to: engine.outputNode, format: format)

        do {
            try engine.start()
        } catch {
            engine.detach(node)
            return
        }

        sourceNode = node
        self.onFinish = onFinish

        stopTask = Task { [weak self] in
            try? await Task.sleep(for: .seconds(duration))
            guard !Task.isCancelled else { return }
            self?.stop()
        }
    }

    func stop() {
        stopTask?.cancel()
        stopTask = nil

        let finish = onFinish
        onFinish = nil

        if let sourceNode {
            engine.stop()
            engine.disconnectNodeOutput(sourceNode)
            engine.detach(sourceNode)
            self.sourceNode = nil
        }

        finish?()
    }

    /// Weight of each harmonic above the fundamental, roughly a sawtooth's falloff.
    /// Low guitar strings (E2 82Hz, A2 110Hz) barely register as a bare sine on a phone
    /// speaker; layering in harmonics keeps the pitch clearly audible even where the
    /// fundamental itself is weak.
    private static let harmonicWeights: [Float] = [1.0, 0.5, 0.33, 0.22]
    private static let masterGain: Float = 0.8

    /// Renders a harmonic-enriched tone into the buffer. Runs on the real-time audio
    /// thread, so it touches only the plain `ToneOscillator` box, never actor-isolated state.
    nonisolated private static func render(
        oscillator: ToneOscillator,
        frequency: Double,
        sampleRate: Double,
        frameCount: AVAudioFrameCount,
        audioBufferList: UnsafeMutablePointer<AudioBufferList>
    ) -> OSStatus {
        let phaseIncrement = 2 * Double.pi * frequency / sampleRate
        let ablPointer = UnsafeMutableAudioBufferListPointer(audioBufferList)
        let totalWeight = harmonicWeights.reduce(0, +)
        var phase = oscillator.phase

        for frame in 0..<Int(frameCount) {
            var sum: Float = 0
            for (index, weight) in harmonicWeights.enumerated() {
                let harmonic = Double(index + 1)
                sum += Float(sin(phase * harmonic)) * weight
            }
            let sample = sum * masterGain / totalWeight

            phase += phaseIncrement
            if phase > 2 * Double.pi { phase -= 2 * Double.pi }
            for buffer in ablPointer {
                let samples = buffer.mData?.assumingMemoryBound(to: Float.self)
                samples?[frame] = sample
            }
        }

        oscillator.phase = phase
        return noErr
    }
}

/// Plain mutable box for the oscillator phase, kept outside actor isolation since it's
/// mutated from the real-time audio render thread.
private final class ToneOscillator: @unchecked Sendable {
    var phase: Double = 0
}
