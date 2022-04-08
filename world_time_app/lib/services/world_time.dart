import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String flag;
  String url;
  bool isDaytime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map time = jsonDecode(response.body);
      String datetime = time['datetime'];
      String offsetHour = time['utc_offset'].toString().substring(1, 3);
      print(offsetHour);
      String offsetMinute = time['utc_offset'].toString().substring(4, 6);
      print(offsetMinute);
      DateTime now = DateTime.parse(datetime);
      print(now);
      if (time['utc_offset'].toString().contains('+'))
        now = now.add(Duration(
            hours: int.parse(offsetHour), minutes: int.parse(offsetMinute)));
      else
        now = now.subtract(Duration(
            hours: int.parse(offsetHour), minutes: int.parse(offsetMinute)));
      print(now);
      isDaytime = now.hour > 6 && now.hour < 18;
      this.time = DateFormat.jm().format(now);
    } catch (e) {
      time = 'could not load time of location $location';
      isDaytime = false;
    }
  }
}
