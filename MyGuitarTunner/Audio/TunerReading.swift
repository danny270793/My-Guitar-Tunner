//
//  TunerReading.swift
//  MyGuitarTunner
//

import Foundation

/// A snapshot of the detected pitch mapped to the nearest chromatic note.
struct TunerReading: Equatable {
    let noteName: String
    let octave: Int
    let frequency: Double
    let targetFrequency: Double
    /// Deviation from the nearest note, in cents. Negative is flat, positive is sharp.
    let cents: Double

    /// Cents within this threshold are considered in tune.
    static let inTuneThreshold: Double = 5

    var isInTune: Bool { abs(cents) <= Self.inTuneThreshold }
    var isFlat: Bool { cents < -Self.inTuneThreshold }
    var isSharp: Bool { cents > Self.inTuneThreshold }
}

enum NoteMapper {
    private static let noteNames = ["C", "C♯", "D", "D♯", "E", "F", "F♯", "G", "G♯", "A", "A♯", "B"]

    /// Maps a detected frequency to the nearest chromatic note using equal temperament
    /// (A4 = 440 Hz by default), returning how far off the pitch is in cents.
    static func reading(for frequency: Double, referenceA4: Double = 440) -> TunerReading? {
        guard frequency > 0 else { return nil }

        let midi = 69 + 12 * log2(frequency / referenceA4)
        let roundedMidi = midi.rounded()
        let noteIndex = (Int(roundedMidi) % 12 + 12) % 12
        let octave = Int(roundedMidi) / 12 - 1
        let targetFrequency = referenceA4 * pow(2, (roundedMidi - 69) / 12)
        let cents = (midi - roundedMidi) * 100

        return TunerReading(
            noteName: noteNames[noteIndex],
            octave: octave,
            frequency: frequency,
            targetFrequency: targetFrequency,
            cents: cents
        )
    }
}
