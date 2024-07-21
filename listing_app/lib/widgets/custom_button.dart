
import 'package:flutter/material.dart';



class CustomButton extends StatefulWidget {
  const CustomButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.height,
    this.radius,
    this.btnColor,
    this.textColor,
  }) : super(key: key);

  final String title;
  final Function()? onPressed;
  final double? height;
  final double? radius;
  final Color? btnColor;
  final Color? textColor;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
           widget.radius ?? 5,
          ),
          color: widget.btnColor ?? theme.hoverColor,
        ),
        padding: EdgeInsets.symmetric(
          vertical: widget.height ?? 16,
        ),
        width: double.infinity,
        child: Center(
          child: Text(
            widget.title,
            style: textTheme.titleMedium?.copyWith(
              color: widget.textColor ?? theme.highlightColor,
            )
          ),
        ),
      ),
    );
  }
}
