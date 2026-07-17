//
//  TermsOfServiceView.swift
//  MyGuitarTunner
//

import SwiftUI

struct TermsOfServiceView: View {
    var body: some View {
        LegalDocumentView(title: Strings.termsOfService, text: Strings.termsOfServiceBody)
    }
}

#Preview {
    NavigationStack {
        TermsOfServiceView()
    }
}
