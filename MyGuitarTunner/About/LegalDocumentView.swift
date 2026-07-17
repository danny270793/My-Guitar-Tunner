//
//  LegalDocumentView.swift
//  MyGuitarTunner
//

import SwiftUI

/// Generic scrollable page for displaying legal copy (privacy policy, terms, etc.)
/// inside a Liquid Glass card.
struct LegalDocumentView: View {
    let title: LocalizedStringKey
    let text: LocalizedStringKey

    var body: some View {
        ScrollView {
            Text(text)
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(28)
                .glassEffect(.regular, in: .rect(cornerRadius: 28))
                .padding()
        }
        .navigationTitle(title)
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .background(backgroundGradient)
    }

    private var backgroundGradient: some View {
        LinearGradient(
            colors: [Color.indigo.opacity(0.2), Color.black.opacity(0.05)],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

#Preview {
    NavigationStack {
        LegalDocumentView(title: "Sample", text: "Sample legal copy.")
    }
}
