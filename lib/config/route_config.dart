import 'package:adscoin/config/string_config.dart';
import 'package:adscoin/view/component/auth/pinComponent.dart';
import 'package:adscoin/view/component/auth/signInComponent.dart';
import 'package:adscoin/view/component/auth/signUpComponent.dart';
import 'package:adscoin/view/component/bankMember/bankMemberComponent.dart';
import 'package:adscoin/view/component/bankMember/formBankMemberComponent.dart';
import 'package:adscoin/view/component/checkout/checkoutComponent.dart';
import 'package:adscoin/view/component/checkout/detailCheckoutComponent.dart';
import 'package:adscoin/view/component/detailProduct/detailProductComponent.dart';
import 'package:adscoin/view/component/fintech/historyMutation/historyMutationComponent.dart';
import 'package:adscoin/view/component/fintech/indexFintechComponent.dart';
import 'package:adscoin/view/component/fintech/topUp/detailTopUpComponent.dart';
import 'package:adscoin/view/component/fintech/topUp/topUpComponent.dart';
import 'package:adscoin/view/component/fintech/withdraw/confirmWithdrawComponent.dart';
import 'package:adscoin/view/component/fintech/withdraw/withdrawComponent.dart';
import 'package:adscoin/view/component/history/detailHistoryPurchaseComponent.dart';
import 'package:adscoin/view/component/history/detailHistorySaleComponent.dart';
import 'package:adscoin/view/component/history/historyPurchaseComponent.dart';
import 'package:adscoin/view/component/history/historySaleComponent.dart';
import 'package:adscoin/view/component/mainComponent.dart';
import 'package:adscoin/view/component/onBoardingComponent.dart';
import 'package:adscoin/view/component/product/favoriteComponent.dart';
import 'package:adscoin/view/component/product/formProductComponent.dart';
import 'package:adscoin/view/component/product/productContributorComponent.dart';
import 'package:adscoin/view/component/profile/formProfileComponent.dart';
import 'package:adscoin/view/component/profile/profilePerMember.dart';
import 'package:adscoin/view/component/profile/referralComponent.dart';
import 'package:adscoin/view/component/promo/detailPromoComponent.dart';
import 'package:adscoin/view/component/searchComponent.dart';
import 'package:adscoin/view/component/splashComponent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    print(args);
    switch (settings.name) {
      case RouteString.splash:
        return CupertinoPageRoute(builder: (_) => SplashComponent());
      case RouteString.onBoarding:
        return CupertinoPageRoute(builder: (_) => OnBoardingComponent());
      case '${RouteString.signIn}':
        return CupertinoPageRoute(builder: (_) => SignInComponent());
      case '${RouteString.signUp}':
        return CupertinoPageRoute(builder: (_) => SignUpComponent());

      case '${RouteString.pin}':
        return CupertinoPageRoute(builder: (_) => PinComponent(callback: args));
      case '${RouteString.main}':
        return CupertinoPageRoute(builder: (_) => MainComponent(index: args));
      case '${RouteString.detailProduct}':
        return CupertinoPageRoute(
            builder: (_) => DetailProductComponent(data: args));
      case '${RouteString.checkout}':
        return CupertinoPageRoute(builder: (_) => CheckoutComponent());
      case '${RouteString.detailCheckout}':
        return CupertinoPageRoute(builder: (_) => DetailCheckoutComponent());
      case '${RouteString.formProfile}':
        return CupertinoPageRoute(builder: (_) => FormProfileComponent());
      case '${RouteString.historyPurchase}':
        return CupertinoPageRoute(builder: (_) => HistoryPurchaseComponent());
      case '${RouteString.detailHistoryPurchase}':
        return CupertinoPageRoute(
            builder: (_) => DetailHistoryPurchaseComponent(id: args));
      case '${RouteString.historySale}':
        return CupertinoPageRoute(builder: (_) => HistorySaleComponent());
      case '${RouteString.detailHistorSale}':
        return CupertinoPageRoute(
            builder: (_) => DetailHistorySaleComponent(id: args));
      case '${RouteString.productContributor}':
        return CupertinoPageRoute(
            builder: (_) => ProductContributorComponent());
      case '${RouteString.formProductContributor}':
        return CupertinoPageRoute(
            builder: (_) => FormProductContributorComponent());
      case '${RouteString.indexFintechComponent}':
        return CupertinoPageRoute(builder: (_) => IndexFintechComponent());
      case '${RouteString.historyMutation}':
        return CupertinoPageRoute(builder: (_) => HistoryMutationComponent());
      case '${RouteString.topUp}':
        return CupertinoPageRoute(builder: (_) => TopUpComponent());
      case '${RouteString.detailTopUp}':
        return CupertinoPageRoute(builder: (_) => DetailTopUpComponent());
      case '${RouteString.withdraw}':
        return CupertinoPageRoute(builder: (_) => WithdrawComponent());
      case '${RouteString.confirmWithdraw}':
        return CupertinoPageRoute(builder: (_) => ConfirmWithdrawComponent());
      case '${RouteString.bankMember}':
        return CupertinoPageRoute(builder: (_) => BankMemberComponent());
      case '${RouteString.formBankMember}':
        return CupertinoPageRoute(builder: (_) => FormBankMemberComponent());
      case '${RouteString.favorite}':
        return CupertinoPageRoute(builder: (_) => FavoriteComponent());
      case '${RouteString.referral}':
        return CupertinoPageRoute(builder: (_) => ReferralComponent());
      case '${RouteString.profilePerMember}':
        return CupertinoPageRoute(builder: (_) => ProfilePerMember(id: args));
      case '${RouteString.detailPromo}':
        return CupertinoPageRoute(builder: (_) => DetailPromoComponent());
      case '${RouteString.search}':
        return CupertinoPageRoute(builder: (_) => SearchComponent(any: args));

      default:
        return _errorRoute(callback: args);
    }
  }

  static Route<dynamic> _errorRoute({Function callback}) {
    return MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Text("Error")],
          ),
        ),
      );
    });
  }
}
