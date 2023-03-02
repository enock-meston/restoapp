class AlbumModel {
  String? productId;
  String? productReference;
  String? productTitle;
  String? price;
  String? buyingPrice;
  String? discountedPrice;
  String? discription;
  String? preparationTime;
  String? productImagePath;
  String? categoryId;
  String? unitId;
  String? productStatus;
  String? createdOn;
  String? udatedOn;
  String? addedBy;

  AlbumModel(
      {this.productId,
      this.productReference,
      this.productTitle,
      this.price,
      this.buyingPrice,
      this.discountedPrice,
      this.discription,
      this.preparationTime,
      this.productImagePath,
      this.categoryId,
      this.unitId,
      this.productStatus,
      this.createdOn,
      this.udatedOn,
      this.addedBy});

  AlbumModel.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productReference = json['product_reference'];
    productTitle = json['product_title'];
    price = json['price'];
    buyingPrice = json['buying_price'];
    discountedPrice = json['discounted_price'];
    discription = json['discription'];
    preparationTime = json['preparationTime'];
    productImagePath = json['productImagePath'];
    categoryId = json['categoryId'];
    unitId = json['unitId'];
    productStatus = json['product_status'];
    createdOn = json['createdOn'];
    udatedOn = json['udatedOn'];
    addedBy = json['addedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['product_reference'] = this.productReference;
    data['product_title'] = this.productTitle;
    data['price'] = this.price;
    data['buying_price'] = this.buyingPrice;
    data['discounted_price'] = this.discountedPrice;
    data['discription'] = this.discription;
    data['preparationTime'] = this.preparationTime;
    data['productImagePath'] = this.productImagePath;
    data['categoryId'] = this.categoryId;
    data['unitId'] = this.unitId;
    data['product_status'] = this.productStatus;
    data['createdOn'] = this.createdOn;
    data['udatedOn'] = this.udatedOn;
    data['addedBy'] = this.addedBy;
    return data;
  }
}
