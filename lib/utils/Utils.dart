

/**
 * 时间戳转化
 */
String ReadableTime(String timestamp) {
  DateTime dateTime =
  new DateTime.fromMicrosecondsSinceEpoch(int.parse(timestamp) * 1000);
  print("publicTime " + dateTime.toString());
  var dateStr = dateTime.toString();
  List<String> datesList = dateStr.split(" ");
  List<String> dates = datesList[0].split("-");
  String date = dates[0] + "年" + dates[1] + "月" + dates[2] + "日";
  return date;
}
