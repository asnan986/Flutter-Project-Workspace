import 'dart:ui';

import 'package:beginwithbasics_v_flutter/pages/home/add_question.dart';
import 'package:beginwithbasics_v_flutter/pages/home/assessment.dart';
import 'package:beginwithbasics_v_flutter/pages/home/practice.dart';
import 'package:beginwithbasics_v_flutter/pages/home/profile.dart';
import 'package:beginwithbasics_v_flutter/pages/home/search.dart';
import 'package:beginwithbasics_v_flutter/pages/home/stats.dart';
import 'package:beginwithbasics_v_flutter/pages/home/topics.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget _homeComponent=Topics();

  final List<dynamic> actions = [
    {'icon': Icons.account_circle, 'value': 'Profile','widget':Profile()},
    {'icon': Icons.book, 'value': 'Subject','widget':Topics()},
    {'icon': Icons.assessment, 'value': 'Test','widget':Assessment()},
    {'icon': Icons.assignment, 'value': 'Practice','widget':Practice()},
    {'icon': Icons.analytics, 'value': 'stats','widget':Stats()},
    {'icon': Icons.add, 'value': 'add ?','widget':AddQuestion()},
    {'icon': Icons.search, 'value': 'Search','widget':Search()}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("BeginWithBasics",style: TextStyle(
            color: Colors.black45,
          ),
          textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.grey[100],
          elevation: 10,
          actions: [
            OutlinedButton(
                onPressed: () {},
                child: Icon(
                  Icons.share,
                  color: Colors.black45,
                )),
            OutlinedButton(
              onPressed: () {},
              child: Icon(
                Icons.info,
                color: Colors.black45,
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
                height: MediaQuery.of(context).size.height,
                width: 100,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30),),
                    color: Colors.grey[100]),
                child: ListView.builder(
                  itemCount: actions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        print('action ${actions[index]['value']} called');
                        setState(() {
                          _homeComponent=actions[index]['widget'];
                        });
                      },
                      title: Icon(
                        actions[index]['icon'],
                        color: Colors.black45,
                      ),
                      subtitle: Align(
                        alignment: Alignment.center,
                        child: Text(
                          actions[index]['value'],
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                    );
                  },
                )),
            _homeComponent,
          ],
        ));
  }
}
