import 'package:flutter/material.dart';

class SocketioLogo extends StatelessWidget {
  static const String asset = 'assets/socket_io.png';

  const SocketioLogo({this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: asset,
      child: Image.asset(asset, width: width),
    );
  }
}
