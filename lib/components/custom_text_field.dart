import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final IconData? icone;
  final String label;
  final String? hintText;
  final bool isSecret;
  final String? initialValue;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final TextCapitalization textCapitalization;
  final int? maxLines;
  final void Function(String?)? onSaved;

  const CustomTextField({
    super.key,
    this.icone,
    required this.label,
    this.hintText,
    this.isSecret = false,
    this.initialValue,
    this.controller,
    this.validator,
    this.textInputType,
    this.textCapitalization = TextCapitalization.none,
    this.maxLines,
    this.onSaved,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = false;

  @override
  void initState() {
    isObscure = widget.isSecret;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: widget.controller,
        initialValue: widget.initialValue,
        obscureText: isObscure,
        validator: widget.validator,
        keyboardType: widget.textInputType,
        textCapitalization: widget.textCapitalization,
        maxLines: widget.maxLines,
        onSaved: widget.onSaved,
        decoration: InputDecoration(
          prefixIcon: widget.icone != null ? Icon(widget.icone) : null,
          suffixIcon: widget.isSecret
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon:
                      Icon(isObscure ? Icons.visibility : Icons.visibility_off))
              : null,
          label: Text(widget.label),
          hintText: widget.hintText,
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
