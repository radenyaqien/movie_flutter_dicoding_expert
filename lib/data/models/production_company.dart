import 'package:equatable/equatable.dart';

class ProductionCompany extends Equatable {
  final int id;
  final String? logo_path;
  final String name;
  final String origin_country;

  ProductionCompany({
    required this.id,
    required this.logo_path,
    required this.name,
    required this.origin_country,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      ProductionCompany(
        id: json["id"],
        logo_path: json["logo_path"],
        name: json["name"],
        origin_country: json["origin_country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "logo_path": logo_path,
        "name": name,
        "origin_country": origin_country,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [id, logo_path, name, origin_country];
}
