import 'package:flutter/material.dart';
import 'package:xml/xml.dart';
import 'package:http/http.dart' as http;


class Flag extends StatefulWidget {
  const Flag({super.key});

  @override
  State<Flag> createState() => _FlagState();
}

Future<String> fetchFlag() async {
  final response = await http.get(Uri.parse('http://m.cucbc.org/'));
  final document = XmlDocument.parse(response.body);
  print(document);
  return "String";
}

class _FlagState extends State<Flag> {
  late Future<String> flag;
  int _count = 0;

  @override
  void initState() {
    super.initState();
    flag = fetchFlag();
  }

  Widget build(BuildContext context) {
    fetchFlag();
    return Container();
  }
}