import 'package:flutter/material.dart';

/// ThemedText - A chainable text styling widget
/// Usage: "Hello".titleM.bold.color(Colors.red)
class ThemedText extends StatelessWidget {
  const ThemedText({
    super.key,
    required this.data,
    this.style,
    this.extra,
  });

  final String data;
  final TextStyle Function(TextTheme)? style;
  final Map<String, dynamic>? extra;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style?.call(Theme.of(context).textTheme),
      overflow: extra?['overflow'],
      maxLines: extra?['maxLine'],
      softWrap: extra?['softWrap'],
      textAlign: extra?['textAlign'],
    );
  }
}
