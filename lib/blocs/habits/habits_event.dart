part of 'habits_bloc.dart';

abstract class HabitsEvent extends Equatable {
  const HabitsEvent();

  @override
  List<Object> get props => [];
}

class LoadHabits extends HabitsEvent {}

class AddHabit extends HabitsEvent {
  final Habit habit;

  const AddHabit({required this.habit});

  @override
  List<Object> get props => [habit];
}

class UpdateHabit extends HabitsEvent {
  final Habit habit;

  const UpdateHabit(this.habit);

  @override
  List<Object> get props => [habit];
}

class UpdateHabits extends HabitsEvent {
  final List<Habit> habits;

  const UpdateHabits(this.habits);

  @override
  List<Object> get props => [habits];
}

class DeleteHabit extends HabitsEvent {
  final Habit habit;

  const DeleteHabit(this.habit);

  @override
  List<Object> get props => [habit];
}
