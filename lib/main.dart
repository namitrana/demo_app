
/// This is a dummy project used to register a user and schedule a video call
///
/// Author: Namit Rana
///  Date: 13/09/2020

import 'dart:ui';
import 'package:demo_app/ProgressWidget.dart';
import 'package:demo_app/Screen2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/Screen3.dart';
import 'package:demo_app/Strings.dart';
import 'package:demo_app/Screen4.dart';
import 'package:demo_app/Screen5.dart';
import 'package:demo_app/registration_details.dart';
import 'dart:developer';

/// Starting point of the project
void main() => runApp(MaterialApp(
      title: Strings.HOME_PAGE_TITLE,
      initialRoute: '/',
      routes: {
        '/': (context) => MyApp(),
        '/screen2': (context) => Screen2(),
        '/screen3': (context) => Screen3(),
        '/screen4': (context) => Screen4(),
        '/screen5': (context) => Screen5(),
      },
    ));



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyHomePage(title: Strings.HOME_PAGE_TITLE),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}


/// Determines the first page of the project to input email
class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController emailController = TextEditingController();
  String emailErrorText = '';
  AnimationController animationController;
  ProgressWidget pw;

  @override
  void initState() {
    emailController.text = '';
    emailErrorText = '';
    pw = new ProgressWidget(0, true);

    /// This code needs improvements as we are [animationController] even though
    /// it is not required.  To be improved later.
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )
      ..forward()
      ..repeat(reverse: true);
    pw.setAnimationController(animationController);
    super.initState();
  }

  @override
  void dispose() {
    /// Dispose animationController without fail
    animationController.dispose();
    super.dispose();
  }

  /// This method is used to display the SnackBar to display error messages
  void showMessage(message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
    ));
  }


  /// Validates [email] and returns email validity status
  String _validateEmail(String email) {
    //log("asdasga: email:: $email");
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

  /// Validates the email.
  ///
  /// Takes the user to the next screen if valid email is inputted
  /// Shows error message if the email has invalid format
  void validateEmail() {
    String str = _validateEmail(emailController.text);
    if (str.length == 0) {
      //emailController.text = '';
      RegistrationDetails.setEmail(emailController.text);
      Navigator.of(context).pushNamed('/screen2');
    } else if (str.length > 0) {
      showMessage(str);
    }
  }



  @override
  Widget build(BuildContext context) {
    //var h = (MediaQuery.of(context).size.height - 88) / 4.5;
    //var h = (MediaQuery.of(context).size.height - 88) * .2;

    /// Height of the status bar of the application
    var statusBarHeight = MediaQuery.of(context).padding.top;

    /// 20% of the height which is used to occupy the top area with circular widget
    var h = (MediaQuery.of(context).size.height - statusBarHeight) * .2;
    /// Width of the screen
    var w = MediaQuery.of(context).size.width;
    log('height in top: $h');


    /// Returns a widget with round Container and a text within
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

    /// Returns a widget with Container as a horizontal line
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

                    // Top widget to display circular containers with horizontal lines
                    ClipPath(
                        clipper: MyCustomClipper(
                            h, MediaQuery.of(context).size.width),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: h,
                            color: Colors.blue,
                            child: pw)),
                  ],
                ),

                // Displays the text just below the above mentioned widget
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
                                        text:Strings.WELCOME_TEXT
                                            ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ))),

                // Email text box widget
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 3, 16, 3),
                  child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.grey),
                        //errorText: emailErrorText,
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

                // Displays the button at the bottom
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


/// This class is used to provide a curve border to a rectangular Container.
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
