// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Afinador de guitarra';

  @override
  String get autoMode => 'Automático';

  @override
  String get autoModeDescription =>
      'Detecta la afinación de tu guitarra con el micrófono';

  @override
  String get manualMode => 'Manual';

  @override
  String get manualModeDescription =>
      'Reproduce un tono de referencia para cada cuerda';

  @override
  String get playANote => 'Toca una nota en tu guitarra';

  @override
  String get microphoneAccessRequired =>
      'Se necesita acceso al micrófono para afinar tu guitarra. Actívalo en los ajustes del dispositivo.';

  @override
  String get inTune => 'Afinada';

  @override
  String get tuneUp => 'Sube el tono';

  @override
  String get tuneDown => 'Baja el tono';

  @override
  String get tapAStringToHear => 'Toca una cuerda para escuchar su nota';

  @override
  String hz(String frequency) {
    return '$frequency Hz';
  }

  @override
  String get biometricLockTitle => 'El afinador está bloqueado';

  @override
  String get settingsBiometricAuthReason =>
      'Activar desbloqueo biométrico para el afinador';

  @override
  String get settingsBiometricResumeReason => 'Desbloquear el afinador';

  @override
  String get settingsAboutTagline =>
      'Un afinador sencillo con micrófono para guitarra, con tonos de referencia para cada cuerda.';

  @override
  String get settingsAboutBulletAuto =>
      'El modo automático escucha con el micrófono y muestra la nota, su frecuencia y cuántos cents te desvías.';

  @override
  String get settingsAboutBulletManual =>
      'El modo manual reproduce un tono de referencia para cada cuerda, para afinar de oído.';

  @override
  String get settingsAboutBulletStrings =>
      'Afinación estándar (E A D G B E), con la cuerda más cercana resaltada mientras tocas.';

  @override
  String get settingsAboutDataBody =>
      'El audio se analiza en este dispositivo en tiempo real y nunca se graba, guarda ni sube. Las preferencias se guardan solo en este dispositivo y no hay cuentas.';

  @override
  String get settingsPrivacyTagline =>
      'Cómo el afinador maneja tu información.';

  @override
  String get settingsPrivacyDataBody =>
      'El afinador no tiene cuentas ni inicio de sesión. Nunca introduces un correo ni una contraseña, y la app no recopila información personal.';

  @override
  String get settingsPrivacyInfraBody =>
      'El micrófono se usa solo para detectar la afinación del instrumento. El audio se analiza en este dispositivo en tiempo real y nunca se graba, guarda ni transmite. Las preferencias (tema, idioma y desbloqueo biométrico) se guardan solo en este dispositivo y se borran al desinstalar la app.';

  @override
  String get settingsPrivacyPermissionsBody =>
      'El afinador pide acceso al micrófono para el modo automático y, de forma opcional, biometría para bloquear la app. El modo manual funciona sin micrófono.';

  @override
  String get settingsTermsTagline => 'Normas para usar el afinador.';

  @override
  String get settingsTermsAcceptanceBody =>
      'Estos términos rigen el uso de Afinador de guitarra (la \"app\"). Al descargar, instalar o usar la app, aceptas quedar sujeto a estos términos. Si no estás de acuerdo, no uses la app.';

  @override
  String get settingsTermsResponsibilitiesBody =>
      'La app se ofrece para uso personal y no comercial, para ayudarte a afinar instrumentos de cuerda con el micrófono del dispositivo o de oído. Eres responsable de usar la app de forma segura y adecuada.';

  @override
  String get settingsTermsAccountBody =>
      'Puedes usar todas las funciones sin crear una cuenta. Las preferencias se quedan en este dispositivo; si desinstalas la app o borras sus datos, no se pueden recuperar.';

  @override
  String get settingsTermsDisclaimerTitle => 'Precisión';

  @override
  String get settingsTermsDisclaimerBody =>
      'La detección depende del micrófono del dispositivo y del ruido ambiente. La app es una ayuda para practicar y no garantiza una afinación perfecta.';

  @override
  String get settingsSecuritySection => 'Seguridad';

  @override
  String get settingsAboutSection => 'Acerca de';

  @override
  String get biometricLockBody => 'Autentícate para continuar.';

  @override
  String get settings => 'Configuración';

  @override
  String get settingsBiometricUnlockTitle => 'Face ID y huella dactilar';

  @override
  String get settingsBiometricUnlockSubtitle =>
      'Requerir autenticación al volver a la aplicación.';

  @override
  String get settingsBiometricUnavailable =>
      'El desbloqueo biométrico no está disponible en este dispositivo.';

  @override
  String get biometricLockUnlockButton => 'Desbloquear';

  @override
  String get settingsAppearance => 'Apariencia';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageSystem => 'Predeterminado del sistema';

  @override
  String get settingsLanguageEnglish => 'Inglés';

  @override
  String get settingsLanguageSpanish => 'Español';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeSystem => 'Predeterminado del sistema';

  @override
  String get settingsThemeLight => 'Claro';

  @override
  String get settingsThemeDark => 'Oscuro';

  @override
  String get settingsAboutApp => 'Acerca de';

  @override
  String get settingsRateApp => 'Calificar en Google Play';

  @override
  String get settingsPrivacyPolicy => 'Política de privacidad';

  @override
  String get settingsTermsOfUse => 'Términos de uso';

  @override
  String get settingsAboutVersionLabel => 'Versión';

  @override
  String get settingsAboutFeaturesHeading => 'Qué puedes hacer';

  @override
  String get settingsAboutDataHeading => 'Tus datos';

  @override
  String get settingsAboutDeveloperHeading => 'Desarrollador';

  @override
  String get settingsAboutDeveloperGithub => 'GitHub';

  @override
  String get settingsAboutDeveloperWebsite => 'Sitio web';

  @override
  String get settingsAboutDeveloperYoutube => 'YouTube';

  @override
  String get settingsAboutDeveloperLinkedin => 'LinkedIn';

  @override
  String get settingsPrivacyDataTitle => 'Sin cuenta';

  @override
  String get settingsPrivacyInfraTitle => 'Qué guardamos';

  @override
  String get settingsPrivacyAnalyticsTitle => 'Sin análisis ni publicidad';

  @override
  String get settingsPrivacyAnalyticsBody =>
      'La app no incluye software de análisis, seguimiento ni publicidad de terceros.';

  @override
  String get settingsPrivacyPermissionsTitle => 'Permisos';

  @override
  String get settingsPrivacySharingTitle => 'Compartir datos';

  @override
  String get settingsPrivacySharingBody =>
      'No vendemos ni compartimos tu información personal. Todos los datos de la app se quedan en tu dispositivo.';

  @override
  String get settingsPrivacyNoticeTitle => 'Cambios a esta política';

  @override
  String get settingsPrivacyNoticeBody =>
      'Esta política de privacidad puede actualizarse periódicamente. El uso continuado de la app después de esos cambios implica la aceptación de la política actualizada.';

  @override
  String get settingsTermsAcceptanceTitle => 'Aceptación';

  @override
  String get settingsTermsResponsibilitiesTitle => 'Uso de la app';

  @override
  String get settingsTermsAccountTitle => 'Sin cuenta';

  @override
  String get settingsTermsIpTitle => 'Propiedad intelectual';

  @override
  String get settingsTermsIpBody =>
      'Todo el contenido, diseño y código de la app son propiedad del desarrollador salvo que se indique lo contrario, y no pueden copiarse, modificarse ni redistribuirse sin permiso.';

  @override
  String get settingsTermsLiabilityTitle => 'Garantía y responsabilidad';

  @override
  String get settingsTermsLiabilityBody =>
      'La app se ofrece \"tal cual\" y \"según disponibilidad\", sin garantías de ningún tipo. En la máxima medida permitida por la ley, el desarrollador no será responsable de daños indirectos, incidentales o consecuentes derivados del uso de la app.';

  @override
  String get settingsTermsNoticeTitle => 'Cambios a estos términos';

  @override
  String get settingsTermsNoticeBody =>
      'Estos términos pueden actualizarse periódicamente. El uso continuado de la app después de publicar cambios constituye la aceptación de los términos revisados.';
}
