
class RouteString{
  static const splash = "/";
  static const onBoarding = "/onBoarding";
  static const signIn = "/signIn";
  static const signUp = "/signUp";
  static const otp = "/otp";
  static const pin = "/pin";
  static const home = "/home";
  static const main = "/main";
  static const detailProduct = "/detailProduct";
  static const checkout = "/checkout";
  static const detailCheckout = "/detailCheckout";

}

class TabIndexString{
  static const int tabHome = 0;
  static const int tabProduct = 1;
  static const int tabProfile = 2;
}


class SessionString{
  static const String sessIsLogin = "isLogin";
  static const String sessId = "id";
  static const String sessToken = "token";
  static const String sessHavePin = "havePin";
  static const String sessPhoto = "foto";
  static const String sessName = "fullname";
  static const String sessMobileNo = "mobileNo";
  static const String sessReferral = "referral";
  static const String sessStatus = "status";
}

class GeneralString{
  static const String imgLocal = "assets/img/";
  static const String dummyImgUser = "https://freepikpsd.com/media/2019/10/user-png-image-9.png";
  static const String dummyImgProduct= "https://png.pngitem.com/pimgs/s/43-434027_product-beauty-skin-care-personal-care-liquid-tree.png";
}

class SiteString{
  static const siteName = "Ads Coin";
}

class ApiString{
  static const String url = "http://ptnetindo.com:6703/";
  static const int timeOut = 60;
  static const String xProjectId = "8123268367ea27e094e71e290";
  static const String xRequestedFrom = "apps";
  static Map<String, String> head={
    'X-Project-ID': xProjectId,
    'X-Requested-From': xRequestedFrom,
  };
}

