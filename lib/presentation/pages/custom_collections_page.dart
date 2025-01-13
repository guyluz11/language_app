import 'package:flutter/material.dart';
import 'package:word_link/domain/controllers/controllers.dart';
import 'package:word_link/domain/objects/cards_collection_object.dart';
import 'package:word_link/presentation/atoms/atoms.dart';
import 'package:word_link/presentation/molecules/molecules.dart';
import 'package:word_link/presentation/pages/pages.dart';

class CustomCollectionsPage extends StatefulWidget {
  @override
  State<CustomCollectionsPage> createState() => _CustomCollectionsPageState();
}

class _CustomCollectionsPageState extends State<CustomCollectionsPage> {
  late List<CardsCollectionObject> customCards;

  @override
  void initState() {
    super.initState();
    customCards = getCards();
  }

  List<CardsCollectionObject> getCards() =>
      PreferencesController.instance.getCardsCollectionObject(
        PreferenceKeys.customCollections,
      ) ??
      [];

  void reloadCards() {
    setState(() {
      customCards = getCards();
    });
  }

  void addCollection(BuildContext context) => Navigator.of(context)
      .push(
        MaterialPageRoute(
          builder: (context) => CreateCardsPage(),
        ),
      )
      .then((_) => reloadCards());

  @override
  Widget build(BuildContext context) {
    return PageEnclosureMolecule(
      title: 'Custom Collections',
      subTitle: 'Create collections and review them',
      expendChild: false,
      topBarType: TopBarType.back,
      floatingActionButtonOnTap: () => addCollection(context),
      child: ListView.builder(
        itemCount: customCards.length,
        itemBuilder: (context, index) {
          final CardsCollectionObject collection = customCards[index];

          return ListTileAtom(
            collection.name,
            subtitle: collection.cards.length.toString(),
            leading: const Icon(Icons.collections),
            trailing: const Icon(Icons.arrow_forward_rounded),
            onTap: () => Navigator.of(context)
                .push(
                  MaterialPageRoute(
                    builder: (context) =>
                        PracticeCardsPage(cardCollection: collection),
                  ),
                )
                .then((_) => reloadCards()),
          );
        },
      ),
    );
  }
}
