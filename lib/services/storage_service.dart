import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_profile.dart';

class StorageService {
  StorageService._();

  static final StorageService instance = StorageService._();

  static const String _profileKey = 'user_profile';
  static const String _xpKey = 'total_xp';
  static const String _bookmarksKey = 'bookmarked_word_ids';

  Future<void> saveUserProfile(UserProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_profileKey, profile.toJson());
  }

  Future<UserProfile?> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_profileKey);
    if (raw == null || raw.isEmpty) {
      return null;
    }
    try {
      return UserProfile.fromJson(raw);
    } catch (_) {
      return null;
    }
  }

  Future<void> saveXP(int points) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_xpKey, points);
  }

  Future<int> getXP() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_xpKey) ?? 0;
  }

  Future<void> saveBookmark(String wordId) async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getStringList(_bookmarksKey) ?? <String>[];
    if (!current.contains(wordId)) {
      current.add(wordId);
      await prefs.setStringList(_bookmarksKey, current);
    }
  }

  Future<void> removeBookmark(String wordId) async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getStringList(_bookmarksKey) ?? <String>[];
    current.remove(wordId);
    await prefs.setStringList(_bookmarksKey, current);
  }

  Future<bool> toggleBookmark(String wordId) async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getStringList(_bookmarksKey) ?? <String>[];
    if (current.contains(wordId)) {
      current.remove(wordId);
      await prefs.setStringList(_bookmarksKey, current);
      return false;
    } else {
      current.add(wordId);
      await prefs.setStringList(_bookmarksKey, current);
      return true;
    }
  }

  Future<List<String>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_bookmarksKey) ?? <String>[];
  }
}