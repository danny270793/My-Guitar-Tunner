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

    private func handle(frequency: Double?) {
        detectedString = frequency.flatMap { GuitarString.nearest(to: $0) }
        reading = frequency.flatMap { NoteMapper.reading(for: $0) }
    }
}
