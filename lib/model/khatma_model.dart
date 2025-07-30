import 'package:serag_app/model/parts_distribution_model.dart';

import 'daily_schedule_entry_model.dart';

class KhatmaModel {
  int id;
  String name;
  String start_date;
  String end_date;
  int total_persons;
  List<String> participants;
  bool is_fajri;
  List<PartDistributionEntry>? parts_distribution;
  List<DailyScheduleEntry>? daily_schedule;

//<editor-fold desc="Data Methods">
  KhatmaModel({
    required this.id,
    required this.name,
    required this.start_date,
    required this.end_date,
    required this.total_persons,
    required this.participants,
    required this.is_fajri,
    this.parts_distribution,
    this.daily_schedule,
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
          participants == other.participants &&
          is_fajri == other.is_fajri &&
          parts_distribution == other.parts_distribution &&
          daily_schedule == other.daily_schedule);

  @override
  int get hashCode =>
      name.hashCode ^
      start_date.hashCode ^
      end_date.hashCode ^
      total_persons.hashCode ^
      participants.hashCode ^
      is_fajri.hashCode ^
      parts_distribution.hashCode ^
      daily_schedule.hashCode;

  @override
  String toString() {
    return 'KhatmaModel{' +
        ' name: $name,' +
        ' start_date: $start_date,' +
        ' end_date: $end_date,' +
        ' total_persons: $total_persons,' +
        ' participants: $participants,' +
        ' is_fajri: $is_fajri,' +
        ' parts_distribution: $parts_distribution,' +
        ' daily_schedule: $daily_schedule,' +
        '}';
  }

  KhatmaModel copyWith({
    String? name,
    String? start_date,
    String? end_date,
    int? total_persons,
    List<String>? participants,
    bool? is_fajri,
    List<PartDistributionEntry>? parts_distribution,
    List<DailyScheduleEntry>? daily_schedule,
  }) {
    return KhatmaModel(
      id: id ?? this.id,
      name: name ?? this.name,
      start_date: start_date ?? this.start_date,
      end_date: end_date ?? this.end_date,
      total_persons: total_persons ?? this.total_persons,
      participants: participants ?? this.participants,
      is_fajri: is_fajri ?? this.is_fajri,
      parts_distribution: parts_distribution ?? this.parts_distribution,
      daily_schedule: daily_schedule ?? this.daily_schedule,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // 'id': this.id,
      'name': this.name,
      'start_date': this.start_date,
      'end_date': this.end_date,
      'total_persons': this.total_persons,
      'participants': this.participants,
      'is_fajri': this.is_fajri,
      'parts_distribution': parts_distribution == null
          ? null
          : parts_distribution!.map((e) => e.toMap()).toList(),
      'daily_schedule': this.daily_schedule == null
          ? null
          : daily_schedule!.map((e) => e.toMap()).toList(),
    };
  }

  factory KhatmaModel.fromMap(Map<String, dynamic> map) {
    return KhatmaModel(
      id: map['id'] as int,
      name: map['name'] as String,
      start_date: map['start_date'] as String,
      end_date: map['end_date'] as String,
      total_persons: map['total_persons'] as int,
      participants: List<String>.from(map['participants']),
      is_fajri: map['is_fajri'] as bool,
      parts_distribution: map['parts_distribution'] != null
          ? (map['parts_distribution'] as List)
              .map((e) => PartDistributionEntry.fromMap(e))
              .toList()
          : null,
      daily_schedule: map['daily_schedule'] != null
          ? (map['daily_schedule'] as List)
              .map((e) => DailyScheduleEntry.fromMap(e))
              .toList()
          : null,
    );
  }

//</editor-fold>
}
