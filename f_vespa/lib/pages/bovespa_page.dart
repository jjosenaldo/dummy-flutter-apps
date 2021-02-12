import 'package:f_vespa/api/bovespa.dart';
import 'package:flutter/material.dart';

const _smallFontSize = 25.0;
const _mediumFontSize = 40.0;
const _largeFontSize = 50.0;
const _kPrimaryTextColor = Colors.white;
final _baseTextStyle = TextStyle(
  color: _kPrimaryTextColor,
  fontFamily: 'Truculenta',
);
final _smallTextStyle = _baseTextStyle.copyWith(fontSize: _smallFontSize);
final _mediumTextStyle = _baseTextStyle.copyWith(fontSize: _mediumFontSize);
final _largeTextStyle = _baseTextStyle.copyWith(fontSize: _largeFontSize);

class BovespaPage extends StatefulWidget {
  @override
  _BovespaPageState createState() => _BovespaPageState();
}

class _BovespaPageState extends State<BovespaPage> {
  String? _symbol;
  bool _isLoadingApiData = false;
  StockPrice? _stockPrice;
  double? _lastPrice;
  final double triangleWidth = 25.0;
  final double triangleHeight = 25.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3), BlendMode.dstATop),
              child: Image.asset(
                'assets/stock_prices.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: DropdownButton<String>(
                  items: availableSymbols.map(buildDropdownMenuItem).toList(),
                  onChanged: _isLoadingApiData
                      ? (_) {}
                      : (newSymbol) {
                          setState(() => _symbol = newSymbol);
                          _loadApiData(_symbol!);
                        },
                  iconEnabledColor: Colors.white,
                  dropdownColor: Colors.black,
                  hint: Text(
                    'Símbolo',
                    style: _mediumTextStyle,
                  ),
                  style: _largeTextStyle,
                  value: _symbol,
                  isDense: true,
                  iconSize: 50,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: triangleWidth,
                    height: triangleHeight,
                    child: CustomPaint(
                      painter: TrianglePainter(
                        width: triangleWidth,
                        height: triangleHeight,
                        type: 1 > 10
                            ? TrianglePainterType.up
                            : TrianglePainterType.down,
                      ),
                    ),
                  ),
                  Text(
                    'R\$52,00',
                    style: _mediumTextStyle,
                  )
                ],
              ),
              if (_stockPrice != null)
                Column(
                  children: [
                    Text(
                      '${_stockPrice!.name}: ${_stockPrice!.price}',
                      style: _mediumTextStyle,
                    ),
                    if (_lastPrice != null && _stockPrice != null)
                      if (_lastPrice != _stockPrice!.price)
                        CustomPaint(
                          painter: TrianglePainter(
                            width: triangleWidth,
                            height: triangleHeight,
                            type: _lastPrice! > _stockPrice!.price
                                ? TrianglePainterType.up
                                : TrianglePainterType.down,
                          ),
                        )
                  ],
                ),
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
        style: _mediumTextStyle,
      ),
      value: symbol,
    );
  }
}

enum TrianglePainterType {
  up,
  down,
}

class TrianglePainter extends CustomPainter {
  TrianglePainter({
    required this.width,
    required this.height,
    required this.type,
  });

  final TrianglePainterType type;
  final double width;
  final double height;

  @override
  void paint(Canvas canvas, Size size) {
    final color = type == TrianglePainterType.up ? Colors.green : Colors.red;
    final paint = Paint()..color = color;
    final path = _trianglePath(width, height, type == TrianglePainterType.up);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  Path _trianglePath(double width, double height, bool isUp) {
    return isUp
        ? (Path()
          ..moveTo(0, height)
          ..lineTo(width, height)
          ..lineTo(width / 2, 0)
          ..lineTo(0, height))
        : (Path()
          ..moveTo(0, 0)
          ..lineTo(width, 0)
          ..lineTo(width / 2, height)
          ..lineTo(0, 0));
  }
}
