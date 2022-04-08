import 'quote.dart';
import 'package:flutter/material.dart';

class QuoteCard extends StatelessWidget {
  final Quote quote;
  Function delete;

  QuoteCard({this.quote,this.delete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20,20,20,10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(quote.quote,style: TextStyle(
                color: Colors.amberAccent
            )
            ),
            Text(quote.author,style: TextStyle(
                color: Colors.amberAccent
            )
            ),
            FlatButton.icon(
                onPressed: delete,
                icon:Icon(Icons.delete),
                label: Text('Delete quote',style: TextStyle(color: Colors.black),),
              color: Colors.white,

            )

          ],
        ),
      ),
    );
  }
}