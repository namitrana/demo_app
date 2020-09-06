import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressWidget extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    var statusBarHeight = MediaQuery.of(context).padding.top;
    var h = (MediaQuery.of(context).size.height - statusBarHeight) * .2;
    var w = MediaQuery.of(context).size.width;

    Widget _getRoundContainer(var text){
      return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle
          ),
          width: (h-(h*.5)) / 2,
          height: (h-(h*.5)) / 2,
          //color: Colors.red,
          child: Center(
            child: new Text(text),
          )
      );
    }

    Widget _getHorizontalLine(){
      var circlesWidth = ((h-(h*.5)) / 2) * 4;
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


    return Container(
      width: MediaQuery.of(context).size.width,
      height: h,
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _getRoundContainer('1'),
          _getHorizontalLine(),
          _getRoundContainer('2'),
          _getHorizontalLine(),
          _getRoundContainer('3'),
          _getHorizontalLine(),
          _getRoundContainer('4'),

        ],
      ),
    );
  }

}