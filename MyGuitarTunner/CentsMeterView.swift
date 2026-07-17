//
//  CentsMeterView.swift
//  MyGuitarTunner
//

import SwiftUI

/// A horizontal meter showing how flat or sharp the detected pitch is, in cents.
struct CentsMeterView: View {
    let cents: Double
    let isInTune: Bool

    private let range: Double = 50

    private var normalizedPosition: CGFloat {
        CGFloat((min(max(cents, -range), range) + range) / (2 * range))
    }

    private var indicatorColor: Color {
        isInTune ? .green : .orange
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Capsule()
                    .fill(Color.primary.opacity(0.1))
                    .frame(height: 8)

                Capsule()
                    .fill(Color.green.opacity(0.3))
                    .frame(width: geometry.size.width * 0.1, height: 8)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)

                Circle()
                    .fill(indicatorColor)
                    .frame(width: 22, height: 22)
                    .shadow(color: indicatorColor.opacity(0.5), radius: isInTune ? 8 : 0)
                    .position(x: normalizedPosition * geometry.size.width, y: geometry.size.height / 2)
                    .animation(.spring(response: 0.25, dampingFraction: 0.75), value: normalizedPosition)
            }
        }
        .frame(height: 22)
    }
}

#Preview {
    VStack(spacing: 24) {
        CentsMeterView(cents: -35, isInTune: false)
        CentsMeterView(cents: 2, isInTune: true)
        CentsMeterView(cents: 40, isInTune: false)
    }
    .padding(40)
}
