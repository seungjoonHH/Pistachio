import 'package:intl/intl.dart';

var f = NumberFormat('###,###,###,###');
String toLocalString(dynamic number) => NumberFormat('###,###,###,###').format(number);

double? stringToNum(String string) {
  try { return double.parse(string); }
  catch(_) { return null; }
}