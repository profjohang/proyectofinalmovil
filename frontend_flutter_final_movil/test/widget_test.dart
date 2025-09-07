import 'package:flutter_test/flutter_test.dart';
import 'package:frontend_flutter_final_movil/main.dart';
import 'package:frontend_flutter_final_movil/pages/splash_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('La app se construye y muestra SplashPage', (WidgetTester tester) async {
    // Construir la app sin ejecutar fetchAll
    await tester.pumpWidget(FinalApiApp(enableAutoFetch: false));

    // Esperar a que se construya la UI inicial
    await tester.pumpAndSettle(const Duration(milliseconds: 500));

    // Verificar que se cargue la SplashPage
    expect(find.byType(SplashPage), findsOneWidget);

    // También puedes validar que el texto definido en tu SplashPage aparezca
    expect(find.text('Final API App'), findsOneWidget);
  });
}
