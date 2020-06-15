class LoginModel {
  String login;
  String password;

  LoginModel({this.login, this.password});

  LoginModel.fromJson(Map<String, dynamic> json) {
    login = json['Login'];
    password = json['Password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Login'] = this.login;
    data['Password'] = this.password;
    return data;
  }
}