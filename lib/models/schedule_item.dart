class ScheduleItem {
  final String id;
  final String weekday;
  final String subject;
  final String time;
  final String room;
  final String teacher;

  const ScheduleItem({
    required this.id,
    required this.weekday,
    required this.subject,
    required this.time,
    required this.room,
    required this.teacher,
  });
}
