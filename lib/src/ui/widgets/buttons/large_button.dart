part of "buttons.dart";

class LargeButton extends StatefulWidget {
  final String text;
  final Color color;
  final Color disabledColor;
  final Color textColor;
  final Color disabledTextColor;
  final bool showBlur;
  final double width;
  final double height;
  final EdgeInsets padding;

  /// If [onPressed] is null, the button is disabled
  final FutureOr<void> Function() onPressed;

  LargeButton({
    Key key,
    @required this.text,
    this.color,
    Color textColor,
    this.disabledColor,
    Color disabledTextColor,
    this.onPressed,
    this.showBlur = true,
    this.width = double.infinity,
    this.height,
    this.padding = const EdgeInsets.symmetric(vertical: 15.0),
  })  : assert(text != null),
        assert(showBlur != null),
        textColor = textColor ?? Colors.white,
        disabledTextColor = disabledColor ?? AppColors.grey.light2,
        super(key: key);

  @override
  _LargeButtonState createState() => _LargeButtonState();
}

class _LargeButtonState extends State<LargeButton> {
  bool isLoading = false;

  bool get isEnable => widget.onPressed != null;

  Future<void> showLoader() async {
    if (widget.onPressed == null) return;
    setState(() => isLoading = true);
    await widget.onPressed();
    if (mounted) {
      setState(() => isLoading = false);
    }
  }

  static const double height = 48.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = widget.color ?? theme.primaryColor;

    Widget tree;

    if (isLoading) {
      tree = Container(
        width: height,
        height: height,
        padding: const EdgeInsets.all(8),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      tree = InkWell(
        onTap: isEnable ? showLoader : null,
        child: Container(
          width: widget.width,
          height: widget.height,
          alignment: Alignment.center,
          padding: widget.padding,
          decoration: isEnable
              ? BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8.0),
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: widget.disabledColor,
                  border: Border.all(color: widget.disabledTextColor),
                ),
          child: Text(
            widget.text,
            style: TextStyle(
              color: isEnable ? widget.textColor : widget.disabledTextColor,
            ),
          ),
        ),
      );
    }

    final boxShadows = <BoxShadow>[
      BoxShadow(
        color: AppColors.orange.light.withAlpha(0x80),
        blurRadius: 20.0, // has the effect of softening the shadow
        spreadRadius: 1.0, // has the effect of extending the shadow
      )
    ];
    return Container(
      alignment: Alignment.center,
      decoration: isLoading
          ? BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              boxShadow: boxShadows,
            )
          : isEnable && widget.showBlur
              ? BoxDecoration(boxShadow: boxShadows)
              : null,
      child: tree,
    );
  }
}
