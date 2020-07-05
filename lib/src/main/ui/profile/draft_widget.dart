import 'package:flutter/material.dart';
import 'package:popwoot/src/main/api/model/draft_model.dart';
import 'package:popwoot/src/main/ui/product/review_details.dart';
import 'package:popwoot/src/main/ui/widgets/add_review_widget.dart';
import 'package:popwoot/src/main/ui/widgets/image_load_widget.dart';
import 'package:popwoot/src/main/ui/widgets/rating_widget.dart';
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
      child: widget.draftList == null
          ? Container(child: Center(child: TextWidget(title: 'Empty Draft')))
          : ListView.builder(
              itemCount: widget.draftList.length,
              itemBuilder: (context, index) =>
                  buildCardView(context, widget.draftList[index])),
    );
  }

  Widget buildCardView(BuildContext context, DraftList item) {
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 5),
        child: Column(
          children: <Widget>[
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: getContent(item),
                    flex: 1,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        getImage(item),
                        SizedBox(
                          height: 5.0,
                        ),
                        AddReviewWidget(data: {
                          'pid': item.pid,
                          'pname': item.pname,
                          'pdesc': item.pdesc,
                          'ipath': item.ipath,
                          'astar': item.astar,
                          "comment": item.comment,
                        }),
                      ],
                    ),
                    flex: -1,
                  )
                ]),
            Divider(
              height: 25.0,
            ),
          ],
        ));
  }

  Widget getImage(DraftList item) {
    return Container(
        color: Colors.grey[100],
        width: 110.0,
        height: 90.0,
        child: ImageLoadWidget(imageUrl: item.ipath));
  }

  Widget getContent(DraftList item) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ReviewDetails(pid: item.pid, pname: item.pname)));
              },
              child: TextWidget(
                title: item.pname ?? 'N.A',
                isBold: true,
              )),
          SizedBox(height: 5.0),
          TextWidget(
              title: item.pdesc,
              fontSize: 13.0,
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
          SizedBox(height: 5.0),
          RatingWidget(rating: item.astar),
          SizedBox(height: 5.0),
          TextWidget(title: " " + item.rdate ?? '',fontSize: 12,),
          SizedBox(height: 5.0),
          TextWidget(title: " " + item.comment ?? ''),
        ],
      ),
    );
  }
}
