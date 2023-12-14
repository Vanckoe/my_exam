import 'package:dio/dio.dart';
import 'package:flutter_market/data/models/cards_models.dart';
import 'package:flutter_market/data/repository/card_repository.dart';

class CardsRepository {
  final ApiClient apiClient;

  CardsRepository(this.apiClient);

  Future<List<FinanceCard>> getCards() async {
    try {
      final response = await apiClient.getCards();
      return response;
    } catch (e) {
      print('Ошибка при загрузке карточек: $e');
      if (e is DioError) {
        print('DioError: ${e.response}');
      }
      throw Exception('Ошибка загрузки данных');
    }
  }
}

