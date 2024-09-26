import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lastest_broo/view/home.dart';

void main() {
  testWidgets('HomePage widget test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Directionality(
          textDirection: TextDirection.ltr,
          child: HomePage(),
        ),
      ),
    );

    // menguji cari title
    expect(find.text('Bang Udah Bang'), findsOneWidget);
    // Menguji mengetuk ikon pencarian
    final searchIconFinder = find.byIcon(Icons.search);
    if (searchIconFinder.evaluate().isNotEmpty) {
      await tester.tap(searchIconFinder.last);
      await tester.pump();

      expect(find.byType(TextField), findsOneWidget);
    }
    // Menguji mengetuk panah kembali
    final backArrowFinder = find.byType(GestureDetector);
    if (backArrowFinder.evaluate().isNotEmpty) {
      await tester.tap(backArrowFinder.first);
      await tester.pump();
    }
  });
}
