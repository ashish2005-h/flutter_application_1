import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/router.dart';
import 'package:flutter_application_1/view_model/bloc/watchlist_bloc.dart';
import 'package:flutter_application_1/view_model/bloc_event/watchlist_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WatchlistBloc()..add(LoadWatchlist()),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}