class WordItem {
  final String id;
  final String categoryId;
  final String word;
  final String translation;
  final String phonetic;
  final String exampleSentence;
  final bool isBookmarked;

  const WordItem({
    required this.id,
    required this.categoryId,
    required this.word,
    required this.translation,
    required this.phonetic,
    required this.exampleSentence,
    this.isBookmarked = false,
  });

  WordItem copyWith({bool? isBookmarked}) {
    return WordItem(
      id: id,
      categoryId: categoryId,
      word: word,
      translation: translation,
      phonetic: phonetic,
      exampleSentence: exampleSentence,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'word': word,
      'translation': translation,
      'phonetic': phonetic,
      'exampleSentence': exampleSentence,
      'isBookmarked': isBookmarked,
    };
  }

  factory WordItem.fromMap(Map<String, dynamic> map) {
    return WordItem(
      id: map['id'] as String? ?? '',
      categoryId: map['categoryId'] as String? ?? '',
      word: map['word'] as String? ?? '',
      translation: map['translation'] as String? ?? '',
      phonetic: map['phonetic'] as String? ?? '',
      exampleSentence: map['exampleSentence'] as String? ?? '',
      isBookmarked: map['isBookmarked'] as bool? ?? false,
    );
  }
}