class OnlineUser{


String username;
String id;
bool onlineStatus;
String age;
String gender;

  OnlineUser({this.username, this.id, this.onlineStatus,this.age,this.gender});
  factory OnlineUser.fromJson(Map<String, dynamic> json) {
    return OnlineUser(
      username: json['username'],
      id:json['id'],
      onlineStatus:json['onlineStatus'],
      age:json['age'],
      gender:json['gender']
    );
  }


}