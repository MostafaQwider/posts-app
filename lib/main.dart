import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:posts_app/firebase_options.dart';
import 'package:provider/provider.dart';
import 'core/di/injection_container.dart' as di;
import 'features/posts/presentation/providers/post_provider.dart';
import 'features/posts/presentation/pages/home_page.dart';
import 'core/services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await di.init();

  await di.sl<StorageService>().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.sl<PostProvider>(),
        ),
      ],
      child: MaterialApp(
        title: 'Posts App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFFFF6333),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xFFFF6333),
            secondary: const Color(0xFFFF6333),
          ),
          useMaterial3: false,
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        ),
        home: const HomePage(),
      ),
    );
  }
}
