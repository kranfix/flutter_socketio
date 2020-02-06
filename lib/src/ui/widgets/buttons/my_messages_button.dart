part of "buttons.dart";

class MyMessagesButton extends StatelessWidget {
  const MyMessagesButton({Key key, this.onTap, this.counter}) : super(key: key);

  final VoidCallback onTap;
  final int counter;

  @override
  Widget build(BuildContext context) {
    Widget tree = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'My messages',
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
      ],
    );

    tree = Container(
      width: 100,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: AppColors.orange,
      ),
      child: tree,
    );

    tree = InkWell(
      onTap: onTap,
      child: tree,
    );

    if (counter != null) {
      tree = Badge(
        badgeContent: Text(
          '$counter',
          style: TextStyle(color: Colors.white),
        ),
        child: tree,
      );
    }

    return tree;
  }
}
