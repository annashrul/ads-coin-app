import 'dart:async';

import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/helper/ScreenScaleHelper.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:flutter/material.dart';

typedef void DeleteCode();
typedef Future<bool> PassCodeVerify(List<int> passcode);

class SecureCodeWidget extends StatefulWidget {
  final VoidCallback onSuccess;
  final int passLength;
  final Color borderColor;
  final Color foregroundColor;
  final PassCodeVerify passCodeVerify;
  bool isTrue;

  SecureCodeWidget({
    this.onSuccess,
    this.borderColor,
    this.foregroundColor = Colors.transparent,
    this.passLength,
    this.passCodeVerify,
    this.isTrue
  })  : assert(passLength <= 8),
        assert(borderColor != null),
        assert(foregroundColor != null),
        assert(passCodeVerify != null),
        assert(onSuccess != null);

  @override
  _SecureCodeWidgetState createState() => _SecureCodeWidgetState();
}

class _SecureCodeWidgetState extends State<SecureCodeWidget> {
  var _currentCodeLength = 0;
  var _inputCodes = <int>[];
  var _currentState = 0;
  Color circleColor = Colors.white;

  _onCodeClick(int code) {
    if (_currentCodeLength < widget.passLength) {
      setState(() {
        _currentCodeLength++;
        _inputCodes.add(code);
      });

      if (_currentCodeLength == widget.passLength) {
        widget.passCodeVerify(_inputCodes).then((onValue) {
          if (onValue) {
            setState(() {
              _currentState = 1;
            });
            widget.onSuccess();
          } else {
            _currentState = 2;
            new Timer(new Duration(milliseconds: 1000), () {
              if(this.mounted){
                setState(() {
                  _currentState = 0;
                  _currentCodeLength = 0;
                  _inputCodes.clear();
                });
              }
            });

          }
        });
      }
    }
  }


  _deleteCode() {
    setState(() {
      if (_currentCodeLength > 0) {
        _currentState = 0;
        _currentCodeLength--;
        _inputCodes.removeAt(_currentCodeLength);
      }
    });
  }

  _deleteAllCode() {
    setState(() {
      if (_currentCodeLength > 0) {
        _currentState = 0;
        _currentCodeLength = 0;
        _inputCodes.clear();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    if(widget.isTrue){
      print("gagal");
      _deleteAllCode();
      widget.isTrue=false;
    }
    final height = MediaQuery.of(context).size.height;
    ScreenScaleHelper scaler = ScreenScaleHelper()..init(context);
    return Container(
      alignment: Alignment.center,
      padding: scaler.getPadding(2,4),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CodePanel(
              codeLength: widget.passLength,
              currentLength: _currentCodeLength,
              borderColor: widget.borderColor,
              foregroundColor: widget.foregroundColor,
              deleteCode: _deleteCode,
              status: _currentState,
            ),
            Container(
              padding: EdgeInsets.only(left: 0, top: 10),
              child:
              NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowGlow();
                  return null;
                },
                child: GridView.count(
                  primary: false,
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  childAspectRatio: 1.6,
                  mainAxisSpacing: 10,
                  padding: EdgeInsets.all(5),
                  children: <Widget>[
                    buildContainerCircle(1),
                    buildContainerCircle(2),
                    buildContainerCircle(3),
                    buildContainerCircle(4),
                    buildContainerCircle(5),
                    buildContainerCircle(6),
                    buildContainerCircle(7),
                    buildContainerCircle(8),
                    buildContainerCircle(9),
                    buildRemoveIcon(Icons.close),
                    buildContainerCircle(0),
                    buildContainerIcon(Icons.arrow_back),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget buildContainerCircle(int number) {
    return Container(
      margin: EdgeInsets.all(10.0),
      height: 50,
      decoration: BoxDecoration(
        borderRadius:  BorderRadius.circular(10.0),
      ),
      child: InTouchWidget(
        radius: 10,
        callback: () {
          _onCodeClick(number);
        },
        child: Container(
          child: Center(
              child:Text(number.toString(),style: Theme.of(context).textTheme.headline1)
            // child:config.MyFont.title(context: context,color: config.Colors.mainColors,text:number.toString(),fontSize: 10)
          ),
        ),
      ),
    );
  }

  Widget buildRemoveIcon(IconData icon) {
    return Container(
      margin: EdgeInsets.all(10.0),
      height: 50,
      decoration: BoxDecoration(
        borderRadius:  BorderRadius.circular(10.0),
      ),
      child: InTouchWidget(
          radius: 10,
          callback: (){
            if (0 < _currentCodeLength) {
              _deleteAllCode();
            }
          },
          child: Container(

            child: Center(
              child:Icon(Icons.highlight_remove_rounded),
              // child: Text('Ulangi',style:TextStyle(fontSize: ScreenUtilQ.getInstance().setSp(40),color:widget.numColor,fontWeight:FontWeight.bold,fontFamily:ThaibahFont().fontQ)),
            ),
          ),
      ),
    );
  }

  Widget buildContainerIcon(IconData icon) {
    return Container(
      margin: EdgeInsets.all(10.0),
      height: 50,
      decoration: BoxDecoration(
        borderRadius:  BorderRadius.circular(10.0),
      ),
      child: InTouchWidget(
        radius: 10,
        callback: (){
          if (0 < _currentCodeLength) {
            setState(() {
              circleColor =  Colors.grey[200];
            });
            Future.delayed(Duration(milliseconds: 200)).then((func) {
              setState(() {
                circleColor =  Colors.grey[200];
              });
            });
          }
          _deleteCode();
        },
        child: Container(

          child: Center(
            child:Icon(Icons.backspace_outlined),
          ),
        ),
      ),
    );

  }

}


class CodePanel extends StatelessWidget {
  final codeLength;
  final currentLength;
  final borderColor;
  final bool fingerVerify;
  final foregroundColor;
  final H = 30.0;
  final W = 30.0;
  final DeleteCode deleteCode;
  final int status;
  CodePanel(
      {this.codeLength,
        this.currentLength,
        this.borderColor,
        this.foregroundColor,
        this.deleteCode,
        this.fingerVerify,
        this.status})
      : assert(codeLength > 0),
        assert(currentLength >= 0),
        assert(currentLength <= codeLength),
        assert(deleteCode != null),
        assert(status == 0 || status == 1 || status == 2);

  @override
  Widget build(BuildContext context) {
    var circles = <Widget>[];
    var color = borderColor;
    int circlePice = 1;

    if (status == 1) {
      color = Colors.green.shade500;
    }
    if (status == 2) {
      color = Colors.green.shade500;
    }
    for (int i = 1; i <= codeLength; i++) {
      if (i > currentLength) {
        circles.add(SizedBox(
            width: W,
            height: H,
            child: Container(
              decoration: new BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1)),
                  color: foregroundColor
              ),
            )
        ));
      } else {
        circles.add(
          new SizedBox(
            width: W,
            height: 20,
            child: new Container(
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                border: new Border.all(color:  Theme.of(context).textTheme.subtitle1.color, width: 1.0),
                color: color,
              ),
            )
          )
        );
      }
    }

    return new SizedBox.fromSize(
      size: new Size(MediaQuery.of(context).size.width, 30.0),
      child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox.fromSize(
                size: new Size(40.0 * codeLength, H),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: circles,
                )),
          ]),
    );
  }
}
