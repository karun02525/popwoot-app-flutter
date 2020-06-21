
class Config{

    static const String base64Prefix='data:image/png;base64,';
    static const baseUrl='http://192.168.43.139:8087';
    static const baseImageUrl='http://192.168.43.139';

    static const String authenticateUrl=baseUrl+'/api/oauth/authenticate';
    static const String addCategoryUrl=baseUrl+'/api/cauth/addcategory';
    static const String addProductUrl=baseUrl+'/api/cauth/addproduct';
    static const String addReviewUrl=baseUrl+'/api/cauth/addreview';
    static const String getScannerUrl=baseUrl+'/api/oauth/sproduct';

    static const String doReviewLikeUrl=baseUrl+'/api/cauth/rlike';
    static const String doReviewCommentUrl=baseUrl+'/api/cauth/rcomment';


    static const String getHomeUrl=baseUrl+'/api/oauth/review/1';

    static const String getReviewDetailsUrl=baseUrl+'/api/oauth/openproduct';
    static const String getReviewListDetailsUrl=baseUrl+'/api/oauth/ireview';


    static const String getReviewCommentUrl=baseUrl+'/api/oauth/ireviewc';
    static const String getAllCommentUrl=baseUrl+'/api/oauth/allcomment';

    static const String getAllCategoryUrl=baseUrl+'/api/oauth/allcategory';
    static const String getDefaultReviewUrl=baseUrl+'/api/oauth/defaultreview';

    static const String token=
    'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI1ZWVmMjk4YzAyOGY4ZjE5MjA1MDFmMTgiLCJzY29wZXMiOltdLCJleHAiOjE1OTI3NTAwNDUsImlhdCI6MTU5MjczMjA0NX0.FOxRdYmu5u1gSf2zKFKwc471vX4DhdbjDxQBimxCjW-FU9x0G1lGUTsOV6VLjvhAmMeI0a8QvvHU-kDAZzJ35Q';


    static const String avatar1='https://yt3.ggpht.com/a/AGF-l79qOCl2IUTeTXzxfd5R_x83FZildu-caGbqAw=s900-c-k-c0xffffffff-no-rj-mo';
    static const String avatar='https://www.mobiletoones.com/downloads/wallpapers/people_wallpapers/preview/44/65525-karunkumar.jpg';
}