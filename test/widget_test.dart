import 'package:flutter_test/flutter_test.dart';
import 'package:my_guitar_tunner/core/di/injection.dart';
import 'package:my_guitar_tunner/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> pumpApp(
  WidgetTester tester, {
  Map<String, Object> preferences = const {},
}) async {
  SharedPreferences.setMockInitialValues(preferences);
  setupDi();
  await tester.runAsync(bootstrap);
  await tester.pumpWidget(const App());
  await tester.pumpAndSettle();
}

void main() {
  tearDown(() async {
    await getIt.reset();
  });

  testWidgets('home offers auto and manual modes without a login screen', (
    tester,
  ) async {
    await pumpApp(tester);

    expect(find.text('Guitar Tuner'), findsOneWidget);
    expect(find.text('Auto'), findsOneWidget);
    expect(find.text('Manual'), findsOneWidget);
    expect(find.text('Sign in'), findsNothing);
  });

  testWidgets('manual mode starts with a prompt and six strings', (
    tester,
  ) async {
    await pumpApp(tester);

    await tester.tap(find.text('Manual'));
    await tester.pumpAndSettle();

    expect(find.text('Tap a string to hear its note'), findsOneWidget);
    expect(find.text('E'), findsNWidgets(2));
    for (final note in ['A', 'D', 'G', 'B']) {
      expect(find.text(note), findsOneWidget);
    }
  });

  testWidgets('settings show security biometric unlock and no sign in', (
    tester,
  ) async {
    await pumpApp(tester);

    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();

    expect(find.text('Security'), findsOneWidget);
    expect(find.text('Face ID & fingerprint'), findsOneWidget);
    expect(find.text('Appearance'), findsOneWidget);
    expect(find.text('Sign in'), findsNothing);
    expect(find.text('Sign out'), findsNothing);
  });

  testWidgets('settings about section offers Google Play rating', (
    tester,
  ) async {
    await pumpApp(tester);

    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(find.text('Terms of use'), 300);
    expect(find.text('Rate on Google Play'), findsOneWidget);
    expect(find.text('Privacy policy'), findsOneWidget);
    expect(find.text('Terms of use'), findsOneWidget);
  });
}
