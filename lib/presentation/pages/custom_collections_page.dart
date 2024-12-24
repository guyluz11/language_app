import 'package:flutter/material.dart';
import 'package:word_link/infrastructure/core/logger.dart';
import 'package:word_link/presentation/molecules/molecules.dart';
import 'package:word_link/presentation/pages/create_cards_page.dart';

class CustomCollectionsPage extends StatelessWidget {
  void addCollection(BuildContext context) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CreateCardsPage(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    logger.v('d');

    return PageEnclosureMolecule(
      title: 'Custom Collections',
      subTitle: 'Create collections and review them',
      expendChild: false,
      floatingActionButtonOnTap: () => addCollection(context),
      child: const SingleChildScrollView(
        child: SizedBox(),
      ),
    );
  }
}
