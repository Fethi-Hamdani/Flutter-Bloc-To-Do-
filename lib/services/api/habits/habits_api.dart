import '../../../models/habit.dart';

class HabitsApi {
  static Future<List<Habit>> loadHabits() async {
    await Future.delayed(const Duration(seconds: 2));
    return [Habit(id: 1, name: 'Sport'), Habit(id: 2, name: 'Eat'), Habit(id: 3, name: 'Pray')];
  }
}
