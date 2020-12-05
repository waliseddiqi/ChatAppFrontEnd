class OnlineUser{


String username;
String id;
bool onlineStatus;
String age;


  OnlineUser({this.username, this.id, this.onlineStatus,this.age});
  factory OnlineUser.fromJson(Map<String, dynamic> json) {
    return OnlineUser(
      username: json['username'],
      id:json['id'],
      onlineStatus:json['onlineStatus'],
      age:json['age'],
    
    );
  }


}