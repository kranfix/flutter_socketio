part of "buttons.dart";

class LinkText extends StatelessWidget {
  const LinkText(this.text, {this.onTap, this.style});

  final String text;
  final VoidCallback onTap;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: style ??
            TextStyle(
              color: AppColors.orange,
              decoration: TextDecoration.underline,
            ),
      ),
    );
  }
}
