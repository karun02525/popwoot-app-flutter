
class Config{

    static const String base64Prefix='data:image/png;base64,';
    static const baseUrl='http://192.168.0.105:8087';
    static const baseImageUrl='http://192.168.0.105';

    static const String addCategoryUrl=baseUrl+'/api/cauth/addcategory';
    static const String addProductUrl=baseUrl+'/api/cauth/addproduct';
    static const String addReviewUrl=baseUrl+'/api/cauth/addreview';
    static const String getScannerUrl=baseUrl+'/api/oauth/sproduct';


    static const String getHomeUrl=baseUrl+'/api/oauth/review/1';

    static const String getReviewDetailsUrl=baseUrl+'/api/oauth/openproduct';
    static const String getReviewListDetailsUrl=baseUrl+'/api/oauth/ireview';

    static const String getAllCategoryUrl=baseUrl+'/api/oauth/allcategory';
    static const String getDefaultReviewUrl=baseUrl+'/api/oauth/defaultreview/1/k';

    static const String token=
        'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI1ZWU5YmNhNDUwZjY2YTIyYjRkM2FiODMiLCJzY29wZXMiOltdLCJleHAiOjE1OTI0ODI1ODksImlhdCI6MTU5MjQ2NDU4OX0.yh5S_kEpZzgfr_vWacfT8JFI4Flh1BRla6aO5FlQSsuVU3NXrxpsdlo5YFzfzQ1N0ammcJs6eC6FaYYZ-jMbDQ';

}