import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/category.dart';
import '../models/user_profile.dart';
import '../services/storage_service.dart';
import '../widgets/category_card.dart';
import 'analytics_screen.dart';
import 'lesson_screen.dart';
import 'quiz_screen.dart';
import 'saved_words_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserProfile? _profile;
  int _xp = 0;
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final profile = await StorageService.instance.getUserProfile();
    final xp = await StorageService.instance.getXP();
    if (!mounted) return;
    setState(() {
      _profile = profile;
      _xp = xp;
    });
  }

  String get _targetLanguage => _profile?.targetLanguage ?? 'Spanish';

  Future<void> _openLesson(Category category) async {
    final words = MockData.getWords(_targetLanguage, category.id);
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => LessonScreen(
          category: category,
          language: _targetLanguage,
          words: words,
        ),
      ),
    );
    _loadData();
  }

  Future<void> _openQuiz() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => QuizScreen(language: _targetLanguage),
      ),
    );
    _loadData();
  }

  Future<void> _editLanguage() async {
    final selected = await showDialog<String>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Change target language'),
        children: MockData.targetLanguageOptions.map((lang) {
          return SimpleDialogOption(
            onPressed: () => Navigator.of(ctx).pop(lang),
            child: Row(
              children: [
                const Icon(Icons.flag_outlined),
                const SizedBox(width: 12),
                Text(lang),
                const Spacer(),
                if (lang == _targetLanguage)
                  const Icon(Icons.check, color: Colors.green),
              ],
            ),
          );
        }).toList(),
      ),
    );

    if (selected != null && selected != _targetLanguage && _profile != null) {
      await StorageService.instance
          .saveUserProfile(_profile!.copyWith(targetLanguage: selected));
      _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = _profile;
    return Scaffold(
      body: IndexedStack(
        index: _pageIndex,
        children: [
          _buildDashboard(context, profile),
          SavedWordsScreen(language: _targetLanguage),
          AnalyticsScreen(profile: profile, xp: _xp),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _pageIndex,
        onDestinationSelected: (index) => setState(() => _pageIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_outline),
            selectedIcon: Icon(Icons.bookmark),
            label: 'Saved Words',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Analytics',
          ),
        ],
      ),
    );
  }

  Widget _buildDashboard(BuildContext context, UserProfile? profile) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _loadData,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back!',
                            style: textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
                          ),
                          Text(
                            profile?.name ?? 'Learner',
                            style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    _BadgeChip(icon: const Icon(Icons.local_fire_department, color: Colors.orange, size: 18), label: '${profile?.streakDays ?? 1}-Day Streak'),
                    const SizedBox(width: 8),
                    _BadgeChip(
                      icon: Icon(Icons.star, color: Colors.amber.shade600, size: 18),
                      label: '$_xp XP',
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: _LanguageBanner(
                  targetLanguage: _targetLanguage,
                  expertiseLevel: profile?.expertiseLevel ?? 'Beginner',
                  onEdit: _editLanguage,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Categories',
                  style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.15,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final category = MockData.getCategories(_targetLanguage)[index];
                    return CategoryCard(
                      category: category,
                      onTap: () => _openLesson(category),
                    );
                  },
                  childCount: MockData.getCategories(_targetLanguage).length,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                child: FilledButton.icon(
                  onPressed: _openQuiz,
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                    backgroundColor: colorScheme.primary,
                  ),
                  icon: const Icon(Icons.quiz),
                  label: const Text('Practice Quiz', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BadgeChip extends StatelessWidget {
  const _BadgeChip({required this.icon, required this.label});

  final Widget icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [icon, const SizedBox(width: 4), Text(label, style: const TextStyle(fontWeight: FontWeight.w600))],
      ),
    );
  }
}

class _LanguageBanner extends StatelessWidget {
  const _LanguageBanner({
    required this.targetLanguage,
    required this.expertiseLevel,
    required this.onEdit,
  });

  final String targetLanguage;
  final String expertiseLevel;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.primary, colorScheme.tertiary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Text('🎓', style: TextStyle(fontSize: 22)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Learning',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                Text(
                  '$targetLanguage ($expertiseLevel)',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onEdit,
            icon: const Icon(Icons.edit, color: Colors.white, size: 20),
            tooltip: 'Change language',
          ),
        ],
      ),
    );
  }
}