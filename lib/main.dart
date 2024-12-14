import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'screens/home_screen.dart';
import 'screens/family_member_screen.dart';
import 'screens/medicine_screen.dart';
import 'screens/analytics_screen.dart';
import 'screens/search_screen.dart';
import 'models/family_member.dart';
import 'models/medicine.dart';
import 'providers/app_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize localization
  await EasyLocalization.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(FamilyMemberAdapter());
  Hive.registerAdapter(MedicineAdapter());
  Hive.registerAdapter(MedicineHistoryEntryAdapter());
  Hive.registerAdapter(HistoryTypeAdapter());
  
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const ProviderScope(
        child: MediAlertApp(),
      ),
    ),
  );
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/family-member/:id',
      builder: (context, state) => FamilyMemberScreen(
        memberId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/medicine/:id',
      builder: (context, state) => MedicineScreen(
        medicineId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/analytics',
      builder: (context, state) => const AnalyticsScreen(),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchScreen(),
    ),
  ],
);

class MediAlertApp extends ConsumerWidget {
  const MediAlertApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: context.tr('appName'),
      localizationsDelegates: context.localizationDelegates + [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ref.watch(themeNotifierProvider),
      routerConfig: _router,
    );
  }
}

