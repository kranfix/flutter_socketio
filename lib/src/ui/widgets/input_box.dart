import 'buttons/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_socketio/src/colors/colors.dart';

class InputBox extends StatefulWidget {
  const InputBox({
    this.imgUrl,
    @required this.onTap,
    this.onCloseReplyPressed,
  }) : assert(onTap != null);

  final String imgUrl;
  final ValueChanged<String> onTap;
  final VoidCallback onCloseReplyPressed;

  @override
  _InputBoxState createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  final controller = TextEditingController();
  final focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 6, left: 6),
                child: CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(widget.imgUrl),
                ),
              ),
              SizedBox(width: 10),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: TextField(
                    maxLines: 5,
                    minLines: 1,
                    controller: controller,
                    focusNode: focus,
                    scrollPadding: EdgeInsets.all(0),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type a message...',
                    ),
                    style: TextStyle(height: 1.6, color: AppColors.grey.light1),
                  ),
                ),
              ),
              SizedBox(width: 10),
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: controller,
                builder: (_, value, __) {
                  final text = value.text.trim();
                  return ArrowSendButton(
                    onTap: text.isNotEmpty ? () => widget.onTap(text) : null,
                  );
                },
              ),
            ]),
      ),
    );
  }
}
