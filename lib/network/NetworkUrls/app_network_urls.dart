class AppNetworkUrls {
  static const _baseUrl = 'http://192.168.1.55:8000/api';
  static get baseUrl => _baseUrl;
  static const signupInfluenceEndPint = '$_baseUrl/influencer/register';
  static const signupBusinessEndPint = '$_baseUrl/owner/register';
  static const influencerProfile = '$_baseUrl/influencer/profile';
  static const businessProfile = '$_baseUrl/owner/profile';
  static const verifyRegisterOtp = '$_baseUrl/verifyRegisterOtp';
  static const resendOtp = '$_baseUrl/resendOtp';
  static const loginEndPint = '$_baseUrl/login';
  static const ownerPublishDeal = '$_baseUrl/owner/publishDeals';
  static const createDeal = '$_baseUrl/owner/deal';
  static const ownerExclusivePublishDeal = '$_baseUrl/owner/exclusivePublishDeals';
  static const searchDeals = '$_baseUrl/deal/search';
  static const searchInfluencer= '$_baseUrl/searchInfluencer';
  static const checkUniqueUser = '$_baseUrl/checkUniqueUser';
  static const qrUpdateApi = '$_baseUrl/scanQrCode';
  static const forgetPass = '$_baseUrl/sentForgetPasswordOtp';
  static const verifyForgetPasswordOTP = '$_baseUrl/verifyForgetPasswordOTP';
  static const changeForgetPassword = '$_baseUrl/changeForgetPassword';
}
