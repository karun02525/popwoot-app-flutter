import 'package:flutter/cupertino.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';

class GeneralNotification extends StatefulWidget {
  @override
  _GeneralNotificationState createState() => _GeneralNotificationState();
}

class _GeneralNotificationState extends State<GeneralNotification> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: TextWidget(title: 'General Notification',),),);
  }
}
