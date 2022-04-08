import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(100, 0, 0, 0),
      child: Container(
        color: Colors.blue,
        width: 200,
        height: 200,
        child: Text('ASNAN M H',style: TextStyle(
          color: Colors.white,
          fontSize: 30
        ),),
      ),
    );
  }
}
