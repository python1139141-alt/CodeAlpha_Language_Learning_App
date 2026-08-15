import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:codealpha_languagelearningapp/main.dart';
import 'package:codealpha_languagelearningapp/screens/onboarding_screen.dart';

void main() {
  testWidgets('App opens Onboarding when no profile is saved',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const LanguageLearningApp());
    await tester.pumpAndSettle();

    expect(find.byType(OnboardingScreen), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
  });
}
