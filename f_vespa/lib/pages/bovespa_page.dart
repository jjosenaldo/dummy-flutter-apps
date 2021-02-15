import 'dart:async';
import 'dart:math';

import 'package:f_vespa/api/bovespa.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const _smallFontSize = 25.0;
const _mediumFontSize = 40.0;
const _largeFontSize = 60.0;
const _kPrimaryTextColor = Colors.white;
final _baseTextStyle = TextStyle(
  color: _kPrimaryTextColor,
  fontFamily: 'Truculenta',
);
final _smallTextStyle = _baseTextStyle.copyWith(fontSize: _smallFontSize);
final _mediumTextStyle = _baseTextStyle.copyWith(fontSize: _mediumFontSize);
final _largeTextStyle = _baseTextStyle.copyWith(fontSize: _largeFontSize);

NumberFormat currencyFormatBuilder(BuildContext context) =>
    NumberFormat.simpleCurrency(
      locale: '${Localizations.localeOf(context)}',
      name: 'R\$',
    );

class BovespaPage extends StatefulWidget {
  const BovespaPage({Key? key, this.inTestMode = false}) : super(key: key);

  final bool inTestMode;

  @override
  _BovespaPageState createState() => _BovespaPageState();
}

class _BovespaPageState extends State<BovespaPage>
    with SingleTickerProviderStateMixin {
  String? _symbol;
  StockPrice? _stockPrice;
  double? _delta;
  final double triangleWidth = 25.0;
  final double triangleHeight = 25.0;
  late final AnimationController _controller;
  Timer? _timer;
  bool _firstLoading = false;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _startTimer(String? symbol) async {
    if (_timer?.isActive ?? false) {
      _timer!.cancel();
    }

    if (symbol != null) {
      await _loadApiData(symbol);
      _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
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
              _symbolsDropdown(),
              if (_stockPrice?.price != null)
                Center(
                  child: Text(
                    currencyFormatBuilder(context).format(_stockPrice!.price),
                    style: _largeTextStyle,
                  ),
                ),
              SizedBox(height: 10),
              Container(
                height: 200,
                child: AnimatedChange(
                  delta: _delta,
                  positionController: _controller,
                  animationLength: 100,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> _loadApiData(String symbol) async {
    debugPrint('loading API data...');
    late final stockPrice;

    if (widget.inTestMode) {
      stockPrice =
          await Future.delayed(Duration(milliseconds: 1500)).then<StockPrice>(
        (_) => StockPrice(
          lastUpdate: DateTime.now(),
          name: 'test_symbol',
          price: (Random().nextInt(4) - 2),
        ),
      );
    } else {
      stockPrice = await BovespaApi.getStockPrice(symbol);
    }

    debugPrint('API data loaded.');

    if (stockPrice != null) {
      late final newDelta;

      if (_stockPrice == null) {
        newDelta = null;
      } else {
        final double actualDelta = stockPrice.price - _stockPrice!.price;
        newDelta = actualDelta != 0 ? actualDelta : null;
      }

      setState(() {
        _delta = newDelta;

        if (_delta != null) {
          _controller.reset();
          _controller.forward();
        }
        _stockPrice = stockPrice;
      });
    }
  }

  Widget _symbolsDropdown() => _firstLoading
      ? Center(
          child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ))
      : Center(
          child: DropdownButton<String>(
            items: availableSymbols.map(_dropdownMenuItem).toList(),
            onChanged: (newSymbol) async {
              setState(() {
                _firstLoading = true;
              });
              _stockPrice = null;
              await _startTimer(newSymbol);

              setState(() {
                _symbol = newSymbol;
                _firstLoading = false;
              });
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
        );

  DropdownMenuItem<String> _dropdownMenuItem(String symbol) {
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
    this.triangleWidth = 15.0,
    this.triangleHeight = 15.0,
    this.animationLength = 200.0,
  }) : super(key: key, listenable: positionController);
  final double? delta;
  final double triangleWidth;
  final double triangleHeight;
  final Animation<double> positionController;
  final double animationLength;

  @override
  Widget build(BuildContext context) {
    final _currencyFormat = currencyFormatBuilder(context);

    return delta == null
        ? Text('-')
        : Stack(
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
                    SizedBox(width: 10),
                    Text(
                      '${_currencyFormat.format(delta!.abs())}',
                      style: _smallTextStyle,
                    ),
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
