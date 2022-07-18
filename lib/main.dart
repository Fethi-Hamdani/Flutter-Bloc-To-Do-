import 'package:bloc_test/blocs/group/group_bloc.dart';
import 'package:bloc_test/blocs/habits/habits_bloc.dart';
import 'package:bloc_test/screens/habits_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HabitsBloc()..add(LoadHabits()),
        ),
        BlocProvider(
          create: (context) => GroupBloc(
            habitsBloc: BlocProvider.of<HabitsBloc>(context),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HabitsPage(),
      ),
    );
  }
}
