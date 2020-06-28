import 'package:flutter/material.dart';
import 'package:popwoot/src/main/api/model/draft_model.dart';
import 'package:popwoot/src/main/ui/widgets/add_review_widget.dart';
import 'package:popwoot/src/main/ui/widgets/image_load_widget.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';

class DraftWidget extends StatefulWidget {
  final List<DraftList> draftList;
  DraftWidget({this.draftList});

  @override
  _DraftWidgetState createState() => _DraftWidgetState();
}

class _DraftWidgetState extends State<DraftWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: widget.draftList.length == 0
          ? Container(child: Center(child: TextWidget(title: 'Empty Draft')))
          : ListView.builder(
              itemCount: widget.draftList.length,
              itemBuilder: (context, index) => buildCardView(context, index)),
    );
  }

  Widget buildCardView(BuildContext context, int index) {
    final i = widget.draftList[index];
    return Container(
        margin: EdgeInsets.only(left: 2, right: 5),
        child: Card(
          elevation: 3,
          child: ListTile(
            leading: SizedBox(
                width: 80.0, child: ImageLoadWidget(imageUrl: i.ipath)),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextWidget(title: i.pname, isBold: true, fontSize: 14.0),
                AddReviewWidget(data: {
                  "pid": i.pid,
                  "pname": i.pname,
                  "pdesc": i.pdesc,
                  "ipath": i.ipath,
                  "comment": i.comment,
                }),
              ],
            ),
            subtitle: Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: TextWidget(title: i.comment, fontSize: 12.0)),
          ),
        ));
  }
}
