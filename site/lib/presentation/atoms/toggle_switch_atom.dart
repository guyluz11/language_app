import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ToggleSwitchAtom extends StatefulWidget {
  const ToggleSwitchAtom({
    required this.offIcon,
    required this.onIcon,
    required this.onChange,
    required this.initialValue,
    this.controlByParent = false,
    this.disable = false,
  });

  final IconData offIcon;
  final IconData onIcon;
  final Function({required bool value}) onChange;
  final bool initialValue;
  final bool controlByParent;
  final bool disable;

  @override
  State<ToggleSwitchAtom> createState() => _ToggleSwitchAtomState();
}

class _ToggleSwitchAtomState extends State<ToggleSwitchAtom> {
  @override
  void initState() {
    super.initState();
    toggle = widget.initialValue;
  }

  late bool toggle;

  void onChange({required bool value}) {
    setState(() => toggle = value);
    widget.onChange(value: value);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final ColorScheme colorScheme = themeData.colorScheme;

    if (widget.controlByParent) {
      toggle = widget.initialValue;
    }

    return AnimatedToggleSwitch<bool>.rolling(
      style: ToggleStyle(
        backgroundColor: toggle
            ? (widget.disable
                ? colorScheme.onSurface.withAlpha((0.12 * 255).toInt())
                : colorScheme.primary)
            : (widget.disable
                ? colorScheme.surfaceContainerHighest
                    .withAlpha((0.12 * 255).toInt())
                : colorScheme.surfaceContainerHighest),
        borderColor: widget.disable
            ? colorScheme.onSurface
            : (toggle ? colorScheme.primary : colorScheme.outline),
        indicatorColor: toggle
            ? (widget.disable
                ? colorScheme.surface.withAlpha(1 * 255)
                : colorScheme.onPrimary)
            : (widget.disable
                ? colorScheme.onSurface.withAlpha((0.38 * 255).toInt())
                : colorScheme.outline),
      ),
      current: toggle,
      values: const [false, true],
      onChanged: (value) => widget.disable ? null : onChange(value: value),
      iconList: [
        FaIcon(
          widget.offIcon,
          color: widget.disable
              ? colorScheme.surfaceContainerHighest
                  .withAlpha((0.38 * 255).toInt())
              : colorScheme.surfaceContainerHighest,
        ),
        FaIcon(
          widget.onIcon,
          color: widget.disable
              ? colorScheme.onSurface.withAlpha((0.38 * 255).toInt())
              : colorScheme.onPrimaryContainer,
        ),
      ],
    );
  }
}
