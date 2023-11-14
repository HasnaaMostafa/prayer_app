import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer_app/core/services/api_service.dart';
import 'package:prayer_app/feature/Home/data/repo/home_repo_impl.dart';
import 'package:prayer_app/feature/Home/presentation/views/home_view.dart';
import 'package:prayer_app/feature/Home/presentation/views_models/prayer_cubit/prayer_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PrayerCubit(HomeRepoImpl(ApiService(Dio()))),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const HomeView(),
      ),
    );
  }
}
