//
//  HomeView.swift
//  MyGuitarTunner
//

import SwiftUI

/// Root screen: lets the user switch between auto (continuous mic-based tuning) and
/// manual (tap a string to hear its reference tone) modes.
struct HomeView: View {
    @State private var mode: TunerMode = .auto

    var body: some View {
        VStack(spacing: 16) {
            Picker(Strings.tunerModeLabel, selection: $mode) {
                Text(Strings.autoMode).tag(TunerMode.auto)
                Text(Strings.manualMode).tag(TunerMode.manual)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            .padding(.top)

            switch mode {
            case .auto:
                TunerView()
            case .manual:
                ManualTunerView()
            }
        }
    }
}

#Preview {
    HomeView()
}
