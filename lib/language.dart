import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Shared DE/EN language preference for the app.
final ValueNotifier<String> appLanguage = ValueNotifier<String>('de');
const _languageKey = 'wer_muss_language';

Future<void> initializeAppLanguage() async {
  final systemLanguage =
      WidgetsBinding.instance.platformDispatcher.locale.languageCode;
  appLanguage.value = systemLanguage == 'de' ? 'de' : 'en';

  try {
    final saved = await SharedPreferencesAsync().getString(_languageKey);
    if (saved == 'de' || saved == 'en') appLanguage.value = saved!;
  } catch (_) {
    // The app remains usable with the device's language.
  }
}

void setAppLanguage(String language) {
  if ((language != 'de' && language != 'en') ||
      appLanguage.value == language) {
    return;
  }
  appLanguage.value = language;
  unawaited(_persistLanguage(language));
}

Future<void> _persistLanguage(String language) async {
  try {
    await SharedPreferencesAsync().setString(_languageKey, language);
  } catch (_) {
    // A storage error must never interrupt a game.
  }
}

class AppLanguageScope extends InheritedNotifier<ValueNotifier<String>> {
  const AppLanguageScope({
    super.key,
    required ValueNotifier<String> notifier,
    required super.child,
  }) : super(notifier: notifier);

  static String current(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<AppLanguageScope>();
    return scope?.notifier?.value ?? appLanguage.value;
  }
}

String tr(BuildContext context, String german, String english) =>
    AppLanguageScope.current(context) == 'en' ? english : german;

class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final chosen = AppLanguageScope.current(context);
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: const Color(0xFF292840),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: const Color(0xFF4B4864)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final language in const ['de', 'en'])
            Semantics(
              button: true,
              selected: chosen == language,
              label: language == 'de' ? 'Deutsch' : 'English',
              child: InkWell(
                onTap: () => setAppLanguage(language),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  constraints: const BoxConstraints(minWidth: 31, minHeight: 29),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: chosen == language
                        ? const Color(0xFFF5F36D)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    language.toUpperCase(),
                    style: TextStyle(
                      fontSize: 11,
                      letterSpacing: .15,
                      fontWeight: FontWeight.w900,
                      color: chosen == language
                          ? const Color(0xFF111224)
                          : const Color(0xFFC6C2D8),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
