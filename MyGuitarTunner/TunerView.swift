//
//  TunerView.swift
//  MyGuitarTunner
//

import SwiftUI

struct TunerView: View {
    @StateObject private var viewModel = TunerViewModel()

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
                    highlighted: viewModel.detectedString
                )
            }
            .padding()
        }
        .task {
            viewModel.start()
        }
        .onDisappear {
            viewModel.stop()
        }
    }

    @ViewBuilder
    private var card: some View {
        if let reading = viewModel.reading {
            readingCard(reading)
        } else if viewModel.permissionDenied {
            messageCard(
                systemImage: "mic.slash.fill",
                tint: .red,
                message: Strings.microphoneAccessRequired
            )
        } else {
            messageCard(
                systemImage: "waveform",
                tint: .secondary,
                message: Strings.playANote
            )
        }
    }

    private func readingCard(_ reading: TunerReading) -> some View {
        VStack(spacing: 20) {
            Text(Strings.note(reading.noteName))
                .font(.system(size: 96, weight: .bold, design: .rounded))
                .contentTransition(.numericText())
                .foregroundStyle(reading.isInTune ? .green : .primary)
                .animation(.easeInOut(duration: 0.2), value: reading.isInTune)

            Text(Strings.hz(reading.frequency))
                .font(.title3.monospacedDigit())
                .foregroundStyle(.secondary)

            CentsMeterView(cents: reading.cents, isInTune: reading.isInTune)
                .padding(.horizontal, 8)

            directionIndicator(for: reading)
        }
        .padding(36)
        .frame(maxWidth: 360)
        .glassEffect(.regular, in: .rect(cornerRadius: 32))
    }

    @ViewBuilder
    private func directionIndicator(for reading: TunerReading) -> some View {
        Group {
            if reading.isInTune {
                Label(Strings.inTune, systemImage: "checkmark.circle.fill")
                    .foregroundStyle(.green)
            } else if reading.isFlat {
                Label(Strings.tuneUp, systemImage: "arrow.up.circle.fill")
                    .foregroundStyle(.orange)
            } else {
                Label(Strings.tuneDown, systemImage: "arrow.down.circle.fill")
                    .foregroundStyle(.orange)
            }
        }
        .font(.title2.bold())
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .glassEffect(
            .regular.tint(reading.isInTune ? .green.opacity(0.35) : .orange.opacity(0.3)),
            in: .capsule
        )
    }

    private func messageCard(systemImage: String, tint: Color, message: LocalizedStringKey) -> some View {
        VStack(spacing: 16) {
            Image(systemName: systemImage)
                .font(.system(size: 48))
                .foregroundStyle(tint)
            Text(message)
                .font(.title3)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
        }
        .padding(48)
        .frame(maxWidth: 360)
        .glassEffect(.regular, in: .rect(cornerRadius: 32))
    }
}

#Preview {
    TunerView()
}
