class LocationModel {
  String? locId;
  String? locReference;
  String? title;
  String? locStatus;
  String? createdOn;
  String? udatedOn;
  String? addedBy;

  LocationModel(
      {this.locId,
        this.locReference,
        this.title,
        this.locStatus,
        this.createdOn,
        this.udatedOn,
        this.addedBy});

  LocationModel.fromJson(Map<String, dynamic> json) {
    locId = json['locId'];
    locReference = json['loc_reference'];
    title = json['title'];
    locStatus = json['loc_status'];
    createdOn = json['createdOn'];
    udatedOn = json['udatedOn'];
    addedBy = json['addedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locId'] = this.locId;
    data['loc_reference'] = this.locReference;
    data['title'] = this.title;
    data['loc_status'] = this.locStatus;
    data['createdOn'] = this.createdOn;
    data['udatedOn'] = this.udatedOn;
    data['addedBy'] = this.addedBy;
    return data;
  }
}