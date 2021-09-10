

class RoleAccessString{
  static const String contributor="Kontributor";
  static const String member="Member";
}



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
  static const formProfile = "/formProfile";
  static const historyPurchase = "/historyPurchase";
  static const detailHistoryPurchase = "/detailHistoryPurchase";
  static const historySale = "/historySale";
  static const detailHistorSale = "/detailHistorSale";
  static const productContributor = "/productContributor";
  static const formProductContributor = "/formProductContributor";
  static const indexFintechComponent = "/indexFintechComponent";
  static const historyMutation = "/historyMutation";


  static const topUp = "/topUp";
  static const detailTopUp = "/detailTopUp";
  static const withdraw = "/withdraw";
  static const confirmWithdraw = "/confirmWithdraw";
  static const bankMember = "/bankMember";
  static const formBankMember = "/formBankMember";
  static const favorite = "/favorite";
  static const success = "/success";
}


class TableString{
  static const String idProduct="idProduct";
  static const String titleProduct="titleProduct";
  static const String sellerProduct="sellerProduct";
  static const String sellerFotoProduct="sellerFotoProduct";
  static const String sellerBioProduct="sellerBioProduct";
  static const String contentProduct="contentProduct";
  static const String previewProduct="previewProduct";
  static const String idSellerProduct="idSellerProduct";
  static const String statusProduct="statusProduct";
  static const String priceProduct="priceProduct";
  static const String ratingProduct="ratingProduct";
  static const String terjualProduct="terjualProduct";
  static const String statusBeliProduct="statusBeliProduct";
  static const String imageProduct="imageProduct";


}


class TabIndexString{
  static const int tabHome = 0;
  static const int tabProduct = 1;
  static const int tabProfile = 2;
}

class StatusRoleString{
  static const String baruInstall = "0";
  static const String keluarAplikasi = "1";
  static const String masukAplikasi = "2";
}

class SessionString{
  static const String sessIsLogin = "isLogin";
  static const String sessId = "idUser";
  static const String sessToken = "token";
  static const String sessHavePin = "havePin";
  static const String sessPhoto = "foto";
  static const String sessName = "fullname";
  static const String sessMobileNo = "mobileNo";
  static const String sessReferral = "referral";
  static const String sessStatus = "status";
  static const String sessType = "type";
}

class GeneralString{
  static const String imgLocal = "assets/img/";
  static const String imgLocalPng = "assets/img/png/";
  static const String imgLocalSvg = "assets/img/svg/";
  static const String dummyImgUser = "https://freepikpsd.com/media/2019/10/user-png-image-9.png";
  static const String dummyImgProduct= "https://png.pngitem.com/pimgs/s/43-434027_product-beauty-skin-care-personal-care-liquid-tree.png";
}

class SiteString{
  static const siteName = "Ads Coin";
}

class ApiString{
  static const String onesignalAppId = "ad1a7344-2b2f-40d0-87c8-0f8ec150cb8f";
  static const String url = "http://ptnetindo.com:6703/";
  static const int timeOut = 60;
  static const String xProjectId = "8123268367ea27e094e71e290";
  static const String xRequestedFrom = "apps";
  static Map<String, String> head={
    'X-Project-ID': xProjectId,
    'X-Requested-From': xRequestedFrom,
  };
}

