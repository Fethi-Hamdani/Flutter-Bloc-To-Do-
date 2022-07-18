part of 'group_bloc.dart';

abstract class GroupState extends Equatable {
  const GroupState();

  @override
  List<Object> get props => [];
}

class GroupSelectDisabled extends GroupState {}

class GroupSelectEnabled extends GroupState {
  final List<int> elements;

  const GroupSelectEnabled({this.elements = const []});

  @override
  List<Object> get props => [elements];
}
