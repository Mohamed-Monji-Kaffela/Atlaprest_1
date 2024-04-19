import 'package:flutter/material.dart';

import 'length_state_realise_green.dart';
import 'length_state_rouge.dart';
import 'length_validation_green.dart';
import 'length_validation_orange.dart';
import 'length_validation_white.dart';

class AllLength extends StatefulWidget {
  const AllLength({super.key});

  @override
  State<AllLength> createState() => _AllLengthState();
}

class _AllLengthState extends State<AllLength> {
  @override
  Widget build(BuildContext context) {
    return Container(child:
    ClipRect(
        child: Row(children:[
          Spacer(flex: 1,),
          Validation(),
          Spacer(flex: 1,),
          NotValidation(),
          Spacer(flex: 1,),
          NullValidation(),
          Spacer(flex: 1,),
          StateOK(),
          Spacer(flex: 1,),
          StateNOK(),
          Spacer(flex: 1,),
        ],
        ),
      ),
    );
  }
}
