class CategoryModel {
  String? catId;
  String? catReference;
  String? title;
  String? catStatus;

  CategoryModel({this.catId, this.catReference, this.title, this.catStatus});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    catId = json['catId'];
    catReference = json['cat_reference'];
    title = json['title'];
    catStatus = json['cat_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['catId'] = this.catId;
    data['cat_reference'] = this.catReference;
    data['title'] = this.title;
    data['cat_status'] = this.catStatus;
    return data;
  }
}