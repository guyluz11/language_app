import 'package:flutter/material.dart';
import 'package:word_link/domain/global_variables/global_functions.dart';
import 'package:word_link/presentation/atoms/atoms.dart';

class ButtonAtom extends StatefulWidget {
  const ButtonAtom({
    required this.variant,
    required this.onPressed,
    super.key,
    this.text,
    this.icon,
    this.disabled = false,
    this.disableActionType = false,
    this.translate = true,
  });

  final ButtonVariant variant;
  final VoidCallback onPressed;
  final String? text;
  final IconData? icon;
  final bool disabled;
  final bool translate;
  final bool disableActionType;

  @override
  State<ButtonAtom> createState() => ButtonAtomState();
}

class ButtonAtomState extends State<ButtonAtom> {
  double get width => 150;

  double get _height => 60;

  Future<void> onPress() async {
    await tapWithSoundAndVibration();
    widget.onPressed();
  }

  Widget buttonConstraints({required Widget child}) => Container(
        constraints: BoxConstraints(
          minWidth: width,
        ),
        height: _height,
        child: child,
      );

  Widget label(TextTheme textTheme, {Color? color}) => TextAtom(
        widget.text ?? '',
        translate: widget.translate,
        maxLines: 1,
        style: textTheme.bodyLarge!.copyWith(color: color),
      );

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;
    final ColorScheme colorScheme = themeData.colorScheme;

    switch (widget.variant) {
      case ButtonVariant.highEmphasisFilled:
        if (widget.icon == null) {
          return buttonConstraints(
            child: FilledButton(
              onPressed: widget.disabled ? null : onPress,
              style: widget.disabled
                  ? null
                  : FilledButton.styleFrom().copyWith(
                      alignment: Alignment.center,
                      backgroundColor: WidgetStateProperty.all(
                        colorScheme.secondaryContainer,
                      ),
                    ),
              child: label(textTheme, color: colorScheme.onPrimaryContainer),
            ),
          );
        }
        return buttonConstraints(
          child: FilledButton.icon(
            onPressed: widget.disabled ? null : onPress,
            style: widget.disabled
                ? null
                : FilledButton.styleFrom().copyWith(
                    alignment: Alignment.center,
                    backgroundColor:
                        WidgetStateProperty.all(colorScheme.secondaryContainer),
                  ),
            icon: Icon(widget.icon, color: colorScheme.onPrimaryContainer),
            label: label(textTheme, color: colorScheme.onPrimaryContainer),
          ),
        );

      case ButtonVariant.mediumHighEmphasisFilledTonal:
        if (widget.icon == null) {
          return buttonConstraints(
            child: FilledButton.tonal(
              onPressed: widget.disabled ? null : onPress,
              style: widget.disabled
                  ? null
                  : FilledButton.styleFrom().copyWith(
                      alignment: Alignment.center,
                      backgroundColor: WidgetStateProperty.all(
                        colorScheme.secondaryContainer,
                      ),
                    ),
              child: label(textTheme, color: colorScheme.onSecondaryContainer),
            ),
          );
        }
        return buttonConstraints(
          child: FilledButton.tonalIcon(
            onPressed: widget.disabled ? null : onPress,
            style: widget.disabled
                ? null
                : FilledButton.styleFrom().copyWith(
                    alignment: Alignment.center,
                    backgroundColor:
                        WidgetStateProperty.all(colorScheme.secondaryContainer),
                  ),
            icon: Icon(widget.icon, color: colorScheme.onSecondaryContainer),
            label: label(textTheme, color: colorScheme.onSecondaryContainer),
          ),
        );
      case ButtonVariant.mediumEmphasisOutlined:
        if (widget.icon == null) {
          return buttonConstraints(
            child: OutlinedButton(
              onPressed: widget.disabled ? null : onPress,
              child: label(textTheme, color: colorScheme.primary),
            ),
          );
        }
        return buttonConstraints(
          child: OutlinedButton.icon(
            onPressed: widget.disabled ? null : onPress,
            icon: Icon(widget.icon, color: colorScheme.primary),
            label: label(textTheme, color: colorScheme.primary),
          ),
        );
      case ButtonVariant.lowEmphasisText:
        if (widget.icon == null) {
          return buttonConstraints(
            child: TextButton(
              onPressed: widget.disabled ? null : onPress,
              child: label(textTheme, color: colorScheme.primary),
            ),
          );
        }
        return buttonConstraints(
          child: TextButton.icon(
            onPressed: widget.disabled ? null : onPress,
            icon: Icon(widget.icon, color: colorScheme.primary),
            label: label(textTheme, color: colorScheme.primary),
          ),
        );
      case ButtonVariant.lowEmphasisIcon:
        return IconButton(
          onPressed: onPress,
          color: colorScheme.primary,
          icon: Icon(widget.icon),
        );
    }
  }
}

/// See "Choosing buttons" section https://m3.material.io/components/all-buttons
enum ButtonVariant {
  highEmphasisFilled,
  mediumHighEmphasisFilledTonal,
  mediumEmphasisOutlined,
  lowEmphasisText,
  lowEmphasisIcon,
}
