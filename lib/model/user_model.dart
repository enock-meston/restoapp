
class UserModel {
  String? userId;
  String? fname;
  String? lname;
  String? phoneNumber;
  String? email;
  String? username;
  String? userType;
  String? password;
  String? createdOn;
  String? updatedOn;
  String? activeStatus;

  UserModel(
      {this.userId,
        this.fname,
        this.lname,
        this.phoneNumber,
        this.email,
        this.username,
        this.userType,
        this.password,
        this.createdOn,
        this.updatedOn,
        this.activeStatus});

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_Id'];
    fname = json['fname'];
    lname = json['lname'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    username = json['username'];
    userType = json['userType'];
    password = json['password'];
    createdOn = json['createdOn'];
    updatedOn = json['updatedOn'];
    activeStatus = json['activeStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_Id'] = this.userId;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    data['username'] = this.username;
    data['userType'] = this.userType;
    data['password'] = this.password;
    data['createdOn'] = this.createdOn;
    data['updatedOn'] = this.updatedOn;
    data['activeStatus'] = this.activeStatus;
    return data;
  }
}