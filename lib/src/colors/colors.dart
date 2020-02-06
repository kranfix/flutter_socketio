import 'dart:ui';

extension HexColorX on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color from(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class AppColors {
  static const orange = OrangePalette(
    0xFFF78F1E,
    light: Color(0xFFF88000),
  );

  static const grey = GreyPalette(
    0xFF5C95B4,
    light3: Color(0XFFF0F0F0),
    light2: Color(0xFF777779),
    light1: Color(0XFF707070),
    dark1: Color(0XFF383A35),
    dark2: Color(0xFF2B2C2A),
  );

  static final blue = BluePalette(
    light: Color(0xFF42B3EF),
  );

  static const green = Color(0xFF01C43B);
}

class GreyPalette extends Color {
  const GreyPalette(
    int value, {
    this.light3,
    this.light2,
    this.light1,
    this.dark2,
    this.dark1,
  }) : super(value);

  final Color light3;
  final Color light2;
  final Color light1;
  final Color dark2;
  final Color dark1;
}

class BluePalette {
  const BluePalette({this.light});

  final Color light;
}

class OrangePalette extends Color {
  const OrangePalette(int value, {this.light}) : super(value);

  final Color light;
}
