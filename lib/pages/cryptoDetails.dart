import 'package:cryptowatch/api/cryptodata.dart';
import 'package:flutter/material.dart';
class CryptoDetails extends StatefulWidget {
  var data;


  CryptoDetails(this.data);

  @override
  _CryptoDetailsState createState() => _CryptoDetailsState(this.data);
}

class _CryptoDetailsState extends State<CryptoDetails> {
  var data;
  var values;
  cryptData crypto = cryptData();
  getData() async {
    print(data[0]);
    var resData = await crypto.getCryptoValue(data[0]);
    setState(() {
      values = resData;

    });
    print(values);

  }
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(data[1]),
      body: getBody(data[0],data[2]),
    );
  }

  _CryptoDetailsState(this.data);

  getAppBar(title) {
    return AppBar(title: Text(title),);
  }

  getBody(symbol,image_url) {
    return Container(
      child: Column(
        children: [
          symbol_image(symbol,image_url),
        ],
      ),
    );
  }

  symbol_image(symbol, image_url) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Center(
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(image_url),
              radius: 80.0 ,
            ),
            SizedBox(height: 20,),
            Text(symbol, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),)
          ],
        ),
      ),
    );
  }
}
