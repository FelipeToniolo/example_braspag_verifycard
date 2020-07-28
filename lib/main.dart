import 'package:braspag_verify_card_dart/verifycard.dart';
import 'package:examplebraspagverifycard/response_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Braspag Verify Card',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controllerName = TextEditingController(text: "Darth Vader");

  final _controllerNumber = TextEditingController(text: "5266135176906859");

  final _controllerExpiration = TextEditingController(text: "01/2030");

  final _controllerCvv = TextEditingController(text: "123");

  var showProgress = false;

  static const menuBrand = <String>['Visa', 'Master'];

  static const menuType = <String>['Debito', 'Credito'];

  final List<DropdownMenuItem<String>> _dropDownMenuBrand = menuBrand
      .map((String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ))
      .toList();

  String _btnSelectBrand1 = 'Visa';

  final List<DropdownMenuItem<String>> _dropDownMenuType = menuType
      .map((String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ))
      .toList();

  String _btnSelectType1 = 'Debito';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo Braspag Verify Card'),
        centerTitle: true,
      ),
      body: DefaultTextStyle(
        style: Theme.of(context).textTheme.body2,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Container(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: TextFormField(
                              controller: _controllerName,
                              decoration: InputDecoration(
                                labelText: "Nome",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.zero)),
                                labelStyle: TextStyle(fontSize: 25),
                                hintStyle: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Center(
                              child: TextFormField(
                                controller: _controllerNumber,
                                decoration: InputDecoration(
                                  labelText: "Numero do Cartão",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.zero)),
                                  labelStyle: TextStyle(fontSize: 25),
                                  hintStyle: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Center(
                              child: TextFormField(
                                controller: _controllerExpiration,
                                decoration: InputDecoration(
                                  labelText: "Data de expiração",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.zero)),
                                  labelStyle: TextStyle(fontSize: 25),
                                  hintStyle: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Center(
                              child: TextFormField(
                                controller: _controllerCvv,
                                decoration: InputDecoration(
                                  labelText: "CVV",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.zero)),
                                  labelStyle: TextStyle(fontSize: 25),
                                  hintStyle: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          ListTile(
                              title: Text('Bandeira do Cartão: '),
                              trailing: DropdownButton<String>(
                                value: _btnSelectBrand1,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _btnSelectBrand1 = newValue;
                                  });
                                },
                                items: this._dropDownMenuBrand,
                              )),
                          ListTile(
                              title: Text('Tipo de Cartão: '),
                              trailing: DropdownButton<String>(
                                value: _btnSelectType1,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _btnSelectType1 = newValue;
                                  });
                                },
                                items: this._dropDownMenuType,
                              )),
                          RaisedButton(
                            color: Colors.blue,
                            onPressed: () {
                              _sendCard();
                              setState(() {});
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Container(
                              constraints:
                                  BoxConstraints(maxWidth: 200, minHeight: 50),
                              alignment: Alignment.center,
                              child: showProgress
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    )
                                  : Text(
                                      "Test",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _sendCard({String name, String number, String expiration, String cvv}) async {
    try {
      showProgress = true;

      print("Send Card");

      name = _controllerName.text;
      number = _controllerNumber.text;
      expiration = _controllerExpiration.text;
      cvv = _controllerCvv.text;

      var typeCard = _btnSelectType1 == 'Debito'
          ? TypeCard.DEBIT_CARD
          : TypeCard.CREDIT_CARD;

      var verifyCard = VerifyCard(
          clientId: "Client Id",
          clientSecret: "Client Secret",
          merchantId: "Merchant Id",
          enviroment: VerifyEnviroment.SANDBOX);

      var response = await verifyCard.verify(
        request: VerifyCardRequest(
          provider: "Cielo30",
          card: CardConsultation(
              cardNumber: number,
              holder: name,
              expirationDate: expiration,
              securityCode: cvv,
              brand: _btnSelectBrand1,
              type: typeCard),
        ),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResponsePage(response: response),
        ),
      );
    } on ErrorResponse catch (e) {
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          setState(() {
            showProgress = false;
          });
          Navigator.pop(context);
        },
      );

      WillPopScope alert = WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text("Verify Card"),
          content: Text(e.message),
          actions: [
            okButton,
          ],
        ),
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );

      print("--------------------------------------");
      print('Code => ${e.code}');
      print('Message: ${e.message}');
      print("--------------------------------------");
    }
    showProgress = false;
  }
}
