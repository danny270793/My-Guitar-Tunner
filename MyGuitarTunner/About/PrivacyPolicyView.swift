//
//  PrivacyPolicyView.swift
//  MyGuitarTunner
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        LegalDocumentView(title: Strings.privacyPolicy, text: Strings.privacyPolicyBody)
    }
}

#Preview {
    NavigationStack {
        PrivacyPolicyView()
    }
}
