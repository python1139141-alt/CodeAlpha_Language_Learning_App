import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/word_item.dart';
import '../services/storage_service.dart';
import '../services/tts_service.dart';

class SavedWordsScreen extends StatefulWidget {
  const SavedWordsScreen({super.key, required this.language});

  final String language;

  @override
  State<SavedWordsScreen> createState() => _SavedWordsScreenState();
}

class _SavedWordsScreenState extends State<SavedWordsScreen> {
  List<WordItem> _savedWords = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedWords();
  }

  @override
  void didUpdateWidget(covariant SavedWordsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.language != widget.language) {
      _loadSavedWords();
    }
  }

  Future<void> _loadSavedWords() async {
    setState(() => _loading = true);
    final ids = await StorageService.instance.getBookmarks();
    final words = <WordItem>[];
    for (final id in ids) {
      final word = MockData.findWordById(widget.language, id);
      if (word != null) {
        words.add(word);
      }
    }
    if (!mounted) return;
    setState(() {
      _savedWords = words;
      _loading = false;
    });
  }

  Future<void> _play(WordItem word) async {
    await TTSService.instance.speak(
      word.word,
      TTSService.instance.languageCodeFor(widget.language),
    );
  }

  Future<void> _remove(WordItem word) async {
    await StorageService.instance.removeBookmark(word.id);
    _loadSavedWords();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Saved Words')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _savedWords.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.bookmark_border,
                          size: 64, color: Colors.grey.shade400),
                      const SizedBox(height: 12),
                      const Text(
                        'No saved words yet',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Tap the bookmark icon on a flashcard to save words here.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _savedWords.length,
                  itemBuilder: (context, index) {
                    final word = _savedWords[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              colorScheme.primaryContainer.withValues(alpha: 0.6),
                          child: const Icon(Icons.menu_book),
                        ),
                        title: Text(
                          word.word,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '${word.translation}\n${word.exampleSentence}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () => _play(word),
                              icon: Icon(Icons.volume_up,
                                  color: colorScheme.primary),
                              tooltip: 'Listen',
                            ),
                            IconButton(
                              onPressed: () => _remove(word),
                              icon: const Icon(Icons.bookmark_remove),
                              tooltip: 'Remove',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}