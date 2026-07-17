//
//  GuitarString.swift
//  MyGuitarTunner
//

import Foundation

/// One string of a standard-tuned guitar.
struct GuitarString: Identifiable, Equatable, Hashable {
    let name: String
    let octave: Int
    let frequency: Double

    var id: String { "\(name)\(octave)" }
}

enum StandardTuning {
    /// Low E to high E, matching how strings are laid out on the instrument.
    static let strings: [GuitarString] = [
        GuitarString(name: "E", octave: 2, frequency: 82.41),
        GuitarString(name: "A", octave: 2, frequency: 110.00),
        GuitarString(name: "D", octave: 3, frequency: 146.83),
        GuitarString(name: "G", octave: 3, frequency: 196.00),
        GuitarString(name: "B", octave: 3, frequency: 246.94),
        GuitarString(name: "E", octave: 4, frequency: 329.63),
    ]
}

extension GuitarString {
    /// The string whose frequency is perceptually closest to `frequency` (compared on a log scale, matching pitch perception).
    static func nearest(to frequency: Double, in strings: [GuitarString] = StandardTuning.strings) -> GuitarString? {
        guard frequency > 0 else { return nil }
        return strings.min { lhs, rhs in
            abs(log2(lhs.frequency / frequency)) < abs(log2(rhs.frequency / frequency))
        }
    }
}
