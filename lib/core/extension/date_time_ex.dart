import 'package:intl/intl.dart';

extension DateTimeEx on DateTime{
  String get toFormattedDate{
    DateFormat formatter=DateFormat("dd/MM/yyyy");
    return formatter.format(this);
  }

  String get toFormattedTime{
    DateFormat formatter=DateFormat("jm");
    return formatter.format(this);
  }


}