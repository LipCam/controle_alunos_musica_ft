import 'package:fluttertoast/fluttertoast.dart';

void ToastMessage(String Message){
  Fluttertoast.showToast(
      msg: Message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1
  );
}