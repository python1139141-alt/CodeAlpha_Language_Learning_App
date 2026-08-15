import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/word_item.dart';
import '../services/storage_service.dart';
import '../services/tts_service.dart';
import '../widgets/flashcard_widget.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({
    super.key,
    required this.category,
    required this.language,
    required this.words,
  });

  final Category category;
  final String language;
  final List<WordItem> words;

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Set<String> _bookmarkedIds = {};

  String get _languageCode =>
      TTSService.instance.languageCodeFor(widget.language);

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    final ids = await StorageService.instance.getBookmarks();
    if (mounted) {
      setState(() => _bookmarkedIds = ids.toSet());
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _speak(String text, {double speed = 1.0}) async {
    await TTSService.instance.speak(text, _languageCode, speed: speed);
  }

  void _onPageChanged(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final words = widget.words;
    final total = words.length;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${widget.category.iconName} ${widget.category.title}'),
            Text(
              'Word ${_currentIndex + 1} of $total',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (total == 0) ? 0 : (_currentIndex + 1) / total,
            minHeight: 6,
            backgroundColor: Colors.grey.shade200,
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: total,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) {
                final word = words[index];
                return FlashcardWidget(
                  key: ValueKey(word.id),
                  word: word.copyWith(isBookmarked: _bookmarkedIds.contains(word.id)),
                  languageCode: _languageCode,
                  onBookmarkChanged: (_) => _loadBookmarks(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
            child: Row(
              children: [
                FilledButton.tonalIcon(
                  onPressed: () => _speak(words[_currentIndex].word),
                  icon: const Icon(Icons.volume_up, size: 20),
                  label: const Text('Sound'),
                ),
                const SizedBox(width: 12),
                FilledButton.tonalIcon(
                  onPressed: () =>
                      _speak(words[_currentIndex].word, speed: 0.5),
                  icon: const Text('🐢', style: TextStyle(fontSize: 18)),
                  label: const Text('Slow Sound'),
                ),
                const Spacer(),
                IconButton.filled(
                  onPressed: _currentIndex < total - 1
                      ? () => _pageController.nextPage(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                          )
                      : null,
                  icon: const Icon(Icons.arrow_forward),
                  tooltip: 'Next',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}