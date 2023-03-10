// ignore_for_file: public_member_api_docs, sort_constructors_first
class TaskModel {
  final int id;
  final String description;
  final DateTime datehour;
  final bool finalizado;

  TaskModel({
    required this.id,
    required this.description,
    required this.datehour,
    required this.finalizado,
  });

  factory TaskModel.loadFromDB(Map<String, dynamic> task) {
    return TaskModel(
        id: task['id'],
        description: task['descricao'],
        datehour: DateTime.parse(task['datahora']),
        finalizado: task['finalizado'] == 1);
  }

  TaskModel copyWith({
    int? id,
    String? description,
    DateTime? datehour,
    bool? finalizado,
  }) {
    return TaskModel(
      id: id ?? this.id,
      description: description ?? this.description,
      datehour: datehour ?? this.datehour,
      finalizado: finalizado ?? this.finalizado,
    );
  }
}
