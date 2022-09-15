//
// class TimeDao {
//
//   Future<void> saveTime(TimeOfDay timeOfDay) async {
//     final pref = await SharedPreferences.getInstance();
//     notificationTime = timeOfDay;
//     final String time = '${notificationTime.hour}:${notificationTime.minute}';
//     await pref.setString(timeKey, time);
//   }
// }