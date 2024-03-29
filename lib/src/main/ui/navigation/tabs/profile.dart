import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/api/model/draft_model.dart';
import 'package:popwoot/src/main/api/model/home_reviews_model.dart';
import 'package:popwoot/src/main/api/repositories/profile_repository.dart';
import 'package:popwoot/src/main/services/google+login_service.dart';
import 'package:popwoot/src/main/services/shared_preferences.dart';
import 'package:popwoot/src/main/ui/profile/draft_widget.dart';
import 'package:popwoot/src/main/ui/profile/myreviews_widget.dart';
import 'package:popwoot/src/main/ui/profile/profile_widget.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:popwoot/src/res/fonts.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isLogin = false;
  ProfileRepository _repository;
  List<DraftList> draftList;
  List<ReviewsModel> reviewswList;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _repository = ProfileRepository(context);
    isLogin =UserPreference().isLogin;
    if (isLogin) {
      setState(() {
        getDraftList();
      });
    }
  }

  void _handleSignIn() {
   signInWithGoogle().whenComplete(() {
      _repository.loginUser([username, emailId, imageUrl, token]).then((value) {

     // _repository.loginUser(["Karun02525", 'karunkumar2023@gmail.com', 'https://images.indianexpress.com/2020/05/ak759-1.jpg', "no........"]).then((value) {
        if (value) {
          getDraftList();
          setState(() {
            isLogin = true;
          });
        }
      });
    });
  }

  void getDraftList() async {
    isLoading = true;

    _repository.findAllDraft().then((value) {
      setState(() {
        isLoading = false;
        draftList = value;
      });
    });

    _repository.findAllReview().then((value) {
      setState(() {
        isLoading = false;
        reviewswList = value;
      });
    });
  }

  void _handleSignOut() {
    signOutGoogle();
    UserPreference().clearSharedPreferences().then((value) {
      if (value) {
        setState(() {
          isLogin = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 2.0,
          centerTitle: true,
          title: TextWidget(
              title: "Profile", fontSize: AppFonts.toolbarSize, isBold: true),
        ),
        backgroundColor: Colors.white,
        body: isLogin
            ? Stack(
                children: [
                  alreadyLogin(),
                  Visibility(
                      visible: isLoading,
                      child: Container(
                          child: Center(
                              child: CupertinoActivityIndicator(
                        radius: 13.0,
                      ))))
                ],
              )
            : doLogin());
  }

  Widget alreadyLogin() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(40.0),
              child: TabBar(
                unselectedLabelColor: Colors.redAccent,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.redAccent),
                tabs: [
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border:
                              Border.all(color: Colors.redAccent, width: 1)),
                      child: Align(
                        alignment: Alignment.center,
                        child: TextWidget(
                          title: "Profile",
                          isBold: true,
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border:
                              Border.all(color: Colors.redAccent, width: 1)),
                      child: Align(
                        alignment: Alignment.center,
                        child: TextWidget(
                          title: "My Reviews",
                          isBold: true,
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border:
                              Border.all(color: Colors.redAccent, width: 1)),
                      child: Align(
                        alignment: Alignment.center,
                        child: TextWidget(
                          title: "Draft",
                          isBold: true,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          body: TabBarView(children: [
            ProfileWidget(
              handleSignOut: _handleSignOut,
            ),
            MyReviews(reviewswList: reviewswList),
            DraftWidget(draftList: draftList),
          ]),
        ),
      ),
    );
  }

  Widget doLogin() {
    return Center(
      child: InkWell(
        onTap: _handleSignIn,
        child: Image.asset(
          'assets/images/googlesignin.png',
          width: 300.0,
          height: 170.0,
        ),
      ),
    );
  }
}
