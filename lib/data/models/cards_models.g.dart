// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cards_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinanceCard _$FinanceCardFromJson(Map<String, dynamic> json) => FinanceCard(
      id: json['id'] as int,
      title: json['title'] as String?,
      story: json['story'] as String?,
      imagePath: json['imagePath'] as String?,
    );

Map<String, dynamic> _$FinanceCardToJson(FinanceCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'story': instance.story,
      'imagePath': instance.imagePath,
    };
