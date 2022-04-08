import 'package:flutter/material.dart';
import 'package:world_time_app/services/world_time.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  List<WorldTime> countries = [
    WorldTime(location: 'India', url: 'Asia/Kolkata', flag: 'India.png'),
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  ];

  void updateTime(index) {
    WorldTime instance = countries[index];
    Navigator.pushReplacementNamed(context, '/loading', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'url': instance.url
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Choose location'),
          backgroundColor: Colors.blue[200],
        ),
        body: Container(
          color: Colors.grey[300],
          child: ListView.builder(
              itemCount: countries.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        //print(countries[index].location);
                        updateTime(index);
                      },
                      title: Text(countries[index].location),
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/${countries[index].flag}'),
                      ),
                    ),
                  ),
                );
              }),
        ));
  }
}
