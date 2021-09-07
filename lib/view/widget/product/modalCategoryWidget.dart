import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/service/provider/categoryProvider.dart';
import 'package:adscoin/service/provider/productProvider.dart';
import 'package:adscoin/view/widget/general/cardAction.dart';
import 'package:adscoin/view/widget/general/cardTitleAction.dart';
import 'package:adscoin/view/widget/general/titleSectionWidget.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';

class ModalCategoryWidget extends StatefulWidget {

  @override
  _ModalCategoryWidgetState createState() => _ModalCategoryWidgetState();
}

class _ModalCategoryWidgetState extends State<ModalCategoryWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);
    final category = Provider.of<CategoryProvider>(context);
    final product = Provider.of<ProductProvider>(context);
    bool isLoading = category.isLoading;
    return Container(
      padding: scale.getPadding(1,2),
      height: scale.getHeight(70),
      child: Column(
        children: [
          TitleSectionWidget(title: "Pilih kategori", callback: (){},isAction: false,),
          SizedBox(height: scale.getHeight(1)),
          isLoading?Text("loading"):Expanded(
            child: ListView.separated(
                itemBuilder: (context,index){
                  return InTouchWidget(
                      callback: ()async{
                        category.setIndexSelectedCategoryForm(index);
                        await product.autoSaveProduct({
                          TableString.idProduct:"${category.categoryProductModel.result[index].id}",
                        });
                        Navigator.of(context).pop();
                      },
                      child: CardTitleAction(image: category.categoryProductModel.result[index].icon,title: category.categoryProductModel.result[index].title)
                  );
                },
                separatorBuilder: (context,index){return Divider();},
                itemCount: category.categoryProductModel.result.length
            ),
          )
        ],
      ),
    );
  }
}
