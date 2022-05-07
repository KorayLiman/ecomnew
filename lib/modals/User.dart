class AppUser {
  final String UserID;
  final bool IsAdmin;
  String Email;
  String UserName;

  AppUser(
      {required this.UserID,
      required this.IsAdmin,
      required this.Email,
      required this.UserName});

  Map<String, dynamic> ToMap() {
    return {
      "UserID": UserID,
      "IsAdmin": IsAdmin,
      "Email": Email,
      "UserName": UserName
    };
  }

  AppUser.FromMap(Map<String, dynamic> map)
      : UserID = map["UserID"],
        IsAdmin = map["IsAdmin"],
        Email = map["Email"],
        UserName = map["UserName"];
}
