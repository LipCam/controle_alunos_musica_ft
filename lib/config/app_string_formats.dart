// ignore_for_file: non_constant_identifier_names

import 'package:intl/intl.dart';

///Retorno: dd/MM/yyyy
String getDateFormat_dd_MM_yyyy(DateTime data) {
  return DateFormat("dd/MM/yyyy", "pt_BR").format(data);
}

///Retorno: yyyy-MM-dd
String getDateFormat_yyyy_MM_dd(DateTime data) {
  return DateFormat("yyyy-MM-dd", "pt_BR").format(data);
}

///Retorno: ddMMyyyy
String getDateFormat_ddMMyyyy(DateTime data) {
  return DateFormat("ddMMyyyy", "pt_BR").format(data);
}
