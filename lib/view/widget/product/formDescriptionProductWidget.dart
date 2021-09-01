import 'package:adscoin/view/widget/general/titleSectionWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:flutter_summernote/flutter_summernote.dart';

// ignore: must_be_immutable
class FormDescriptionProductWidget extends StatefulWidget {
  Function(String desc) callback;
  String desc;
  FormDescriptionProductWidget({this.callback,this.desc});
  @override
  _FormDescriptionProductWidgetState createState() => _FormDescriptionProductWidgetState();
}

class _FormDescriptionProductWidgetState extends State<FormDescriptionProductWidget> {
  GlobalKey<FlutterSummernoteState> _keyEditor = GlobalKey();
  String result = "";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      result = widget.desc;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);
    return Container(
      padding: scale.getPadding(1,2),
      height:scale.getHeight(70) ,
      child: ListView(
        children: [
          TitleSectionWidget(
            title: "Deskripsi produk",
            callback: ()async{
              final value = await _keyEditor.currentState.getText();
              widget.callback(value);
              Navigator.of(context).pop();
            },
            isAction: true,
            titleAction: "Simpan",
          ),
          SizedBox(height: scale.getHeight(1),),
          FlutterSummernote(
            value:result,
            height:scale.getHeight(50) ,
            hint: "Your text here...",
            key: _keyEditor,
            hasAttachment: true,
            returnContent: (val)async{
              widget.callback(val);
              _keyEditor.currentState.setState(() {
                result=val;
              });
            },
            customToolbar: """
                [
                  ['style', ['bold', 'italic', 'underline','strikethrough', 'undo','redo','color','height','fontname']],
                  ['insert', ['link','table',  'hr','paragraph','ul','ol', 'codeview','fontsize']],
                ],
              """,
          ),


        ],
      ),
    );
  }
}
