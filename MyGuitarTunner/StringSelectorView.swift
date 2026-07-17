//
//  StringSelectorView.swift
//  MyGuitarTunner
//

import SwiftUI

/// Row of the six guitar strings (low E to high E). Tapping one locks the tuner onto that
/// string's target pitch; the string closest to the currently detected pitch is highlighted too.
struct StringSelectorView: View {
    let strings: [GuitarString]
    let selected: GuitarString?
    let detected: GuitarString?
    let onSelect: (GuitarString) -> Void

    var body: some View {
        GlassEffectContainer(spacing: 12) {
            HStack(spacing: 12) {
                ForEach(strings) { string in
                    StringButton(
                        string: string,
                        isSelected: string == selected,
                        isDetected: string == detected,
                        action: { onSelect(string) }
                    )
                }
            }
        }
    }
}

private struct StringButton: View {
    let string: GuitarString
    let isSelected: Bool
    let isDetected: Bool
    let action: () -> Void

    private var isHighlighted: Bool { isSelected || isDetected }

    var body: some View {
        Button(action: action) {
            Text(string.name)
                .font(.title3.bold())
                .frame(width: 48, height: 48)
                .foregroundStyle(isHighlighted ? Color.white : Color.primary)
        }
        .buttonStyle(.plain)
        .glassEffect(
            isHighlighted ? .regular.tint(.green).interactive() : .regular.interactive(),
            in: .circle
        )
        .animation(.spring(response: 0.25, dampingFraction: 0.7), value: isHighlighted)
    }
}

#Preview {
    StringSelectorView(
        strings: StandardTuning.strings,
        selected: StandardTuning.strings[2],
        detected: StandardTuning.strings[2],
        onSelect: { _ in }
    )
    .padding(40)
}
