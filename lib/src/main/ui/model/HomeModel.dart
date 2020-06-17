
class HomeModel {
  String name;
  String profile_url;
  String bg_url;
  HomeModel(this.name,this.profile_url,this.bg_url);
}

List<HomeModel> fetchAllProduct(){
     return [
         HomeModel("Ramesh Singh","https://3.bp.blogspot.com/-trfrEcSbLCA/UyvaWmjdriI/AAAAAAAAAq8/gEM1wRLzQ90/s1600/Lord+shri+ram+pictures.jpg","https://cdn.britannica.com/26/84526-050-45452C37/Gateway-monument-India-entrance-Mumbai-Harbour-coast.jpg"),
         HomeModel("Karun Kumar","https://images.news18.com/ibnlive/uploads/2012/07/630saif-july14.jpg?impolicy=website&width=536&height=356","https://laughingcolours.com/wp-content/uploads/2019/10/74164789_333433830821751_6967954825619177472_n.jpg"),
         HomeModel("Mohan Kumsar","https://images.news18.com/ibnlive/uploads/2012/07/630saif-july14.jpg?impolicy=website&width=536&height=356","https://www.livemorezone.com/wp-content/uploads/yasmin-gym-fitness-livemore-dbs.jpg"),
         HomeModel("Rishi Singh","https://qph.fs.quoracdn.net/main-qimg-356d83b1976abf999fcaf4064f85fbab.webp","https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Shaqi_jrvej.jpg/1200px-Shaqi_jrvej.jpg"),
         HomeModel("Mila Singh","https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSJVwkMncmU7WD_wh_sdrHPJZ-LaAsQlY_NgrEwmno0y2VI7_dn&usqp=CAU","https://images.csmonitor.com/csm/2020/04/0407%20DDP%20NATURECALM%20topaz%20lake.jpg?alias=standard_900x600"),
         HomeModel("Sita Singh","https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSJVwkMncmU7WD_wh_sdrHPJZ-LaAsQlY_NgrEwmno0y2VI7_dn&usqp=CAU","https://www.youandthemat.com/wp-content/uploads/nature-2-26-17.jpg"),
         HomeModel("Geta Varma","https://qph.fs.quoracdn.net/main-qimg-4a5b46bac6c469eb3712665bbc1bc820","https://i.ytimg.com/vi/nU4EJfX2aXE/maxresdefault.jpg"),
         HomeModel("Mita Devi","https://mediaindia.eu/wp-content/uploads/2017/03/shahid-kapoor-366x260.jpg","https://natlands.org/wp-content/uploads/2020/03/StroudPreserveOwenMundth_Full-scaled-e1584730383492-2560x1160.jpg"),
     ];
}