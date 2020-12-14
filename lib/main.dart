//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';

void main() {
  runApp(
    MaterialApp(
      title: 'Tcp',
      debugShowCheckedModeBanner: false,
      home: Home(),
      // theme: ThemeData(
      //  // brightness: Brightness.dark,
      //   primaryColor: Colors.indigo,
      //   accentColor: Colors.indigoAccent,

    //  ),
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
          title: Text('Client - Server'),
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
                              showAlertDialog(context);

                            })),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.all(5.0),
                child: Text('',style: textStyle,),),
            ],
          ),
        ));
  }

  tcp() async {
    Socket socket = await Socket.connect('192.168.1.8', 9999);
    print('connected');

    // read  msg
    socket.listen((List<int> event) {
      fromServer = utf8.decode(event);
    });

    // send message
    var msg = msgController.text;
    socket.add(utf8.encode(msg));


    // .. and close the socket
    socket.close();
  }

  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("from Server"),
      content: Text(fromServer),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}


