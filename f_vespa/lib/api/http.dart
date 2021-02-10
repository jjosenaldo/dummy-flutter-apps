import 'dart:convert';

import 'package:http/http.dart' as http;

const _apiKey = '';
const _kBaseUrl = 'api.hgbrasil.com';

String _buildStockPriceRequestPath(String symbol) =>
    'finance/stock_price?key=$_apiKey&symbol=$symbol';

Future<Map<String, dynamic>> getStockPriceJson(String symbol) async {
  String path = _buildStockPriceRequestPath(symbol);
  final response = await http.get(Uri.https(_kBaseUrl, path));

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    return {};
  }
}
