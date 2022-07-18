part of 'group_bloc.dart';

abstract class GroupEvent extends Equatable {
  const GroupEvent();

  @override
  List<Object> get props => [];
}

class EnableGroupSelect extends GroupEvent {}

class DisableGroupSelect extends GroupEvent {}

class AddToGroup extends GroupEvent {
  final int id;

  const AddToGroup(this.id);

  @override
  List<Object> get props => [id];
}

class RemoveFromGroup extends GroupEvent {
  final int id;

  const RemoveFromGroup(this.id);

  @override
  List<Object> get props => [id];
}

class DeleteGroup extends GroupEvent {
  const DeleteGroup();

  @override
  List<Object> get props => [];
}

class StarGroup extends GroupEvent {
  const StarGroup();

  @override
  List<Object> get props => [];
}
