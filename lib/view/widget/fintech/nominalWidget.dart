import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/helper/formatCurrencyHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// ignore: must_be_immutable
class NominalWidget extends StatefulWidget {
  Function(String amount,int index) callback;
  int idx;
  NominalWidget({this.callback,this.idx});

  @override
  _NominalWidgetState createState() => _NominalWidgetState();
}

class _NominalWidgetState extends State<NominalWidget> {
  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);


    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.all(0.0),
      shrinkWrap: true,
      primary: false,
      crossAxisCount: 3,
      itemCount:  MoneyFormat.dataNominal.length,
      itemBuilder: (BuildContext context, int index) {
        return FlatButton(
          color: widget.idx==index?ColorConfig.yellowColor:Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          padding: scale.getPadding(1,1),
          onPressed: (){
            setState(() {
              widget.idx=index;
            });
            widget.callback(MoneyFormat.dataNominal[index],index);
          },
          child: Text("Rp ${MoneyFormat.toCurrency(double.parse(MoneyFormat.dataNominal[index]))}",style: Theme.of(context).textTheme.subtitle1.copyWith(color: widget.idx==index?Colors.white:ColorConfig.grayPrimaryColor),),
        );
      },
      staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
      mainAxisSpacing: 5.0,
      crossAxisSpacing: 10.0,
    );

  }
}
