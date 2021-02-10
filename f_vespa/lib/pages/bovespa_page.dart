import 'package:f_vespa/api/bovespa.dart';
import 'package:flutter/material.dart';

const _kPrimaryColor = Colors.white;
const _kDefaultTextStyle = TextStyle(color: _kPrimaryColor);

class BovespaPage extends StatefulWidget {
  @override
  _BovespaPageState createState() => _BovespaPageState();
}

class _BovespaPageState extends State<BovespaPage> {
  String? _symbol;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Positioned.fill(
          //   child: ColorFiltered(
          //     colorFilter: ColorFilter.mode(
          //         Colors.white.withOpacity(0.8), BlendMode.luminosity),
          //     child: Image.asset(
          //       'assets/stock_prices.jpg',
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Text('eita kkk')),
              DropdownButton<String>(
                items: availableSymbols.map(buildDropdownMenuItem).toList(),
                onChanged: (newSymbol) => setState(() => _symbol = newSymbol),
                dropdownColor: Colors.black45,
                style: _kDefaultTextStyle,
                value: _symbol,
              ),
            ],
          )
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildDropdownMenuItem(String symbol) {
    return DropdownMenuItem(
      child: Text(
        symbol,
        style: _kDefaultTextStyle,
      ),
      value: symbol,
    );
  }
}
