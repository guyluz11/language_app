import 'package:flutter/material.dart';

class TextAtom extends StatelessWidget {
  const TextAtom(
    this.text, {
    super.key,
    this.style = const TextStyle(),
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.translationArgs,
    this.translate = true,
    this.variant = TextVariant.regular,
  });

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final List<String>? translationArgs;
  final bool translate;
  final TextVariant variant;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;
    TextStyle? tempStyle = style;

    switch (variant) {
      case TextVariant.regular:
        // tempStyle = textTheme.bodyMedium;
        break;
      case TextVariant.smallTitle:
        tempStyle = textTheme.titleMedium;
      case TextVariant.title:
        tempStyle = textTheme.titleLarge;
      case TextVariant.titleLarge:
        tempStyle = textTheme.headlineMedium;
      case TextVariant.medium:
        tempStyle = textTheme.bodyMedium;
    }

    return Text(
      // translate && text.isNotEmpty ? text.tr(args: translationArgs) : text,
      text,
      style: tempStyle,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }
}

enum TextVariant {
  titleLarge,
  title,
  smallTitle,

  /// define out side, trying to deprecate
  regular,
  medium,
  ;
}
