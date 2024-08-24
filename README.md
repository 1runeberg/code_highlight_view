# code_highlight_view

Code syntax highlighter for Flutter. 
This project was forked from: https://git-touch.github.io/highlight/ 

Main impetus to publish this is to update the (abandoned?) original project to Dart 3.x, add text selection capabilities and some perf improvements.

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var code = '''main() {
  print("Hello, World!");
}
''';

    return CodeHighlightView(
      // The original code to be highlighted
      code,

      // Specify language
      // It is recommended to give it a value for performance
      language: 'dart',

      // Make text selectable (defaults to true)
      isSelectable: true, 

      // Specify highlight theme
      // All available themes are listed in `themes` folder
      theme: githubTheme,

      // Specify padding
      padding: EdgeInsets.all(12),

      // Specify text style
      textStyle: TextStyle(
        fontFamily: 'My awesome monospace font',
        fontSize: 16,
      ),
    );
  }
}
```

## References

- [All available languages](https://github.com/git-touch/highlight.dart/tree/master/highlight/lib/languages)
- [All available themes](https://github.com/1runeberg/code_highlight_view/tree/main/lib/themes)

## License

MIT
