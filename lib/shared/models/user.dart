class User {
  String email;
  String university;
  List lovedEvent;

  User({this.email, this.university, this.lovedEvent});

  factory User.fromMap(Map<String, dynamic> map){
    return User(
        email: map['email'],
        university: map['university'],
        lovedEvent: map['lovedEvent']
    );
  }

  Map toMap(){
    var map = {
      'email': email,
      'university': university,
      'lovedEvent': lovedEvent
    };
    return map;
  }
}