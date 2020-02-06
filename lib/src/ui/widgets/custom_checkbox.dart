import 'package:flutter/material.dart';
import 'package:flutter_socketio/src/colors/colors.dart';

class CustomCheckBox extends StatelessWidget {
  CustomCheckBox({
    bool value,
    this.onChanged,
    this.text,
    Color borderColor,
    Color selectedBackgroundColor,
    Color checkColor,
  })  : _value = value ?? false,
        borderColor = AppColors.grey.light2,
        selectedBackgroundColor = AppColors.orange;

  final bool _value;
  final ValueChanged<bool> onChanged;
  final Widget text;
  final Color borderColor;
  final Color selectedBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: InkWell(
        onTap: onChanged == null ? null : () => onChanged(!_value),
        child: Row(
          children: <Widget>[
            if (_value)
              Icon(
                Icons.check_box,
                color: selectedBackgroundColor,
              )
            else
              Icon(
                Icons.check_box_outline_blank,
                color: borderColor,
              ),
            if (text != null) text,
          ],
        ),
      ),
    );
  }
}
