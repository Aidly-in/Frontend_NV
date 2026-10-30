import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_aidly/aidly.dart';
import 'features/Authentication/presentation/Aidly.dart';

Future<void> main() async {

  /// THIS ENSURES FLUTTER IS FULLY INITIALIZED
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(

      /// DESIGN SIZE APNE FIGMA/DESIGN KE HISAAB SE SET KARO
      designSize: const Size(360, 800),

      minTextAdapt: true,

      splitScreenMode: true,

      builder: (context, child) {

        return const MaterialApp(

          debugShowCheckedModeBanner: false,

          home: AidlyPgae(
            title: 'Aidly',
          ),
        );
      },
    );
  }
}