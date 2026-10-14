import 'package:doctorapp/colors/color.dart';
import 'package:doctorapp/icons/icons.dart';
import 'package:flutter/material.dart';

class TextInputField extends StatefulWidget {
  final String hinttext;
  final IconData? prefixicon;
  final TextEditingController controller;
  final Function(String)? onchanged;
  final bool obsecure;
  const TextInputField({super.key,required this.hinttext,required this.prefixicon,required this.controller, required this.onchanged,

  this.obsecure = false
  });

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextField(

        onChanged: widget.onchanged,
controller: widget.controller,
        obscureText: widget.obsecure && hidePassword,
        decoration: InputDecoration(

          hintStyle: TextStyle(color: Colors.blue),
          hintText: widget.hinttext,
prefixIcon: widget.prefixicon == null ? null:Icon(widget.prefixicon),
            suffixIcon: widget.obsecure
                ? IconButton(
              onPressed: () {
                setState(() {
                  hidePassword = !hidePassword;
                });
              },
              icon: Icon(
                hidePassword
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.blue,
              ),
            )
                : null,
          filled: true,
          fillColor: Theme.of(context).scaffoldBackgroundColor,
iconColor: Colors.blue,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue),

          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFF3498DB))
          )
        ),
      ),
    );
  }
}
