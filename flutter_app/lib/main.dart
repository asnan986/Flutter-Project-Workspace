import 'package:flutter/material.dart';
import 'package:flutter_app/quote.dart';
import 'quote-card.dart';

void main() =>
  runApp(MaterialApp(
    home: MyHome(),
  ));

//list example
class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  List<Quote> quotes= [Quote(quote:'hai', author:'asnan'),Quote(quote:'hello',author:'aaro'),Quote(author: 'unknown',quote: 'life is a ..')];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('lists'),
      ),
      body: Column(
        children: quotes.map((i) =>QuoteCard(quote: i,delete:(){
          setState(() {
            quotes.remove(i);
          });
        })).toList(),
      ),
    );
  }
}




//stateful widget button pressing project
/*class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int expertLevel=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text('project1'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        elevation: 0,
      ),
      backgroundColor: Colors.grey[900],
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.amberAccent,
        ),
        onPressed: (){
          setState(() {
            expertLevel++;
          });
        },
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/avatar.jpg'),
                radius: 50,
              ),
            ),
            Divider(height: 60,color: Colors.amberAccent,),
            Text('Name',
            style: TextStyle(
              color: Colors.grey[200],
              letterSpacing: 2,
              fontSize: 20
            ),),
            SizedBox(height: 20,),
            Text('Asnan',
              style: TextStyle(
                  color: Colors.amberAccent,
                  letterSpacing: 2,
                  fontSize: 30
              ),),
            SizedBox(height: 30,),
            Text('Flutter-Current Expertise level',
              style: TextStyle(
                  color: Colors.grey[200],
                  letterSpacing: 2,
                  fontSize: 20
              ),),
            SizedBox(height: 20,),
            Text('$expertLevel',
              style: TextStyle(
                  color: Colors.amberAccent,
                  letterSpacing: 2,
                  fontSize: 30
              ),),
            SizedBox(height: 30,),
            Row(
              children: [
                Icon(
                  Icons.email,
                  color: Colors.amberAccent,
                  size: 30,
                ),
                SizedBox(width: 15,),
                Text(
                  'asnu@gmail.com',
                  style: TextStyle(
                    color: Colors.amberAccent,
                    fontSize: 15
                  ),
                )

              ],
            )

          ],
        ),


      ),
    );
  }
}*/


