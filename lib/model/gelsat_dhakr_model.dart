class GelsatDhakrModel {
  String name;
  String start_date;
  String end_date;
  int total_persons;
  int required_number;

//<editor-fold desc="Data Methods">
  GelsatDhakrModel({
    required this.name,
    required this.start_date,
    required this.end_date,
    required this.total_persons,
    required this.required_number,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GelsatDhakrModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          start_date == other.start_date &&
          end_date == other.end_date &&
          total_persons == other.total_persons &&
          required_number == other.required_number);

  @override
  int get hashCode =>
      name.hashCode ^
      start_date.hashCode ^
      end_date.hashCode ^
      total_persons.hashCode ^
      required_number.hashCode;

  @override
  String toString() {
    return 'GelsatDhakrModel{' +
        ' name: $name,' +
        ' start_date: $start_date,' +
        ' end_date: $end_date,' +
        ' total_persons: $total_persons,' +
        ' required_number: $required_number,' +
        '}';
  }

  GelsatDhakrModel copyWith({
    String? name,
    String? start_date,
    String? end_date,
    int? total_persons,
    int? required_number,
  }) {
    return GelsatDhakrModel(
      name: name ?? this.name,
      start_date: start_date ?? this.start_date,
      end_date: end_date ?? this.end_date,
      total_persons: total_persons ?? this.total_persons,
      required_number: required_number ?? this.required_number,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'start_date': this.start_date,
      'end_date': this.end_date,
      'total_persons': this.total_persons,
      'required_number': this.required_number,
    };
  }

  factory GelsatDhakrModel.fromMap(Map<String, dynamic> map) {
    return GelsatDhakrModel(
      name: map['name']?.toString() ?? 'غير محدد',
      start_date: map['start_date']?.toString() ?? DateTime.now().toString(),
      end_date: map['end_date']?.toString() ?? DateTime.now().toString(),
      total_persons: (map['total_persons'] as num?)?.toInt() ?? 1,
      required_number: (map['required_number'] as num?)?.toInt() ?? 10000,
    );
  }

  // factory GelsatDhakrModel.fromMap(Map<String, dynamic> map) {
  //   return GelsatDhakrModel(
  //     name: map['name'] as String,
  //     start_date: map['start_date'] as String,
  //     end_date: map['end_date'] as String,
  //     total_persons: map['total_persons'] as int,
  //     required_number: map['required_number'] as int,
  //   );
  // }

//</editor-fold>
}
