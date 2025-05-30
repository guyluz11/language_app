import 'package:flutter/cupertino.dart';
import 'package:word_link/presentation/atoms/atoms.dart';

class DetailedCardOrganism extends StatelessWidget {
  const DetailedCardOrganism({
    required this.titleText,
    required this.subTitle,
    required this.buttonText,
    required this.onClick,
    required this.background,
    this.customContent,
  });

  final String titleText;
  final String subTitle;
  final String buttonText;
  final VoidCallback onClick;
  final Widget background;
  final Widget? customContent;

  @override
  Widget build(BuildContext context) {
    return CardAtom(
      image: background,
      onClick: onClick,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextAtom(
              titleText,
              variant: TextVariant.titleLarge,
            ),
            TextAtom(
              subTitle,
            ),
            if (customContent != null) ...[
              const SeparatorAtom(),
              customContent!,
            ],
            const SeparatorAtom(),
            ButtonAtom(
              text: buttonText,
              variant: ButtonVariant.mediumEmphasisOutlined,
              onPressed: onClick,
            ),
          ],
        ),
      ),
    );
  }
}
