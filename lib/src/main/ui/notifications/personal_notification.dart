import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/api/model/notification_model.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:popwoot/src/main/utils/global.dart';

class PersonalNotification extends StatefulWidget {
  List<NotificationData> data=[];
  PersonalNotification({Key key, this.data}) : super(key: key);

  @override
  _PersonalNotificationState createState() => _PersonalNotificationState();
}

class _PersonalNotificationState extends State<PersonalNotification> {
  @override
  Widget build(BuildContext context) {
    List<NotificationData> data=List.from(widget.data.reversed);
    return Container(
        child: data.length == 0
            ? Container(
                child: Center(child: TextWidget(title: 'Noting Notifications')))
            : ListView.builder(
             itemCount: data.length,
            itemBuilder: (context, index) {
                return buildCard(data[index]);
              }));
  }

  Widget buildCard(NotificationData data) {
    return Card(
        child: ListTile(
        title: TextWidget(title:data.title),
          subtitle:TextWidget(title:data.message,fontSize: 12.0),
          trailing:TextWidget(title:Global.timeAgo(data.createAt),isBold: true,fontSize: 11.0,) ,
    ));
  }


}
