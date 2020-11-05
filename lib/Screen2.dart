/// This class is used to display a UI to create a password
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
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: MyHomePage(title: 'Create Account'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

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

    pw = new ProgressWidget(1, true);
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

  /// Validates password and returns a text with password validation status
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
        passwordErrorText = "Minimum 9 letters required";
      }else if(password.length > 40){
        passwordErrorText = "Password length cannot exceed 40 characters";
      }
      else if(hasDigits & hasUppercase & hasLowercase & hasSpecialCharacters){
        passwordErrorText = '';
      }else{
        passwordErrorText = "Invalid password";
      }
    });
    temp = passwordErrorText;
    return temp;
  }

  /// Validates the password
  ///
  /// If the password is correct, the control is taken to the next page
  /// Display the error message using SnackBar
  void validatePassword() {
    String str = _validatePassword(passwordController.text);
    log('//////////////// $str');
    if (str.length == 0) {
      Navigator.of(context).pushNamed('/screen3');
    }else{
      showMessage(str);
    }
  }

  void showMessage(message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
    ));
  }

  @override
  Widget build(BuildContext context) {
    //var h = (MediaQuery.of(context).size.height - 88) / 4.5;
    //var h = (MediaQuery.of(context).size.height - 88) * .2;
    var statusBarHeight = MediaQuery.of(context).padding.top;
    var h = (MediaQuery.of(context).size.height - statusBarHeight) * .2;
    var w = MediaQuery.of(context).size.width;
    log('height in top: $h');


    /// Returns the UI used to display password complexity and its requirements.
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

                     /// Displays the top part with circular widget and horizontal lines
                     Container(
                        width: MediaQuery.of(context).size.width,
                        height: h,
                        color: Colors.blue,
                        child: pw
                     ),

                    /// Displays some texts below the above widget
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


                    /// Shows the [TextField] used to enter the password
                    Padding(
                        padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                        /*child: Container(
                    color: Colors.blue,*/
                        child: TextField(

                            /// Logic to display password complexity. Code needs improvements.
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
                                  if(text.length >= 9) {
                                    widgetIndex[3] = 1;
                                  }else{
                                    widgetIndex[3] = 0;
                                  }


                                  int value = widgetIndex[0] + widgetIndex[1] +
                                      widgetIndex[2] + widgetIndex[3];
                                  if(text.length <= 5){
                                      complexityText = Strings.PASSWORD_COMPLEXITY_VERY_WEAK;
                                  }else{
                                    switch(value){
                                      case 1:
                                        complexityText = Strings.PASSWORD_COMPLEXITY_VERY_WEAK;
                                        break;
                                      case 2:
                                        complexityText = Strings.PASSWORD_COMPLEXITY_WEAK;
                                        break;
                                      case 3:
                                        complexityText = Strings.PASSWORD_COMPLEXITY_STRONG;
                                        break;
                                      case 4:
                                        complexityText = Strings.PASSWORD_COMPLEXITY_VERY_STRONG;
                                        break;
                                    }

                                  }

                                });

                            },
                          controller: passwordController,

                            keyboardType: TextInputType.text,
                            obscureText: !isPasswordVisible,
                            decoration: InputDecoration(
                              hintText: 'Create Password',
                              //errorText: passwordErrorText,
                              hintStyle: TextStyle(color: Colors.grey),
                              fillColor: Colors.white,
                              filled: true,

                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),

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

                   /// Area that determines password complexity
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


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        for ( int i = 0; i < topTextList.length; i++ )
                          getTextWidget(topTextList[i], bottomTextList[i], i)
                      ],
                    ),



                    /// Displays the next button
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


