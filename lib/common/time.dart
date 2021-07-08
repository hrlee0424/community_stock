import 'package:intl/intl.dart';
class TimeMagage{

  String getTimeNow(){
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    return formattedDate;
  }

}