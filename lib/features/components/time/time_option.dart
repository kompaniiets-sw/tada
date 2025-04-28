enum TimeOption {
  fifteen(15),
  twenty(20),
  twentyFive(25),
  thirty(30),
  thirtyFive(35),
  forty(40);

  final int minutes;
  const TimeOption(this.minutes);

  String get displayName => '$minutes min';
} 