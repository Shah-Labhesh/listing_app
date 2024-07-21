// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:listing_app/constants/app_colors.dart';
import 'package:listing_app/constants/app_font_size.dart';
import 'package:listing_app/constants/app_heights.dart';

class CustomField extends StatefulWidget {
  const CustomField({
    Key? key,
    this.hintText,
    this.title,
    this.inputType,
    this.controller,
    this.focusNode,
    this.readOnly = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.isPassword = false,
    this.onChanged,
    this.bottomHeight,
    this.validator,
  }) : super(key: key);

  final String? hintText;
  final String? title;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool readOnly;
  final int minLines;
  final int maxLines;
  final bool isPassword;
  final Function(String)? onChanged;
  final double? bottomHeight;
  final String? Function(String?)? validator;

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final InputBorder border = OutlineInputBorder(
      borderSide: BorderSide(
        color: textTheme.labelSmall?.color ?? AppColors.lightBlack,
        width: 1.5,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(0)),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.title != null) ...[
          Text(
            widget.title!,
            style: textTheme.labelMedium?.copyWith(
              fontSize: FontSizeManager.f18,
              color: theme.brightness == Brightness.light
                  ? AppColors.lightBlack
                  : AppColors.darkBaseSecondaryGray2,
            ),
          ),
          const SizedBox(
            height: HeightManager.h10,
          ),
        ],
        TextFormField(
          cursorColor: AppColors.lightBlack,
          validator: widget.validator,
          keyboardType: widget.inputType,
          controller: widget.controller,
          style: textTheme.bodyMedium?.copyWith(
            color: theme.brightness == Brightness.light
                ? AppColors.lightBlack
                : AppColors.darkBaseSecondaryGray2,
          ),
          focusNode: widget.focusNode,
          readOnly: widget.readOnly,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          obscureText: widget.isPassword,
          onChanged: widget.onChanged,
          onTapOutside: (event) {
            widget.focusNode?.unfocus();
          },
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: textTheme.labelMedium?.copyWith(
              color: textTheme.labelSmall?.color,
              letterSpacing: 0.5,
            ),
            border: border,
            enabledBorder: border,
            focusedBorder: border,
            errorBorder: border,
            disabledBorder: border,
            focusedErrorBorder: border,
            contentPadding: const EdgeInsets.all(12),
            fillColor: theme.brightness == Brightness.light
                ? AppColors.lightUnitBg
                : AppColors.darkUnitBg,
            filled: true,
            errorStyle: textTheme.displaySmall,
          ),
        ),
        SizedBox(
          height: widget.bottomHeight ?? HeightManager.h12,
        ),
      ],
    );
  }
}
