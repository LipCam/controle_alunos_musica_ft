import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  final String label;
  final bool value;
  final Function(bool?) onChange;

  const CustomCheckBox({
    super.key,
    required this.label,
    required this.value,
    required this.onChange,
  });

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool? value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CheckboxListTile(
        title: Text(widget.label),
        contentPadding: EdgeInsets.zero,
        value: value,
        onChanged: (bool? value) {
          setState(() {
            this.value = value;
            widget.onChange(value);
          });
        },
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}
