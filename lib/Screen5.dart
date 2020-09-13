/// Displays the final page with registration details
import 'dart:ui';

import 'package:demo_app/ProgressWidget.dart';
import 'package:demo_app/registration_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:flutter/services.dart';

void main() => runApp(Screen5());

class Screen5 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: MyHomePage(title: 'Account Created'),
    );

  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{
  final _formKey = GlobalKey<FormState>();


  AnimationController animationController;
  ProgressWidget pw;

  @override
  void initState() {

    pw = new ProgressWidget(4, true);
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )
      ..forward()
      ..repeat(reverse: true);

    pw.setAnimationController(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }


  /// Displays error message using SnackBar
  void showMessage(message){
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
    ));
  }


  /// Exits the app
  void exitApp(){
    try {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }on Exception{
        showMessage('System could not close the app. Please press HOME button...');
    }
  }


  @override
  Widget build(BuildContext context) {
    //var h = (MediaQuery.of(context).size.height - 88) / 4.5;
    //var h = (MediaQuery.of(context).size.height - 88) * .2;
    var statusBarHeight = MediaQuery.of(context).padding.top;
    var h = (MediaQuery.of(context).size.height - statusBarHeight) * .2;
    var w = MediaQuery.of(context).size.width;
    log('height in top: $h');


    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Form(
            key: _formKey,
            child: Container(
                color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[

                    /// Displays the top area with rounded containers
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: h,
                        color: Colors.blue,
                        child: pw),


                    /// Display the message with registration details
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: RichText(
                            text: new TextSpan(
                              // Note: Styles for TextSpans must be explicitly defined.
                              // Child text spans will inherit styles from parent
                              style: new TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                              children: <TextSpan>[
                                new TextSpan(
                                    text: 'Registration Success:\n',
                                    style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                new TextSpan(
                                  // Note: Styles for TextSpans must be explicitly defined.
                                  // Child text spans will inherit styles from parent
                                  style: new TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  children: <TextSpan>[
                                    //, style: new TextStyle(fontWeight: FontWeight.bold, )
                                    new TextSpan(
                                        text:
                                        '\nCongratulations!! You have been registered with us with email ' + RegistrationDetails.getEmail() + '.\n'
                                            ''
                                            '\nThe video call has been scheduled as mentioned below:\n Date: ' + RegistrationDetails.getDate() + '\n'
                                            ' Time: ' + RegistrationDetails.getTime() + '\n\n'
                                            'Please check your registered email for more details.'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )),

                    /// Exit app button
                    Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: w,
                            padding: EdgeInsets.fromLTRB(16, 1, 16, 1),
                            child:  MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    side: BorderSide(color: Colors.lightBlue)),
                                splashColor: Colors.blueAccent,
                                color: Colors.lightBlue,
                                onPressed: exitApp,
                                child: Text('Exit App')),
                          ),
                        )),

                  ],
                ) //column,
            ))//form
    );
  }
}