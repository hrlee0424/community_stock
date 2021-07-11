import 'package:intl/intl.dart';

class TimeDate{

  String timeFormat(timestamp){
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
    String formatDate = DateFormat('yyyy-MM-dd').format(date);
    return formatDate;
  }

}