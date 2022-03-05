import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  void ansToQues(){
    print('answer chosen!');
  }

  Widget build(BuildContext context) {
    var questions = [
      'what\'s your favourite color ?',
      'what\'s your favourite animal ?'
    ];

    return MaterialApp(
        home: Scaffold(
           appBar: AppBar(
            title: Text('Get Current Date in Flutter')
              ),
            body:Column(
              children: <Widget>[
                Text("The question"),
                RaisedButton(
                  child: Text("Answer1"),
                  onPressed: ansToQues,
                  ),
                  RaisedButton(
                  child: Text("Answer2"),
                  onPressed: ansToQues,
                  ),
                  RaisedButton(
                  child: Text("Answer3"),
                  onPressed: ansToQues,
                  ),
              ],
            ),
            )
          );
    
  }
}

