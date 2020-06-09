
/*

https://reqres.in/api/users?page=1
https://randomuser.me/api/?results=2&page=2

loading ? Center(child: CircularProgressIndicator()) : Text()


 onPressed: () {
        signInWithGoogle().whenComplete(() {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return Homepage();
              },
            ),
          );
        });


RaisedButton(
onPressed: () {
signOutGoogle();
Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)
{return LoginPage();}), ModalRoute.withName('/'));
},

*/
