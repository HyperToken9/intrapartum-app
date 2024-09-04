
import 'package:flutter/material.dart';
import 'package:implementation/components/info_card.dart';


class FormLabel extends StatelessWidget {

  final String label;
  final String unitLabel;
  final List<String> infoText;
  const FormLabel({
    super.key,
    required this.label,
    required this.infoText,
    this.unitLabel = ""});


  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // Dismiss when clicking outside
      builder: (BuildContext context) {
        return InfoCard(
          title: label,
          content: infoText,
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, bottom: 5, top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(

              TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: label.toUpperCase(),
                    style: const TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'OpenSansCondensed'
                    ),
                  ),
                  if (unitLabel.isNotEmpty)
                    TextSpan(
                      text: " [$unitLabel]",
                      style: const TextStyle(
                          color: Color(0xFF6B368D),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'OpenSansCondensed'
                      ),
                    ),
                ],
              )
          ),
          /* Info Icon as a button */
          TextButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
                minimumSize: WidgetStateProperty.all<Size>(Size.zero),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: (){
                _showPopup(context);
              },
              child: const Icon(
                Icons.info_outline_rounded,
                color: Color(0xFF000000),
                size: 15,
              )
          )
        ],
      ),
    );
  }
}
