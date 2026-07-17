//
//  TermsOfServiceView.swift
//  MyGuitarTunner
//

import SwiftUI

struct TermsOfServiceView: View {
    var body: some View {
        LegalDocumentView(title: "Terms of Service", text: """
        Last updated: July 16, 2026

        By using MyGuitarTunner, you agree to the following terms.

        Use of the app
        MyGuitarTunner is provided to help you tune stringed instruments using your device's microphone. You are responsible for using the app in a safe and appropriate manner.

        No warranty
        MyGuitarTunner is provided "as is," without warranty of any kind, express or implied, including but not limited to the accuracy of pitch detection. The developer is not liable for any damage, loss, or missed performance resulting from use of the app.

        Intellectual property
        All app design, code, and content are the property of the developer unless otherwise noted.

        Changes to these terms
        These terms may be updated from time to time. Continued use of the app after changes constitutes acceptance of the revised terms.

        Contact
        Questions about these terms can be directed to the developer via GitHub: https://github.com/danny270793
        """)
    }
}

#Preview {
    NavigationStack {
        TermsOfServiceView()
    }
}
