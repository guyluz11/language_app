import 'package:flutter/material.dart';
import 'package:word_link/presentation/atoms/atoms.dart';
import 'package:word_link/presentation/core/theme_data.dart';
import 'package:word_link/presentation/molecules/molecules.dart';

class PageEnclosureMolecule extends StatelessWidget {
  const PageEnclosureMolecule({
    required this.title,
    required this.child,
    this.subTitle,
    this.margin = true,
    this.topMargin = true,
    this.topBarTranslate = true,
    this.topBarType = TopBarType.none,
    this.scaffold = true,
    this.topBarLeftOnTap,
    this.floatingActionButtonOnTap,
    this.topBarRightOnTap,
    this.rightPopupMenu,
    this.expendChild = true,
    this.topBarRightWidget,
    this.logoBackgroundColor = false,
    super.key,
  });

  final Widget child;
  final String title;
  final String? subTitle;
  final bool topBarTranslate;
  final bool margin;
  final bool topMargin;
  final bool scaffold;
  final VoidCallback? floatingActionButtonOnTap;
  final TopBarType topBarType;
  final VoidCallback? topBarLeftOnTap;
  final VoidCallback? topBarRightOnTap;
  final List<PopupMenuEntryAtom<Enum>>? rightPopupMenu;
  final bool expendChild;
  final Widget? topBarRightWidget;
  final bool logoBackgroundColor;

  Widget topBarHelper() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TopBarMolecule(
          topBarType: topBarType,
          title: title,
          margin: false,
          translate: topBarTranslate,
          leftOnTap: topBarLeftOnTap,
          rightOnTap: topBarRightOnTap,
          rightPopupMenu: rightPopupMenu,
          rightWidget: topBarRightWidget,
        ),
        if (subTitle != null)
          TextAtom(
            subTitle!,
            variant: TextVariant.smallTitle,
          ),
        if (topMargin) const SeparatorAtom(),
        Expanded(
          child: child,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget page = topBarHelper();

    if (margin) {
      page = MarginedExpandedAtom(child: page);
    }

    if (logoBackgroundColor) {
      page = ColoredBox(
        color: AppThemeData.logoSecondaryBackgroundColor,
        child: page,
      );
    }

    if (scaffold) {
      page = Scaffold(
        body: page,
        floatingActionButton: floatingActionButtonOnTap == null
            ? null
            : FloatingActionButton(
                onPressed: floatingActionButtonOnTap,
                child: const Icon(Icons.add),
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );
    }
    if (expendChild) {
      page = Expanded(child: page);
    }

    return page;
  }
}
