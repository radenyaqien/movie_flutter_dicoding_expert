
import 'package:equatable/equatable.dart';
import 'package:movieflutter/data/models/series_model.dart';

class SeriesResponse extends Equatable {
  SeriesResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int page;
  final List<SeriesModel> results;
  final int totalPages;
  final int totalResults;

  factory SeriesResponse.fromJson(Map<String, dynamic> json) => SeriesResponse(
    page: json["page"],
    results: List<SeriesModel>.from((json['results'] as List)
        .map((x) => SeriesModel.fromJson(x))
        .where((element) => element.posterPath != null)),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };

  @override
  List<Object?> get props => [
    page,
    results,
    totalPages,
    totalResults,
  ];
}

