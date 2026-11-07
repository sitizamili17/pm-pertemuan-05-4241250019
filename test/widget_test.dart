import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pm_tugas_05_4241250019/main.dart';

void main() {
  testWidgets('Tombol favorit mengubah ikon setelah ditekan', (tester) async {
    await tester.pumpWidget(const UmkmApp());

    // Awalnya semua menu belum favorit.
    expect(
      find.byIcon(Icons.favorite_border),
      findsNWidgets(daftarMenu.length),
    );
    expect(find.byIcon(Icons.favorite), findsNothing);

    // Tekan tombol favorit menu pertama.
    final tombol = find.byIcon(Icons.favorite_border).first;
    await tester.ensureVisible(tombol);
    await tester.pumpAndSettle();
    await tester.tap(tombol);
    await tester.pump();

    // Satu ikon berubah jadi hati penuh, SnackBar muncul.
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(
      find.byIcon(Icons.favorite_border),
      findsNWidgets(daftarMenu.length - 1),
    );
    expect(find.byType(SnackBar), findsOneWidget);
  });
}