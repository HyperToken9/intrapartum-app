
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumericInputField extends StatefulWidget {
  final bool isInteger;
  final double minValue;
  final double maxValue;
  final double defaultValue;
  final TextEditingController textController;
  NumericInputField({
    super.key,
    required this.minValue,
    required this.maxValue,
    required this.defaultValue,
    required this.textController,
    this.isInteger = true
  });

  @override
  _NumericInputFieldState createState() => _NumericInputFieldState();
}

class _NumericInputFieldState extends State<NumericInputField> {
  late double _counter; // Default value
  late final double _minValue;
  late final double _maxValue;
  @override
  void initState() {
    super.initState();
    _counter = widget.defaultValue;
    _minValue = widget.minValue;
    _maxValue = widget.maxValue;
    // Ensure the default value is within the range
    if (_counter < _minValue) _counter = _minValue;
    if (_counter > _maxValue) _counter = _maxValue;
    widget.textController.text = _formatCounter();
  }

  String _formatCounter() {
    return widget.isInteger ? _counter.toInt().toString() : _counter.toStringAsFixed(1);
  }

  void _updateCounter(double change) {
    setState(() {
      _counter += change;
      if (_counter < _minValue) _counter = _minValue;
      if (_counter > _maxValue) _counter = _maxValue;
      widget.textController.text = _formatCounter();
    });
  }

  void _incrementCounter() {
    if (widget.isInteger){
      _updateCounter(1);
    }else{
      _updateCounter(0.1);
    }
    
  }

  void _decrementCounter() {
    if (widget.isInteger){
      _updateCounter(-1);
    }else{
      _updateCounter(-0.1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        onHorizontalDragUpdate: (DragUpdateDetails details) {
          if (details.primaryDelta! < 0) {
            _decrementCounter();
          } else {
            _incrementCounter();
          }
        },
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextField(
                  controller: widget.textController,
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: !widget.isInteger,
                    signed: false,
                  ),
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.top,
                  onTapOutside: (_) {
                    FocusScope.of(context).unfocus();
                  },
                  // showCursor: false,
                  enableInteractiveSelection: false,
                  style: const TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF7469B6)),
                    ),
                    contentPadding: EdgeInsets.only(bottom: 1.0),
                  ),
                  inputFormatters: widget.isInteger
                      ? <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ]
                      : <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  onSubmitted: (value) {
                    setState(() {
                      double newValue = double.tryParse(value) ?? _minValue;
                      if (newValue < _minValue) newValue = _minValue;
                      if (newValue > _maxValue) newValue = _maxValue;
                      _counter = newValue;
                      widget.textController.text = _formatCounter();
                    });
                  },
                ),
              ),
              Positioned(
                left: 5,
                child: IconButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(const Color(0x73AD88C6)),
                    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
                    minimumSize: WidgetStateProperty.all<Size>(Size.zero),
                    tapTargetSize: MaterialTapTargetSize.padded,
                    shape: WidgetStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                    ),
                  ),
                  icon: const Icon(Icons.remove),
                  onPressed: _decrementCounter,
                ),
              ),
              Positioned(
                right: 5,
                child: IconButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(const Color(0x73AD88C6)),
                    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
                    minimumSize: WidgetStateProperty.all<Size>(Size.zero),
                    // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    //Inflate the tap target size to make it easier to tap
                    tapTargetSize: MaterialTapTargetSize.padded,
                    shape: WidgetStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                    ),
                  ),
                  icon: const Icon(Icons.add),
                  onPressed: _incrementCounter,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}