import 'package:adscoin/helper/functionalWidgetHelper.dart';
import 'package:adscoin/service/provider/channelPaymentProvider.dart';
import 'package:adscoin/view/widget/general/cardTitleSubtileAction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:provider/provider.dart';

import '../../loadingComponent.dart';

// ignore: must_be_immutable
class MethodChannelComponent extends StatefulWidget {
  Function(String code) callback;
  MethodChannelComponent({this.callback});
  @override
  _MethodChannelComponentState createState() => _MethodChannelComponentState();
}

class _MethodChannelComponentState extends State<MethodChannelComponent> {
  @override
  void initState() {
    super.initState();
    final channel = Provider.of<ChannelPaymentProvider>(context, listen: false);
    channel.get(context: context);
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scale = ScreenScaler()..init(context);
    final channel = Provider.of<ChannelPaymentProvider>(context);
    return Scaffold(
        appBar: FunctionalWidget.appBarHelper(
            context: context, title: "Metode pembayaran"),
        body: ListView.separated(
          padding: scale.getPadding(1, 2),
          addRepaintBoundaries: true,
          primary: false,
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount:
              channel.isLoading ? 2 : channel.channelPaymentModel.result.length,
          itemBuilder: (context, index) {
            return channel.isLoading
                ? Container(
                    child: ListTile(
                      leading: BaseLoading(height: 3, width: 8, radius: 100),
                      title: Container(
                        child: BaseLoading(
                            height: 1,
                            width: MediaQuery.of(context).size.width / 3),
                      ),
                      subtitle: BaseLoading(height: 1, width: 15),
                    ),
                  )
                : CardTitleSubtitleAction(
                    image: channel.channelPaymentModel.result[index].logo,
                    title: channel.channelPaymentModel.result[index].name,
                    subtitle: channel.channelPaymentModel.result[index].code,
                    callback: () {
                      widget.callback(
                          channel.channelPaymentModel.result[index].code);
                    },
                  );
          },
        ));
  }
}
