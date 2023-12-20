import 'package:intl/intl.dart';

class DateTimeHelper {
  static DateTime format(){
    /// date & time
    final now = DateTime.now();
    final dateFormat = DateFormat('y/M/d');
    const timeSpecific = "11:00:00";
    final completeFormat = DateFormat('y/M/d H:m:s');

    /// today
    final todayDate = dateFormat.format(now);
    final todayDateTime = "$todayDate $timeSpecific";
    final resultToday = completeFormat.parseStrict(todayDateTime);

    /// Tomorrow
    final formatted = resultToday.add(const Duration(days: 1));
    final tomorrowDate = dateFormat.format(formatted);
    final tomorrowDateTime = "$tomorrowDate $timeSpecific";
    final resultTomorrow = completeFormat.parseStrict(tomorrowDateTime);

    return now.isAfter(resultToday) ? resultTomorrow : resultToday;
  }
}