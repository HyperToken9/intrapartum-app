import 'package:flutter/material.dart';

class DropdownInputField extends StatefulWidget {

  final List<List<String>> items;
  // final double width;
  final String defaultValue;
  String? selectedItem;
  final Function(String?) onChange;
  DropdownInputField({
    super.key,
    required this.items,
    required this.defaultValue,
    required this.onChange,
  }){
    selectedItem = defaultValue;
  }

  @override
  State<DropdownInputField> createState() => _DropdownInputFieldState();
}

class _DropdownInputFieldState extends State<DropdownInputField> {
  @override
  void initState() {
    super.initState();
    if (widget.defaultValue != null && widget.items.any((element) => element.contains(widget.defaultValue))) {
      widget.selectedItem = widget.defaultValue;
      widget.onChange(widget.selectedItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: widget.width
      width: 200,
      height: 45,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: DropdownButtonFormField<String>(
        value: widget.selectedItem,
        isExpanded: true,
        borderRadius: BorderRadius.circular(5.0),
        items: widget.items.map((List<String> value) {
          return DropdownMenuItem<String>(
            value: value[1],
            child: Text(value[0].toUpperCase()),
          );
        }).toList(),
        style: const TextStyle(
          color: Color(0xFF000000),
          fontSize: 20,
          fontWeight: FontWeight.w700,
          fontFamily: 'OpenSans',
        ),
        decoration: const InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF7469B6)),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
        ),
        onChanged: (String? newValue) {
          setState(() {
            widget.selectedItem = newValue;
            widget.onChange(widget.selectedItem);
          });
        },
        selectedItemBuilder: (BuildContext context) {
          return widget.items.map((List<String> value) {
            return Align(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  widget.selectedItem == value[1] ? value[1].toUpperCase() :
                  value[0].toUpperCase(),
                ),
              ),
            );
          }).toList();
        },
      ),
    );
  }
}