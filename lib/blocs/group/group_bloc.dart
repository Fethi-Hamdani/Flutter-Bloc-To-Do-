import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_test/blocs/habits/habits_bloc.dart';
import 'package:bloc_test/models/habit.dart';
import 'package:equatable/equatable.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final HabitsBloc _habitsBloc;
  late StreamSubscription _habitsSubscription;
  GroupBloc({
    required HabitsBloc habitsBloc,
  })  : _habitsBloc = habitsBloc,
        super(GroupSelectDisabled()) {
    on<AddToGroup>(_addtogroup);
    on<RemoveFromGroup>(_removefromgroup);
    on<DeleteGroup>(_deletegroup);
    on<StarGroup>(_stargroup);
    on<EnableGroupSelect>(_enablegroupselect);
    on<DisableGroupSelect>(_disablegroupselect);
  }

  void _addtogroup(AddToGroup event, Emitter<GroupState> emit) {
    final state = this.state;
    if (state is GroupSelectEnabled) {
      emit(
        GroupSelectEnabled(
          elements: List.from(state.elements)..add(event.id),
        ),
      );
    }
  }

  void _removefromgroup(RemoveFromGroup event, Emitter<GroupState> emit) {
    final state = this.state;
    if (state is GroupSelectEnabled) {
      emit(
        GroupSelectEnabled(
          elements: List.from(state.elements)..remove(event.id),
        ),
      );
    }
  }

  void _deletegroup(DeleteGroup event, Emitter<GroupState> emit) {
    final state = _habitsBloc.state;

    if (state is HabitsLoaded) {
      final groupstate = this.state as GroupSelectEnabled;
      List<Habit> habits = state.habits.where((element) {
        return !groupstate.elements.contains(element.id);
      }).toList();
      _habitsBloc.emit(HabitsLoaded(habits: habits));
      emit(const GroupSelectEnabled());
    }
  }

  void _stargroup(StarGroup event, Emitter<GroupState> emit) {
    final state = _habitsBloc.state;

    if (state is HabitsLoaded) {
      final groupstate = this.state as GroupSelectEnabled;
      List<Habit> habits = [];
      for (var item in state.habits) {
        if (groupstate.elements.contains(item.id)) {
          item = item.copyWith(isFavorite: !item.isFavorite);
        }
        habits.add(item);
      }
      _habitsBloc.emit(HabitsLoaded(habits: habits));
    }
  }

  void _enablegroupselect(EnableGroupSelect event, Emitter<GroupState> emit) {
    emit(GroupSelectEnabled());
  }

  void _disablegroupselect(DisableGroupSelect event, Emitter<GroupState> emit) {
    emit(GroupSelectDisabled());
  }
}
