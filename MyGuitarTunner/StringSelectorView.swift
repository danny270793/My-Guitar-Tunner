//
//  StringSelectorView.swift
//  MyGuitarTunner
//

import SwiftUI

/// Row of the six guitar strings (low E to high E). The string closest to the currently
/// detected pitch highlights automatically; the row is display-only, not interactive.
struct StringSelectorView: View {
    let strings: [GuitarString]
    let detected: GuitarString?

    var body: some View {
        GlassEffectContainer(spacing: 12) {
            HStack(spacing: 12) {
                ForEach(strings) { string in
                    StringBadge(string: string, isDetected: string == detected)
                }
            }
        }
    }
}

private struct StringBadge: View {
    let string: GuitarString
    let isDetected: Bool

    var body: some View {
        Text(Strings.note(string.name))
            .font(.title3.bold())
            .frame(width: 48, height: 48)
            .foregroundStyle(isDetected ? Color.white : Color.primary)
            .glassEffect(
                isDetected ? .regular.tint(.green) : .regular,
                in: .circle
            )
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: isDetected)
    }
}

#Preview {
    StringSelectorView(
        strings: StandardTuning.strings,
        detected: StandardTuning.strings[2]
    )
    .padding(40)
}
