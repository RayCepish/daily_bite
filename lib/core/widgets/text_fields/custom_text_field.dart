import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPasswordField;
  final FormFieldValidator<String>? textFieldValidator;

  const CustomTextField({
    required this.hintText,
    required this.controller,
    this.isPasswordField = false,
    this.textFieldValidator,
    super.key,
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

    return SizedBox(
      height: 50,
      child: TextFormField(
        validator: widget.textFieldValidator,
        controller: widget.controller,
        textAlign: TextAlign.start,
        obscureText: widget.isPasswordField ? _obscureText : false,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.secondary.withOpacity(0.5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          contentPadding: const EdgeInsets.only(left: 20),
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
                      setState(
                        () {
                          _obscureText = !_obscureText;
                        },
                      );
                    },
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
