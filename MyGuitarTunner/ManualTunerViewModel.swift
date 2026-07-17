//
//  ManualTunerViewModel.swift
//  MyGuitarTunner
//

import Combine
import Foundation

/// Drives manual mode: tapping a string plays its reference tone directly, no
/// microphone involved.
@MainActor
final class ManualTunerViewModel: ObservableObject {
    @Published private(set) var playingString: GuitarString?

    private let tonePlayer = TonePlayer()

    func play(_ string: GuitarString) {
        playingString = string
        tonePlayer.play(frequency: string.frequency) { [weak self] in
            if self?.playingString == string {
                self?.playingString = nil
            }
        }
    }

    func stop() {
        tonePlayer.stop()
    }
}
