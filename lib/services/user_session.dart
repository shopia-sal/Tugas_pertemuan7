class UserSession {

  static final UserSession _instance = UserSession._internal();

  factory UserSession() {
    return _instance;
  }

  UserSession._internal();

  int? id;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  String? gender;
  String? image;
  String? token;


  void simpanDariApi(Map<String, dynamic> data) {
    id        = data['id'];
    username  = data['username'];
    email     = data['email'];
    firstName = data['firstName'];
    lastName  = data['lastName'];
    gender    = data['gender'];
    image     = data['image'];
    token     = data['accessToken'];
  }


  bool sudahLogin() {
    return token != null;
  }


  void hapusSession() {
    id        = null;
    username  = null;
    email     = null;
    firstName = null;
    lastName  = null;
    gender    = null;
    image     = null;
    token     = null;
  }

  String get namaLengkap {
    return '${firstName ?? '-'} ${lastName ?? '-'}';
  }
}