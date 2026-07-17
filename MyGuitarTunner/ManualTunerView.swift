//
//  ManualTunerView.swift
//  MyGuitarTunner
//

import SwiftUI

/// Manual mode: same look as auto tuning, but the string row is the control — tapping
/// a string plays its reference tone instead of the app listening to the microphone.
struct ManualTunerView: View {
    @StateObject private var viewModel = ManualTunerViewModel()

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.indigo.opacity(0.35), Color.black.opacity(0.05)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 28) {
                Text(Strings.guitarTunerTitle)
                    .font(.largeTitle.bold())

                Spacer()

                card

                Spacer()

                StringSelectorView(
                    strings: StandardTuning.strings,
                    highlighted: viewModel.playingString,
                    onSelect: { string in viewModel.play(string) }
                )
            }
            .padding()
        }
        .onDisappear {
            viewModel.stop()
        }
    }

    @ViewBuilder
    private var card: some View {
        if let playingString = viewModel.playingString {
            VStack(spacing: 20) {
                Text(Strings.note(playingString.name))
                    .font(.system(size: 96, weight: .bold, design: .rounded))
                    .foregroundStyle(.green)

                Text(Strings.hz(playingString.frequency))
                    .font(.title3.monospacedDigit())
                    .foregroundStyle(.secondary)
            }
            .padding(36)
            .frame(maxWidth: 360)
            .glassEffect(.regular, in: .rect(cornerRadius: 32))
        } else {
            VStack(spacing: 16) {
                Image(systemName: "hand.tap.fill")
                    .font(.system(size: 48))
                    .foregroundStyle(.secondary)
                Text(Strings.tapAStringToHear)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
            }
            .padding(48)
            .frame(maxWidth: 360)
            .glassEffect(.regular, in: .rect(cornerRadius: 32))
        }
    }
}

#Preview {
    ManualTunerView()
}
