//
//  ManualTunerView.swift
//  MyGuitarTunner
//

import SwiftUI

/// Manual mode: just the six strings. Tapping one plays its reference tone.
struct ManualTunerView: View {
    @StateObject private var viewModel = ManualTunerViewModel()

    var body: some View {
        VStack(spacing: 28) {
            Spacer()

            Text(Strings.tapAStringToHear)
                .font(.title3)
                .foregroundStyle(.secondary)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                ForEach(StandardTuning.strings) { string in
                    ManualStringButton(
                        string: string,
                        isPlaying: viewModel.playingString == string,
                        action: { viewModel.play(string) }
                    )
                }
            }
            .frame(maxWidth: 320)

            Spacer()
        }
        .padding()
        .onDisappear {
            viewModel.stop()
        }
    }
}

private struct ManualStringButton: View {
    let string: GuitarString
    let isPlaying: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Text(Strings.note(string.name))
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                Text(Strings.hz(string.frequency))
                    .font(.caption)
            }
            .frame(width: 96, height: 96)
            .foregroundStyle(isPlaying ? Color.white : Color.primary)
        }
        .buttonStyle(.plain)
        .glassEffect(
            isPlaying ? .regular.tint(.green) : .regular,
            in: .circle
        )
        .animation(.spring(response: 0.25, dampingFraction: 0.7), value: isPlaying)
    }
}

#Preview {
    ManualTunerView()
}
