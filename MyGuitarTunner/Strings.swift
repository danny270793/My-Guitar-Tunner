//
//  Strings.swift
//  MyGuitarTunner
//

import SwiftUI

/// Single source of truth for the app's user-facing text. Every property/function is built
/// from a literal (or a literal interpolation), so it still extracts into `Localizable.xcstrings` —
/// views reference these instead of writing literals inline at each call site.
enum Strings {
    /// Maps a chromatic note name (as stored on `TunerReading`/`GuitarString`) to a localizable
    /// key, so displaying it goes through the String Catalog instead of `Text(someString)`
    /// showing the raw value verbatim.
    static func note(_ name: String) -> LocalizedStringKey {
        switch name {
        case "C": "C"
        case "C♯": "C♯"
        case "D": "D"
        case "D♯": "D♯"
        case "E": "E"
        case "F": "F"
        case "F♯": "F♯"
        case "G": "G"
        case "G♯": "G♯"
        case "A": "A"
        case "A♯": "A♯"
        case "B": "B"
        default: LocalizedStringKey(name)
        }
    }

    static let guitarTunerTitle: LocalizedStringKey = "Guitar Tuner"
    static let playANote: LocalizedStringKey = "Play a note on your guitar"
    static let microphoneAccessRequired: LocalizedStringKey = "Microphone access is required to tune your guitar. Enable it in Settings."
    static let inTune: LocalizedStringKey = "In tune"
    static let tuneUp: LocalizedStringKey = "Tune up"
    static let tuneDown: LocalizedStringKey = "Tune down"

    static let autoMode: LocalizedStringKey = "Auto"
    static let autoModeDescription: LocalizedStringKey = "Detects pitch from your guitar automatically"
    static let manualMode: LocalizedStringKey = "Manual"
    static let manualModeDescription: LocalizedStringKey = "Play a reference tone for each string"
    static let tapAStringToHear: LocalizedStringKey = "Tap a string to hear its note"

    static func hz(_ frequency: Double) -> LocalizedStringKey {
        "\(frequency, specifier: "%.1f") Hz"
    }

    static let about: LocalizedStringKey = "About"
    static let appName: LocalizedStringKey = "MyGuitarTunner"
    static let appDescription: LocalizedStringKey = "A simple microphone-based tuner for guitar and other stringed instruments."
    static let developer: LocalizedStringKey = "Developer"
    static let developerGitHub: LocalizedStringKey = "Danny Vaca on GitHub"

    static func version(_ version: String, build: String) -> LocalizedStringKey {
        "Version \(version) (\(build))"
    }

    static let privacyPolicy: LocalizedStringKey = "Privacy Policy"
    static let termsOfService: LocalizedStringKey = "Terms of Service"

    static let privacyPolicyBody: LocalizedStringKey = """
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
    """

    static let termsOfServiceBody: LocalizedStringKey = """
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
    """
}
