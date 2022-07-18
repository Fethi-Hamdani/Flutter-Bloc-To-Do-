import 'package:bloc_test/blocs/group/group_bloc.dart';
import 'package:bloc_test/blocs/habits/habits_bloc.dart';
import 'package:bloc_test/screens/add_habit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/habit.dart';

class HabitsPage extends StatelessWidget {
  const HabitsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            BlocBuilder<GroupBloc, GroupState>(
              builder: (context, state) {
                if (state is GroupSelectDisabled) {
                  return IconButton(
                    icon: const Icon(Icons.check_circle_outline_outlined),
                    onPressed: () {
                      context.read<GroupBloc>().add(EnableGroupSelect());
                    },
                  );
                } else {
                  return Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () {
                          context.read<GroupBloc>().add(DisableGroupSelect());
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.star),
                        onPressed: () {
                          context.read<GroupBloc>().add(const StarGroup());
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context.read<GroupBloc>().add(const DeleteGroup());
                        },
                      ),
                    ],
                  );
                }
              },
            ),
          ],
          title: BlocBuilder<GroupBloc, GroupState>(
            builder: (context, state) {
              if (state is GroupSelectEnabled) {
                return Text('Habits selected ${state.elements.length}');
              } else
                return Text('Habits page');
            },
          ),
        ),
        body: BlocBuilder<HabitsBloc, HabitsState>(
          builder: (context, state) {
            if (state is HabitsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is HabitsLoaded) {
              return ListView.builder(
                itemCount: state.habits.length,
                itemBuilder: (context, index) {
                  final habit = state.habits[index];
                  return habitWidget(habit: habit, context: context);
                },
              );
            } else {
              return const Center(
                child: Text("Error Loading Habits"),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddHabitPage()));
        }));
  }

  Widget habitWidget({required Habit habit, required BuildContext context}) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.amber[100],
          border: Border.all(
            color: Colors.black26,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          BlocBuilder<GroupBloc, GroupState>(
            builder: (context, state) {
              if (state is GroupSelectEnabled) {
                bool isEnabled = state.elements.contains(habit.id);
                return IconButton(
                    onPressed: () {
                      if (!isEnabled) {
                        context.read<GroupBloc>().add(AddToGroup(habit.id));
                      } else {
                        context.read<GroupBloc>().add(RemoveFromGroup(habit.id));
                      }
                    },
                    icon: Icon(isEnabled ? Icons.check_box : Icons.check_box_outline_blank));
              } else {
                return Container();
              }
            },
          ),
          Text(habit.id.toString() + " : " + habit.name),
          const Spacer(),
          BlocBuilder<HabitsBloc, HabitsState>(
            builder: (context, state) {
              return IconButton(
                  onPressed: () {
                    context.read<HabitsBloc>().add(UpdateHabit(habit.copyWith(isFavorite: !habit.isFavorite)));
                  },
                  icon: Icon(habit.isFavorite ? Icons.star : Icons.star_border));
            },
          ),
          IconButton(
              onPressed: () {
                context.read<HabitsBloc>().add(DeleteHabit(habit));
              },
              icon: const Icon(Icons.delete))
        ],
      ),
    );
  }
}
