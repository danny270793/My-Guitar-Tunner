//
//  PrivacyPolicyView.swift
//  MyGuitarTunner
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        LegalDocumentView(title: "Privacy Policy", text: """
        Last updated: July 16, 2026

        MyGuitarTunner is designed with your privacy in mind.

        Microphone
        MyGuitarTunner uses your device's microphone solely to detect the pitch of the instrument you are tuning. Audio is analyzed entirely on your device in real time and is never recorded, saved, or transmitted anywhere.

        Data collection
        MyGuitarTunner does not collect, store, or share any personal data. The app does not use analytics, advertising, or third-party tracking, and it does not require an account.

        Network access
        MyGuitarTunner does not send any data over the network.

        Changes to this policy
        If this policy changes, the "Last updated" date above will be revised accordingly.

        Contact
        Questions about this policy can be directed to the developer via GitHub: https://github.com/danny270793
        """)
    }
}

#Preview {
    NavigationStack {
        PrivacyPolicyView()
    }
}
