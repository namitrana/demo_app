import 'package:flutter/material.dart';

class RoundedBorderDropdown extends StatelessWidget {


  final List<String> _dropdownValues = [
    "- Choose Option -",
    "One",
    "Two",
    "Three",
    "Four",
    "Five"
  ]; //The list of values we want on the dropdown

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
          padding: EdgeInsets.fromLTRB(16, 1, 16, 1),
          alignment: Alignment.center,
          //padding: EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),

            color: Colors.white,
            border: Border.all(
                color: Colors.white, style: BorderStyle.solid, width: 0.80),
          ),
          child: DropdownButton(
              hint: Text('DropdownButton Hint'),
            iconEnabledColor: Colors.grey,

            items: _dropdownValues
                .map((value) => DropdownMenuItem(
              child: Text(value),
              value: value,
            ))
                .toList(),
            onChanged: (String value) {

            },
            isExpanded: true,
            value: _dropdownValues.first,
          ),
        );
     // );

  }
}