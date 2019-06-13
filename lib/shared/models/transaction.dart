import 'event.dart';

class TransactionTicket {
  String transactionId;
  Event event;
  int validUntil;
  String paymentFile;
  bool isPaid;

  TransactionTicket({this.transactionId, this.event, this.validUntil, this.paymentFile, this.isPaid});

  Map toMap(){
    var map = {
      'transactionId': this.transactionId,
      'event': this.event.toMap(),
      'validUntil': this.validUntil,
      'paymentFile': this.paymentFile,
      'isPaid': this.isPaid,
    };

    return map;
  }

  factory TransactionTicket.fromMap(Map<String, dynamic> map){
    return TransactionTicket(
      transactionId: map['transactionId'],
      event: Event.fromMap(map['event']),
      validUntil: map['validUntil'],
      paymentFile: map['paymentFile'],
      isPaid: map['isPaid'],
    );
  }
}