import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {

  String label = '';
  LabelText(String label) {
    this.label = label;
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var w = MediaQuery.of(context).size.width;
    return Container(
      //color: Colors.red,
        width: w,
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 3, 0),
          child: new Text(
            label,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        )
    );
  }


}

