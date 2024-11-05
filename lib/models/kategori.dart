class CategoryModel {
  int? id;
  String? name, desc, icon;

  CategoryModel(
    {this.id, this.name, this.desc, this.icon});

    factory CategoryModel.fromJson(Map<String, dynamic> json){
      return CategoryModel(
        id: json['id'],
        name: json['name'],
        desc: json['desc'],
        icon: json['icon'],
      );
    }
}