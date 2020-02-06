part of 'buttons.dart';

typedef FutureOrCallback<T> = FutureOr<T> Function();
typedef AsyncLoaderBuilder = Widget Function(
    BuildContext context, Widget child, bool isLoading);

class AsyncTapable extends StatefulWidget {
  AsyncTapable({Key key, this.onTap, this.builder, this.padding, this.child})
      : super(key: key);

  final FutureOrCallback<void> onTap;
  final AsyncLoaderBuilder builder;
  final Widget child;
  final EdgeInsets padding;

  @override
  _AsyncTapableState createState() => _AsyncTapableState();
}

class _AsyncTapableState extends State<AsyncTapable> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Widget tree = widget.child;
    if (widget.builder != null) {
      tree = widget.builder(context, tree, isLoading);
    }

    if (widget.padding != null) {
      tree = Padding(padding: widget.padding, child: tree);
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: isLoading || widget.onTap == null
          ? null
          : () async {
              setState(() => isLoading = true);
              await widget.onTap();
              if (mounted) {
                setState(() => isLoading = false);
              }
            },
      child: tree,
    );
  }
}
