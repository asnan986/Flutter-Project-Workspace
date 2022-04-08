import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  int i = 0;

  @override
  void initState() {
    super.initState();
    i = i + 1;
    print(i);
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    String bgImage = data['isDay'] ? 'day.png' : 'night.png';
    Color color = data['isDay'] ? Colors.blue : Colors.indigo[700];
    print(data);
    return Scaffold(
      backgroundColor: color,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/$bgImage'), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: [
                FlatButton.icon(
                  onPressed: () async {
                    Navigator.pushReplacementNamed(context, '/location');
                    // dynamic result=await Navigator.pushNamed(context, '/location');
                    // setState(() {
                    //   data={
                    //     'time':result['time'],
                    //     'location':result['location'],
                    //     'isDay':result['isDay']
                    //   };
                    // });
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[300],
                  ),
                  label: Text(
                    'choose location',
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['location'],
                      style: TextStyle(
                          fontSize: 35.0,
                          letterSpacing: 2,
                          color: Colors.white),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(data['time'],
                    style: TextStyle(fontSize: 66, color: Colors.white))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
