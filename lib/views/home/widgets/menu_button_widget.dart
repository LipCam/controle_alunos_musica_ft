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
              Container(height: 100, child: Image.asset(image)),
              SizedBox(height: 10),
              Text(label, style: TextStyle(color: Colors.blue, fontSize: 20))
            ],
          ),
        ));
  }
}
