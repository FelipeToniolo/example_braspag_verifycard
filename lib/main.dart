import 'package:braspag_verify_card_dart/braspag_verify_card_dart.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<VerifyCardResponse>(
              future: _braspagVerify(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Container();
                return Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Status: ${snapshot.data.status}',
                      ),
                      Text(
                        'cardType: ${snapshot.data.binData.cardType}',
                      ),
                      Text(
                        'foreignCard: ${snapshot.data.binData.foreignCard}',
                      ),
                      Text(
                        'code: ${snapshot.data.binData.code}',
                      ),
                      Text(
                        'message: ${snapshot.data.binData.message}',
                      ),
                      Text(
                        'corporateCard: ${snapshot.data.binData.corporateCard}',
                      ),
                      Text(
                        'issuer: ${snapshot.data.binData.issuer}',
                      ),
                      Text(
                        'issuerCode: ${snapshot.data.binData.issuerCode}',
                      ),
                      Text(
                        'cardBin: ${snapshot.data.binData.cardBin}',
                      ),
                      Text(
                        'cardLast4Digits: ${snapshot.data.binData.cardLast4Digits}',
                      ),
                      Text(
                        'ProviderReturnCode: ${snapshot.data.providerReturnCode}',
                      ),
                      Text(
                        'ProviderReturnMessage: ${snapshot.data.providerReturnMessage}',
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Future<VerifyCardResponse> _braspagVerify() async {
    try {
      var verifyCard = VerifyCard(
          clientId: "Client Id",
          clientSecret: "Client Secret",
          merchantId: "Merchant Id",
          enviroment: VerifyEnviroment.SANDBOX);

      return await verifyCard.verify(
        request: VerifyCardRequest(
          provider: "Cielo30",
          card: CardConsultation(
              cardNumber: "9876543210123456",
              holder: "Darth Vader",
              expirationDate: "01/2030",
              securityCode: "123",
              brand: "Visa",
              type: TypeCard.CREDIT_CARD),
        ),
      );
    } on VerifyCardException catch (e) {
      VerifyCardException error = e;
      print("--------------------------------------");
      print('Status => ${error.message}');
      print("--------------------------------------");
      print(
          'Retorno OAuth => Error: ${error.errorsOAuth.error}, Error Description: ${error.errorsOAuth.errorDescription}');
      print("--------------------------------------");
      print(
          'Retorno VerifyCard => Code: ${error.errorsVerifyCard.code}, Message: ${error.errorsVerifyCard.message}');
      print("--------------------------------------");
    }
  }
}
