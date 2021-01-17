class OnlineUser{


String username;
String userid;
bool onlineStatus;
String age;


  OnlineUser({this.username, this.userid, this.onlineStatus,this.age});
  factory OnlineUser.fromJson(Map<String, dynamic> json) {
    return OnlineUser(
      username: json['username'],
      userid:json['userid'],
      onlineStatus:json['onlineStatus'],
      age:json['age'],
    
    );
  }


}