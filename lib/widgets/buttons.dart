import 'package:doctorapp/colors/color.dart';
import 'package:flutter/material.dart';

class ButtonsField extends StatefulWidget {
  final String text;
  final VoidCallback onpressed;
  const ButtonsField({super.key,required this.text, required this.onpressed});

  @override
  State<ButtonsField> createState() => _ButtonsFieldState();
}

class _ButtonsFieldState extends State<ButtonsField> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(8),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10)
      ),
      height: 50,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              backgroundColor: buttoncolor),
          onPressed: widget.onpressed, child: Center(child: Text(widget.text,style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),)),
    ),
    );
  }
}
