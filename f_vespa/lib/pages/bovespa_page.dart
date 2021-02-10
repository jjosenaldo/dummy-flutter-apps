import 'package:flutter/material.dart';

class BovespaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: Text('eita kkk')),
          ],
        )
      ],
    );
  }
}
