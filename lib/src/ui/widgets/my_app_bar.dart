import 'package:flutter/material.dart';

import 'buttons/buttons.dart';

class MyMessageAppBar extends AppBar {
  final VoidCallback onTapMessageButton;
  final int messageCounter;
  final Widget logo;

  MyMessageAppBar({
    this.onTapMessageButton,
    this.messageCounter,
    this.logo,
  }) : super(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          title: logo,
          actions: <Widget>[
            Center(
              child: MyMessagesButton(
                onTap: onTapMessageButton,
                counter: messageCounter,
              ),
            ),
            SizedBox(width: 12),
          ],
        );
}
