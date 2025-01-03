import 'package:flutter/material.dart';
import 'package:word_link/domain/objects/card_object.dart';
import 'package:word_link/domain/objects/cards_collection_object.dart';
import 'package:word_link/presentation/atoms/atoms.dart';
import 'package:word_link/presentation/molecules/molecules.dart';
import 'package:word_link/presentation/organisms/create_card_organism.dart';

class CreateCardsPage extends StatefulWidget {
  @override
  State<CreateCardsPage> createState() => _CreateCardsPageState();
}

class _CreateCardsPageState extends State<CreateCardsPage> {
  CardObject currentMemoryObject = CardObject();
  List<CardObject> addedCards = [];
  bool nextAnimation = false;

  @override
  Widget build(BuildContext context) {
    return PageEnclosureMolecule(
      title: 'Custom Collections',
      subTitle: 'Create collections and review them',
      expendChild: false,
      topMargin: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SeparatorAtom(variant: SeparatorVariant.farApart),
          TextAtom('Cards Saved: ${addedCards.length}'),
          const SeparatorAtom(),
          Expanded(
            child: nextAnimation
                ? Center(child: ProgressAtom())
                : SingleChildScrollView(
                    child: CreateCardOrganism(
                      onNameChanged: onNameChanged,
                      onSecondaryNameChanged: onSecondaryNameChanged,
                      onAnswerChanged: onAnswerChanged,
                    ),
                  ),
          ),
          const SeparatorAtom(variant: SeparatorVariant.farApart),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonAtom(
                variant: ButtonVariant.mediumHighEmphasisFilledTonal,
                onPressed: onDone,
                text: 'Done',
              ),
              const SeparatorAtom(),
              ButtonAtom(
                variant: ButtonVariant.highEmphasisFilled,
                onPressed: anotherCard,
                text: 'Another Card',
              ),
            ],
          ),
          const SeparatorAtom(variant: SeparatorVariant.farApart),
        ],
      ),
    );
  }

  void onNameChanged(String value) => currentMemoryObject.name = value;
  void onSecondaryNameChanged(String value) =>
      currentMemoryObject.secondaryName = value;
  void onAnswerChanged(String value) => currentMemoryObject.answer = value;

  void onDone() {
    addedCards.add(currentMemoryObject);

    if (addedCards.isEmpty) {
      Navigator.pop(context);
      return;
    }
    String? collectionName;
    openAlertDialog(
      context,
      SizedBox(
        height: 230,
        child: PageEnclosureMolecule(
          title: 'Collection Name',
          subTitle: 'Choose name for your collection',
          expendChild: false,
          child: SingleChildScrollView(
            child: TextInputAtom(
              labelText: 'Name',
              onChanged: (value) => collectionName = value,
            ),
          ),
        ),
      ),
      onConfirm: () {
        final CardsCollectionObject collection = CardsCollectionObject(
          name: collectionName ?? 'Empty Name',
          cards: addedCards,
        );
        CollectionsManager.customCards.add(collection);

        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
  }

  Future<void> anotherCard() async {
    setState(() => nextAnimation = true);
    await Future.delayed(const Duration(seconds: 1));
    addedCards.add(currentMemoryObject);
    currentMemoryObject = CardObject();
    setState(() => nextAnimation = false);
  }
}
