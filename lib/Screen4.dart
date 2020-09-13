

///  This widget is used to display date and time to schedule a video call
import 'dart:ui';
import 'package:demo_app/ProgressWidget.dart';
import 'package:demo_app/registration_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:demo_app/Strings.dart';
import 'dart:io' show Platform;

void main() => runApp(Screen4());

class Screen4 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  AnimationController animationController;
  String time = Strings.dropDownTime.first;
  TextEditingController dateTextController = TextEditingController()..text = '- Choose Date -';

  List<String> list;
  String label;
  String _selectedItem = '';

  ProgressWidget pw;

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    //isPasswordVisible = false;
    pw = new ProgressWidget(3, false);
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

  String getSelectedItem(String id) {
    if (id == 'time') {
      log("getSelectedItem()111: $time");
      return time;
    }
  }

  /// This decides which day will be enabled.
  ///
  /// It will allow users to schedule a time from current day to next 30 days
  /// This will be called every time while displaying day in calender.
  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(Duration(days: 30))))) {
      return true;
    }
    return false;
  }

  /// This builds material date picker in Android
  buildMaterialDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 3),
      selectableDayPredicate: _decideWhichDayToEnable,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {

        selectedDate = picked;
       // dateTextController.value = 'thai gau';
        log("//////////////the selected date is $selectedDate");
        dateTextController = TextEditingController()..text = getDateOnly(selectedDate.toString());
      });
  }

  /// Returns date part from date-time format of a date
  String getDateOnly(String dateTime){
    int idx = dateTime.indexOf(" ");
    String date = '';
    if(idx > -1){
      date = dateTime.substring(0, idx);
    }
    return date;
  }

  /// This builds cupertion date picker in iOS
  buildCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                if (picked != null && picked != selectedDate)
                  setState(() {
                    selectedDate = picked;
                  });
              },
              initialDateTime: selectedDate,
              minimumYear: 2000,
              maximumYear: 2025,
            ),
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    //var h = (MediaQuery.of(context).size.height - 88) / 4.5;
    //var h = (MediaQuery.of(context).size.height - 88) * .2;
    var statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;
    var h = (MediaQuery
        .of(context)
        .size
        .height - statusBarHeight) * .2;
    var w = MediaQuery
        .of(context)
        .size
        .width;
    log('height in top: $h');
    /*int _widgetIndex = 0;
    String _chosenValue = '';*/

    /// This is used to display error messages in SnackBar
    void showMessage(message) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ));
    }

    /// Validates date and time combo-box
    ///
    /// Displays error message if there is any problem in validation
    /// If date and time combo-boxes are selected, it takes user to final screen
    void validate() {
      String message = '';

      if(dateTextController.value.toString().indexOf('Choose') > -1){
        message = Strings.SELECT_DATE_ERROR;
        showMessage(message);
      }else if( time.indexOf("-") > -1){
        message = Strings.SELECT_TIME_ERROR;
        showMessage(message);
      }else{
        RegistrationDetails.setDate(dateTextController.text);
        RegistrationDetails.setTime(time);
        Navigator.of(context).pushNamed('/screen5');
        //showMessage(message);
      }
   }


    /// Displays date picker specific to the platform(Android/iOS)
    void _showDatePicker(){
      log("showdatepicker...............");
      if(Platform.isAndroid){
        buildMaterialDatePicker(context);
      }else if(Platform.isAndroid){
        buildCupertinoDatePicker(context);
      }
    }


    /// Returns the rounded combo-box used to display time on this page
    Widget getRoundedBorderDropdown(List<String> _dropdownValues, String label,
        String id) {
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
                            if (id == 'time') {
                              time = value;
                            }
                          });
                        },

                        items: _dropdownValues
                            .map((value) =>
                            DropdownMenuItem(
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
                    /// Displays the top part with circular container and horizontal lines
                    Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: h,
                        color: Colors.blue,
                        child: pw
                    ),


                    /// Displays the text messages which asks user to schedule the call
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
                                    text: 'Schedule Video Call\n',
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
                                        'Choose the date and time that you preferred. '
                                            'we will send a link via email to make a video'
                                            'call on the scheduled date and time.'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )),


                    /// Date picker UI
                    Padding(
                        padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                        child: Container(
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
                                        'Date',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    )
                                ),
                                Container(
                                  //color: Colors.red,
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(10, 0, 3, 0),
                                      child: InkWell(
                                        onTap: _showDatePicker,
                                        child: TextField(

                                            controller: dateTextController,
                                            enabled: false,
                                            //initialValue: '-- Chose Date--',

                                            //keyboardType: TextInputType.emailAddress,
                                            decoration: InputDecoration(

                                              hintStyle: TextStyle(color: Colors.grey),

                                              enabledBorder: const OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.white, width: 10),
                                                  borderRadius: const BorderRadius.all(
                                                      const Radius.circular(10.0))),
                                              suffixIcon: new IconButton(
                                                icon: new Icon(Icons.arrow_drop_down),
                                                onPressed: _showDatePicker
                                              )
                                              //border: InputBorder.none
                                              //labelText: 'Email'
                                            )
                                        ),
                                      ),
                                    )
                                ),


                                //),
                              ],
                            ))

                      //)

                    ),
                    ),

                    /// Time drop-down
                    Padding(
                        padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                        child: getRoundedBorderDropdown(
                            Strings.dropDownTime, Strings.TIME, 'time')
                      //new RoundedBorderDropdown(Strings.dropdownValues, Strings.MONTHLY_INCOME_TEXT)
                    ),


                    /// Next button
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
                                child: Text('Next')),
                          ),
                        )),
                  ],
                ) //column,
            )) //form
    );
  }
}
