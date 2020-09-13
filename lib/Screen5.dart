/// Displays the final page after registration
import 'dart:ui';

import 'package:demo_app/ProgressWidget.dart';
import 'package:demo_app/registration_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:demo_app/Strings.dart';
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
  List<String> topTextList = ['a', 'A', '123', '9+'];
  List<String> bottomTextList = ['Lowercase', 'Uppercase', 'Number', 'Characters'];
  List<int> widgetIndex = [0, 0, 0, 0];
  bool isPasswordVisible;
  String complexityText = '';

  TextEditingController passwordController = TextEditingController();
  Widget widget1;
  String passwordErrorText = '';

  AnimationController animationController;
  ProgressWidget pw;
  //List<PasswordStatusState> passwordStatusList = new List<PasswordStatusState>();
  @override
  void initState() {
    passwordController.text = '';
    isPasswordVisible = false;

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

  void showMessage(message){
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
    ));
  }

  void validate(){
    try {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }on Exception{
        showMessage('System could not close the app. Please press HOME button...');


    }
  }

  String _validatePassword(String password) {
    bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    //bool hasSpecialCharacters = password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasSpecialCharacters = true;

    String temp;
    setState(() {
      if(password.length == 0){
        passwordErrorText = "Please enter some text";
      }else if(password.length < 9){
        passwordErrorText = "Minimum 8 letters required";
      }else if(hasDigits & hasUppercase & hasLowercase & hasSpecialCharacters){
        passwordErrorText = '';
      }else{
        passwordErrorText = "Invalid password";
      }

    });

    temp = passwordErrorText;
    return temp;
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

    Widget getTextWidget(var topText, var bottomText, int index) {

      widget1 = Column(

        // mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            IndexedStack(
              //key: bottomText,
              alignment: Alignment.topCenter,
              index: widgetIndex[index],
              children: <Widget>[
                RichText(
                  textAlign: TextAlign.center,
                  text: new TextSpan(
                      style: new TextStyle(
                          fontSize: 28.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      text: topText
                  ),
                ),
                RawMaterialButton(
                  onPressed: () {},
                  elevation: 2.0,
                  fillColor: Colors.green,
                  highlightColor: Colors.white,
                  child: new IconTheme(
                    data: new IconThemeData(
                        color: Colors.white),
                    child: new Icon(Icons.check),
                  ),
                  //padding: EdgeInsets.all(5.0),
                  shape: CircleBorder(),
                )
              ],
            ),


            /*RichText(
                  textAlign: TextAlign.center,
                  text: new TextSpan(
                    children: <TextSpan>[
                      new TextSpan(
                        style: new TextStyle(
                            fontSize: 28.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          //, style: new TextStyle(fontWeight: FontWeight.bold, )
                          new TextSpan(text: topText),

                          new TextSpan(
                          text: bottomText,
                          style: new TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ],
                  ),
                ),*/

            RichText(
              textAlign: TextAlign.center,
              text: new TextSpan(
                  text: bottomText,
                  style: new TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.normal)),
            ),



            //)
          ]);

      return widget1;
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
                        child: pw),
                    // ),

                    /*Expanded(
                  child: Container(
                    color: Colors.blue,
                    child:*/
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
                                      fontSize: 14.0,
                                      color: Colors.black,
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
                                onPressed: validate,
                                child: Text('Exit App')),
                          ),
                        )),
                    //),
                    //),




                    //
                    /*Expanded(
                      child: */

                    //),


                  ],
                ) //column,
            ))//form
    );
  }
}


/*class PasswordStatus extends StatefulWidget{

  static String topText = '';
  static String bottomText = '';
  PasswordStatus(String topText1, String bottomText1){
    topText = topText1;
    bottomText = bottomText1;
  }

  PasswordStatusState ps = new PasswordStatusState(topText, bottomText);
  @override
  PasswordStatusState createState() => ps;

}*/

//class PasswordStatusState extends State<PasswordStatus>{
/*
class PasswordStatusState extends StatelessWidget{

  String topText = '';
  String bottomText = '';

  int _widgetIndex = 0;

  void setWidgetIndex(int w){
    this._widgetIndex = w;
  }

  PasswordStatusState(String topText, String bottomText){
    this.topText = topText;
    this.bottomText = bottomText;

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(

      // mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          IndexedStack(
            //key: bottomText,
            alignment: Alignment.topCenter,
            index: _widgetIndex,
            children: <Widget>[
              RichText(
                textAlign: TextAlign.center,
                text: new TextSpan(
                    style: new TextStyle(
                        fontSize: 28.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    text: topText
                ),
              ),
              RawMaterialButton(
                onPressed: () {},
                elevation: 2.0,
                fillColor: Colors.green,
                highlightColor: Colors.white,
                child: new IconTheme(
                  data: new IconThemeData(
                      color: Colors.white),
                  child: new Icon(Icons.check),
                ),
                //padding: EdgeInsets.all(5.0),
                shape: CircleBorder(),
              )
            ],
          ),


          */
/*RichText(
                  textAlign: TextAlign.center,
                  text: new TextSpan(
                    children: <TextSpan>[
                      new TextSpan(
                        style: new TextStyle(
                            fontSize: 28.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          //, style: new TextStyle(fontWeight: FontWeight.bold, )
                          new TextSpan(text: topText),

                          new TextSpan(
                          text: bottomText,
                          style: new TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ],
                  ),
                ),*//*


          RichText(
            textAlign: TextAlign.center,
            text: new TextSpan(
                text: bottomText,
                style: new TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.normal)),
          ),



          //)
        ]);
  }

}
*/
