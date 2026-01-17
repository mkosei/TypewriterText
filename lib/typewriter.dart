import 'dart:async';
import 'package:flutter/material.dart';

class TypewriterText extends StatefulWidget {
  final String text;
  final Duration speed;
  final TextStyle? style;
  final VoidCallback? onComplete;
  final bool showCursor;
  final String cursorChar;
  final bool loop;

  const TypewriterText({
    super.key,
    required this.text,
    this.speed = const Duration(milliseconds: 100),
    this.style,
    this.onComplete,
    this.showCursor = true,
    this.cursorChar = "|",
    this.loop = false,
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {

  String _displayedText = "";
  late Timer _timer;
  int _index = 0;
  bool _cursorVisible = true;
  Timer? _cursorTimer;


  @override
  void initState() {
    super.initState();
    _startTyping();
    _startCursorBlink();
  }

  void _startTyping() {
    _displayedText = "";
    _index = 0;

    _timer = Timer.periodic(widget.speed, (timer) {
      if(_index < widget.text.length) {
        setState(() {
          _displayedText += widget.text[_index];
          _index++;
        });
      } else {
          _timer.cancel();
          if(widget.onComplete != null) widget.onComplete!();
          if(widget.loop) {
            Future.delayed(const Duration(seconds: 1), () {
              _startTyping();
            });
          }
      }
    }
    );
  }

  void _startCursorBlink() {
    _cursorTimer = Timer.periodic(const Duration( milliseconds: 500), (timer) {
      setState(() {
        _cursorVisible = !_cursorVisible;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _cursorTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayedText + (widget.showCursor && _cursorVisible ? widget.cursorChar : ""),
      style: widget.style,
    );
  }
}

