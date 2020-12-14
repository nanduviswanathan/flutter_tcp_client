//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';

void main() {
  runApp(
    MaterialApp(
      title: 'SI Calculator',
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,

      ),
    ),
  );
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _home();
  }
}

class _home extends State<Home> {

  TextEditingController msgController = TextEditingController();
  var fromServer = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Simple Interest Calculator'),
        ),
        body: Container(
          margin: EdgeInsets.all(5.0),
          child: ListView(
            children: [
              // Img(),

              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: TextField(
                    style: textStyle,
                    controller: msgController,
                    decoration: InputDecoration(
                      labelText: 'Message',
                      hintText: 'Input message',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          textColor: Theme.of(context).primaryColorDark,
                          child: Text('Send',textScaleFactor: 1.5,),
                          onPressed: () {
                            tcp();
                          }),
                    ),
                    Expanded(
                        child: RaisedButton(
                            color: Theme.of(context).primaryColorDark,
                            textColor: Theme.of(context).primaryColorLight,
                            child: Text('Refresh',textScaleFactor: 1.5,),
                            onPressed: () {

                            })),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.all(5.0),
                child: Text('Recived message is ${this.fromServer}',style: textStyle,),),
            ],
          ),
        ));
  }

  tcp() async {
    Socket socket = await Socket.connect('192.168.1.8', 9999);
    print('connected');

    // listen to the received data event stream
    socket.listen((List<int> event) {
      fromServer =utf8.decode(event);
    });

    // send hello
    var msg = msgController.text;
    socket.add(utf8.encode(msg));

    // wait 5 seconds
    await Future.delayed(Duration(seconds: 5));

    // .. and close the socket
    socket.close();
  }
}


