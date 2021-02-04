import 'package:flutter/material.dart';

const int kMaxPeople = 20;

void main() {
  runApp(
    MaterialApp(
      home: CountPage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class CountPage extends StatefulWidget {
  @override
  _CountPageState createState() => _CountPageState();
}

String getPlacesAvailability(int peopleCount, int maxPeople) {
  assert(peopleCount >= 0);

  return peopleCount < maxPeople ? 'Pode entrar!' : 'Tá cheio!';
}

class _CountPageState extends State<CountPage> {
  final TextStyle _baseTextStyle = TextStyle(color: Colors.white);
  int _peopleCount = 0;

  void _incrementPeopleCount() {
    if (_peopleCount < kMaxPeople) {
      setState(() {
        ++_peopleCount;
      });
    }
  }

  void _decrementPeopleCount() {
    if (_peopleCount > 0) {
      setState(() {
        --_peopleCount;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Image.asset(
            'assets/images/restaurant.jpg',
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Pessoas: $_peopleCount',
                style: _baseTextStyle,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: _decrementPeopleCount,
                    child: Text(
                      '-1',
                      style: _baseTextStyle.copyWith(fontSize: 25),
                    ),
                  ),
                  TextButton(
                    onPressed: _incrementPeopleCount,
                    child: Text(
                      '+1',
                      style: _baseTextStyle.copyWith(fontSize: 25),
                    ),
                  )
                ],
              ),
              Text(
                getPlacesAvailability(_peopleCount, kMaxPeople),
                style: _baseTextStyle.copyWith(
                  fontStyle: FontStyle.italic,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
