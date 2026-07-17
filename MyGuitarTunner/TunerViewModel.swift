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

    private let pitchDetector = PitchDetector()
    private var cancellables = Set<AnyCancellable>()

    init() {
        pitchDetector.$frequency
            .map { frequency in
                frequency.flatMap { NoteMapper.reading(for: $0) }
            }
            .assign(to: &$reading)

        pitchDetector.$permissionDenied
            .assign(to: &$permissionDenied)
    }

    func start() {
        pitchDetector.start()
    }

    func stop() {
        pitchDetector.stop()
    }
}
