import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:word_link/domain/controllers/controllers.dart';
import 'package:word_link/presentation/core/theme_data.dart';

class CardAtom extends StatelessWidget {
  const CardAtom({required this.child, this.onClick, this.image});

  final Widget child;
  final SvgPicture? image;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick != null
          ? () {
              VibrationController.instance.vibrate(VibrationType.light);
              onClick!();
            }
          : null,
      child: Card.filled(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            if (image != null)
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(15)),
                child: SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: image,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(AppThemeData.generalSpacing),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
