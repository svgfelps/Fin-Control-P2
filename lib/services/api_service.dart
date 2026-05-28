import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyQuote {
  final String name;
  final String code;
  final double bid;
  final double high;
  final double low;
  final String pctChange;
  final String date;

  CurrencyQuote({
    required this.name,
    required this.code,
    required this.bid,
    required this.high,
    required this.low,
    required this.pctChange,
    required this.date,
  });

  factory CurrencyQuote.fromJson(Map<String, dynamic> json) {
    return CurrencyQuote(
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      bid: double.parse(json['bid']),
      high: double.parse(json['high']),
      low: double.parse(json['low']),
      pctChange: json['pctChange'] ?? '0',
      date: json['create_date'] ?? '',
    );
  }
}

class ApiService {
  Future<List<CurrencyQuote>> getCurrencyQuotes() async {
    final url = Uri.parse(
      'https://economia.awesomeapi.com.br/json/last/USD-BRL,EUR-BRL,BTC-BRL',
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Erro ao carregar cotações');
    }

    final data = jsonDecode(response.body);

    return [
      CurrencyQuote.fromJson(data['USDBRL']),
      CurrencyQuote.fromJson(data['EURBRL']),
      CurrencyQuote.fromJson(data['BTCBRL']),
    ];
  }
}