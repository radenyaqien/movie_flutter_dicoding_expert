import 'package:equatable/equatable.dart';

class ProductionCompany extends Equatable {
  final int id;
  final String? logo_path;
  final String name;
  final String origin_country;

  const ProductionCompany({
    required this.id,
    required this.logo_path,
    required this.name,
    required this.origin_country,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, logo_path, name, origin_country];
}
