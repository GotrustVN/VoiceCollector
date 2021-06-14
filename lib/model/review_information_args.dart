class ReviewInformationArgs {
  final String gender;
  final String age;
  final String weight;
  final String healthStatus;
  final String fullName;
  final String recordFileName;

  ReviewInformationArgs({
    required this.gender,
    required this.age,
    required this.weight,
    required this.healthStatus,
    this.fullName ='',
    required this.recordFileName,
  });
}
