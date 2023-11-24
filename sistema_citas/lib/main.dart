import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_citas/firebase_options.dart';
import 'package:sistema_citas/provider/firebase_provider.dart';
import 'package:sistema_citas/screens/screens.dart';
import 'package:sistema_citas/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => FirebaseProvider())
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xff0ee9c6)),
            useMaterial3: true,
          ),
          routes: {
            LOGIN_SCREEN: (_) => const LoginScreen(),
            SIGN_IN_SCREEN: (_) => const SignInScreen(),
            MEDICAL_APPOINTMENTS_SCREEN: (_) =>
                const MedicalAppointmentsScreen(),
            PENDING_APPOINTMENTS_SCREEN: (_) =>
                const PendingAppointmentsScreen(),
            CHAT_SCREEN: (_) => const ChatScreen(),
          },
          initialRoute: LOGIN_SCREEN,
        ));
  }
}
