import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/theme/text_style.dart';
import 'package:pantrikita/feature/login/presentation/pages/login_page.dart';
import 'package:pantrikita/feature/pantry/presentation/pages/pantry_page.dart';
import 'package:pantrikita/feature/register/presentation/pages/register_page.dart';
import 'package:pantrikita/injection-container.dart';
import 'core/bloc/observer/app_bloc_observer.dart';
import 'core/theme/app_style.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await dotenv.load();
  deviceOrientation();
  statusBarLightStyle();

  await initializeServiceLocator();

  Bloc.observer = AppBlocObserver();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id_ID');

    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'PantriKita',
      debugShowCheckedModeBanner: false,
      home: PantryPage(),
    );
  }
}
