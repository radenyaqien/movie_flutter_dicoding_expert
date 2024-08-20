import 'package:equatable/equatable.dart';

class CreatedBy extends Equatable {
  final int id;
  final String creditId;
  final String name;
  final String originalName;
  final int gender;
  final String profilePath;

  CreatedBy({
    required this.id,
    required this.creditId,
    required this.name,
    required this.originalName,
    required this.gender,
    required this.profilePath,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["id"],
        creditId: json["credit_id"],
        name: json["name"],
        originalName: json["original_name"],
        gender: json["gender"],
        profilePath: json["profile_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "credit_id": creditId,
        "name": name,
        "original_name": originalName,
        "gender": gender,
        "profile_path": profilePath,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        creditId,
        name,
        originalName,
        gender,
        profilePath,
      ];
}
