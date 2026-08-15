import 'package:flutter/material.dart';

import '../services/storage_service.dart';
import 'quiz_screen.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    super.key,
    required this.correctCount,
    required this.totalQuestions,
    required this.xpEarned,
    required this.language,
  });

  final int correctCount;
  final int totalQuestions;
  final int xpEarned;
  final String language;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    super.initState();
    _saveXP();
  }

  Future<void> _saveXP() async {
    final current = await StorageService.instance.getXP();
    await StorageService.instance.saveXP(current + widget.xpEarned);
  }

  double get _percentage =>
      widget.totalQuestions == 0
          ? 0
          : (widget.correctCount / widget.totalQuestions) * 100;

  IconData get _resultIcon {
    if (_percentage >= 80) return Icons.emoji_events;
    if (_percentage >= 50) return Icons.sentiment_satisfied;
    return Icons.sentiment_dissatisfied;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Container(
                width: 110,
                height: 110,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(_resultIcon,
                    size: 60, color: colorScheme.primary),
              ),
              const SizedBox(height: 24),
              Text(
                'Quiz Complete!',
                textAlign: TextAlign.center,
                style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _ScoreRow(
                      label: 'Correct Answers',
                      value: '${widget.correctCount} / ${widget.totalQuestions}',
                    ),
                    const SizedBox(height: 12),
                    _ScoreRow(
                      label: 'Percentage',
                      value: '${_percentage.toStringAsFixed(0)}%',
                    ),
                    const SizedBox(height: 12),
                    _ScoreRow(
                      label: 'XP Earned',
                      value: '+${widget.xpEarned} XP',
                      valueColor: Colors.amber.shade800,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              FilledButton.icon(
                onPressed: () =>
                    Navigator.of(context).popUntil((route) => route.isFirst),
                style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
                icon: const Icon(Icons.home),
                label: const Text('Back to Home', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => QuizScreen(language: widget.language),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(52)),
                icon: const Icon(Icons.replay),
                label: const Text('Retry Quiz', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScoreRow extends StatelessWidget {
  const _ScoreRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.grey.shade600)),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}