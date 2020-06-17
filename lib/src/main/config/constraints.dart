
class Config{

    static const String base64Prefix='data:image/png;base64,';
    static const baseUrl='http://192.168.0.105:8087';
    static const baseImageUrl='http://192.168.0.105';

    static const String addCategoryUrl=baseUrl+'/api/cauth/addcategory';
    static const String addProductUrl=baseUrl+'/api/cauth/addproduct';
    static const String addReviewUrl=baseUrl+'/api/cauth/addreview';
    static const String getHomeUrl=baseUrl+'/api/oauth/review/1';

    static const String getAllCategoryUrl=baseUrl+'/api/oauth/allcategory';
    static const String getDefaultReviewUrl=baseUrl+'/api/oauth/defaultreview/1/k';

    static const String token=
        'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI1ZWU5YmNhNDUwZjY2YTIyYjRkM2FiODMiLCJzY29wZXMiOltdLCJleHAiOjE1OTIzOTQ0ODUsImlhdCI6MTU5MjM3NjQ4NX0.BAhL3ns7YB0SaZFfUaj5m3DVhL2OGDu4UN0IHqwcj1WwiiSiKIWh0rhJppVgdNytrXUrUblCsL7J4xzk8cZqDQ';


}