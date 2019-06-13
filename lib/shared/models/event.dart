class Event {
  String eventId;
  String createdBy;
  String eventName;
  String eventDetail;
  String eventCategory;
  String eventTime;
  String eventDate;
  String eventAddress;
  int eventPrice;
  int eventAvaTicket;
  int eventTak;
  int eventLove;
  int eventAttended;
  List eventLoved;
  String eventImage;


  Event({this.eventId, this.createdBy, this.eventName, this.eventDetail, this.eventCategory,
    this.eventTime, this.eventDate, this.eventAddress, this.eventLove, this.eventAttended,
    this.eventPrice, this.eventAvaTicket, this.eventTak, this.eventImage, this.eventLoved});

  Map toMap(){
    var map = {
      'eventId': this.eventId,
      'createdBy': this.createdBy,
      'eventName': this.eventName,
      'eventDetail': this.eventDetail,
      'eventCategory': this.eventCategory,
      'eventTime': this.eventTime,
      'eventDate': this.eventDate,
      'eventAddress': this.eventAddress,
      'eventAvaTicket': this.eventAvaTicket,
      'eventTak': this.eventTak,
      'eventPrice': this.eventPrice,
      'eventLove':this.eventLove,
      'eventAttended':this.eventAttended,
      'eventImage': this.eventImage,
      'eventLoved': this.eventLoved
    };

    return map;
  }

  factory Event.fromMap(Map map){
    return Event(
        eventId: map['dataEdit'],
        createdBy: map['createdBy'],
        eventName: map['eventName'],
        eventDetail: map['eventDetail'],
        eventCategory: map['eventCategory'],
        eventTime: map['eventTime'],
        eventDate: map['eventDate'],
        eventAddress: map['eventAddress'],
        eventAvaTicket: map['eventAvaTicket'],
        eventTak: map['eventTak'],
        eventAttended: map['eventAttended'],
        eventLove: map['eventLove'],
        eventPrice: map['eventPrice'],
        eventImage: map['eventImage'],
        eventLoved: map['eventLoved'],
    );
  }


}