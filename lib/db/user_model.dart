class User{ // data class
  final String? userId;
  final String? createDate;
  final String? fcmToken;

  // required -> 필수인자
  // 생성자({인자값1,인자값2,....})
  User({required this.userId, required this.createDate,this.fcmToken});

  // json to map
  factory User.fromJson(Map<String,dynamic> json){
    return User(
        userId : json['userId'],
        createDate : json['createDate'],
        fcmToken : json['fcmToken']
    );
  }

  // map to json
  Map<String,dynamic> toJson() =>{
    'userId' : userId,
    'createDate' : createDate,
    'fcmToken' : fcmToken,
  };
}