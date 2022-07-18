import 'package:bloc_test/blocs/habits/habits_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/habit.dart';

class AddHabitPage extends StatelessWidget {
  const AddHabitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController name = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('add new habit'),
      ),
      body: Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(
            height: 10,
          ),
          const Text('enter Habit information'),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: TextField(
              controller: name,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              int id = 1;
              if (context.read<HabitsBloc>().state is HabitsLoaded) {
                final state = context.read<HabitsBloc>().state as HabitsLoaded;
                id = state.habits.length + 1;
              }
              context.read<HabitsBloc>().add(AddHabit(
                    habit: Habit(
                      id: id,
                      name: name.text,
                    ),
                  ));
              Navigator.pop(context);
            },
            child: const Text('Add Habit'),
          )
        ]),
      ),
    );
  }
}
