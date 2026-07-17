//
//  TunerViewModel.swift
//  MyGuitarTunner
//

import Combine
import Foundation

@MainActor
final class TunerViewModel: ObservableObject {
    @Published private(set) var reading: TunerReading?
    @Published private(set) var permissionDenied = false
    @Published private(set) var detectedString: GuitarString?
    @Published private(set) var selectedString: GuitarString?

    private let pitchDetector = PitchDetector()
    private var cancellables = Set<AnyCancellable>()

    init() {
        pitchDetector.$frequency
            .sink { [weak self] frequency in
                self?.handle(frequency: frequency)
            }
            .store(in: &cancellables)

        pitchDetector.$permissionDenied
            .assign(to: &$permissionDenied)
    }

    func start() {
        pitchDetector.start()
    }

    func stop() {
        pitchDetector.stop()
    }

    /// Tapping the currently selected string deselects it, returning to nearest-note detection.
    func selectString(_ string: GuitarString) {
        selectedString = (selectedString == string) ? nil : string
    }

    private func handle(frequency: Double?) {
        detectedString = frequency.flatMap { GuitarString.nearest(to: $0) }

        guard let frequency else {
            reading = nil
            return
        }

        if let selectedString {
            reading = NoteMapper.reading(for: frequency, target: selectedString)
        } else {
            reading = NoteMapper.reading(for: frequency)
        }
    }
}
