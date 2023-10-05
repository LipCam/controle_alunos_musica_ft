// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final String label;
  final DateTime dateInit;
  final ValueChanged<DateTime> onDateTimeChanged;
  final Color? color;

  ///0-(Default)Data passada e futura, 1-Apenas data passada, 2-Apenas data futura
  final int? tipoData;

  const DatePicker({
    super.key,
    required this.label,
    required this.dateInit,
    required this.onDateTimeChanged,
    this.color,
    this.tipoData = 0,
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime data = DateTime.now();

  @override
  void initState() {
    data = widget.dateInit;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(
              color: widget.color != null
                  ? widget.color!
                  : Theme.of(context).textTheme.bodyLarge?.backgroundColor,
              fontSize: 15,
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    locale: const Locale("pt", "BR"),
                    initialDate: data,
                    firstDate: (widget.tipoData == 0 || widget.tipoData == 1)
                        ? DateTime(1900)
                        : DateTime.now(),
                    lastDate: (widget.tipoData == 0 || widget.tipoData == 1)
                        ? DateTime.now()
                        : DateTime(
                            DateTime.now().year,
                            DateTime.now().month + 12,
                            DateTime.now().day,
                          ),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          colorScheme: ColorScheme.light(
                            primary: widget.color != null
                                ? widget.color!
                                : Theme.of(context).primaryColor,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );

                  if (newDate != null) {
                    setState(() {
                      data = newDate;
                      widget.onDateTimeChanged(data);
                    });
                  }
                },
                child: Row(
                  children: [
                    Text(
                      DateFormat("dd/MM/yyyy").format(data),
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.edit),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DatePickerClear extends StatefulWidget {
  final String label;
  final DateTime? date;
  final ValueChanged<DateTime> onDateTimeChanged;
  final VoidCallback clearDate;
  final Color? color;

  ///0-(Default)Data passada e futura, 1-Apenas data passada, 2-Apenas data futura
  final int? tipoData;

  const DatePickerClear({
    required this.label,
    this.date,
    required this.onDateTimeChanged,
    required this.clearDate,
    this.color,
    this.tipoData = 0,
  });

  @override
  State<DatePickerClear> createState() => _DatePickerClearState();
}

class _DatePickerClearState extends State<DatePickerClear> {
  DateTime? data;

  @override
  void initState() {
    data = widget.date;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            color: widget.color != null
                ? widget.color!
                : Theme.of(context).textTheme.bodyLarge?.backgroundColor,
            fontSize: 15,
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: onGetDate,
              child: Text(
                data != null
                    ? DateFormat("dd/MM/yyyy").format(data!)
                    : "___/___/____",
                style: const TextStyle(fontSize: 17),
              ),
            ),
            const SizedBox(width: 10),
            if (data != null)
              IconButton(
                  icon: const Icon(Icons.cancel_outlined),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    setState(() {
                      data = null;
                      widget.clearDate();
                    });
                  })
            else
              IconButton(
                icon: const Icon(Icons.edit),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: onGetDate,
              ),
          ],
        ),
      ],
    );
  }

  onGetDate() async {
    DateTime? newDate = await showDatePicker(
      context: context,
      locale: const Locale("pt", "BR"),
      initialDate: data ?? DateTime.now(),
      firstDate: (widget.tipoData == 0 || widget.tipoData == 1)
          ? DateTime(1900)
          : DateTime.now(),
      lastDate: (widget.tipoData == 0 || widget.tipoData == 1)
          ? DateTime.now()
          : DateTime(
              DateTime.now().year,
              DateTime.now().month + 12,
              DateTime.now().day,
            ),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: widget.color != null
                  ? widget.color!
                  : Theme.of(context).primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (newDate != null) {
      setState(() {
        data = newDate;
        widget.onDateTimeChanged(data!);
      });
    }
  }
}

class DatePickerRange extends StatefulWidget {
  final String label;
  final DateTime? dateInit;
  final DateTime? dateEnd;
  final ValueChanged<DateTimeRange> onDateTimeRageChanged;
  final Color? color;
  final int? dateType;

  const DatePickerRange({
    super.key,
    required this.label,
    this.dateInit,
    this.dateEnd,
    required this.onDateTimeRageChanged,
    this.color,

    ///0-(Default)Data passada e futura, 1-Apenas data passada, 2-Apenas data futura
    this.dateType,
  });

  @override
  State<DatePickerRange> createState() => _DatePickerRangeState();
}

class _DatePickerRangeState extends State<DatePickerRange> {
  DateTimeRange? dataIntervalo;
  DateTime? dataInicio;
  DateTime? dataFim;

  @override
  void initState() {
    dataIntervalo = DateTimeRange(
      start: widget.dateInit ?? DateTime.now(),
      end: widget.dateEnd ?? DateTime.now(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(
              color: widget.color != null ? widget.color! : Colors.grey,
              fontSize: 15,
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () async {
                  DateTimeRange? newDate = await showDateRangePicker(
                    context: context,
                    locale: const Locale("pt", "BR"),
                    initialDateRange: dataIntervalo,
                    firstDate: (widget.dateType == 0 || widget.dateType == 1)
                        ? DateTime(1900)
                        : DateTime.now(),
                    lastDate: (widget.dateType == 0 || widget.dateType == 1)
                        ? DateTime.now()
                        : DateTime(
                            DateTime.now().year,
                            DateTime.now().month + 12,
                            DateTime.now().day,
                          ),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          colorScheme: ColorScheme.light(
                            primary: widget.color != null
                                ? widget.color!
                                : Theme.of(context).primaryColor,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );

                  if (newDate != null) {
                    setState(() {
                      dataIntervalo = newDate;
                      widget.onDateTimeRageChanged(dataIntervalo!);
                    });
                  }
                },
                child: Row(
                  children: [
                    Text(
                      (dataIntervalo?.start != null
                          ? DateFormat("dd/MM/yyyy")
                              .format(dataIntervalo!.start)
                          : "___/__/____"),
                      style: const TextStyle(fontSize: 18),
                    ),
                    const Text("  -  "),
                    Text(
                      (dataIntervalo?.end != null
                          ? DateFormat("dd/MM/yyyy").format(dataIntervalo!.end)
                          : "___/__/____"),
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.edit,
                      //color: AppColors.fontColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
