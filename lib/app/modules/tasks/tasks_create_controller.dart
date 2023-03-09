import 'package:flutter/foundation.dart';
import 'package:todo_list_flutter/app/services/task/task_service.dart';

import '../../core/notifier/default_change_notifier.dart';

class TasksCreateController extends DefaultChangeNotifier {
  final TaskService _taskService;
  DateTime? _selectedTime;

  TasksCreateController({required TaskService taskService})
      : _taskService = taskService;

  set selectedTime(DateTime? selectedTime) {
    resetState();
    _selectedTime = selectedTime;
    notifyListeners();
  }

  DateTime? get selectedTime => _selectedTime;

  Future<void> save(String description) async {
    try {
      showLoadingAndReset();
      notifyListeners();
      if (_selectedTime != null) {
        await _taskService.saveTask(_selectedTime!, description);
        showSucess();
      } else {
        setError('Data da task não selecionada.');
      }
    } on Exception catch (e, s) {
      if (kDebugMode) {
        print("$e, $s");
      }
      setError('Erro ao cadastrar task, tente novamente.');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
