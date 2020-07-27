import 'package:braspag_verify_card_dart/verifycard.dart';
import 'package:flutter/material.dart';

class ResponsePage extends StatelessWidget {
  VerifyCardResponse response;

  ResponsePage({this.response});

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
                          Text('Status => : ${response.status}'),
                          Text(
                              'Provider Return Code => : ${response.providerReturnCode}'),
                          Text(
                              'Provider Return Message => : ${response.providerReturnMessage}'),
                          Text('  Provider => : ${response.binData.provider}'),
                          Text('  Card Type => : ${response.binData.cardType}'),
                          Text(
                              '  ForeignCard => : ${response.binData.foreignCard}'),
                          Text('  Code => : ${response.binData.code}'),
                          Text('  Message => : ${response.binData.message}'),
                          Text(
                              '  Corporate Card => : ${response.binData.corporateCard}'),
                          Text('  Issuer => : ${response.binData.issuer}'),
                          Text(
                              '  IssuerCode => : ${response.binData.issuerCode}'),
                          Text('  Card Bin => : ${response.binData.cardBin}'),
                          Text(
                              '  CardLast4Digits => : ${response.binData.cardLast4Digits}'),
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
}
