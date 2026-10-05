// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Guitar Tuner';

  @override
  String get autoMode => 'Auto';

  @override
  String get autoModeDescription =>
      'Detects the pitch of your guitar through the microphone';

  @override
  String get manualMode => 'Manual';

  @override
  String get manualModeDescription => 'Play a reference tone for each string';

  @override
  String get playANote => 'Play a note on your guitar';

  @override
  String get microphoneAccessRequired =>
      'Microphone access is required to tune your guitar. Enable it in your device settings.';

  @override
  String get inTune => 'In tune';

  @override
  String get tuneUp => 'Tune up';

  @override
  String get tuneDown => 'Tune down';

  @override
  String get tapAStringToHear => 'Tap a string to hear its note';

  @override
  String hz(String frequency) {
    return '$frequency Hz';
  }

  @override
  String get biometricLockTitle => 'Guitar Tuner is locked';

  @override
  String get settingsBiometricAuthReason =>
      'Enable biometric unlock for Guitar Tuner';

  @override
  String get settingsBiometricResumeReason => 'Unlock Guitar Tuner';

  @override
  String get settingsAboutTagline =>
      'A simple microphone tuner for guitar, with reference tones for every string.';

  @override
  String get settingsAboutBulletAuto =>
      'Auto mode listens through the microphone and shows the note, its frequency, and how many cents you are off.';

  @override
  String get settingsAboutBulletManual =>
      'Manual mode plays a reference tone for each string so you can tune by ear.';

  @override
  String get settingsAboutBulletStrings =>
      'Standard tuning (E A D G B E) with the nearest string highlighted as you play.';

  @override
  String get settingsAboutDataBody =>
      'Audio is analyzed on this device in real time and is never recorded, saved, or uploaded. Preferences are stored only on this device, and there are no accounts.';

  @override
  String get settingsPrivacyTagline =>
      'How Guitar Tuner handles your information.';

  @override
  String get settingsPrivacyDataBody =>
      'Guitar Tuner has no accounts and no sign-in. You never enter an email or password, and the app does not collect personal information.';

  @override
  String get settingsPrivacyInfraBody =>
      'The microphone is used only to detect the pitch of the instrument you are tuning. Audio is analyzed on this device in real time and is never recorded, saved, or transmitted. Preferences (theme, language and biometric unlock) are stored only on this device and are deleted when you uninstall the app.';

  @override
  String get settingsPrivacyPermissionsBody =>
      'Guitar Tuner asks for microphone access for auto mode and, optionally, biometrics to lock the app. Manual mode works without the microphone.';

  @override
  String get settingsTermsTagline => 'Rules for using Guitar Tuner.';

  @override
  String get settingsTermsAcceptanceBody =>
      'These terms govern your use of Guitar Tuner (the \"app\"). By downloading, installing, or using the app, you agree to be bound by these terms. If you do not agree, do not use the app.';

  @override
  String get settingsTermsResponsibilitiesBody =>
      'The app is provided for personal, non-commercial use to help you tune stringed instruments with your device\'s microphone or by ear. You are responsible for using the app in a safe and appropriate manner.';

  @override
  String get settingsTermsAccountBody =>
      'You can use every feature without creating an account. Preferences stay on this device; if you uninstall the app or clear its data, they cannot be recovered.';

  @override
  String get settingsTermsDisclaimerTitle => 'Accuracy';

  @override
  String get settingsTermsDisclaimerBody =>
      'Pitch detection depends on your device\'s microphone and the surrounding noise. The app is a practice aid and does not guarantee a perfectly tuned instrument.';

  @override
  String get settingsSecuritySection => 'Security';

  @override
  String get settingsAboutSection => 'About';

  @override
  String get biometricLockBody => 'Authenticate to continue.';

  @override
  String get settings => 'Settings';

  @override
  String get settingsBiometricUnlockTitle => 'Face ID & fingerprint';

  @override
  String get settingsBiometricUnlockSubtitle =>
      'Require authentication when returning to the app.';

  @override
  String get settingsBiometricUnavailable =>
      'Biometric unlock is not available on this device.';

  @override
  String get biometricLockUnlockButton => 'Unlock';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageSystem => 'System default';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageSpanish => 'Spanish';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsThemeSystem => 'System default';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsAboutApp => 'About';

  @override
  String get settingsRateApp => 'Rate on Google Play';

  @override
  String get settingsPrivacyPolicy => 'Privacy policy';

  @override
  String get settingsTermsOfUse => 'Terms of use';

  @override
  String get settingsAboutVersionLabel => 'Version';

  @override
  String get settingsAboutFeaturesHeading => 'What you can do';

  @override
  String get settingsAboutDataHeading => 'Your data';

  @override
  String get settingsAboutDeveloperHeading => 'Developer';

  @override
  String get settingsAboutDeveloperGithub => 'GitHub';

  @override
  String get settingsAboutDeveloperWebsite => 'Website';

  @override
  String get settingsAboutDeveloperYoutube => 'YouTube';

  @override
  String get settingsAboutDeveloperLinkedin => 'LinkedIn';

  @override
  String get settingsPrivacyDataTitle => 'No account needed';

  @override
  String get settingsPrivacyInfraTitle => 'What we store';

  @override
  String get settingsPrivacyAnalyticsTitle => 'No analytics or advertising';

  @override
  String get settingsPrivacyAnalyticsBody =>
      'The app does not include third-party analytics, tracking, or advertising software.';

  @override
  String get settingsPrivacyPermissionsTitle => 'Permissions';

  @override
  String get settingsPrivacySharingTitle => 'Data sharing';

  @override
  String get settingsPrivacySharingBody =>
      'We do not sell or share your personal information. All app data stays on your device.';

  @override
  String get settingsPrivacyNoticeTitle => 'Changes to this policy';

  @override
  String get settingsPrivacyNoticeBody =>
      'This privacy policy may be updated from time to time. Continued use of the app after changes means you accept the updated policy.';

  @override
  String get settingsTermsAcceptanceTitle => 'Acceptance';

  @override
  String get settingsTermsResponsibilitiesTitle => 'Use of the app';

  @override
  String get settingsTermsAccountTitle => 'No account';

  @override
  String get settingsTermsIpTitle => 'Intellectual property';

  @override
  String get settingsTermsIpBody =>
      'All content, design, and code in the app are owned by the developer unless otherwise noted, and may not be copied, modified, or redistributed without permission.';

  @override
  String get settingsTermsLiabilityTitle => 'Warranty and liability';

  @override
  String get settingsTermsLiabilityBody =>
      'The app is provided \"as is\" and \"as available,\" without warranties of any kind, express or implied. To the fullest extent permitted by law, the developer shall not be liable for any indirect, incidental, or consequential damages arising from your use of the app.';

  @override
  String get settingsTermsNoticeTitle => 'Changes to these terms';

  @override
  String get settingsTermsNoticeBody =>
      'These terms may be updated from time to time. Continued use of the app after changes are published constitutes acceptance of the revised terms.';
}
