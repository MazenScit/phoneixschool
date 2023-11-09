import 'package:flutter/material.dart';
import 'package:phoenixschool/component/Color.dart';

import '../component/myimage.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        color: globalcolor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Container(
              height: 60,
              padding: EdgeInsets.all(2),
              child: Image.asset(logo_brandimage)),
          ],
        )),
    );
  }
}