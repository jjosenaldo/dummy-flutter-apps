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
  bool _isLoadingApiData = false;
  StockPrice? _stockPrice;

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
                onChanged: _isLoadingApiData
                    ? (_) {}
                    : (newSymbol) {
                        setState(() => _symbol = newSymbol);
                        _loadApiData(_symbol!);
                      },
                dropdownColor: Colors.black45,
                style: _kDefaultTextStyle,
                value: _symbol,
              ),
              if (_stockPrice != null)
                Text(
                  '${_stockPrice!.name}: ${_stockPrice!.price}',
                  style: _kDefaultTextStyle,
                )
            ],
          )
        ],
      ),
    );
  }

  Future<void> _loadApiData(String symbol) async {
    setState(() => _isLoadingApiData = true);
    final stockPrice = await BovespaApi.getStockPrice(symbol);
    setState(() {
      _isLoadingApiData = false;
      _stockPrice = stockPrice;
    });
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
