import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:typewriter/typewriter.dart'; // 自作パッケージをインポート

void main() {
  testWidgets('文字列が1文字ずつ表示される', (WidgetTester tester) async {
    const testText = "Hi";

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TypewriterText(
            text: testText,
            speed: Duration(milliseconds: 10),
            showCursor: false, // カーソルは無視
          ),
        ),
      ),
    );

    // 初期状態は空文字
    expect(find.text(''), findsOneWidget);

    // 10ms 経過で 'H' が表示される
    await tester.pump(Duration(milliseconds: 10));
    expect(find.text('H'), findsOneWidget);

    // さらに10ms 経過で 'Hi' が表示される
    await tester.pump(Duration(milliseconds: 10));
    expect(find.text('Hi'), findsOneWidget);
  });

  testWidgets('onComplete コールバックが呼ばれる', (WidgetTester tester) async {
    bool completed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TypewriterText(
            text: "Hello",
            speed: Duration(milliseconds: 10),
            onComplete: () {
              completed = true;
            },
          ),
        ),
      ),
    );

    // アニメーションが完了するまで待つ
    await tester.pumpAndSettle();

    // コールバックが呼ばれたか確認
    expect(completed, isTrue);
  });

  testWidgets('カーソルが点滅する', (WidgetTester tester) async {
    const testText = "Hi";

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TypewriterText(
            text: testText,
            speed: Duration(milliseconds: 10),
            showCursor: true,
            cursorChar: "|",
          ),
        ),
      ),
    );

    // タイピング完了まで待つ
    await tester.pumpAndSettle();

    // 文字列 + カーソル表示
    final textFinder = find.byType(Text);
    expect(textFinder, findsOneWidget);

    // 点滅確認（カーソルは切り替わるので文字列は変わる）
    final textWidget1 = tester.widget<Text>(textFinder).data!;
    await tester.pump(Duration(milliseconds: 500)); // カーソル切替
    final textWidget2 = tester.widget<Text>(textFinder).data!;
    expect(textWidget1 != textWidget2, isTrue);
  });

  testWidgets('リプレイ機能で文字列が再度タイピングされる', (WidgetTester tester) async {
    int completeCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TypewriterText(
            text: "Hi",
            speed: Duration(milliseconds: 10),
            loop: true,
            onComplete: () {
              completeCount++;
            },
          ),
        ),
      ),
    );

    // 最初のタイピング完了
    await tester.pumpAndSettle();
    expect(completeCount, 1);

    // リプレイ完了まで待つ（少し余裕を持たせる）
    await tester.pump(Duration(milliseconds: 20 + 1000)); // 文字タイピング + loop delay
    await tester.pumpAndSettle();

    // 2回目の完了が呼ばれる
    expect(completeCount, greaterThanOrEqualTo(2));
  });
}
