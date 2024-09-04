
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final List<String> content;

  const InfoCard({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: const Color(0xFFFFEEF7),
      title: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: Color(0xFF493655),
          fontSize: 24,
          fontWeight: FontWeight.w800,
          fontFamily: 'OpenSansCondensed',
        ),
      ),
      content: Container(
        constraints: const BoxConstraints(maxHeight: 300),
        child: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              ...content.map((String text) => Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: (
                  Text(
                    text.toUpperCase(),
                    style: const TextStyle(
                      color: Color(0xFF664857),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'OpenSans',
                    ),
                  )
                ),
              )),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}