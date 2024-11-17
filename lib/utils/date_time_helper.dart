class DateTimeHelper {
  static String formatDateTime(DateTime dateTime) {
    final now = DateTime.now();

    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      // Today
      if (dateTime.hour == now.hour && dateTime.minute == now.minute) {
        // Within the same minute
        return 'Now';
      } else {
        return 'Today at ${dateTime.hour < 12 ? dateTime.hour : dateTime.hour - 12}:${dateTime.minute.toString().padLeft(2, '0')} ${dateTime.hour < 12 ? 'AM' : 'PM'}';
      }
    } else {
      // Yesterday
      final yesterday = now.subtract(const Duration(days: 1));
      if (dateTime.year == yesterday.year &&
          dateTime.month == yesterday.month &&
          dateTime.day == yesterday.day) {
        return 'Yesterday at ${dateTime.hour < 12 ? dateTime.hour : dateTime.hour - 12}:${dateTime.minute.toString().padLeft(2, '0')} ${dateTime.hour < 12 ? 'AM' : 'PM'}';
      } else {
        // Other days
        return '${dateTime.day}/${dateTime.month}/${dateTime.year} at ${dateTime.hour < 12 ? dateTime.hour : dateTime.hour - 12}:${dateTime.minute.toString().padLeft(2, '0')} ${dateTime.hour < 12 ? 'AM' : 'PM'}';
      }
    }
  }
}
