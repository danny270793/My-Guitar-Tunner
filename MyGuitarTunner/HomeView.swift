//
//  HomeView.swift
//  MyGuitarTunner
//

import SwiftUI

/// Landing screen: pick auto (continuous mic-based tuning) or manual (tap a string to
/// hear its reference tone) mode, each pushed as its own screen.
struct HomeView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.indigo.opacity(0.35), Color.black.opacity(0.05)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 28) {
                Image("AppIconDisplay")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 88, height: 88)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(radius: 8)

                Text(Strings.guitarTunerTitle)
                    .font(.largeTitle.bold())

                Spacer()

                VStack(spacing: 20) {
                    NavigationLink {
                        TunerView()
                    } label: {
                        ModeCard(
                            systemImage: "waveform",
                            title: Strings.autoMode,
                            subtitle: Strings.autoModeDescription
                        )
                    }

                    NavigationLink {
                        ManualTunerView()
                    } label: {
                        ModeCard(
                            systemImage: "hand.tap.fill",
                            title: Strings.manualMode,
                            subtitle: Strings.manualModeDescription
                        )
                    }
                }
                .buttonStyle(.plain)

                Spacer()
            }
            .padding()
        }
    }
}

private struct ModeCard: View {
    let systemImage: String
    let title: LocalizedStringKey
    let subtitle: LocalizedStringKey

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: systemImage)
                .font(.system(size: 28))
                .frame(width: 52, height: 52)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.title2.bold())
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
        }
        .foregroundStyle(Color.primary)
        .padding(20)
        .frame(maxWidth: 360)
        .glassEffect(.regular, in: .rect(cornerRadius: 24))
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
