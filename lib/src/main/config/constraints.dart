import 'package:popwoot/src/main/services/shared_preferences.dart';
import 'package:popwoot/src/main/utils/ip_address_shared_preferences.dart';

class Config {



  //https://maps.googleapis.com/maps/api/place/autocomplete/json?input=1600+Amphitheatre&key=AIzaSyBFgb-c1pBbGK_iXOpDxY2voGYzWDvAuGE&sessiontoken=1234567890

  static const api_youtube = 'AIzaSyCY-rwuiZrzlx6XRl3Vb1l8rPOsz7FcD9w';
  static const api_key = 'AIzaSyBFgb-c1pBbGK_iXOpDxY2voGYzWDvAuGE';

  static const String base64Prefix = 'data:image/png;base64,';

  static String ipAdd;
  static String baseUrl = '$ipAdd:8080';
  static String baseImageUrl = ipAdd;

  static String authenticateUrl = baseUrl + '/api/oauth/authenticate';
  static String addCategoryUrl = baseUrl + '/api/cauth/addcategory';
  static String addProductUrl = baseUrl + '/api/cauth/addproduct';
  static String addStoreUrl = baseUrl + '/api/cauth/addstore';
  static String addReviewUrl = baseUrl + '/api/cauth/addreview';
  static String getScannerUrl = baseUrl + '/api/oauth/sproduct';

  static String doReviewLikeUrl = baseUrl + '/api/cauth/rlike';
  static String doReviewCommentUrl = baseUrl + '/api/cauth/rcomment';
  static String loginCheckUrl = baseUrl + '/api/cauth/logincheck';
  static String notificationUrl = baseUrl + '/api/';

  static String getHomeUrl = baseUrl + '/api/oauth/review/1';
  static String getDraftUrl = baseUrl + '/api/cauth/ureview';

  static String getReviewDetailsUrl = baseUrl + '/api/oauth/openproduct';
  static String getReviewListDetailsUrl = baseUrl + '/api/oauth/ireview';

  static String getReviewCommentUrl = baseUrl + '/api/oauth/ireviewc';
  static String getAllCommentUrl = baseUrl + '/api/oauth/allcomment';

  static String getAllStoreUrl = baseUrl + '/api/oauth/allstore';
  static String getAllCategoryUrl = baseUrl + '/api/oauth/category';
  static String getFollowUrl = baseUrl + '/api/cauth/cfollow';

  static String geProductsUrl = baseUrl + '/api/oauth/products';
  static String getDefaultReviewUrl = baseUrl + '/api/oauth/defaultreview';

  static String token = UserPreference().token;

  static String avatar1 =
      'https://yt3.ggpht.com/a/AGF-l79qOCl2IUTeTXzxfd5R_x83FZildu-caGbqAw=s900-c-k-c0xffffffff-no-rj-mo';
  static String avatar =
      'https://www.mobiletoones.com/downloads/wallpapers/people_wallpapers/preview/44/65525-karunkumar.jpg';
}
