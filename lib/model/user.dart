class User {
  String? user_email;
  String? user_password;

  User(
    this.user_email,
    this.user_password,
  );

  User.fromJson(Map<String, dynamic> json){
        user_email =json["user_email"];
        user_password= json["user_password"];
      }

  Map<String, dynamic> toJson() => {
        'user_email': user_email.toString(),
        'user_password': user_password.toString()
      };
}
