
import 'api_provider.dart';
import 'model/category/category_model.dart';
import 'model/post/post_model.dart';

class ApiRepository{

  ApiProvider _provider = ApiProvider();

  Future<List<PostModel>> get getPostApi => _provider.getDataPostFromApiAsync();
  Future<List<CategoryModel>> get getCategoryApi => _provider.getCategoryAllAsync();


}