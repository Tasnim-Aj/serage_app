class MspahModel {
  String name;
  int required_number;
  int counter;

//<editor-fold desc="Data Methods">
  MspahModel({
    required this.name,
    required this.required_number,
    required this.counter,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MspahModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          required_number == other.required_number &&
          counter == other.counter);

  @override
  int get hashCode =>
      name.hashCode ^ required_number.hashCode ^ counter.hashCode;

  @override
  String toString() {
    return 'MspahModel{ name: $name, required_number: $required_number, counter: $counter,}';
  }

  MspahModel copyWith({
    String? name,
    int? required_number,
    int? counter,
  }) {
    return MspahModel(
      name: name ?? this.name,
      required_number: required_number ?? this.required_number,
      counter: counter ?? this.counter,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'required_number': required_number,
      'counter': counter,
    };
  }

  factory MspahModel.fromMap(Map<String, dynamic> map) {
    return MspahModel(
      name: map['name'] as String,
      required_number: map['required_number'] as int,
      counter: map['counter'] as int,
    );
  }

//</editor-fold>
}
