class PartDistributionEntry {
  final String date;
  final int part;
  final String person;

  PartDistributionEntry({
    required this.date,
    required this.part,
    required this.person,
  });

  factory PartDistributionEntry.fromMap(Map<String, dynamic> map) {
    return PartDistributionEntry(
      date: map['date'],
      part: map['part'],
      person: map['person'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'part': part,
      'person': person,
    };
  }
}
