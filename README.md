# TypewriterText

A Flutter widget package for displaying simple typewriter (typing) animations.  
This MVP version includes cursor blinking and replay (loop) functionality.

---

## Features

- Display text **one character at a time**
- Configurable typing **speed** (in milliseconds)
- **Callback** when typing is complete
- Cursor display (blinking vertical bar `|` or underscore `_`)
- Supports **multi-line text** (`\n`)
- **Replay / loop** functionality

---

## Installation

For local use:

```yaml
dependencies:
  typewriter:
    path: ../typewriter
```
## Usage

### Import the package:
```dart
import 'package:typewriter/typewriter.dart';
```

### Example:
```dart
import 'package:flutter/material.dart';
import 'package:typewriter/typewriter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Typewriter Demo')),
        body: const Center(
          child: TypewriterText(
            text: "Hello!\nTypewriter animation in Flutter",
            speed: Duration(milliseconds: 80),
            showCursor: true,
            cursorChar: "|",
            loop: true,
            style: TextStyle(fontSize: 24, color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
```

## Explanation of Example:

- text → The string to type out. Supports multi-line with \n.

- speed → Duration between each character.

- showCursor → Whether to display a blinking cursor.

- cursorChar → Character used for the cursor (default "|").

- loop → If true, the typing animation will repeat after completion.

- style → Text style (color, font size, etc.).

- onComplete → Optional callback when typing finishes.

## Constructor Options
Parameter	Type	Default	Description
text	String	—	The text to display
speed	Duration	100ms	Interval between each character
style	TextStyle?	null	Text style
onComplete	VoidCallback?	null	Callback called when typing completes
showCursor	bool	true	Whether to show a blinking cursor
cursorChar	String	`"	"`
loop	bool	false	Replay the typing animation after completion

## Testing
```bash
flutter test
```

### Tests included:

- Text is displayed one character at a time

- onComplete callback is called

- Cursor blinking works correctly

- Loop / replay functionality works