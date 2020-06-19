
class Config{

    static const String base64Prefix='data:image/png;base64,';
    static const baseUrl='http://192.168.0.105:8087';
    static const baseImageUrl='http://192.168.0.105';

    static const String authenticateUrl=baseUrl+'/api/oauth/authenticate';
    static const String addCategoryUrl=baseUrl+'/api/cauth/addcategory';
    static const String addProductUrl=baseUrl+'/api/cauth/addproduct';
    static const String addReviewUrl=baseUrl+'/api/cauth/addreview';
    static const String getScannerUrl=baseUrl+'/api/oauth/sproduct';
    static const String doReviewLikeUrl=baseUrl+'/api/cauth/rlike';


    static const String getHomeUrl=baseUrl+'/api/oauth/review/1';

    static const String getReviewDetailsUrl=baseUrl+'/api/oauth/openproduct';
    static const String getReviewListDetailsUrl=baseUrl+'/api/oauth/ireview';

    static const String getAllCategoryUrl=baseUrl+'/api/oauth/allcategory';
    static const String getDefaultReviewUrl=baseUrl+'/api/oauth/defaultreview';

    static const String token=
        'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI1ZWU5YmNhNDUwZjY2YTIyYjRkM2FiODMiLCJzY29wZXMiOltdLCJleHAiOjE1OTI2MjQwMjYsImlhdCI6MTU5MjYwNjAyNn0.5PIU-ziItBlpy99qY4ygkRRZIHbNSfk5cxWlh7Efg9Dy60fgaqPRowxkDdXStv8CfJPnPKvjUlht39X9h0lk4g';
}