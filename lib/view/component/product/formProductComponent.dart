import 'dart:async';
import 'dart:io';

import 'package:adscoin/config/color_config.dart';
import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/database/databaseInit.dart';
import 'package:adscoin/database/table.dart';
import 'package:adscoin/helper/formatCurrencyHelper.dart';
import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/authProvider.dart';
import 'package:adscoin/service/provider/categoryProvider.dart';
import 'package:adscoin/service/provider/productProvider.dart';
import 'package:adscoin/view/widget/general/buttonWidget.dart';
import 'package:adscoin/view/widget/general/fieldWidget.dart';
import 'package:adscoin/view/widget/general/touchWidget.dart';
import 'package:adscoin/view/widget/general/uploadWidget.dart';
import 'package:adscoin/view/widget/product/modalCategoryWidget.dart';
import 'package:adscoin/view/widget/product/modalStatusFormProductWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:provider/provider.dart';

class FormProductContributorComponent extends StatefulWidget {
  @override
  _FormProductContributorComponentState createState() => _FormProductContributorComponentState();
}

class _FormProductContributorComponentState extends State<FormProductContributorComponent> with WidgetsBindingObserver  {
  TextEditingController nameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController categoryController = new TextEditingController();
  TextEditingController previewController = new TextEditingController();
  TextEditingController statusController = new TextEditingController();
  File _image;
  String base64Image="-";
  MoneyMaskedTextControllerQ priceController = new MoneyMaskedTextControllerQ();
  String result = "-";
  final HtmlEditorController contentController = HtmlEditorController();

  void setTime(){
    contentController.resetHeight();
    final product = Provider.of<ProductProvider>(context, listen: false);
    if(product.timeUpFlag){
      product.setTimer(1);
      product.timeUpFlag=false;
      product.timerUpdate();
    }
  }
  saveData(){
    final product = Provider.of<ProductProvider>(context, listen: false);
    FunctionalWidget.nofitDialog(
      context: context,
      msg: "simpan data sebagai draft ?",
      callback1: (){
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
      callback2: ()async{
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        await product.storeAutoSaveProduct(context: context,status: "0");
      },
    );
  }
  checkForm(){
    if(nameController.text!=""&&previewController.text!=""){
      if(result!=""&&result!="-"&&result!="<p><br></p>"){
        return true;
      }
    }
    return false;
  }
  DatabaseInit db = new DatabaseInit();

  Future autoSaveProduct(img)async{
    final data ={
      TableString.contentProduct:"$result",
      TableString.titleProduct:"${nameController.text}",
      TableString.imageProduct:"$img",
      TableString.previewProduct:"${previewController.text}",
      TableString.statusProduct:"0",
    };
    final get = await db.getData(ProductTable.TABLE_NAME);
    if(get.length>0){
      await db.update(ProductTable.TABLE_NAME,get[0]["id"],data);
    }
    else{
      await db.insert(ProductTable.TABLE_NAME, data);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final product = Provider.of<ProductProvider>(context, listen: false);
    final category = Provider.of<CategoryProvider>(context, listen: false);
    category.getCategoryProduct(context: context);
    priceController = MoneyMaskedTextControllerQ(decimalSeparator: '', thousandSeparator: ',');
    WidgetsBinding.instance.addObserver(this);
    product.timerUpdate();
    product.timeUpFlag = false;
    product.timeCounter=1;
    db.delete(ProductTable.TABLE_NAME).then((value) => null);
    if(!product.isAdd){
      final dataEdit = product.dataEditProductContributor;
      nameController.text=dataEdit["title"];
      previewController.text=dataEdit["preview"];
      Future.delayed(Duration(seconds: 2)).then((value){
        contentController.setText(dataEdit["content"]);
      });
    }
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    int resumed=0;
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        // store();
        break;
      case AppLifecycleState.resumed:
        // store();
        break;
      case AppLifecycleState.paused:
        // store();
        break;
      case AppLifecycleState.detached:
        // store();

        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);
    final product = Provider.of<ProductProvider>(context);
    final category = Provider.of<CategoryProvider>(context);
    final check = checkForm();
    int indexCategory=category.indexSelectedCategoryForm;
    int statusProduct=product.statusProduct;
    // Future.delayed(Duration(seconds: 2)).then((value)=>contentController.resetHeight());
    if(category.categoryProductModel!=null){
        if(!category.isLoading){
          categoryController.text = category.categoryProductModel.result[indexCategory].title;
        }
      }

    if(product.timeUpFlag){
      print("nameController.text = ${nameController.text}");
      print("previewController.text = ${previewController.text}");
      print("result.text = $result");
      if(nameController.text!=""||previewController.text!=""||result!=""&&result!="-"&&result!="<p><br></p>") autoSaveProduct(base64Image);
    }
    if(statusProduct==0)statusController.text="Draft";
    else statusController.text="Selesai";

    return Listener(
      onPointerDown: (_)=>setTime(), // best place to reset timer imo
      onPointerMove: (_)=>setTime(),
      onPointerUp: (_)=>setTime(),
      child: WillPopScope(
        onWillPop: () async{
          return nameController.text!=""||previewController.text!=""||result!=""&&result!="-"&&result!="<p><br></p>"?saveData():true ?? false;
        },
        child: Scaffold(
          appBar: FunctionalWidget.appBarHelper(context: context,title: product.isAdd?"Tambah produk ${product.timeCounter}":"Edit produk ${product.timeCounter}",callback: (){
            if(nameController.text!=""||previewController.text!=""||result!=""&&result!="-"&&result!="<p><br></p>"){
              saveData();
            }else{
              Navigator.of(context).pop();
            }

          }),
          body: ListView(
            primary: true,
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
                        setTime();
                        FunctionalWidget.modal(
                            context: context,
                            child: UploadWidget(
                                callback: (res)async{
                                  setTime();
                                  autoSaveProduct(res["path"]);
                                  setState((){
                                    _image = res["preview"];
                                    base64Image = res["path"];
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
                  if(base64Image!="-")Container(
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
                  if(!product.isAdd)Container(
                    margin: scale.getMarginLTRB(1,0,0,0),
                    width: scale.getWidth(30),
                    height: scale.getHeight(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(product.dataEditProductContributor["image"])
                        )
                    ),
                  ),
                ],
              ),
              SizedBox(height: scale.getHeight(1)),
              Text("Nama",style: Theme.of(context).textTheme.headline2),
              FieldWidget(
                controller: nameController,
                maxLines: 1,
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                onChange: (e){
                  setTime();
                },
              ),
              SizedBox(height: scale.getHeight(1)),
              Text("Kategori",style: Theme.of(context).textTheme.headline2),
              FieldWidget(
                controller: categoryController,
                maxLines: 1,
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                readOnly: true,
                isIcon: true,
                onTap: (){
                  FunctionalWidget.modal(
                      context: context,
                      child: ModalCategoryWidget()
                  );
                },

              ),
              SizedBox(height: scale.getHeight(1)),
              Text("Status",style: Theme.of(context).textTheme.headline2),
              FieldWidget(
                controller: statusController,
                maxLines: 1,
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                readOnly: true,
                isIcon: true,
                onTap: (){
                  FunctionalWidget.modal(
                      context: context,
                      child: ModalStatusFormProductWidget()
                  );
                },
              ),
              SizedBox(height: scale.getHeight(1)),
              Text("Ringkasan",style: Theme.of(context).textTheme.headline2),
              FieldWidget(
                controller: previewController,
                maxLines: 5,
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                onChange: (e){
                  setTime();
                },
              ),
              SizedBox(height: scale.getHeight(1)),
              Text("Konten",style: Theme.of(context).textTheme.headline2),
              Container(
                height: scale.getHeight(51),
                child: HtmlEditor(
                    hint: "tulis konten disini ..",
                    controller: contentController,
                    callbacks: Callbacks(
                      onChange: (String changed)async {
                        checkForm();
                        setState(() {
                          result = changed;
                        });
                      },
                      onEnter: () {
                        setTime();
                      },
                      onFocus: () {

                        setTime();
                      },
                      onBlur: () {
                        setTime();
                      },
                      onBlurCodeview: () {
                        setTime();
                      },
                      onKeyDown: (keyCode) {
                        setTime();
                      },
                      onKeyUp: (keyCode) {
                        setTime();
                      },
                      onPaste: () {
                        setTime();
                      },
                    ),
                    toolbar: [
                      Style(),
                      Font(buttons: [FontButtons.bold, FontButtons.underline, FontButtons.italic])
                    ]

                ),
              )
            ],
          ),
          bottomNavigationBar: Container(
            padding: scale.getPadding(1,2.5),
            child:BackroundButtonWidget(
              backgroundColor: check?ColorConfig.redColor:ColorConfig.graySecondaryColor,
              color: check?ColorConfig.graySecondaryColor:ColorConfig.grayPrimaryColor,
              title: "Simpan",
              callback: (){
                product.timeUpFlag = true;
                product.timer.cancel();
                product.storeAutoSaveProduct(context: context,status:statusProduct.toString(),loading: true);
              },
            ),
          ),
        ),
      ),
    );
  }

}

