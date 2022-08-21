import 'package:flutter/material.dart';

class AnimeTextField extends StatefulWidget {
  bool? filled = true;
  double? borderRadius;
  String? hintText;
  Icon? prefixIcon;
  Widget? suffixIcon;
  bool? isObscure;
  TextEditingController? controller;

  AnimeTextField(
      {Key? key,
      this.hintText,
      this.filled,
      this.borderRadius,
      this.prefixIcon,
      this.suffixIcon,
      this.isObscure,
      required this.controller})
      : super(key: key);

  @override
  State<AnimeTextField> createState() => _AnimeTextFieldState();
}

class _AnimeTextFieldState extends State<AnimeTextField> {
  final _focusNode = FocusNode();
  bool _isObscure = false;
  _focusListner() {
    setState(() {});
  }

  @override
  void initState() {
    _focusNode.addListener(_focusListner);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusListner);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _isObscure,
      focusNode: _focusNode,
      decoration: InputDecoration(
          hintText: widget.hintText!,
          filled: widget.filled!,
          fillColor: _focusNode.hasFocus
              ? const Color.fromARGB(27, 67, 160, 72)
              : Colors.black45,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.isObscure ?? false
              ? IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                )
              : null,
          border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(widget.borderRadius!)))),
    );
  }
}
