import 'package:flutter/material.dart';

class DatePicker extends StatelessWidget {
  final String label;
  final DateTime date;
  final VoidCallback getDate;
  const DatePicker(
      {required this.label, required this.date, required this.getDate});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        Row(
          children: [
            GestureDetector(
              child: Text(
                date.day.toString().padLeft(2, '0') +
                    "/" +
                    date.month.toString().padLeft(2, '0') +
                    "/" +
                    date.year.toString(),
                style: TextStyle(fontSize: 17),
              ),
              onTap: getDate,
            ),
          ],
        ),
      ],
    );
  }
}

class DatePickerClear extends StatelessWidget {
  final String label;
  final DateTime? date;
  final bool temData;
  final VoidCallback getDate;
  final VoidCallback clearDate;

  const DatePickerClear(
      {required this.label,
      this.date,
      required this.temData,
      required this.getDate,
      required this.clearDate});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        Row(
          children: [
            GestureDetector(
              child: Text(
                date != null
                    ? date!.day.toString().padLeft(2, '0') +
                        "/" +
                        date!.month.toString().padLeft(2, '0') +
                        "/" +
                        date!.year.toString()
                    : "___/___/_____",
                style: TextStyle(fontSize: 17),
              ),
              onTap: getDate,
            ),
            SizedBox(width: 10),
            Visibility(
              visible: temData,
              child: GestureDetector(
                child: Text(
                  "X",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                onTap: clearDate,
              ),
            )
          ],
        ),
      ],
    );
  }
}
