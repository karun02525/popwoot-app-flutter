import 'package:flutter/cupertino.dart';
import 'package:popwoot/src/main/api/model/notification_model.dart';
import 'package:popwoot/src/main/api/service/api_error_handle.dart';
import 'package:popwoot/src/main/api/service/custom_dio.dart';
import 'package:popwoot/src/main/config/constraints.dart';

class NotificationRepository{

  BuildContext context;
  NotificationRepository(BuildContext cnt){
    this.context=cnt;
  }

  Future<List<NotificationData>> findAllNotifications() async {
      var dio =CustomDio.withAuthentication().instance;
     return await dio.get(Config.notificationUrl).then((res){
        return NotificationModel.fromJson(res.data).data;
      }).catchError((e) {
        ApiErrorHandel.errorHandel(context,e);
     });
  }
}