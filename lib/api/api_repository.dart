
import 'api_provider.dart';
import 'model/post/post_model.dart';

class ApiRepository{

  ApiProvider _provider = ApiProvider();
  Future<List<PostModel>> get getPostApi => _provider.getDataPostFromApiAsync();





}