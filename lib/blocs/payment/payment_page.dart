import 'package:eventell/widgets/MoneyFormater.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  final data;

  const PaymentPage({Key key, this.data}) : super(key: key);
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  List<String> _tutorial = [
    "Silakan lakukan pembayaran via transfer pada rekening diatas.",
    "Setelah melakukan transfer, upload bukti pembayaran dengan cara, buka menu My ticket",
    "Pilih tiketnya dan upload bukti pembayaran.",
    "Setelah di upload tunggu konfirmasi dari admin.",
    "Kamu akan mendapatkan notifikasi jika pembayaran sudah dikonfirmasi.",
    "Tiket yang berhasil dibeli bisa dilihat di My Ticket"
  ];

  @override
  Widget build(BuildContext context) {
    int len = 1;
    var money = widget.data['moneyValue'];
    DateTime validUntil = DateTime.fromMillisecondsSinceEpoch(widget.data['validUntil']);
    String date = validUntil.day.toString() + "/" + validUntil.month.toString() + "/"
        + validUntil.year.toString() + "\t" + validUntil.hour.toString()
        + ":" + validUntil.minute.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Total Pembayaran",
                style: TextStyle(fontSize: 16.0),
              ),
              MoneyFormater(
                money: money,
                textStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
            ],
          ),
          Divider(height: 40, color: Colors.black87),
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.blue[200],
              borderRadius: BorderRadius.circular(10.0)
            ),
            child: Text("Harap selesaikan pembayaran sebelum tanggal "
                + date, style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          SizedBox(height: 15),
          Row(
            children: <Widget>[
              Image.asset("assets/graphics/bni_logo.png"),
              SizedBox(width: 20),
              Text("a/n Eventell")
            ],
          ),
          SizedBox(height: 15),
          Text(
            "Nomor rekening",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text("8765245761552661726",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          Divider(height: 40, color: Colors.black87),
          Text(
            "Petunjuk",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          for (var txt in _tutorial)
            Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text((len++).toString()),
                    SizedBox(width: 10),
                    Flexible(child: Text(txt)),
                  ],
                ),
                SizedBox(height: 15)
              ],
            )
        ],
      ),
    );
  }
}
