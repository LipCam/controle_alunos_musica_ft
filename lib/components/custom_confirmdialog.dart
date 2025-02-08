import 'package:flutter/material.dart';

customConfirmDialog({
  required BuildContext context,
  String? title,
  required String message,
  required void Function()? functionYes,
  void Function()? functionNo,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title ?? "Mensagem"),
      content: Text(message),
      actions: [
        TextButton(
            onPressed: functionNo ?? () => Navigator.of(context).pop(),
            child: const Text("Não")),
        TextButton(
          onPressed: functionYes,
          child: const Text("Sim"),
        ),
      ],
    ),
  );
}
