class AppUser {
  final String UserID;
  final bool IsAdmin;
  String Email;

  AppUser({
    required this.UserID,
    required this.IsAdmin,
    required this.Email,
  });

  Map<String, dynamic> ToMap() {
    return {
      "UserID": UserID,
      "IsAdmin": IsAdmin,
      "Email": Email,
    };
  }

  AppUser.FromMap(Map<String, dynamic> map)
      : UserID = map["UserID"],
        IsAdmin = map["IsAdmin"],
        Email = map["Email"];
}
