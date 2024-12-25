import 'package:flutter/material.dart';
import 'package:word_link/domain/objects/cards_collection_object.dart';
import 'package:word_link/presentation/atoms/atoms.dart';
import 'package:word_link/presentation/molecules/molecules.dart';
import 'package:word_link/presentation/pages/pages.dart';

class CustomCollectionsPage extends StatelessWidget {
  void addCollection(BuildContext context) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CreateCardsPage(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return PageEnclosureMolecule(
      title: 'Custom Collections',
      subTitle: 'Create collections and review them',
      expendChild: false,
      topBarType: TopBarType.back,
      floatingActionButtonOnTap: () => addCollection(context),
      child: ListView.builder(
        itemCount: CollectionsManager.customCards.length,
        itemBuilder: (context, index) {
          final CardsCollectionObject collection =
              CollectionsManager.customCards[index];

          return ListTileAtom(
            collection.name,
            subtitle: collection.cards.length.toString(),
            leading: const Icon(Icons.collections),
            trailing: const Icon(Icons.arrow_forward_rounded),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    PracticeCardsPage(cardCollection: collection),
              ),
            ),
          );
        },
      ),
    );
  }
}
