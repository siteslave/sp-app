import 'package:intl/intl.dart';

class Helper {
  Helper();

  String toThaiDate(DateTime date) {
    String date1 = new DateFormat.MMMd('th_TH').format(date); // 20 ม.ค.
    var year = date.year + 543;
    String thaiDate = '$date1 $year'; // 20 ม.ค. 2564
    return thaiDate;
  }

  String toMySQLDate(DateTime date) {
    var format = new DateFormat('yyyy-MM-dd');
    String mysqlDate = format.format(date);
    return mysqlDate; // YYYY-MM-DD
  }
}
