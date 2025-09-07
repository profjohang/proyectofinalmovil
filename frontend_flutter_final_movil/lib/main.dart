// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend_flutter_final_movil/providers/product_provider.dart';
import 'package:frontend_flutter_final_movil/pages/splash_page.dart';
import 'package:frontend_flutter_final_movil/pages/home_page.dart';
import 'package:frontend_flutter_final_movil/pages/detail_page.dart';
import 'package:frontend_flutter_final_movil/pages/edit_page.dart';

void main() {
  runApp(const FinalApiApp());
}

class FinalApiApp extends StatelessWidget {
  final bool enableAutoFetch;

  const FinalApiApp({
    super.key,
    this.enableAutoFetch = true, // 👈 ya no es required, tiene valor por defecto
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (_) {
            final provider = ProductProvider();
            if (enableAutoFetch) {
              provider.fetchAll();
            }
            return provider;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Final API App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: Colors.green,
          brightness: Brightness.light,
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => const SplashPage(),
          '/home': (_) => const HomePage(),
          '/detail': (_) => const DetailPage(),
          '/edit': (_) => const EditPage(),
        },
      ),
    );
  }
}

