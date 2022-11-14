import 'package:intl/intl.dart';

var f = NumberFormat('###,###,###,###');
String toLocalString(dynamic number) => NumberFormat('###,###,###,###').format(number);

double? stringToNum(String string) {
  try { return double.parse(string); }
  catch(_) { return null; }
}

double sum(List<double> list) {
  List<double> temp = [...list];
  return temp.reduce((a, b) => a + b);
}

double average(List<double> list) {
  return sum(list) / list.length;
}