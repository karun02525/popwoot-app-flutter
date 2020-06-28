import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popwoot/src/main/api/model/draft_model.dart';
import 'package:popwoot/src/main/api/repositories/profile_repository.dart';
import 'package:popwoot/src/main/services/login_service.dart';
import 'package:popwoot/src/main/ui/profile/draft_widget.dart';
import 'package:popwoot/src/main/ui/profile/myreviews_widget.dart';
import 'package:popwoot/src/main/ui/profile/profile_widget.dart';
import 'package:popwoot/src/main/ui/widgets/text_widget.dart';
import 'package:popwoot/src/main/utils/global.dart';
import 'package:popwoot/src/res/fonts.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name="Karun Kumar",email="kk@gmail.com",url="https://upload.wikimedia.org/wikipedia/commons/2/2e/Akshay_Kumar.jpg";
  bool isLogin=true;
  bool isLoading = false;
  ProfileRepository _repository;
  List<DraftList> draftList;

  @override
  void initState() {
    super.initState();
    _repository = ProfileRepository();
    getDraftList();
  }


  void _handleSignIn() {
    signInWithGoogle().whenComplete(() {
      setState(() {
       var name = username;
       var email = emailId;
       var url = imageUrl;
       var isLogin = true;
      });
    });
  }

  void getDraftList(){
      _repository.findAllDraft().then((value){
          setState(() {
            draftList=value;
          });
      });
  }


  void _handleSignOut() {
    Global.toast('_handleSignOut');
   // signOutGoogle();
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
        body: isLogin ? alreadyLogin() : doLogin());
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
                            child: TextWidget(title:"Profile",isBold: true,),
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
                            child: TextWidget(title:"My Reviews",isBold: true,),
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
                            child: TextWidget(title:"Draft",isBold: true,),
                          ),
                        ),
                      ),
                    ],
              )),
          body: TabBarView(
              children: [
                ProfileWidget(data: [name,email,url],handleSignOut: _handleSignOut,),
                MyReviews(),
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

/*

Widget _buildInfo() {
  if (isLogin) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 150.0,
              height: 150.0,
              child: CachedNetworkImage(
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, url) => CircularProgressIndicator(),
                imageUrl: url==null?"":url,
              )),
          SizedBox(height: 30.0),
          TextWidget(title:name==null ?"":name,isBold: true,),
          TextWidget(title:email==null ?"":email),
          SizedBox(height: 30.0),
          RaisedButton(
            onPressed:_handleSignOut,
            child: Text('SignOut'),
          )
        ],
      ),
    );
  } else {
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
}*/
