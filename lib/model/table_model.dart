class TableModel {
  String? tabId;
  String? tabReference;
  String? title;
  String? tabLocation;
  String? tabInformation;
  String? tabStatus;
  String? createdOn;
  String? udatedOn;
  String? addedBy;

  TableModel(
      {this.tabId,
        this.tabReference,
        this.title,
        this.tabLocation,
        this.tabInformation,
        this.tabStatus,
        this.createdOn,
        this.udatedOn,
        this.addedBy});

  TableModel.fromJson(Map<String, dynamic> json) {
    tabId = json['tab_Id'];
    tabReference = json['tab_reference'];
    title = json['title'];
    tabLocation = json['tab_location'];
    tabInformation = json['tab_information'];
    tabStatus = json['tab_status'];
    createdOn = json['createdOn'];
    udatedOn = json['udatedOn'];
    addedBy = json['addedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tab_Id'] = this.tabId;
    data['tab_reference'] = this.tabReference;
    data['title'] = this.title;
    data['tab_location'] = this.tabLocation;
    data['tab_information'] = this.tabInformation;
    data['tab_status'] = this.tabStatus;
    data['createdOn'] = this.createdOn;
    data['udatedOn'] = this.udatedOn;
    data['addedBy'] = this.addedBy;
    return data;
  }
}