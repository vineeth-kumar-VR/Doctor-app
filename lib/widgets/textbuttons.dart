import 'package:flutter/material.dart';

class Textbuttons extends StatefulWidget {
  final String text;
  final VoidCallback onpressed;
  const Textbuttons({super.key,required this.text,required this.onpressed});

  @override
  State<Textbuttons> createState() => _TextbuttonsState();
}

class _TextbuttonsState extends State<Textbuttons> {
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: widget.onpressed, child: Text(widget.text));
  }
}
