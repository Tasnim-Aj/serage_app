class PartAssignment {
  final int part;
  final String person;

  PartAssignment({
    required this.part,
    required this.person,
  });

  factory PartAssignment.fromMap(Map<String, dynamic> map) {
    return PartAssignment(
      part: map['part'],
      person: map['person'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'part': part,
      'person': person,
    };
  }
}

class DailyScheduleEntry {
  final String date;
  final List<PartAssignment> parts;

  DailyScheduleEntry({
    required this.date,
    required this.parts,
  });

  factory DailyScheduleEntry.fromMap(Map<String, dynamic> map) {
    return DailyScheduleEntry(
      date: map['date'],
      parts:
          (map['parts'] as List).map((e) => PartAssignment.fromMap(e)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'parts': parts.map((e) => e.toMap()).toList(),
    };
  }
}
