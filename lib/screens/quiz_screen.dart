import 'dart:math';

import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/quiz_question.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.language});

  final String language;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final List<QuizQuestion> _questions;
  late final int _totalQuestions;

  int _currentIndex = 0;
  int _correctCount = 0;
  int? _selectedIndex;

  static const int _xpPerCorrect = 10;

  @override
  void initState() {
    super.initState();
    final pool = List<QuizQuestion>.from(
      MockData.getQuizQuestions(widget.language),
    )..shuffle(Random());
    _questions = pool.take(5).toList();
    _totalQuestions = _questions.length;
  }

  bool get _answered => _selectedIndex != null;

  QuizQuestion get _currentQuestion => _questions[_currentIndex];

  void _selectOption(int index) {
    if (_answered) return;

    setState(() {
      _selectedIndex = index;
      if (index == _currentQuestion.correctIndex) {
        _correctCount++;
      }
    });
  }

  void _next() {
    if (_currentIndex < _totalQuestions - 1) {
      setState(() {
        _currentIndex++;
        _selectedIndex = null;
      });
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            correctCount: _correctCount,
            totalQuestions: _totalQuestions,
            xpEarned: _correctCount * _xpPerCorrect,
            language: widget.language,
          ),
        ),
      );
    }
  }

  Color _optionColor(int index) {
    if (!_answered) {
      return Theme.of(context).colorScheme.surface;
    }
    if (index == _currentQuestion.correctIndex) {
      return Colors.green.shade100;
    }
    if (index == _selectedIndex) {
      return Colors.red.shade100;
    }
    return Theme.of(context).colorScheme.surface;
  }

  BoxBorder? _optionBorder(int index) {
    if (!_answered) {
      return null;
    }
    if (index == _currentQuestion.correctIndex) {
      return Border.all(color: Colors.green.shade600, width: 2);
    }
    if (index == _selectedIndex) {
      return Border.all(color: Colors.red.shade600, width: 2);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz: ${widget.language}'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            LinearProgressIndicator(
              value: (_currentIndex + 1) / _totalQuestions,
              minHeight: 6,
              backgroundColor: Colors.grey.shade200,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: [
                  Text(
                    'Question ${_currentIndex + 1} of $_totalQuestions',
                    style: textTheme.titleSmall,
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.star, size: 16, color: Colors.amber.shade700),
                        const SizedBox(width: 4),
                        Text(
                          '$_correctCount × $_xpPerCorrect XP',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    _currentQuestion.question,
                    style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  ..._currentQuestion.options.asMap().entries.map((entry) {
                    final index = entry.key;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Material(
                        color: _optionColor(index),
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          onTap: _answered ? null : () => _selectOption(index),
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: _optionBorder(index),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  _answered &&
                                          index == _currentQuestion.correctIndex
                                      ? Icons.check_circle
                                      : (_answered && index == _selectedIndex
                                          ? Icons.cancel
                                          : Icons.radio_button_unchecked),
                                  color: _answered
                                      ? (index == _currentQuestion.correctIndex
                                          ? Colors.green.shade600
                                          : (index == _selectedIndex
                                              ? Colors.red.shade600
                                              : Colors.grey.shade400))
                                      : colorScheme.primary,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    entry.value,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  if (_answered) ...[
                    const SizedBox(height: 8),
                    FilledButton(
                      onPressed: _next,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                      ),
                      child: Text(
                        _currentIndex < _totalQuestions - 1
                            ? 'Next Question'
                            : 'See Results',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}