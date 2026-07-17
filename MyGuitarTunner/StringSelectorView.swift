//
//  StringSelectorView.swift
//  MyGuitarTunner
//

import SwiftUI

/// Row of the six guitar strings (low E to high E). The highlighted string shows green;
/// pass `onSelect` to make badges tappable (e.g. to play a reference tone), or omit it
/// for a display-only row driven purely by pitch detection.
struct StringSelectorView: View {
    let strings: [GuitarString]
    let highlighted: GuitarString?
    var onSelect: ((GuitarString) -> Void)?

    var body: some View {
        GlassEffectContainer(spacing: 12) {
            HStack(spacing: 12) {
                ForEach(strings) { string in
                    StringBadge(
                        string: string,
                        isHighlighted: string == highlighted,
                        action: onSelect.map { onSelect in { onSelect(string) } }
                    )
                }
            }
        }
    }
}

private struct StringBadge: View {
    let string: GuitarString
    let isHighlighted: Bool
    let action: (() -> Void)?

    var body: some View {
        Group {
            if let action {
                Button(action: action) { label }
                    .buttonStyle(.plain)
            } else {
                label
            }
        }
        .glassEffect(
            isHighlighted ? .regular.tint(.green) : .regular,
            in: .circle
        )
        .animation(.spring(response: 0.25, dampingFraction: 0.7), value: isHighlighted)
    }

    private var label: some View {
        Text(Strings.note(string.name))
            .font(.title3.bold())
            .frame(width: 48, height: 48)
            .foregroundStyle(isHighlighted ? Color.white : Color.primary)
    }
}

#Preview {
    StringSelectorView(
        strings: StandardTuning.strings,
        highlighted: StandardTuning.strings[2]
    )
    .padding(40)
}
