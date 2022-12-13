// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class MenuButtonWidget extends StatelessWidget {
  final String label;
  final String image;
  final String route;

  const MenuButtonWidget(this.label, this.image, this.route);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[300],
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100, child: Image.asset(image)),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
