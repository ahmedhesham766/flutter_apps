class HomeModel
{
  late bool status;
  late HomeData data;

  HomeModel.fromjson(Map<String,dynamic> json)
  {
    status = json['status'];
    data = HomeData.fromjson(json['data']);
  }

}

class HomeData
{
  late List<bannersModel> banners = [];
  late List<productsModel> products = [];

  HomeData.fromjson(Map<String,dynamic> json)
  {
    json['banners'].forEach((element)
    {
      banners.add(bannersModel.fromjson(element));
    });

    json['products'].forEach((element)
    {
      products.add(productsModel.fromjson(element));
    });
  }
}

class bannersModel
{
  late int id;
  late String image;

  bannersModel.fromjson(Map<String,dynamic> json)
  {
    id = json['id'];
    image = json['image'];
  }
}

class productsModel
{
  late int id;
  late dynamic price;
  late dynamic old_price;
  late dynamic discount;
  late String image;
  late String name;
  late bool infavorites;
  late bool incart;

  productsModel.fromjson(Map<String,dynamic> json)
  {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    infavorites = json['in_favorites'];
    incart = json['in_cart'];
  }

}