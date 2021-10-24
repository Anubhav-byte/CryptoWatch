class CryptoHelper{
    String cryptoName;
    String cryptoSymbol;
    String imageUrl;

    CryptoHelper(this.cryptoName, this.cryptoSymbol, this.imageUrl);

    Map<String,dynamic> toMap(){
        return {
          'cryptoName': cryptoName,
          'cryptoSymbol': cryptoSymbol,
          'imageUrl' : imageUrl
        };
    }
}