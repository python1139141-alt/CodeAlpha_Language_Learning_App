import '../models/category.dart';
import '../models/quiz_question.dart';
import '../models/word_item.dart';

/// Static mock data for the app. Content is provided for all three target
/// languages (Spanish, French, German) and is selected at runtime based on the
/// learner's profile.
class MockData {
  MockData._();

  static const List<String> nativeLanguages = [
    'Urdu',
    'English',
    'Hindi',
    'Arabic',
  ];

  static const List<String> targetLanguageOptions = ['Spanish', 'French', 'German'];

  static const List<String> expertiseLevels = [
    'Beginner',
    'Intermediate',
    'Advanced',
  ];

  static WordItem _w(
    String id,
    String categoryId,
    String word,
    String translation,
    String phonetic,
    String example,
  ) {
    return WordItem(
      id: id,
      categoryId: categoryId,
      word: word,
      translation: translation,
      phonetic: phonetic,
      exampleSentence: example,
    );
  }

  // ---------------------------------------------------------------------------
  // Categories
  // ---------------------------------------------------------------------------

  static const List<Category> _categories = [
    Category(
      id: 'greetings',
      title: 'Greetings & Basics',
      iconName: '👋',
      totalWords: 6,
    ),
    Category(
      id: 'food',
      title: 'Food & Drinks',
      iconName: '🍽️',
      totalWords: 6,
    ),
    Category(
      id: 'travel',
      title: 'Travel & Places',
      iconName: '✈️',
      totalWords: 6,
    ),
    Category(
      id: 'phrases',
      title: 'Daily Phrases',
      iconName: '💬',
      totalWords: 6,
    ),
  ];

  // ---------------------------------------------------------------------------
  // Words per language
  // ---------------------------------------------------------------------------

  static final List<WordItem> _spanishWords = [
    _w('es_g_1', 'greetings', 'hola', 'Hello', 'oh-la',
        'Hola, ¿cómo estás?'),
    _w('es_g_2', 'greetings', 'adiós', 'Goodbye', 'ah-dee-ohs',
        'Adiós, hasta mañana.'),
    _w('es_g_3', 'greetings', 'gracias', 'Thank you', 'grah-thee-ahs',
        'Gracias por tu ayuda.'),
    _w('es_g_4', 'greetings', 'por favor', 'Please', 'por fah-vor',
        'Por favor, ayúdame.'),
    _w('es_g_5', 'greetings', 'sí', 'Yes', 'see', 'Sí, quiero aprender.'),
    _w('es_g_6', 'greetings', 'no', 'No', 'noh', 'No, gracias.'),

    _w('es_f_1', 'food', 'pan', 'bread', 'pahn',
        'Este pan es muy suave.'),
    _w('es_f_2', 'food', 'agua', 'water', 'ah-gwah',
        '¿Puedo tomar agua?'),
    _w('es_f_3', 'food', 'manzana', 'apple', 'mahn-thah-nah',
        'La manzana es roja.'),
    _w('es_f_4', 'food', 'café', 'coffee', 'kah-feh',
        'Me gusta el café con leche.'),
    _w('es_f_5', 'food', 'leche', 'milk', 'leh-cheh',
        'Bebo leche por la mañana.'),
    _w('es_f_6', 'food', 'queso', 'cheese', 'keh-soh',
        'El queso está delicioso.'),

    _w('es_t_1', 'travel', 'aeropuerto', 'airport', 'ah-eh-roh-pwehr-toh',
        'El aeropuerto está lejos.'),
    _w('es_t_2', 'travel', 'tren', 'train', 'tren',
        'El tren sale a las nueve.'),
    _w('es_t_3', 'travel', 'hotel', 'hotel', 'oh-tehl',
        'El hotel tiene piscina.'),
    _w('es_t_4', 'travel', 'playa', 'beach', 'plah-yah',
        'La playa es hermosa.'),
    _w('es_t_5', 'travel', 'calle', 'street', 'kah-yeh',
        'Esta calle es larga.'),
    _w('es_t_6', 'travel', 'ciudad', 'city', 'thee-oo-dahd',
        'La ciudad es grande.'),

    _w('es_p_1', 'phrases', '¿Cómo estás?', 'How are you?', 'koh-moh ehs-tahs',
        'Hola, ¿cómo estás hoy?'),
    _w('es_p_2', 'phrases', 'No entiendo', "I don't understand",
        'noh ehn-tyehn-doh', 'No entiendo la pregunta.'),
    _w('es_p_3', 'phrases', '¿Dónde está...?', 'Where is...?',
        'dohn-deh ehs-tah', '¿Dónde está el baño?'),
    _w('es_p_4', 'phrases', '¿Qué hora es?', 'What time is it?',
        'keh oh-rah ehs', '¿Qué hora es ahora?'),
    _w('es_p_5', 'phrases', 'Te extraño', 'I miss you',
        'teh ehks-trah-nyoh', 'Te extraño mucho.'),
    _w('es_p_6', 'phrases', 'Tengo hambre', "I'm hungry", 'tehn-goh ahm-breh',
        'Tengo hambre ahora.'),
  ];

  static final List<WordItem> _frenchWords = [
    _w('fr_g_1', 'greetings', 'bonjour', 'Hello', 'bohn-zhoor',
        'Bonjour, comment ça va ?'),
    _w('fr_g_2', 'greetings', 'au revoir', 'Goodbye', 'oh ruh-vwahr',
        'Au revoir, à demain.'),
    _w('fr_g_3', 'greetings', 'merci', 'Thank you', 'mehr-see',
        'Merci pour votre aide.'),
    _w('fr_g_4', 'greetings', 's\'il vous plaît', 'Please', 'seel voo pleh',
        'S\'il vous plaît, aidez-moi.'),
    _w('fr_g_5', 'greetings', 'oui', 'Yes', 'wee',
        'Oui, je veux apprendre.'),
    _w('fr_g_6', 'greetings', 'non', 'No', 'nohn', 'Non, merci.'),

    _w('fr_f_1', 'food', 'pain', 'bread', 'pan',
        'Ce pain est très frais.'),
    _w('fr_f_2', 'food', 'eau', 'water', 'oh', 'Puis-je boire de l\'eau ?'),
    _w('fr_f_3', 'food', 'pomme', 'apple', 'pum', 'La pomme est rouge.'),
    _w('fr_f_4', 'food', 'café', 'coffee', 'kah-fay',
        'J\'aime le café au lait.'),
    _w('fr_f_5', 'food', 'lait', 'milk', 'leh', 'Je bois du lait le matin.'),
    _w('fr_f_6', 'food', 'fromage', 'cheese', 'froh-mahzh',
        'Le fromage est délicieux.'),

    _w('fr_t_1', 'travel', 'aéroport', 'airport', 'ah-eh-roh-por',
        'L\'aéroport est loin.'),
    _w('fr_t_2', 'travel', 'train', 'train', 'tran',
        'Le train part à neuf heures.'),
    _w('fr_t_3', 'travel', 'hôtel', 'hotel', 'oh-tel',
        'L\'hôtel a une piscine.'),
    _w('fr_t_4', 'travel', 'plage', 'beach', 'plahzh',
        'La plage est magnifique.'),
    _w('fr_t_5', 'travel', 'rue', 'street', 'rew', 'Cette rue est longue.'),
    _w('fr_t_6', 'travel', 'ville', 'city', 'veel', 'La ville est grande.'),

    _w('fr_p_1', 'phrases', 'Comment ça va ?', 'How are you?',
        'koh-mahn sah vah', 'Bonjour, comment ça va aujourd\'hui ?'),
    _w('fr_p_2', 'phrases', 'Je ne comprends pas', "I don't understand",
        'zhuh nuh kohn-prahn pah', 'Je ne comprends pas la question.'),
    _w('fr_p_3', 'phrases', 'Où est...?', 'Where is...?', 'oo eh',
        'Où est la salle de bains ?'),
    _w('fr_p_4', 'phrases', 'Quelle heure est-il ?', 'What time is it?',
        'kel er eh-teel', 'Quelle heure est-il maintenant ?'),
    _w('fr_p_5', 'phrases', 'Tu me manques', 'I miss you', 'tew muh mahnk',
        'Tu me manques beaucoup.'),
    _w('fr_p_6', 'phrases', 'J\'ai faim', "I'm hungry", 'zhay fan',
        'J\'ai faim maintenant.'),
  ];

  static final List<WordItem> _germanWords = [
    _w('de_g_1', 'greetings', 'hallo', 'Hello', 'hah-loh',
        'Hallo, wie geht es dir?'),
    _w('de_g_2', 'greetings', 'auf Wiedersehen', 'Goodbye',
        'owf vee-der-zay-en', 'Auf Wiedersehen, bis morgen.'),
    _w('de_g_3', 'greetings', 'danke', 'Thank you', 'dahn-keh',
        'Danke für deine Hilfe.'),
    _w('de_g_4', 'greetings', 'bitte', 'Please', 'bih-teh', 'Bitte, hilf mir.'),
    _w('de_g_5', 'greetings', 'ja', 'Yes', 'yah', 'Ja, ich möchte lernen.'),
    _w('de_g_6', 'greetings', 'nein', 'No', 'nine', 'Nein, danke.'),

    _w('de_f_1', 'food', 'Brot', 'bread', 'broht',
        'Dieses Brot ist sehr frisch.'),
    _w('de_f_2', 'food', 'Wasser', 'water', 'vah-ser',
        'Kann ich Wasser trinken?'),
    _w('de_f_3', 'food', 'Apfel', 'apple', 'ahp-fehl', 'Der Apfel ist rot.'),
    _w('de_f_4', 'food', 'Kaffee', 'coffee', 'kah-feh',
        'Ich mag Kaffee mit Milch.'),
    _w('de_f_5', 'food', 'Milch', 'milk', 'milch',
        'Ich trinke Milch am Morgen.'),
    _w('de_f_6', 'food', 'Käse', 'cheese', 'kay-zeh', 'Der Käse ist lecker.'),

    _w('de_t_1', 'travel', 'Flughafen', 'airport', 'floog-hah-fen',
        'Der Flughafen ist weit weg.'),
    _w('de_t_2', 'travel', 'Zug', 'train', 'tsoog',
        'Der Zug fährt um neun Uhr.'),
    _w('de_t_3', 'travel', 'Hotel', 'hotel', 'hoh-tel',
        'Das Hotel hat einen Pool.'),
    _w('de_t_4', 'travel', 'Strand', 'beach', 'shtrahnt',
        'Der Strand ist wunderschön.'),
    _w('de_t_5', 'travel', 'Straße', 'street', 'shtrah-seh',
        'Diese Straße ist lang.'),
    _w('de_t_6', 'travel', 'Stadt', 'city', 'shtaht', 'Die Stadt ist groß.'),

    _w('de_p_1', 'phrases', 'Wie geht es dir?', 'How are you?',
        'vee gayt es deer', 'Hallo, wie geht es dir heute?'),
    _w('de_p_2', 'phrases', 'Ich verstehe nicht', "I don't understand",
        'ich fer-shtay-eh nicht', 'Ich verstehe die Frage nicht.'),
    _w('de_p_3', 'phrases', 'Wo ist...?', 'Where is...?', 'voh ist',
        'Wo ist die Toilette?'),
    _w('de_p_4', 'phrases', 'Wie spät ist es?', 'What time is it?',
        'vee shpayt ist es', 'Wie spät ist es jetzt?'),
    _w('de_p_5', 'phrases', 'Ich vermisse dich', 'I miss you',
        'ich fer-miss-eh dich', 'Ich vermisse dich sehr.'),
    _w('de_p_6', 'phrases', 'Ich habe Hunger', "I'm hungry",
        'ich hah-beh hoong-er', 'Ich habe jetzt Hunger.'),
  ];

  static final Map<String, List<WordItem>> _wordsByLanguage = {
    'Spanish': _spanishWords,
    'French': _frenchWords,
    'German': _germanWords,
  };

  // ---------------------------------------------------------------------------
  // Quiz questions per language
  // ---------------------------------------------------------------------------

  static final Map<String, List<QuizQuestion>> _quizByLanguage = {
    'Spanish': [
      const QuizQuestion(
        question: 'What does "hola" mean?',
        options: ['Hello', 'Goodbye', 'Please', 'Thank you'],
        correctIndex: 0,
      ),
      const QuizQuestion(
        question: 'What is the Spanish word for "water"?',
        options: ['agua', 'pan', 'café', 'leche'],
        correctIndex: 0,
      ),
      const QuizQuestion(
        question: 'What does "gracias" mean?',
        options: ['Thank you', 'Yes', 'Please', 'Bread'],
        correctIndex: 0,
      ),
      const QuizQuestion(
        question: 'How do you say "airport" in Spanish?',
        options: ['aeropuerto', 'tren', 'playa', 'hotel'],
        correctIndex: 0,
      ),
      const QuizQuestion(
        question: 'What does "manzana" mean?',
        options: ['apple', 'bread', 'cheese', 'milk'],
        correctIndex: 0,
      ),
      const QuizQuestion(
        question: 'How do you say "please" in Spanish?',
        options: ['por favor', 'gracias', 'adiós', 'sí'],
        correctIndex: 0,
      ),
      const QuizQuestion(
        question: 'What does "playa" mean?',
        options: ['beach', 'city', 'street', 'train'],
        correctIndex: 0,
      ),
      const QuizQuestion(
        question: 'What does "¿Cómo estás?" mean?',
        options: ['How are you?', 'What time is it?', 'Where is...?', "I'm hungry"],
        correctIndex: 0,
      ),
      const QuizQuestion(
        question: 'What is the Spanish word for "cheese"?',
        options: ['queso', 'leche', 'pan', 'manzana'],
        correctIndex: 0,
      ),
      const QuizQuestion(
        question: 'What does "¿Dónde está...?" mean?',
        options: ['Where is...?', "I don't understand", 'I miss you', 'Goodbye'],
        correctIndex: 0,
      ),
    ],
    'French': [
      const QuizQuestion(
        question: 'What does "bonjour" mean?',
        options: ['Hello', 'Goodbye', 'Please', 'Thank you'],
        correctIndex: 0,
      ),
      const QuizQuestion(
        question: 'What is the French word for "water"?',
        options: ['eau', 'pain', 'pomme', 'café'],
        correctIndex: 0,
      ),
      const QuizQuestion(
        question: 'What does "merci" mean?',
        options: ['Thank you', 'Yes', 'Please', 'Bread'],
        correctIndex: 0,
      ),
      const QuizQuestion(
        question: 'How do you say "airport" in French?',
        options: ['aéroport', 'train', 'plage', 'hôtel'],
        correctIndex: 0,
      ),
      const QuizQuestion(
        question: 'What does "pomme" mean?',
        options: ['apple', 'bread', 'cheese', 'milk'],
        correctIndex: 0,
      ),
      const QuizQuestion(
        question: 'How do you say "please" in French?',
        options: ["s'il vous plaît", 'merci', 'au revoir', 'oui'],
        correctIndex: 0,
      ),
      const QuizQuestion(
        question: 'What does "plage" mean?',
        options: ['beach', 'city', 'train', 'street'],
        correctIndex: 0,
      ),
      const QuizQuestion(
        question: 'What does "Comment ça va ?" mean?',
        options: ['How are you?', 'What time is it?', 'Where is...?', "I'm hungry"],
        correctIndex: 0,
      ),
      const QuizQuestion(
        question: 'What is the French word for "cheese"?',
        options: ['fromage', 'lait', 'pain', 'pomme'],
        correctIndex: 0,
      ),
      const QuizQuestion(
        question: 'What does "Où est...?" mean?',
        options: ['Where is...?', 'I miss you', 'How are you?', 'Please'],
        correctIndex: 0,
      ),
    ],
    'German': [
      const QuizQuestion(
        question: 'What does "hallo" mean?',
        options: ['Hello', 'Goodbye', 'Please', 'Thank you'],
        correctIndex: 0,
      ),
      const QuizQuestion(
        question: 'What is the German word for "water"?',
        options: ['Wasser', 'Brot', 'Apfel', 'Kaffee'],
        correctIndex: 0,
      ),
      const QuizQuestion(
        question: 'What does "danke" mean?',
        options: ['Thank you', 'Yes', 'Please', 'Bread'],
        correctIndex: 0,
      ),
      const QuizQuestion(
        question: 'How do you say "airport" in German?',
        options: ['Flughafen', 'Zug', 'Strand', 'Hotel'],
        correctIndex: 0,
      ),
      const QuizQuestion(
        question: 'What does "Apfel" mean?',
        options: ['apple', 'bread', 'cheese', 'milk'],
        correctIndex: 0,
      ),
      const QuizQuestion(
        question: 'How do you say "please" in German?',
        options: ['bitte', 'danke', 'auf Wiedersehen', 'ja'],
        correctIndex: 0,
      ),
      const QuizQuestion(
        question: 'What does "Strand" mean?',
        options: ['beach', 'city', 'train', 'street'],
        correctIndex: 0,
      ),
      const QuizQuestion(
        question: 'What does "Wie geht es dir?" mean?',
        options: ['How are you?', 'What time is it?', 'Where is...?', "I'm hungry"],
        correctIndex: 0,
      ),
      const QuizQuestion(
        question: 'What is the German word for "cheese"?',
        options: ['Käse', 'Milch', 'Brot', 'Apfel'],
        correctIndex: 0,
      ),
      const QuizQuestion(
        question: 'What does "Wo ist...?" mean?',
        options: ['Where is...?', 'I miss you', 'How are you?', 'Please'],
        correctIndex: 0,
      ),
    ],
  };

  // ---------------------------------------------------------------------------
  // Public accessors
  // ---------------------------------------------------------------------------

  static List<Category> getCategories(String language) {
    return List.unmodifiable(_categories);
  }

  static Category? getCategoryById(String language, String categoryId) {
    for (final category in _categories) {
      if (category.id == categoryId) {
        return category;
      }
    }
    return null;
  }

  static List<WordItem> getWords(String language, String categoryId) {
    final all = _wordsByLanguage[language] ?? const <WordItem>[];
    return all.where((w) => w.categoryId == categoryId).toList();
  }

  static List<WordItem> getAllWords(String language) {
    return List.unmodifiable(_wordsByLanguage[language] ?? const []);
  }

  static WordItem? findWordById(String language, String id) {
    final all = _wordsByLanguage[language] ?? const <WordItem>[];
    for (final word in all) {
      if (word.id == id) {
        return word;
      }
    }
    return null;
  }

  static List<QuizQuestion> getQuizQuestions(String language) {
    return List.unmodifiable(_quizByLanguage[language] ?? const []);
  }
}