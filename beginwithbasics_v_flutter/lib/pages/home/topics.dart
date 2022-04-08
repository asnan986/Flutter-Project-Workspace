import 'package:flutter/material.dart';
class Topics extends StatelessWidget {
  final List<String> topics = [
    "HTML",
    "CSS",
    "JAVASCRIPT",
  ];
  final List<String> icons = [
    "html.png",
    "css.png",
    "js.png",
  ];

  Map mapData={
    'topic':'html'
  };
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(100, 0, 0, 0),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemCount: topics.length,
          itemBuilder: (context, index) {
            return Column(children: [
              Container(
                  padding: EdgeInsets.all(10),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.red),
                  ),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/loadTopics',arguments: {
                        'subject':topics[index]
                      });

                    },
                    child: icons[index].isNotEmpty
                        ? Image.asset(
                        'assets/subjectIcons/${icons[index]}')
                        : Icon(Icons.access_time),
                  )),
              Text(topics[index]),
            ]);
          }),
    );
  }
}
