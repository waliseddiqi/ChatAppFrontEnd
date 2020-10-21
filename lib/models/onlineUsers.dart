class OnlineUser{


String username;
String id;
bool onlineStatus;


  OnlineUser({this.username, this.id, this.onlineStatus});
  factory OnlineUser.fromJson(Map<String, dynamic> json) {
    return OnlineUser(
      username: json['username'],
      id:json['id'],
      onlineStatus:json['onlineStatus']
    );
  }


}