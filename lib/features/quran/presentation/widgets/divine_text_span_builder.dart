import 'package:flutter/material.dart';
import 'package:muslim_werd_app/features/quran/domain/services/divine_name_matcher.dart';

class DivineTextSpanBuilder {
  const DivineTextSpanBuilder._();

  static const Color allahLightColor = Color(0xFFE53935);
  static const Color allahDarkColor = Color(0xFFFF5252);
  static const Color rabLightColor = Color(0xFFE53935);
  static const Color rabDarkColor = Color(0xFFFF5252);

  /// يبني أقساماً نصية ملوّنة من نتائج [DivineNameMatcher.findMatches].
  static List<InlineSpan> highlightDivineNames(
    String text, {
    required TextStyle normal,
    required TextStyle allah,
    required TextStyle rab,
  }) {
    final matches = DivineNameMatcher.findMatches(text);
    if (matches.isEmpty) {
      return [TextSpan(text: text, style: normal)];
    }

    final spans = <InlineSpan>[];
    var lastEnd = 0;

    for (final match in matches) {
      final style = match.kind == DivineKind.allah ? allah : rab;
      if (match.start > lastEnd) {
        spans.add(
          TextSpan(text: text.substring(lastEnd, match.start), style: normal),
        );
      }
      spans.add(
        TextSpan(text: text.substring(match.start, match.end), style: style),
      );
      lastEnd = match.end;
    }

    if (lastEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastEnd), style: normal));
    }

    return spans;
  }
}
