
class CategoryModel{
     int id;
     String name;
     String desc;
     String url;

     CategoryModel(this.id,this.name,this.desc,this.url);

}

List<CategoryModel> fetchAllCategory(){
    return [
        CategoryModel(1,"Electronic","Redmi Note 8 Pro (Electric Blue, 6GB RAM, 64GB Storage with Helio G90T Processor)","https://images-eu.ssl-images-amazon.com/images/G/31/img15/rcx-events/AurDikhaoStore/400x400_Vodoo_1.jpg"),
        CategoryModel(2,"Shoes","shoes online for Men, Women & Kids at best price in India. Shop from the latest collection of shoes available in various brands, colours","https://images-eu.ssl-images-amazon.com/images/G/31/img15/rcx-events/AurDikhaoStore/400x400_Vodoo_11.jpg"),
        CategoryModel(3,"Book","Books Store offers you millions of titles across categories like Children's Books, Free eBooks, Audiobooks, Business & Economics, and Literature .","https://images-eu.ssl-images-amazon.com/images/G/31/img15/rcx-events/AurDikhaoStore/400x400_Vodoo_5.1.jpg"),
        CategoryModel(4,"Sports","Sport includes all forms of competitive physical activity or games which, through casual or organized participation,","https://images-eu.ssl-images-amazon.com/images/G/31/img15/rcx-events/AurDikhaoStore/400x400_Vodoo-7-1.jpg"),
        CategoryModel(5,"Beauty","Everything you need to know about the latest beauty trends and styles.","https://images-eu.ssl-images-amazon.com/images/G/31/img15/rcx-events/AurDikhaoStore/400x400_Vodoo9.jpg"),
        CategoryModel(6,"Handbags","Handbags for Women - Buy designer handbags, leather handbags for women & men online","https://images-eu.ssl-images-amazon.com/images/G/31/img15/rcx-events/AurDikhaoStore/400X400.jpg"),
        CategoryModel(7,"Musical Instruments","Musical may also refer to: Musical theatre, a performance art that combines songs, spoken dialogue, acting and dance.","https://images-eu.ssl-images-amazon.com/images/G/31/img15/rcx-events/AurDikhaoStore/400x400_Vodoo_8.jpg"),

    ];
}