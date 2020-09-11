//import 'dart:html';
import 'dart:ui';

import 'package:demo_app/ProgressWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:demo_app/Screen3.dart';
import 'package:demo_app/Strings.dart';

void main() => runApp(
    MaterialApp(title:  "Routing..",
      initialRoute: '/screen2',
      routes: {
        '/screen2' : (context) => Screen2(),
        '/screen3' : (context) =>  Screen3(),
      },
    )
);

class Screen2 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: MyHomePage(title: 'Create Account'),
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
      home: MyHomePage(title: 'Create Account'),
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
  List<String> topTextList = ['a', 'A', '123', '9+'];
  List<String> bottomTextList = ['Lowercase', 'Uppercase', 'Number', 'Characters'];
  List<int> widgetIndex = [0, 0, 0, 0];
  bool isPasswordVisible;
  String complexityText = '';

  TextEditingController passwordController = TextEditingController();
  Widget widget1;
  String passwordErrorText = '';

  //List<PasswordStatusState> passwordStatusList = new List<PasswordStatusState>();
  @override
  void initState() {
    passwordController.text = '';
    isPasswordVisible = false;
  }

  String _validatePassword(String password) {
    bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    bool hasSpecialCharacters = password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    String temp;
    setState(() {
      if(password.length == 0){
        passwordErrorText = "Please enter some text";
      }else if(password.length < 8){
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

  void validatePassword() {
    String str = _validatePassword(passwordController.text);
    log('//////////////// $str');
    if (str.length == 0) {
      Navigator.of(context).pushNamed('/screen3');
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
                        child: new ProgressWidget(1)),
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
                                    text: 'Create Password\n',
                                    style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
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
                                        text:
                                            'Password will be used to login to account'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )),
                    //),
                    //),
                    Padding(
                        padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                        /*child: Container(
                    color: Colors.blue,*/
                        child: TextField(
                            onChanged: (text) {
                              print("First text field: $text");
                              bool isLetter = RegExp('[a-z]+').hasMatch(text);
                              bool isCapLetter = RegExp('[A-Z]+').hasMatch(text);
                              bool isNumber = RegExp('[0-9]+').hasMatch(text);
                              print("isLetter: $isLetter" );
                              print("isCapLetter: $isCapLetter" );

                                setState(() {


                                  if(isLetter) {
                                    widgetIndex[0] = 1;
                                  }else{
                                    widgetIndex[0] = 0;
                                  }

                                  if(isCapLetter) {
                                    widgetIndex[1] = 1;
                                  }else{
                                    widgetIndex[1] = 0;
                                  }
                                  if(isNumber) {
                                    widgetIndex[2] = 1;
                                  }else{
                                    widgetIndex[2] = 0;
                                  }
                                  if(text.length > 9) {
                                    widgetIndex[3] = 1;
                                  }else{
                                    widgetIndex[3] = 0;
                                  }


                                  int value = widgetIndex[0] + widgetIndex[1] +
                                      widgetIndex[2] + widgetIndex[3];
                                  if(text.length < 4){
                                      complexityText = "Very Weak";
                                  }else{
                                    switch(value){
                                      case 1:
                                        complexityText = 'Very Weak';
                                        break;
                                      case 2:
                                        complexityText = 'Weak';
                                        break;
                                      case 3:
                                        complexityText = 'Strong';
                                        break;
                                      case 4:
                                        complexityText = 'Very Strong';
                                        break;
                                    }

                                  }

                                });

                            },
                          controller: passwordController,
                            /*autovalidate: true,

                      validator: (password) {
                        if (password.isEmpty) {
                          return 'Please enter some text';
                        } else if(password.length < 6){
                          return 'Password must have 6 or more characters';
                        }
                      },*/
                            keyboardType: TextInputType.text,
                            obscureText: !isPasswordVisible,
                            decoration: InputDecoration(
                              hintText: 'Create Password',
                              errorText: passwordErrorText,
                              hintStyle: TextStyle(color: Colors.grey),
                              fillColor: Colors.white,
                              filled: true,

                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
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
                            ))),

                   /* Expanded(
                      child: */Align(
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
                                      new TextSpan(text: 'Complexity: '),
                                      new TextSpan(
                                          text: complexityText,
                                          style: new TextStyle(
                                              fontSize: 14,
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )),
                    //),

                    //
                    /*Expanded(
                      child: */
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        for ( int i = 0; i < topTextList.length; i++ )
                            //passwordStatusList[i]

                          getTextWidget(topTextList[i], bottomTextList[i], i)

                      ],
                    ),
                    //),

                    Expanded(
                        child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: w,
                        padding: EdgeInsets.fromLTRB(16, 1, 16, 1),
                        child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(color: Colors.lightBlue)),
                            splashColor: Colors.blueAccent,
                            color: Colors.lightBlue,
                            onPressed: validatePassword,
                            child: Text('Next')),
                      ),
                    )),
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
