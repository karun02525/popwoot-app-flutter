class ReviewModel{
      int  id;
      String title;
      String desc;
      String  url;
      int  rating;
      int review;

      ReviewModel(this.id,this.title,this.desc,this.url,this.rating,this.review);

}

List<ReviewModel> fetchAllReview(){
  return [
    ReviewModel(1,"Water pump","It is poweful pump for the money at 18W","https://previews.123rf.com/images/olegtoka/olegtoka1809/olegtoka180900014/110258991-illustration-of-water-pump-power-generator.jpg",3,4),
    ReviewModel(2,"Vu4K TV (55PM)","Indian television brand Vu only recently launched its Cinema TV range in India, which we praised for the sheer value on offer.","https://i.gadgets360cdn.com/products/large/vu-premium-4k-tv-db-800x600-1583925020.jpg",5,3),
    ReviewModel(3,"Gym","The best fitness equipment to use at any gym, according to a trainer","https://cnet1.cbsistatic.com/img/s5uAgaJZUF9ndQRk4xSfFqQJWsw=/940x0/2020/03/06/5afa92b5-777b-4ef8-ab4a-07253682bffe/gettyimages-1132006407.jpg",2,1)
    ];
}