import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPasswordField;
  final FormFieldValidator<String>? textFieldValidator;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Color? fillColor;
  final int? maxLines, maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixTap;
  final bool enabled;
  final TextInputAction? textInputAction;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPasswordField = false,
    this.textFieldValidator,
    this.onChanged,
    this.onSubmitted,
    this.fillColor,
    this.maxLines,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.enabled = true,
    this.textInputAction,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPasswordField;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      enabled: widget.enabled,
      maxLines: widget.maxLines ?? 1,
      maxLength: widget.maxLength,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      cursorColor: theme.colorScheme.secondary,
      obscureText: widget.isPasswordField ? _obscureText : false,
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        hintText: widget.hintText,
        filled: true,
        fillColor:
            widget.fillColor?.withOpacity(0.2) ?? theme.colorScheme.surface,
        hintStyle: theme.textTheme.titleMedium?.copyWith(
          color: theme.colorScheme.secondary,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: widget.fillColor ?? theme.colorScheme.primary,
            width: 2,
          ),
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPasswordField
            ? Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: _obscureText
                        ? theme.colorScheme.primary
                        : theme.colorScheme.secondary,
                  ),
                  onPressed: () {
                    setState(() => _obscureText = !_obscureText);
                  },
                ),
              )
            : widget.suffixIcon != null
                ? IconButton(
                    onPressed: widget.onSuffixTap,
                    icon: widget.suffixIcon!,
                    color: theme.colorScheme.secondary,
                  )
                : null,
      ),
      validator: widget.textFieldValidator,
    );
  }
}
