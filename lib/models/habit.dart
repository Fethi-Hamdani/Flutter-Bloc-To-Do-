import 'package:equatable/equatable.dart';

class Habit extends Equatable {
  int id;
  String name;
  bool isFavorite;
  bool isDone;
  Habit({
    required this.id,
    required this.name,
    this.isFavorite = false,
    this.isDone = false,
  });

  @override
  List<Object> get props => [
        id,
        name,
        isFavorite,
        isDone,
      ];

  Habit copyWith({
    String? name,
    bool? isFavorite,
    bool? isDone,
  }) {
    return Habit(
      id: id,
      name: name ?? this.name,
      isFavorite: isFavorite ?? this.isFavorite,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  String toString() {
    return 'id: $id, isFavorite: $isFavorite';
  }
}
