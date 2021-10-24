import 'package:cryptowatch/api/cryptodata.dart';
import 'package:cryptowatch/database/cryptoDatabase.dart';
import 'package:cryptowatch/database/cryptoHelper.dart';
import 'package:cryptowatch/pages/cryptoDetails.dart';
import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var data = [];
  var flag = 0;
  CryptoDatabase cryptoDatabase = CryptoDatabase();
  initData() async {
    print('calling api');
    cryptData crypt = cryptData();
    var apidata = await crypt.getCryptData();
    setState(() {
      data = apidata;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: getBody()
    );
  }

  getAppBar() {
    return AppBar(
      title: Text('Crypto Watch'),
    );
  }

  getBody() {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index){
          return Card(
            child: ListTile(
              leading: Image.network(data[index][2]),
              title: Text(data[index][1]),
              trailing: getFavoriteButton(data[index]),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CryptoDetails(data[index])),
                );
              },
            ),
          );
      }
    );
  }

  getFavoriteButton(data) {
    CryptoHelper cryptoHelper = CryptoHelper(data[1],data[0],data[2]);
    return GestureDetector(
        child: Icon(
            Icons.favorite,
            color: flag==1?Colors.red:Colors.black12,
        ),
      onTap: (){
          // insertData(cryptoHelper);
      },
    );
  }

  Future<void> insertData(CryptoHelper cryptoHelper) async {
    await cryptoDatabase.insertFileData(cryptoHelper);
    data = await cryptoDatabase.getCryptoData();
    print(data.length);
  }
}
