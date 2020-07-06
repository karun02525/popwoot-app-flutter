
import 'package:popwoot/src/main/services/shared_preferences.dart';

class Config{


    static const api_youtube='AIzaSyAiSJV9ZHpFN8AwzpUDyorMVegUMS1corw';
    static const String base64Prefix='data:image/png;base64,';
    static const baseUrl='http://192.168.1.2:8087';
    static const baseImageUrl='http://192.168.1.2';

    static const String authenticateUrl=baseUrl+'/api/oauth/authenticate';
    static const String addCategoryUrl=baseUrl+'/api/cauth/addcategory';
    static const String addProductUrl=baseUrl+'/api/cauth/addproduct';
    static const String addReviewUrl=baseUrl+'/api/cauth/addreview';
    static const String getScannerUrl=baseUrl+'/api/oauth/sproduct';

    static const String doReviewLikeUrl=baseUrl+'/api/cauth/rlike';
    static const String doReviewCommentUrl=baseUrl+'/api/cauth/rcomment';
    static const String loginCheckUrl=baseUrl+'/api/cauth/logincheck';
    static const String notificationUrl=baseUrl+'/api/';


    static const String getHomeUrl=baseUrl+'/api/oauth/review/1';
    static const String getDraftUrl=baseUrl+'/api/cauth/ureview';

    static const String getReviewDetailsUrl=baseUrl+'/api/oauth/openproduct';
    static const String getReviewListDetailsUrl=baseUrl+'/api/oauth/ireview';


    static const String getReviewCommentUrl=baseUrl+'/api/oauth/ireviewc';
    static const String getAllCommentUrl=baseUrl+'/api/oauth/allcomment';

    static const String getAllCategoryUrl=baseUrl+'/api/oauth/category';
    static const String getFollowUrl=baseUrl+'/api/cauth/cfollow';


    static const String geProductsUrl=baseUrl+'/api/oauth/products';
    static const String getDefaultReviewUrl=baseUrl+'/api/oauth/defaultreview';

    static String token = UserPreference().token;


    static const String avatar1='https://yt3.ggpht.com/a/AGF-l79qOCl2IUTeTXzxfd5R_x83FZildu-caGbqAw=s900-c-k-c0xffffffff-no-rj-mo';
    static const String avatar='https://www.mobiletoones.com/downloads/wallpapers/people_wallpapers/preview/44/65525-karunkumar.jpg';
}