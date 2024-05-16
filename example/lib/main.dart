import 'package:flutter/material.dart';
import 'package:markdown_editor_plus/markdown_editor_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = TextEditingController();
  bool _focused = false;

  @override
  void initState() {
    _controller.text = text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height - 320;
    final minHeight = _focused ? 320.0 + 45 + 6 : 320.0;
    var maxHeight = _focused ? height + 45 + 6 : height;
    if (maxHeight < minHeight) {
      maxHeight = minHeight;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: Column(
        children: [
          Container(
            height: 80,
            color: Colors.blue,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const TextField(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Switch(
                        value: _focused,
                        inactiveTrackColor: Colors.blue,
                        activeTrackColor: Colors.green,
                        activeColor: Colors.white,
                        trackOutlineColor: MaterialStateProperty.all(_focused ? Colors.green : Colors.blue),
                        trackOutlineWidth: MaterialStateProperty.all(10),
                        thumbIcon: MaterialStateProperty.all(Icon(
                          _focused ? Icons.edit : Icons.visibility,
                          color: _focused ? Colors.green : Colors.blue,
                        )),
                        onChanged: (value) => setState(() => _focused = value),
                      ),
                    ],
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: minHeight,
                      maxHeight: maxHeight,
                    ),
                    child: MarkdownAutoPreview(
                      expands: true,
                      enableToolBar: _focused,
                      focused: _focused,
                      toolbarGap: 6,
                      showPreviewButton: false,
                      showClearButton: false,
                      showResetButton: false,
                      showSelectSingleLine: false,
                      showEmojiSelection: false,
                      showLinkInput: false,
                      showImageInput: false,
                      enableOnTapFocus: false,
                      onFocusChanged: (value) => setState(() => _focused = value),
                      previewPadding: const EdgeInsets.all(12),
                      previewDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.grey),
                      ),
                      toolbarDecoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      decoration: const InputDecoration(
                        isDense: false,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const text = """
# Markdown Editor Plus

This is a fork of [simple_markdown_editor by zahnia88](https://github.com/zahniar88/simple_markdown_editor)
with contributions from [fossfreaks](https://github.com/fossfreaks)

Simple markdown editor library For flutter. 
For demo video, you can see it at this url [Demo](https://youtu.be/aYBeXXDoNPo)


## Features
- ✅ Convert to Bold, Italic, Strikethrough
- ✅ Convert to Code, Quote, Links
- ✅ Convert to Heading (H1, H2, H3).
- ✅ Convert to unorder list and checkbox list
- ✅ Support multiline convert
- ✅ Support auto convert emoji

## Usage

Add dependencies to your `pubspec.yaml`

```yaml
dependencies:
    markdown_editor_plus: ^latest
```

Run `flutter pub get` to install.

## How it works

Import library

```dart
import 'package:markdown_editor_plus/markdown_editor_plus.dart';
```

Initialize controller and focus node. These controllers and focus nodes are optional because if you don't create them, the editor will create them themselves

```dart
TextEditingController _controller = TextEditingController();
```

Show widget for editor

```dart
// editable text with toolbar by default
MarkdownAutoPreview(
    controller: _controller,
    emojiConvert: true,
)

// editable text without toolbar
MarkdownField(
    controller: _controller,
    emojiConvert: true,
    enableToolBar: false,
)
```

if you want to parse text into markdown you can use the following widget:

```dart
String data = '''
**bold**
*italic*

#hashtag
@mention
'''

MarkdownParse(
    data: data,
    onTapHastag: (String name, String match) {
        // name => hashtag
        // match => #hashtag
    },
    onTapMention: (String name, String match) {
        // name => mention
        // match => #mention
    },
)
```

In order to set the colors

```dart
MarkdownAutoPreview(
    controller: _controller,
    enableToolBar: true,
    emojiConvert: true,
    autoCloseAfterSelectEmoji: false,
    // toolbar's background color, text color will be based on theme
    toolbarBackground: Colors.blue,
    // toolbar's expandable widget colors like headings, ordering
    expandableBackground: Colors.blue[200],
)
```

___

""";
