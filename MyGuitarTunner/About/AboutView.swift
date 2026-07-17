//
//  AboutView.swift
//  MyGuitarTunner
//

import SwiftUI

struct AboutView: View {
    private let developerProfileURL = URL(string: "https://github.com/danny270793")!

    private var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }

    private var buildNumber: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                appCard
                developerCard
                legalCard
            }
            .padding()
        }
        .navigationTitle(Strings.about)
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

    private var appCard: some View {
        VStack(spacing: 12) {
            Image(systemName: "tuningfork")
                .font(.system(size: 48))
                .foregroundStyle(.tint)

            Text(Strings.appName)
                .font(.title2.bold())

            Text(Strings.version(appVersion, build: buildNumber))
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text(Strings.appDescription)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(28)
        .glassEffect(.regular, in: .rect(cornerRadius: 28))
    }

    private var developerCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(Strings.developer)
                .font(.headline)

            Link(destination: developerProfileURL) {
                Label(Strings.developerGitHub, systemImage: "person.circle")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(24)
        .glassEffect(.regular, in: .rect(cornerRadius: 28))
    }

    private var legalCard: some View {
        VStack(spacing: 0) {
            NavigationLink {
                PrivacyPolicyView()
            } label: {
                legalRow(title: Strings.privacyPolicy, systemImage: "hand.raised")
            }

            Divider()

            NavigationLink {
                TermsOfServiceView()
            } label: {
                legalRow(title: Strings.termsOfService, systemImage: "doc.text")
            }
        }
        .padding(.vertical, 4)
        .glassEffect(.regular, in: .rect(cornerRadius: 28))
    }

    private func legalRow(title: LocalizedStringKey, systemImage: String) -> some View {
        HStack {
            Label(title, systemImage: systemImage)
            Spacer()
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .contentShape(Rectangle())
        .foregroundStyle(.primary)
    }
}

#Preview {
    NavigationStack {
        AboutView()
    }
}
