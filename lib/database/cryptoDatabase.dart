import 'package:cryptowatch/database/cryptoHelper.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CryptoDatabase{
  var tableName = 'crypto_data';
  var imageUrl = 'imageUrl';
  var cryptoName = 'cryptoName';
  var cryptoSymbol = 'cryptoSymbol';

  Future<Database> getDatabase() async {
    var path = join(await getDatabasesPath(), 'favorite_crypto.db');
    Database database = await openDatabase(
        path,
        onCreate: (db,version){
          return db.execute('CREATE TABLE $tableName('
              '$cryptoSymbol TEXT,'
              '$cryptoName TEXT,'
              '$imageUrl TEXT)'
          );
        },
        version: 1
    );
    return database;
  }

  Future<List<CryptoHelper>> getCryptoData() async{
    final Database db = await getDatabase();
    final List<Map<String,dynamic>> maps = await db.query(tableName);
    return List.generate(
        maps.length,
            (index){
          return cryptData(index, maps);
        }
    );

  }

  CryptoHelper cryptData(int index, List<Map<String,dynamic>> maps){
    return CryptoHelper(
        maps[index]['cryptoName'],
        maps[index]['cryptoSymbol'],
          maps[index]['imageUrl']  );
  }

  Future<void> insertFileData(CryptoHelper cryptoHelper) async {
    final Database db = await getDatabase();
    db.insert(tableName, cryptoHelper.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<void> deleteFileData(String cryptName) async {
    final Database db = await getDatabase();
    await db.delete(tableName,where: '$cryptoName= ?',whereArgs: [cryptName]);
    //await db.rawDelete('DELETE FROM $tableName WHERE $colFileName = $fileName');

  }


}