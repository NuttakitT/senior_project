class RegisterModel {

  late String _username;
  late String _email;
  late String _password;
  late int _gender;

  String get getUsername => _username;
  String get getEmail => _email;
  String get getPassword => _password;
  int get getGender => _gender;

  set setUsername(String username) => _username = username;
  set setEmail(String email) => _email = email;
  set setPassword(String password) => _password = password;
  set setGender(int gender) => _gender = gender; 
}