part of 'buttons.dart';

class ArrowSendButton extends StatelessWidget {
  ArrowSendButton({this.onTap});

  final FutureOrCallback<void> onTap;

  @override
  Widget build(BuildContext context) {
    return AsyncTapable(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        margin: EdgeInsets.only(bottom: 10, top: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: onTap != null ? AppColors.orange : AppColors.grey.light1,
        ),
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Icon(
          Icons.send,
          size: 15,
          color: Colors.white,
        ),
      ),
    );
  }
}
