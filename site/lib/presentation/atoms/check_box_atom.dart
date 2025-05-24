import 'package:flutter/material.dart';
import 'package:site/domain/controllers/controllers.dart';

class CheckBoxAtom extends StatefulWidget {
  const CheckBoxAtom({
    required this.callback,
    this.initialValue = false,
    this.controlByParent = false,
    this.isSound = true,
  });

  final bool initialValue;
  final Function({required bool value}) callback;
  final bool controlByParent;
  final bool isSound;

  @override
  State<CheckBoxAtom> createState() => _CheckBoxAtomState();
}

class _CheckBoxAtomState extends State<CheckBoxAtom> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialValue;
  }

  void onChange({required bool? value}) {
    setState(() {
      isChecked = value!;
    });
    VibrationController.instance.vibrate(VibrationType.light);

    if (widget.isSound && isChecked) {
      PlayerController.instance.play(SoundType.checkBoxChecked);
    }

    widget.callback(value: isChecked);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controlByParent) {
      isChecked = widget.initialValue;
    }

    return Checkbox(
      value: isChecked,
      onChanged: (value) => onChange(value: value),
    );
  }
}
