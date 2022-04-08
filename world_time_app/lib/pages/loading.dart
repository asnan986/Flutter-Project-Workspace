import 'package:flutter/material.dart';
import 'package:world_time_app/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Map data = {'location': 'India', 'url': 'Asia/Kolkata', 'flag': 'India.png'};

  void setWorldTime(WorldTime instance) async {
    await instance.getTime();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'time': instance.time,
      'location': instance.location,
      'flag': instance.flag,
      'isDay': instance.isDaytime
    });
    //print(instance.time);
  }

  @override
  Widget build(BuildContext context) {
    Map data1 = ModalRoute.of(context).settings.arguments;
    if (data1 != null) {
      data = data1;
    }
    setWorldTime(WorldTime(
        location: data['location'], url: data['url'], flag: data['flag']));
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Center(
        child: SpinKitCircle(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
