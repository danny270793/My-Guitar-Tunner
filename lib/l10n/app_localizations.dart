import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Guitar Tuner'**
  String get appTitle;

  /// No description provided for @autoMode.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get autoMode;

  /// No description provided for @autoModeDescription.
  ///
  /// In en, this message translates to:
  /// **'Detects the pitch of your guitar through the microphone'**
  String get autoModeDescription;

  /// No description provided for @manualMode.
  ///
  /// In en, this message translates to:
  /// **'Manual'**
  String get manualMode;

  /// No description provided for @manualModeDescription.
  ///
  /// In en, this message translates to:
  /// **'Play a reference tone for each string'**
  String get manualModeDescription;

  /// No description provided for @playANote.
  ///
  /// In en, this message translates to:
  /// **'Play a note on your guitar'**
  String get playANote;

  /// No description provided for @microphoneAccessRequired.
  ///
  /// In en, this message translates to:
  /// **'Microphone access is required to tune your guitar. Enable it in your device settings.'**
  String get microphoneAccessRequired;

  /// No description provided for @inTune.
  ///
  /// In en, this message translates to:
  /// **'In tune'**
  String get inTune;

  /// No description provided for @tuneUp.
  ///
  /// In en, this message translates to:
  /// **'Tune up'**
  String get tuneUp;

  /// No description provided for @tuneDown.
  ///
  /// In en, this message translates to:
  /// **'Tune down'**
  String get tuneDown;

  /// No description provided for @tapAStringToHear.
  ///
  /// In en, this message translates to:
  /// **'Tap a string to hear its note'**
  String get tapAStringToHear;

  /// No description provided for @hz.
  ///
  /// In en, this message translates to:
  /// **'{frequency} Hz'**
  String hz(String frequency);

  /// No description provided for @biometricLockTitle.
  ///
  /// In en, this message translates to:
  /// **'Guitar Tuner is locked'**
  String get biometricLockTitle;

  /// No description provided for @settingsBiometricAuthReason.
  ///
  /// In en, this message translates to:
  /// **'Enable biometric unlock for Guitar Tuner'**
  String get settingsBiometricAuthReason;

  /// No description provided for @settingsBiometricResumeReason.
  ///
  /// In en, this message translates to:
  /// **'Unlock Guitar Tuner'**
  String get settingsBiometricResumeReason;

  /// No description provided for @settingsAboutTagline.
  ///
  /// In en, this message translates to:
  /// **'A simple microphone tuner for guitar, with reference tones for every string.'**
  String get settingsAboutTagline;

  /// No description provided for @settingsAboutBulletAuto.
  ///
  /// In en, this message translates to:
  /// **'Auto mode listens through the microphone and shows the note, its frequency, and how many cents you are off.'**
  String get settingsAboutBulletAuto;

  /// No description provided for @settingsAboutBulletManual.
  ///
  /// In en, this message translates to:
  /// **'Manual mode plays a reference tone for each string so you can tune by ear.'**
  String get settingsAboutBulletManual;

  /// No description provided for @settingsAboutBulletStrings.
  ///
  /// In en, this message translates to:
  /// **'Standard tuning (E A D G B E) with the nearest string highlighted as you play.'**
  String get settingsAboutBulletStrings;

  /// No description provided for @settingsAboutDataBody.
  ///
  /// In en, this message translates to:
  /// **'Audio is analyzed on this device in real time and is never recorded, saved, or uploaded. Preferences are stored only on this device, and there are no accounts.'**
  String get settingsAboutDataBody;

  /// No description provided for @settingsPrivacyTagline.
  ///
  /// In en, this message translates to:
  /// **'How Guitar Tuner handles your information.'**
  String get settingsPrivacyTagline;

  /// No description provided for @settingsPrivacyDataBody.
  ///
  /// In en, this message translates to:
  /// **'Guitar Tuner has no accounts and no sign-in. You never enter an email or password, and the app does not collect personal information.'**
  String get settingsPrivacyDataBody;

  /// No description provided for @settingsPrivacyInfraBody.
  ///
  /// In en, this message translates to:
  /// **'The microphone is used only to detect the pitch of the instrument you are tuning. Audio is analyzed on this device in real time and is never recorded, saved, or transmitted. Preferences (theme, language and biometric unlock) are stored only on this device and are deleted when you uninstall the app.'**
  String get settingsPrivacyInfraBody;

  /// No description provided for @settingsPrivacyPermissionsBody.
  ///
  /// In en, this message translates to:
  /// **'Guitar Tuner asks for microphone access for auto mode and, optionally, biometrics to lock the app. Manual mode works without the microphone.'**
  String get settingsPrivacyPermissionsBody;

  /// No description provided for @settingsTermsTagline.
  ///
  /// In en, this message translates to:
  /// **'Rules for using Guitar Tuner.'**
  String get settingsTermsTagline;

  /// No description provided for @settingsTermsAcceptanceBody.
  ///
  /// In en, this message translates to:
  /// **'These terms govern your use of Guitar Tuner (the \"app\"). By downloading, installing, or using the app, you agree to be bound by these terms. If you do not agree, do not use the app.'**
  String get settingsTermsAcceptanceBody;

  /// No description provided for @settingsTermsResponsibilitiesBody.
  ///
  /// In en, this message translates to:
  /// **'The app is provided for personal, non-commercial use to help you tune stringed instruments with your device\'s microphone or by ear. You are responsible for using the app in a safe and appropriate manner.'**
  String get settingsTermsResponsibilitiesBody;

  /// No description provided for @settingsTermsAccountBody.
  ///
  /// In en, this message translates to:
  /// **'You can use every feature without creating an account. Preferences stay on this device; if you uninstall the app or clear its data, they cannot be recovered.'**
  String get settingsTermsAccountBody;

  /// No description provided for @settingsTermsDisclaimerTitle.
  ///
  /// In en, this message translates to:
  /// **'Accuracy'**
  String get settingsTermsDisclaimerTitle;

  /// No description provided for @settingsTermsDisclaimerBody.
  ///
  /// In en, this message translates to:
  /// **'Pitch detection depends on your device\'s microphone and the surrounding noise. The app is a practice aid and does not guarantee a perfectly tuned instrument.'**
  String get settingsTermsDisclaimerBody;

  /// No description provided for @settingsSecuritySection.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get settingsSecuritySection;

  /// No description provided for @settingsAboutSection.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAboutSection;

  /// No description provided for @biometricLockBody.
  ///
  /// In en, this message translates to:
  /// **'Authenticate to continue.'**
  String get biometricLockBody;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @settingsBiometricUnlockTitle.
  ///
  /// In en, this message translates to:
  /// **'Face ID & fingerprint'**
  String get settingsBiometricUnlockTitle;

  /// No description provided for @settingsBiometricUnlockSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Require authentication when returning to the app.'**
  String get settingsBiometricUnlockSubtitle;

  /// No description provided for @settingsBiometricUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Biometric unlock is not available on this device.'**
  String get settingsBiometricUnavailable;

  /// No description provided for @biometricLockUnlockButton.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get biometricLockUnlockButton;

  /// No description provided for @settingsAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearance;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get settingsLanguageSystem;

  /// No description provided for @settingsLanguageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsLanguageEnglish;

  /// No description provided for @settingsLanguageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get settingsLanguageSpanish;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get settingsThemeSystem;

  /// No description provided for @settingsThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// No description provided for @settingsAboutApp.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAboutApp;

  /// No description provided for @settingsRateApp.
  ///
  /// In en, this message translates to:
  /// **'Rate on Google Play'**
  String get settingsRateApp;

  /// No description provided for @settingsPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get settingsPrivacyPolicy;

  /// No description provided for @settingsTermsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of use'**
  String get settingsTermsOfUse;

  /// No description provided for @settingsAboutVersionLabel.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get settingsAboutVersionLabel;

  /// No description provided for @settingsAboutFeaturesHeading.
  ///
  /// In en, this message translates to:
  /// **'What you can do'**
  String get settingsAboutFeaturesHeading;

  /// No description provided for @settingsAboutDataHeading.
  ///
  /// In en, this message translates to:
  /// **'Your data'**
  String get settingsAboutDataHeading;

  /// No description provided for @settingsAboutDeveloperHeading.
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get settingsAboutDeveloperHeading;

  /// No description provided for @settingsAboutDeveloperGithub.
  ///
  /// In en, this message translates to:
  /// **'GitHub'**
  String get settingsAboutDeveloperGithub;

  /// No description provided for @settingsAboutDeveloperWebsite.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get settingsAboutDeveloperWebsite;

  /// No description provided for @settingsAboutDeveloperYoutube.
  ///
  /// In en, this message translates to:
  /// **'YouTube'**
  String get settingsAboutDeveloperYoutube;

  /// No description provided for @settingsAboutDeveloperLinkedin.
  ///
  /// In en, this message translates to:
  /// **'LinkedIn'**
  String get settingsAboutDeveloperLinkedin;

  /// No description provided for @settingsPrivacyDataTitle.
  ///
  /// In en, this message translates to:
  /// **'No account needed'**
  String get settingsPrivacyDataTitle;

  /// No description provided for @settingsPrivacyInfraTitle.
  ///
  /// In en, this message translates to:
  /// **'What we store'**
  String get settingsPrivacyInfraTitle;

  /// No description provided for @settingsPrivacyAnalyticsTitle.
  ///
  /// In en, this message translates to:
  /// **'No analytics or advertising'**
  String get settingsPrivacyAnalyticsTitle;

  /// No description provided for @settingsPrivacyAnalyticsBody.
  ///
  /// In en, this message translates to:
  /// **'The app does not include third-party analytics, tracking, or advertising software.'**
  String get settingsPrivacyAnalyticsBody;

  /// No description provided for @settingsPrivacyPermissionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Permissions'**
  String get settingsPrivacyPermissionsTitle;

  /// No description provided for @settingsPrivacySharingTitle.
  ///
  /// In en, this message translates to:
  /// **'Data sharing'**
  String get settingsPrivacySharingTitle;

  /// No description provided for @settingsPrivacySharingBody.
  ///
  /// In en, this message translates to:
  /// **'We do not sell or share your personal information. All app data stays on your device.'**
  String get settingsPrivacySharingBody;

  /// No description provided for @settingsPrivacyNoticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Changes to this policy'**
  String get settingsPrivacyNoticeTitle;

  /// No description provided for @settingsPrivacyNoticeBody.
  ///
  /// In en, this message translates to:
  /// **'This privacy policy may be updated from time to time. Continued use of the app after changes means you accept the updated policy.'**
  String get settingsPrivacyNoticeBody;

  /// No description provided for @settingsTermsAcceptanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Acceptance'**
  String get settingsTermsAcceptanceTitle;

  /// No description provided for @settingsTermsResponsibilitiesTitle.
  ///
  /// In en, this message translates to:
  /// **'Use of the app'**
  String get settingsTermsResponsibilitiesTitle;

  /// No description provided for @settingsTermsAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'No account'**
  String get settingsTermsAccountTitle;

  /// No description provided for @settingsTermsIpTitle.
  ///
  /// In en, this message translates to:
  /// **'Intellectual property'**
  String get settingsTermsIpTitle;

  /// No description provided for @settingsTermsIpBody.
  ///
  /// In en, this message translates to:
  /// **'All content, design, and code in the app are owned by the developer unless otherwise noted, and may not be copied, modified, or redistributed without permission.'**
  String get settingsTermsIpBody;

  /// No description provided for @settingsTermsLiabilityTitle.
  ///
  /// In en, this message translates to:
  /// **'Warranty and liability'**
  String get settingsTermsLiabilityTitle;

  /// No description provided for @settingsTermsLiabilityBody.
  ///
  /// In en, this message translates to:
  /// **'The app is provided \"as is\" and \"as available,\" without warranties of any kind, express or implied. To the fullest extent permitted by law, the developer shall not be liable for any indirect, incidental, or consequential damages arising from your use of the app.'**
  String get settingsTermsLiabilityBody;

  /// No description provided for @settingsTermsNoticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Changes to these terms'**
  String get settingsTermsNoticeTitle;

  /// No description provided for @settingsTermsNoticeBody.
  ///
  /// In en, this message translates to:
  /// **'These terms may be updated from time to time. Continued use of the app after changes are published constitutes acceptance of the revised terms.'**
  String get settingsTermsNoticeBody;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
