import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MaterialApp inicializa corretamente', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: Text('TCMatcher'))));
    expect(find.text('TCMatcher'), findsOneWidget);
  });
}