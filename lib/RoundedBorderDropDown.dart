import 'dart:developer';

import 'package:flutter/material.dart';

class RoundedBorderDropdown extends StatefulWidget {
  RoundedBorderDropdown({Key key}) : super(key: key);

  @override
  _RoundedBorderDropdown createState() => _RoundedBorderDropdown();
}

class _RoundedBorderDropdown extends State<RoundedBorderDropdown> {
  final List<String> _dropdownValues = [
    "- Choose Option -",
    "One",
    "Two",
    "Three",
    "Four",
    "Five"
  ]; //The list of values we want on the dropdown

  String _selectedItem = '';
  @override
  void initState() {
    _selectedItem = _dropdownValues.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    /*return Scaffold(
      appBar: AppBar(
        title: Text('Rounded Border Button in AppBar'),
      ),
      body:*/
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
              child: new DropdownButtonHideUnderline(
                  child: /*InputDecorator(
                  decoration: const InputDecoration(
                    labelText: ' Namit',
                    labelStyle: TextStyle(

                    )
                  ),
                  child: */DropdownButton(
                    value: _selectedItem,
                    //    isDense: true,
                    hint: Text('DropdownButton Hint'),
                    iconEnabledColor: Colors.grey,
                    onChanged: (String value) {

                      setState(() {
                        _selectedItem = value;
                        log('Combooooo: $_selectedItem');
                      });

                    },

                    items: _dropdownValues.map((value) => DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    )).toList(),

                    isExpanded: true,

                  )
                //)
              ),
          )

          //)

        );
     // );

  }


}