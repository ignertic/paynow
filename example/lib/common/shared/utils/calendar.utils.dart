class CalendarUtils {
  static final daysMap = {
    0: 'Sunday',
    1: 'Monday',
    2: 'Tuesday',
    3: 'Wednesday',
    4: 'Thursday',
    5: 'Friday',
    6: 'Saturday',
  };

  static final monthMap = {
    0: 'January',
    1: 'February',
    2: 'March',
    3: 'April',
    4: 'May',
    5: 'June',
    6: 'July',
    7: 'August',
    8: 'September',
    9: 'October',
    10: 'November',
    11: 'December'
  };

  static List<String> get months => monthMap.values.toList();

  static final monthMapKeys = monthMap.keys.toList();
  static final dayMapKeys = daysMap.keys.toList();

  static String getMonthNameFromIndex(int index) {
    return monthMap[monthMapKeys[index]]!;
  }

  static int getMonthIndexFromName(String month) {
    final month0 = months.where((element) => element.startsWith(month)).first;
    return months.indexOf(month0);
  }

  static String getDayNameFromIndex(int index) {
    return daysMap[dayMapKeys[index]]!;
  }

  static List<DateTime> generateTimeslots(DateTime opening, DateTime closing) {
    final slots = [opening];
    while (slots.last.isBefore(closing)) {
      final toAdd = slots.last.add(const Duration(minutes: 30));
      slots.add(toAdd);
    }
    return slots;
  }
}
