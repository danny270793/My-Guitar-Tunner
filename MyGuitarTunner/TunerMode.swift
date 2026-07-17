//
//  TunerMode.swift
//  MyGuitarTunner
//

import Foundation

/// Auto tunes continuously from the microphone; manual just plays reference tones on tap.
enum TunerMode: String, CaseIterable, Identifiable, Hashable {
    case auto
    case manual

    var id: String { rawValue }
}
