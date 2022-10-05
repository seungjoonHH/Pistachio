import 'package:intl/intl.dart';

var f = NumberFormat('###,###,###,###');
String toLocalString(dynamic number) => NumberFormat('###,###,###,###').format(number);