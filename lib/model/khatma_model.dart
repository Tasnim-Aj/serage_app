class KhatmaModel {
  String name;
  String start_date;
  String end_date;
  int total_persons;
  bool is_fajri;

//<editor-fold desc="Data Methods">
  KhatmaModel({
    required this.name,
    required this.start_date,
    required this.end_date,
    required this.total_persons,
    required this.is_fajri,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KhatmaModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          start_date == other.start_date &&
          end_date == other.end_date &&
          total_persons == other.total_persons &&
          is_fajri == other.is_fajri);

  @override
  int get hashCode =>
      name.hashCode ^
      start_date.hashCode ^
      end_date.hashCode ^
      total_persons.hashCode ^
      is_fajri.hashCode;

  @override
  String toString() {
    return 'KhatmaModel{' +
        ' name: $name,' +
        ' start_date: $start_date,' +
        ' end_date: $end_date,' +
        ' total_persons: $total_persons,' +
        ' is_fajri: $is_fajri,' +
        '}';
  }

  KhatmaModel copyWith({
    String? name,
    String? start_date,
    String? end_date,
    int? total_persons,
    bool? is_fajri,
  }) {
    return KhatmaModel(
      name: name ?? this.name,
      start_date: start_date ?? this.start_date,
      end_date: end_date ?? this.end_date,
      total_persons: total_persons ?? this.total_persons,
      is_fajri: is_fajri ?? this.is_fajri,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'start_date': this.start_date,
      'end_date': this.end_date,
      'total_persons': this.total_persons,
      'is_fajri': this.is_fajri,
    };
  }

  factory KhatmaModel.fromMap(Map<String, dynamic> map) {
    return KhatmaModel(
      name: map['name'] as String,
      start_date: map['start_date'] as String,
      end_date: map['end_date'] as String,
      total_persons: map['total_persons'] as int,
      is_fajri: map['is_fajri'] as bool,
    );
  }

//</editor-fold>
}
