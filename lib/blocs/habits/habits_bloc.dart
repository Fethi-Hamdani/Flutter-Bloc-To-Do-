import 'package:bloc/bloc.dart';
import 'package:bloc_test/models/habit.dart';
import 'package:bloc_test/services/api/habits/habits_api.dart';
import 'package:equatable/equatable.dart';

part 'habits_event.dart';
part 'habits_state.dart';

class HabitsBloc extends Bloc<HabitsEvent, HabitsState> {
  HabitsBloc() : super(HabitsLoading()) {
    on<LoadHabits>(_loadHabits);
    on<AddHabit>(_addHabit);
    on<UpdateHabit>(_updateHabit);
    on<DeleteHabit>(_deleteHabit);
    on<UpdateHabits>(_updateHabits);
  }

  Future<void> _loadHabits(LoadHabits event, Emitter<HabitsState> emit) async {
    List<Habit> habits = await HabitsApi.loadHabits();
    emit(HabitsLoaded(habits: habits));
  }

  void _addHabit(AddHabit event, Emitter<HabitsState> emit) {
    final state = this.state;
    if (state is HabitsLoaded) {
      emit(HabitsLoaded(habits: [
        ...state.habits,
        event.habit,
      ]));
    }
  }

  void _updateHabit(UpdateHabit event, Emitter<HabitsState> emit) {
    final state = this.state;
    if (state is HabitsLoaded) {
      List<Habit> habits = state.habits.map((e) {
        return e.id == event.habit.id ? event.habit : e;
      }).toList();
      emit(HabitsLoaded(habits: habits));
    }
  }

  void _updateHabits(UpdateHabits event, Emitter<HabitsState> emit) {
    final state = this.state;
    if (state is HabitsLoaded) {
      List<Habit> habits = state.habits.map((e) {
        return event.habits.contains(e.id) ? event.habits.firstWhere((element) => element.id == e.id) : e;
      }).toList();
      emit(HabitsLoaded(habits: habits));
    }
  }

  void _deleteHabit(DeleteHabit event, Emitter<HabitsState> emit) {
    final state = this.state;
    if (state is HabitsLoaded) {
      List<Habit> habits = state.habits.where((e) {
        return e.id != event.habit.id;
      }).toList();
      emit(HabitsLoaded(habits: habits));
    }
  }
}
