import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/user_profile.dart';
import '../services/storage_service.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  String _nativeLanguage = MockData.nativeLanguages.first;
  String _targetLanguage = 'Spanish';
  String _expertiseLevel = 'Beginner';

  static const Map<String, Color> _levelColors = {
    'Beginner': Colors.red,
    'Intermediate': Colors.amber,
    'Advanced': Colors.green,
  };

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _getStarted() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final profile = UserProfile(
      name: _nameController.text.trim(),
      nativeLanguage: _nativeLanguage,
      targetLanguage: _targetLanguage,
      expertiseLevel: _expertiseLevel,
    );

    await StorageService.instance.saveUserProfile(profile);
    await StorageService.instance.saveXP(0);

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                const Text('🌍', textAlign: TextAlign.center, style: TextStyle(fontSize: 56)),
                const SizedBox(height: 8),
                Text(
                  'Welcome!',
                  textAlign: TextAlign.center,
                  style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Set up your profile to start learning a new language.',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                ),
                const SizedBox(height: 32),

                Text('Your Name', style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    hintText: 'e.g. Ali',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                Text('Native Language', style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: _nativeLanguage,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.translate),
                    border: OutlineInputBorder(),
                  ),
                  items: MockData.nativeLanguages
                      .map((lang) => DropdownMenuItem(value: lang, child: Text(lang)))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _nativeLanguage = value);
                    }
                  },
                ),
                const SizedBox(height: 24),

                Text('Target Language', style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                ...MockData.targetLanguageOptions.map(
                  (lang) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _TargetLanguageCard(
                      language: lang,
                      selected: _targetLanguage == lang,
                      onTap: () => setState(() => _targetLanguage = lang),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                Text('Expertise Level', style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: MockData.expertiseLevels
                      .map(
                        (level) => ChoiceChip(
                          label: Text(
                            '$_levelEmoji(level) $level',
                            style: TextStyle(
                              color: _expertiseLevel == level
                                  ? Colors.white
                                  : _levelColors[level],
                            ),
                          ),
                          selected: _expertiseLevel == level,
                          selectedColor: _levelColors[level],
                          onSelected: (_) => setState(() => _expertiseLevel = level),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 32),

                FilledButton.icon(
                  onPressed: _getStarted,
                  icon: const Icon(Icons.rocket_launch),
                  label: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Text('Get Started', style: TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _levelEmoji(String level) {
    switch (level) {
      case 'Beginner':
        return '🔴';
      case 'Intermediate':
        return '🟡';
      case 'Advanced':
        return '🟢';
      default:
        return '';
    }
  }
}

class _TargetLanguageCard extends StatelessWidget {
  const _TargetLanguageCard({
    required this.language,
    required this.selected,
    required this.onTap,
  });

  final String language;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.12)
              : Theme.of(context).colorScheme.surface,
          border: Border.all(
            color: selected
                ? Theme.of(context).colorScheme.primary
                : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey,
            ),
            const SizedBox(width: 12),
            Text(language, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}