class CategoryModel {
  late bool status;
  late CategoryData data;
  
  CategoryModel.fromjson(Map<String,dynamic> json)
  {
    status = json['status'];
    data = CategoryData.fromjson(json['data']);
  }
}

class CategoryData {
  late int current_page;
  List<DataModel> data = [];

  CategoryData.fromjson(Map<String,dynamic> json)
  {
    current_page = json['current_page'];
    json['data'].forEach((elements)
    {
      data.add(DataModel.fromjson(elements));
    });
  }
}

class DataModel {
  late int id;
  late String name;
  late String image;

  DataModel.fromjson(Map<String,dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}