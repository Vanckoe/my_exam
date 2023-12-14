import 'package:flutter_market/data/models/cards_models.dart';
import 'package:flutter_market/data/repository/card_api.dart';

class GetCardsUseCase {
  final CardsRepository repository;

  GetCardsUseCase(this.repository);

  Future<List<FinanceCard>> call() async {
    return repository.getCards();
  }
}
