//import 'dart:html';
import 'dart:ui';

import 'package:demo_app/ProgressWidget.dart';

import 'package:demo_app/Screen2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/Screen3.dart';
import 'package:demo_app/Strings.dart';
import 'dart:developer';

void main() => runApp(MaterialApp(
      title: Strings.HOME_PAGE_TITLE,
      initialRoute: '/',
      routes: {
        '/': (context) => MyApp(),
        '/screen2': (context) => Screen2(),
        '/screen3': (context) => Screen3(),
      },
    ));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyHomePage(title: Strings.HOME_PAGE_TITLE),
    );
    /*return MaterialApp(

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
      home: MyHomePage(title: 'Demo App'),
    );*/
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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController emailController = TextEditingController();

  String emailErrorText = '';

  @override
  void initState() {
    emailController.text = '';
    emailErrorText = '';
  }

  @override
  void dispose() {
    //emailController.text = '';
  }

  String _validateEmail(String email) {
    String temp;
    setState(() {
      if (email.isEmpty) {
        emailErrorText = Strings.EMAIL_EMPTY_TEXT;
      } else if (email.isNotEmpty) {
        bool emailValid =
            RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                .hasMatch(email);
        if (!emailValid) {
          emailErrorText = Strings.EMAIL_ERROR_TEXT;
        } else {
          //emailErrorText = Strings.EMAIL_SUCCESS_TEXT;
          emailErrorText = '';
          log("Email Error Text when success:" +
              emailErrorText.length.toString());
        }
      }
    });

    temp = emailErrorText;
    return temp;
  }

  void validateEmail() {
    int x = 0;
    String str = _validateEmail(emailController.text);
    log('//////////////// $str');
    if (_validateEmail(emailController.text).length == 0) {
      Navigator.of(context).pushNamed('/screen2');
    }
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
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
          //color: Colors.red,
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

    String text1;
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    ClipPath(
                        clipper: MyCustomClipper(
                            h, MediaQuery.of(context).size.width),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: h,
                            color: Colors.blue,
                            child: new ProgressWidget(0))),
                  ],
                ),
                Expanded(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: RichText(
                            text: new TextSpan(
                              // Note: Styles for TextSpans must be explicitly defined.
                              // Child text spans will inherit styles from parent
                              style: new TextStyle(
                                fontSize: 24.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                new TextSpan(
                                    text: 'Welcome to\n',
                                    style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                new TextSpan(
                                    text: 'GIN',
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold)),
                                new TextSpan(
                                    text: ' Finans',
                                    style: new TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold)),
                                new TextSpan(
                                  // Note: Styles for TextSpans must be explicitly defined.
                                  // Child text spans will inherit styles from parent
                                  style: new TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  children: <TextSpan>[
                                    //, style: new TextStyle(fontWeight: FontWeight.bold, )
                                    new TextSpan(
                                        text:
                                            '\n\nWelcome to The Bank of The Future.'
                                            '\nManage and track your accounts\non the go.'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ))),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 3, 16, 3),
                  child: TextField(
                      controller: emailController,
                      /*autovalidate: true,
                      validator: (email) {
                        if (email.isEmpty) {
                          return 'Please enter some text';
                        }else if(email.isNotEmpty){
                          bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(email);
                          if(!emailValid){
                            return 'Please enter valid email id';
                          }
                        }
                        return null;
                      },*/

                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.grey),
                        errorText: emailErrorText,
                        enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 10),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0))),
                        prefixIcon: Icon(Icons.email),
                        //border: InputBorder.none
                        //labelText: 'Email'
                      )),
                ),
                Expanded(
                    child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: w,
                    //color: Colors.red,
                    padding: EdgeInsets.fromLTRB(16, 1, 16, 1),
                    child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(color: Colors.lightBlue)),
                        splashColor: Colors.lightBlue,
                        color: Colors.lightBlue,
                        onPressed: validateEmail,
                        child: Text('Next')),
                  ),
                )),
              ],
            ) //column,
            ));
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  var h, w;

  MyCustomClipper(double h1, double w1) {
    h = h1;
    w = w1;
  }

  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var path = new Path();
    path.lineTo(0, h);
    //var firstControlPoint = new Offset(size.width / 12, h / 4);
    var firstControlPoint =
        new Offset(size.width - (size.width * .95), h - (h * .5));
    var firstEndPoint = new Offset(size.width, h);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
