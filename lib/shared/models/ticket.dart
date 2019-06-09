class Ticket {
  String eventId;
  String boughtBy;
  String fullname;
  String email;
  String nim;
  String noTelp;

  Ticket({this.boughtBy, this.eventId, this.fullname, this.email, this.nim,
    this.noTelp});

  Map toMap(){
    var map = {
      'boughtBy': this.boughtBy,
      'eventId': this.eventId,
      'fullname': this.fullname,
      'email': this.email,
      'nim': this.nim,
      'noTelp': this.noTelp,
    };

    return map;
  }

  factory Ticket.fromMap(Map<String, dynamic> map){
    return Ticket(
      boughtBy: map['boughtBy'],
      eventId: map['eventId'],
      fullname: map['fullname'],
      email: map['email'],
      nim: map['nim'],
      noTelp: map['noTelp'],
    );
  }

}