/// Third step in the registration process used to select Goal, monthly income and monthly expense

//import 'dart:html';
import 'dart:ui';

import 'package:demo_app/ProgressWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:demo_app/RoundedBorderDropDown.dart';
import 'package:demo_app/Strings.dart';

void main() => runApp(Screen3());

class Screen3 extends StatelessWidget {
  // This widget is the root of your application.
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

  AnimationController animationController;
  ProgressWidget pw;

  @override
  void initState() {
    //isPasswordVisible = false;

    pw = new ProgressWidget(2, true);
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

  String goal = Strings.dropdownValues.first;
  String monthlyIncome = Strings.dropdownValues.first;
  String monthlyExpense = Strings.dropdownValues.first;

  List<String> list;
  String label;
  String _selectedItem = '';


  /// Used to return the change value of the combo box with reference to its id
  String getSelectedItem(String id){
    if(id=='goal'){
      log("getSelectedItem()111: $goal");
      return goal;
    }else if(id == 'mi'){
      log("getSelectedItem()222: $monthlyIncome");
      return monthlyIncome;
    }else{
      log("getSelectedItem()333: $monthlyExpense");
      return monthlyExpense;
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
    int _widgetIndex = 0;
    String _chosenValue = '';

    /// Dislays the error message in the snackbar
    void showMessage(message){
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ));
    }

    /// Validates the combo-box and displays error message if not selected
    void validate(){
      String message = '';
      if(goal.contains('-') || goal.length == 0){
          message = Strings.SELECT_GOAL_ERROR;
          showMessage(message);
      }else if(monthlyIncome.contains("-") || monthlyIncome.length == 0){
          message = Strings.SELECT_MI_ERROR;
          showMessage(message);
      }else if(monthlyExpense.contains('-') || monthlyExpense.length == 0){
          message = Strings.SELECT_ME_ERROR;
          showMessage(message);
      }else{
        Navigator.of(context).pushNamed('/screen4');
      }

    }


    /// Returns the widget used to display the rounded drop down list
    Widget getRoundedBorderDropdown(List<String> _dropdownValues, String label, String id){
      list = _dropdownValues;
      this.label = label;
      _selectedItem = _dropdownValues.first;
     // goal = monthlyExpense = monthlyIncome = _selectedItem;

      return Container(
          width: w - 20,
          padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
          alignment: Alignment.center,
          //padding: EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
            border: Border.all(
                color: Colors.white, style: BorderStyle.solid, width: 0.80),
          ),
          child: Container(
              child: Column(
                children: <Widget>[

                  Container(
                    //color: Colors.red,
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 3, 0),
                        child: new Text(
                          label,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      )),

                  new DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: getSelectedItem(id),
                        //    isDense: true,
                        //hint: Text('DropdownButton Hint'),
                        iconEnabledColor: Colors.grey,
                        onChanged: (String value) {
                          setState(() {
                            _selectedItem = value;
                            //log('Combooooo: $_selectedItem');
                            if(id == 'goal'){
                              goal = value;
                            }else if(id == 'mi'){
                              monthlyIncome = value;
                            }else{
                              monthlyExpense = value;
                            }
                          });

                        },

                        items: _dropdownValues
                            .map((value) => DropdownMenuItem(
                          child: Text(value),
                          value: value,
                        ))
                            .toList(),

                        isExpanded: true,
                      ))
                  //),
                ],
              ))

        //)

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    text: 'Personal Information\n',
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
                                            'Please fill the information below and your goal for digital saving.'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )),



                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                            child: getRoundedBorderDropdown(Strings.dropdownValues, Strings.GOAL_FOR_ACTIVATION_TEXT, 'goal')
                            //new RoundedBorderDropdown(Strings.dropdownValues, Strings.GOAL_FOR_ACTIVATION_TEXT)
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                        child: getRoundedBorderDropdown(Strings.dropdownValues, Strings.MONTHLY_INCOME_TEXT,'mi')
                        //new RoundedBorderDropdown(Strings.dropdownValues, Strings.MONTHLY_INCOME_TEXT)
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                        child:  getRoundedBorderDropdown(Strings.dropdownValues, Strings.MONTHLY_EXPENSE_TEXT,'me')
                        //new RoundedBorderDropdown(Strings.dropdownValues, Strings.MONTHLY_EXPENSE_TEXT)
                    ),



                    //),
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
                            onPressed: validate,
                            child: Text('Next')),
                      ),
                    )),
                  ],
                ) //column,
                )) //form
        );
  }
}
