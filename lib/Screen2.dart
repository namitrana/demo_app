//import 'dart:html';
import 'dart:ui';

import 'package:demo_app/ProgressWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

void main() => runApp(Screen2());

class Screen2 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Create Account'),
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

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  bool isPasswordVisible;

  @override
  void initState(){
    isPasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    //var h = (MediaQuery.of(context).size.height - 88) / 4.5;
    //var h = (MediaQuery.of(context).size.height - 88) * .2;
    var statusBarHeight = MediaQuery.of(context).padding.top;
    var h = (MediaQuery.of(context).size.height - statusBarHeight) * .2;
    var w = MediaQuery.of(context).size.width;
    log('height in top: $h');
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    Widget _getRoundContainer(var text) {
      return Container(
          decoration:
              BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          width: (h - (h * .5)) / 2,
          height: (h - (h * .5)) / 2,

          child: Center(
            child: new Text(text),
          ));
    }

    Widget _getHorizontalLine() {
      var circlesWidth = ((h - (h * .5)) / 2) * 4;
      var remainWidth = w - circlesWidth;
      var lineWidth = remainWidth / 6;
      return Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        width: lineWidth,
        height: 2,
      );
    }

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
                /*Stack(
                  children: <Widget>[*/
                   /* ClipPath(
                        clipper: MyCustomClipper(
                            h, MediaQuery.of(context).size.width),*/
                        /*child:*/ Container(
                            width: MediaQuery.of(context).size.width,
                            height: h,
                            color: Colors.blue,
                            child:
                                new ProgressWidget(2)
                            ),
                   // ),

                /*Expanded(
                  child: Container(
                    color: Colors.blue,
                    child:*/ Align(
                        alignment: Alignment.centerLeft,

                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: RichText(

                            text: new TextSpan(
                              // Note: Styles for TextSpans must be explicitly defined.
                              // Child text spans will inherit styles from parent
                              style: new TextStyle(
                                fontSize: 24.0,
                                color: Colors.white,
                              ),
                              children: <TextSpan>[
                                new TextSpan(
                                    text: 'Create Password\n',
                                    style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),

                                new TextSpan(
                                  // Note: Styles for TextSpans must be explicitly defined.
                                  // Child text spans will inherit styles from parent
                                  style: new TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal),
                                  children: <TextSpan>[
                                    //, style: new TextStyle(fontWeight: FontWeight.bold, )
                                    new TextSpan(
                                        text:
                                            'Password will be used to login to account'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                    ),
                //),
                //),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                  /*child: Container(
                    color: Colors.blue,*/
                  child: TextField(
                      /*autovalidate: true,

                      validator: (password) {
                        if (password.isEmpty) {
                          return 'Please enter some text';
                        } else if(password.length < 6){
                          return 'Password must have 6 or more characters';
                        }
                      },*/
                      keyboardType: TextInputType.text,
                      obscureText: isPasswordVisible,

                      decoration: InputDecoration(
                          hintText: 'Create Password',
                          hintStyle: TextStyle(color: Colors.grey),
                          fillColor: Colors.white,
                          filled: true,

                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        /*border: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.white)
                            //borderSide: BorderSide.none
                          borderSide: const BorderSide(),
                        ),*/
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                          //border: InputBorder.
                          )
                  )
                  //),

                ),

                Align(
                    alignment: Alignment.centerLeft,

                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: RichText(

                        text: new TextSpan(
                          // Note: Styles for TextSpans must be explicitly defined.
                          // Child text spans will inherit styles from parent
                          style: new TextStyle(
                            fontSize: 24.0,
                            color: Colors.white,
                          ),
                          children: <TextSpan>[

                            new TextSpan(
                              // Note: Styles for TextSpans must be explicitly defined.
                              // Child text spans will inherit styles from parent
                              style: new TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                              children: <TextSpan>[
                                //, style: new TextStyle(fontWeight: FontWeight.bold, )
                                new TextSpan(

                                    text: 'Complexity: '
                                ),
                                new TextSpan(
                                    text: ' Very Weak',
                                    style: new TextStyle(
                                        fontSize: 14,
                                        color: Colors.brown,
                                        fontWeight: FontWeight.bold)
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                ),



                Expanded(
                    child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: w,

                    padding: EdgeInsets.fromLTRB(16, 1, 16, 1),
                    child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(color: Colors.lightBlue)
                        ),
                        splashColor: Colors.blueAccent,
                        color: Colors.lightBlue,
                        onPressed: () => {
                              if (_formKey.currentState.validate())
                                {
                                  //log('Email is successful')
                                  /* Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Screen2()),
    );*/
                                }
                            },
                        child: Text('Next')),
                  ),
                )),
              ],
            ) //column,
            )
      )
    );
  }
}


