part of 'habits_bloc.dart';

abstract class HabitsState extends Equatable {
  const HabitsState();
  @override
  List<Object> get props => [];
}

class HabitsLoading extends HabitsState {}

class HabitsLoaded extends HabitsState {
  final List<Habit> habits;
  const HabitsLoaded({
    this.habits = const <Habit>[],
  });

  @override
  List<Object> get props => [habits];
}
