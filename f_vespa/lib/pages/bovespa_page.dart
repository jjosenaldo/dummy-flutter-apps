import 'dart:async';

import 'package:f_vespa/api/bovespa.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// const _smallFontSize = 25.0;
const _mediumFontSize = 40.0;
const _largeFontSize = 50.0;
const _kPrimaryTextColor = Colors.white;
final _baseTextStyle = TextStyle(
  color: _kPrimaryTextColor,
  fontFamily: 'Truculenta',
);
// final _smallTextStyle = _baseTextStyle.copyWith(fontSize: _smallFontSize);
final _mediumTextStyle = _baseTextStyle.copyWith(fontSize: _mediumFontSize);
final _largeTextStyle = _baseTextStyle.copyWith(fontSize: _largeFontSize);

class BovespaPage extends StatefulWidget {
  @override
  _BovespaPageState createState() => _BovespaPageState();
}

class _BovespaPageState extends State<BovespaPage>
    with SingleTickerProviderStateMixin {
  String? _symbol;
  StockPrice? _stockPrice;
  double? _lastDelta;
  final double triangleWidth = 25.0;
  final double triangleHeight = 25.0;
  late final AnimationController _controller;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer(String? symbol) {
    if (_timer?.isActive ?? false) {
      _timer!.cancel();
    }

    if (symbol != null) {
      _timer = Timer.periodic(Duration(seconds: 10), (timer) async {
        await _loadApiData(symbol);
      });
    }
  }

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
                  onChanged: (newSymbol) async {
                    _stockPrice = null;
                    _startTimer(newSymbol);

                    setState(() {
                      _symbol = newSymbol;
                    });

                    _controller.reset();
                    _controller.forward();
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
              Container(
                height: 200,
                child: AnimatedChange(
                  delta: _lastDelta,
                  positionController: _controller,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> _loadApiData(String symbol) async {
    final stockPrice = await BovespaApi.getStockPrice(symbol);

    if (stockPrice != null) {
      setState(() {
        _lastDelta =
            _stockPrice == null ? null : _stockPrice!.price - stockPrice.price;
        _stockPrice = stockPrice;
      });
    }
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

class AnimatedChange extends AnimatedWidget {
  AnimatedChange({
    Key? key,
    required this.delta,
    required this.positionController,
    this.triangleWidth = 25.0,
    this.triangleHeight = 25.0,
    this.animationLength = 200.0,
  }) : super(key: key, listenable: positionController);
  final double? delta;
  final double triangleWidth;
  final double triangleHeight;
  final Animation<double> positionController;
  final double animationLength;

  @override
  Widget build(BuildContext context) {
    final _currencyFormat = NumberFormat.simpleCurrency(
      locale: '${Localizations.localeOf(context)}',
      name: 'R\$',
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: (1 - positionController.value) * animationLength,
          child: Row(
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
                    type: delta == null || (delta != null && delta! >= 0)
                        ? TrianglePainterType.up
                        : TrianglePainterType.down,
                  ),
                ),
              ),
              Text(
                '${delta != null ? _currencyFormat.format(delta!.abs()) : '-'}',
                style: _mediumTextStyle,
              )
            ],
          ),
        ),
      ],
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
