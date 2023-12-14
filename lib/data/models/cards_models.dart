import 'package:json_annotation/json_annotation.dart';

part 'cards_models.g.dart';

@JsonSerializable()
class FinanceCard {
  final int id;
  final String? title; 
  final String? story;
  final String? imagePath;

  FinanceCard({required this.id, this.title, this.story, this.imagePath});

  factory FinanceCard.fromJson(Map<String, dynamic> json) => _$FinanceCardFromJson(json);
  Map<String, dynamic> toJson() => _$FinanceCardToJson(this);
}

