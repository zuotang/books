import 'package:flutter/material.dart';

@immutable
class ReadingThemeTokens extends ThemeExtension<ReadingThemeTokens> {
  const ReadingThemeTokens({
    required this.paperGradientTop,
    required this.paperGradientBottom,
    required this.shelfStart,
    required this.shelfEnd,
    required this.readerCard,
  });

  final Color paperGradientTop;
  final Color paperGradientBottom;
  final Color shelfStart;
  final Color shelfEnd;
  final Color readerCard;

  @override
  ReadingThemeTokens copyWith({
    Color? paperGradientTop,
    Color? paperGradientBottom,
    Color? shelfStart,
    Color? shelfEnd,
    Color? readerCard,
  }) {
    return ReadingThemeTokens(
      paperGradientTop: paperGradientTop ?? this.paperGradientTop,
      paperGradientBottom: paperGradientBottom ?? this.paperGradientBottom,
      shelfStart: shelfStart ?? this.shelfStart,
      shelfEnd: shelfEnd ?? this.shelfEnd,
      readerCard: readerCard ?? this.readerCard,
    );
  }

  @override
  ReadingThemeTokens lerp(
    ThemeExtension<ReadingThemeTokens>? other,
    double t,
  ) {
    if (other is! ReadingThemeTokens) {
      return this;
    }

    return ReadingThemeTokens(
      paperGradientTop:
          Color.lerp(paperGradientTop, other.paperGradientTop, t)!,
      paperGradientBottom:
          Color.lerp(paperGradientBottom, other.paperGradientBottom, t)!,
      shelfStart: Color.lerp(shelfStart, other.shelfStart, t)!,
      shelfEnd: Color.lerp(shelfEnd, other.shelfEnd, t)!,
      readerCard: Color.lerp(readerCard, other.readerCard, t)!,
    );
  }
}
