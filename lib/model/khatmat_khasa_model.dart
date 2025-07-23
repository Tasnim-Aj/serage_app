class KhatmatKhasaModel {
  int id;
  String name;
  List reserved_parts;

//<editor-fold desc="Data Methods">
  KhatmatKhasaModel({
    required this.id,
    required this.name,
    required this.reserved_parts,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KhatmatKhasaModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          reserved_parts == other.reserved_parts);

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ reserved_parts.hashCode;

  @override
  String toString() {
    return 'KhatmatKhasaModel{' +
        ' id: $id,' +
        ' name: $name,' +
        ' reserved_parts: $reserved_parts,' +
        '}';
  }

  KhatmatKhasaModel copyWith({
    int? id,
    String? name,
    List? reserved_parts,
  }) {
    return KhatmatKhasaModel(
      id: id ?? this.id,
      name: name ?? this.name,
      reserved_parts: reserved_parts ?? this.reserved_parts,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'reserved_parts': this.reserved_parts,
    };
  }

  factory KhatmatKhasaModel.fromMap(Map<String, dynamic> map) {
    return KhatmatKhasaModel(
      id: map['id'] as int,
      name: map['name'] as String,
      reserved_parts: map['reserved_parts'] as List,
    );
  }

//</editor-fold>
}
