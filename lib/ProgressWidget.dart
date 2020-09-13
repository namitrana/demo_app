/// Used to display the top area with rounded Container and horizontal line in each of the screen

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressWidget extends StatelessWidget {
  int greenText = 0;
  AnimationController animationController;
  bool hide = true;

  ProgressWidget(int greenText, bool hide) {
    this.greenText = greenText;
    this.hide = hide;
  }

  void setAnimationController(AnimationController animationController) {
    this.animationController = animationController;
  }

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top;
    var h = (MediaQuery.of(context).size.height - statusBarHeight) * .2;
    var w = MediaQuery.of(context).size.width;

    Widget _getIcon() {
      return Offstage(
          offstage: hide,
          child: Container(
                  alignment: Alignment.centerLeft,
                  width: w,
                  child: AnimatedBuilder(
                    animation: animationController,
                    builder: (context, child){
                      return Container(
                        decoration: ShapeDecoration(
                            color: Colors.white.withOpacity(0.5),
                            shape: CircleBorder(),
                      ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0 * animationController.value),
                          child: Container(
                              decoration: ShapeDecoration(
                                color: Colors.white.withOpacity(0.8),
                                shape: CircleBorder(),
                              ),
                              child : RawMaterialButton(

                                onPressed: () {},
                                elevation: 2.0,
                                fillColor: Colors.white,
                                highlightColor: Colors.white,
                                child: new IconTheme(
                                  data: new IconThemeData(color: Colors.grey),
                                  child: new Icon(Icons.calendar_today),
                                ),

                                //padding: EdgeInsets.all(5.0),
                                shape: CircleBorder(),
                              )
                          ),
                        ),
                      );
                    }
                  )

                )

      );
      /*Offstage(
            offstage: hide,
            child: AnimatedBuilder(
                animation: animationController,
                builder: (context, child) {
                  return Container(

                    alignment: Alignment.centerLeft,
                      decoration: ShapeDecoration(
                        color: Colors.white.withOpacity(0.5),
                        shape: CircleBorder(),
                      ),
                    width: w,
                    child:  Padding(
                        padding: EdgeInsets.all(5.0 * animationController.value),
                        child: RawMaterialButton(
                          onPressed: () {},
                          elevation: 2.0,
                          fillColor: Colors.white,
                          highlightColor: Colors.white,
                          child: new IconTheme(
                            data: new IconThemeData(
                                color: Colors.grey),
                            child: new Icon(Icons.calendar_today),
                          ),

                          //padding: EdgeInsets.all(5.0),
                          shape: CircleBorder(),
                        ),
                      ),


                  );
                }
            ),*/
    }

    Widget _getRoundContainer(int text) {
      return Container(
          decoration: BoxDecoration(
              color: text > greenText ? Colors.white : Colors.green,
              shape: BoxShape.circle),
          width: (h - (h * .5)) / 2,
          height: (h - (h * .5)) / 2,
          //color: Colors.red,
          child: Center(
            child: new Text(text.toString()),
          ));
    }

    Widget _getHorizontalLine() {
      var circlesWidth = ((h - (h * .5)) / 2) * 4;
      var remainWidth = w - circlesWidth;
      //var lineWidth = remainWidth / 3;
      var lineWidth = (remainWidth / 3) - 30;
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                //padding: EdgeInsets.fromLTRB(15, 0, 15,0),
                alignment: Alignment.topLeft,
                width: w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _getRoundContainer(1),
                    _getHorizontalLine(),
                    _getRoundContainer(2),
                    _getHorizontalLine(),
                    _getRoundContainer(3),
                    _getHorizontalLine(),
                    _getRoundContainer(4),
                  ],
                )),
            _getIcon(),
          ],
        ));
  }

  @override
  // TODO: implement context
  BuildContext get context => null;

  @override
  void deactivate() {
    // TODO: implement deactivate
  }

  @override
  void didUpdateWidget(StatefulWidget oldWidget) {
    // TODO: implement didUpdateWidget
  }

  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  // TODO: implement mounted
  bool get mounted => null;

  @override
  void reassemble() {
    // TODO: implement reassemble
  }

  @override
  void setState(fn) {
    // TODO: implement setState
  }

  @override
  // TODO: implement widget
  StatefulWidget get widget => null;
}
