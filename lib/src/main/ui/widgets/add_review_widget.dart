import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/ui/product/add_review.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:popwoot/src/res/app_icons.dart';

import 'icon_widget.dart';

class AddReviewWidget extends StatelessWidget {
  final data;

  AddReviewWidget({this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconWidget(
        icon: AppIcons.ic_add_review,
        mgs: 'Add Review',
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddReview(),
                  settings: RouteSettings(arguments: [
                    data['pid'],
                    data['pname'],
                    data['pdesc'],
                    data['ipath']
                  ])));
        },
      ),
    );
  }
}
