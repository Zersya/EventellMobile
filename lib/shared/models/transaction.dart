class TransactionTicket {
  String eventId;
  int validUntil;
  String paymentFile;
  bool isPaid;

  TransactionTicket({this.eventId, this.validUntil, this.paymentFile, this.isPaid});

  Map toMap(){
    var map = {
      'eventId': this.eventId,
      'validUntil': this.validUntil,
      'paymentFile': this.paymentFile,
      'isPaid': this.isPaid,
    };

    return map;
  }

  factory TransactionTicket.fromMap(Map<String, dynamic> map){
    return TransactionTicket(
      eventId: map['eventId'],
      validUntil: map['validUntil'],
      paymentFile: map['paymentFile'],
      isPaid: map['isPaid'],
    );
  }
}