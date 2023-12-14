import 'package:flutter_market/data/models/cards_models.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'card_repository.g.dart';

@RestApi(baseUrl: "https://finance-372ed-default-rtdb.firebaseio.com/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/cards.json")
  Future<List<FinanceCard>> getCards();
}
