// ignore_for_file: use_key_in_widget_constructors

import 'package:controle_alunos_musica_ft/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final String label;
  final DateTime dateInit;
  final ValueChanged<DateTime> onDateTimeChanged;

  ///0-(Default)Data passada e futura, 1-Apenas data passada, 2-Apenas data futura
  final int? tipoData;

  const DatePicker({
    super.key,
    required this.label,
    required this.dateInit,
    required this.onDateTimeChanged,
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
      padding: const EdgeInsets.only(bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(fontSize: 15),
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
                            primary: AppColors.cursorColor,
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
                    const Column(
                      children: [
                        SizedBox(
                          child: Icon(
                            FontAwesomeIcons.pen,
                            size: 20,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
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

class DatePickerClear extends StatefulWidget {
  final String label;
  final DateTime? date;
  final ValueChanged<DateTime> onDateTimeChanged;
  final VoidCallback clearDate;

  ///0-(Default)Data passada e futura, 1-Apenas data passada, 2-Apenas data futura
  final int? tipoData;

  const DatePickerClear({
    required this.label,
    this.date,
    required this.onDateTimeChanged,
    required this.clearDate,
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
          style: const TextStyle(fontSize: 15),
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
              Column(
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.circleXmark,
                          size: 20,
                        ),
                        padding: EdgeInsets.zero,
                        color: Colors.red,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          setState(() {
                            data = null;
                            widget.clearDate();
                          });
                        }),
                  ),
                  const SizedBox(height: 6)
                ],
              )
            else
              Column(
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.pen,
                        size: 20,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: onGetDate,
                    ),
                  ),
                  const SizedBox(height: 6)
                ],
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
            colorScheme: ColorScheme.light(primary: AppColors.cursorColor),
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
  final int? dateType;

  const DatePickerRange({
    super.key,
    required this.label,
    this.dateInit,
    this.dateEnd,
    required this.onDateTimeRageChanged,

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
            style: const TextStyle(fontSize: 15),
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
                            primary: AppColors.cursorColor,
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
                      FontAwesomeIcons.pen,
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
