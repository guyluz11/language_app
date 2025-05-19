

import 'package:flutter/material.dart';
import 'package:site/presentation/atoms/atoms.dart';
import 'package:site/presentation/core/global_variables.dart';
import 'package:site/presentation/molecules/molecules.dart';

class PrivacyPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  PageEnclosureMolecule(
      title: 'Privacy Policy',
      topBarType: TopBarType.back,
      expendChild: false,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextAtom('The app ${GlobalVariables.appName}', variant: TextVariant.smallTitle,),
          ],
        ),
      ),
    );
  }
}
