import 'package:flutter/cupertino.dart';
import 'package:word_link/presentation/atoms/atoms.dart';

class CreateCardOrganism extends StatelessWidget {
  const CreateCardOrganism({
    required this.onNameChanged,
    required this.onSecondaryNameChanged,
    required this.onAnswerChanged,
  });

  final void Function(String) onNameChanged;
  final void Function(String) onSecondaryNameChanged;
  final void Function(String) onAnswerChanged;

  @override
  Widget build(BuildContext context) {
    return CardAtom(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlutterLogo(),
              ],
            ),
            const SeparatorAtom(),
            TextInputAtom(
              labelText: 'Item Name',
              onChanged: onNameChanged,
            ),
            const SeparatorAtom(),
            TextInputAtom(
              labelText: 'Secondary Name (Optional)',
              onChanged: onSecondaryNameChanged,
            ),
            const SeparatorAtom(),
            TextInputAtom(
              labelText: 'Answer',
              onChanged: onAnswerChanged,
            ),
            const SeparatorAtom(),
          ],
        ),
      ),
      onClick: () {},
    );
  }
}
