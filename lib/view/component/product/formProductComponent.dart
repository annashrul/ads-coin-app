import 'dart:io';

import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/helper/formatCurrencyHelper.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/authProvider.dart';
import 'package:adscoin/service/provider/productProvider.dart';
import 'package:adscoin/view/widget/general/buttonWidget.dart';
import 'package:adscoin/view/widget/general/fieldWidget.dart';
import 'package:adscoin/view/widget/general/titleSectionWidget.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:adscoin/view/widget/general/uploadWidget.dart';
import 'package:adscoin/view/widget/product/formDescriptionProductWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:provider/provider.dart';

class FormProductContributorComponent extends StatefulWidget {
  @override
  _FormProductContributorComponentState createState() => _FormProductContributorComponentState();
}

class _FormProductContributorComponentState extends State<FormProductContributorComponent> {

  TextEditingController nameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController categoryController = new TextEditingController();
  var priceController = MoneyMaskedTextControllerQ(decimalSeparator: '.', thousandSeparator: ',');
  File _image;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProductProvider>(context, listen: false);

  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);
    bool isValid=false;
    final product = Provider.of<ProductProvider>(context);
    if(_image!=null&&nameController.text!=""&&descriptionController.text!=""){
      isValid=true;
    }
    return Scaffold(
      appBar: FunctionalWidget.appBarHelper(
        context: context,title: product.isAdd?"Tambah produk":"Edit produk"
      ),
      body: ListView(
        padding: scale.getPadding(1,2.5),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: InTouchWidget(
                  radius: 10,
                  callback: (){
                    FunctionalWidget.modal(
                        context: context,
                        child: UploadWidget(
                            callback: (res){
                              print(res);
                              setState(() {
                                _image = res["preview"];
                              });
                              Navigator.of(context).pop();
                            }
                        )
                    );
                  },
                  child: Container(
                    padding: scale.getPadding(1,2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: ColorConfig.bluePrimaryColor)
                    ),
                    child: Column(
                      children: [
                        Image.asset(GeneralString.imgLocalPng+"plus.png",height: scale.getHeight(2),),
                        SizedBox(height: scale.getHeight(0.5)),
                        Text("Gambar produk",style: Theme.of(context).textTheme.headline2.copyWith(color: ColorConfig.bluePrimaryColor),)
                      ],
                    ),
                  ),
                ),
              ),
              if(_image!=null)Container(
                margin: scale.getMarginLTRB(1,0,0,0),
                width: scale.getWidth(30),
                height: scale.getHeight(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                        image: FileImage(_image)
                    )
                ),
              ),
            ],
          ),
          SizedBox(height: scale.getHeight(1)),
          Text("Nama produk",style: Theme.of(context).textTheme.headline2),
          FieldWidget(
            controller: nameController,
            maxLines: 1,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.done,
          ),

          SizedBox(height: scale.getHeight(1)),
          Text("Kategori produk",style: Theme.of(context).textTheme.headline2),
          FieldWidget(
            controller: categoryController,
            maxLines: 1,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.done,
            readOnly: true,
            isIcon: true,
            onTap: (){
            },
          ),
          SizedBox(height: scale.getHeight(1)),
          Text("Harga produk",style: Theme.of(context).textTheme.headline2),
          FieldWidget(
            controller: priceController,
            maxLines: 1,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.done,
          ),
          SizedBox(height: scale.getHeight(1)),
          Text("Deskripsi produk",style: Theme.of(context).textTheme.headline2),

          InTouchWidget(
              callback: (){
                FunctionalWidget.modal(
                    context: context,
                    child: FormDescriptionProductWidget(
                      callback: (res){
                        setState(() {
                          descriptionController.text=res;
                        });
                        // Navigator.of(context).pop();
                      },
                      desc:descriptionController.text,
                    )
                );
              },
              child: Container(
                height: descriptionController.text==""?scale.getHeight(10):null,
                padding: scale.getPadding(1, 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorConfig.graySecondaryColor
                ),
                child: Html(
                  data: descriptionController.text,
                  onLinkTap: (String url){
                    print(url);
                  },
                  style: {
                    "body": Style(
                        fontSize: FontSize(16.0),
                        fontWeight: FontWeight.w400,
                        margin: EdgeInsets.zero,
                        markerContent: "asasdasdasd"
                    ),
                  },
                ),
              )
          )


        ],
      ),
      bottomNavigationBar: Container(
        padding: scale.getPadding(1,2.5),
        child:BackroundButtonWidget(
          backgroundColor: isValid?ColorConfig.redColor:ColorConfig.graySecondaryColor,
          color: isValid?ColorConfig.graySecondaryColor:ColorConfig.grayPrimaryColor,
          title: "Simpan",
          callback: (){},
        ),
      ),
    );
  }
}

