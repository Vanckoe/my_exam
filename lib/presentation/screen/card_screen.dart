import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_market/data/models/cards_models.dart';
import 'package:flutter_market/data/repository/card_api.dart';
import 'package:flutter_market/data/repository/card_repository.dart';
import 'package:flutter_market/domain/uses_case/card_usecase.dart';
import 'package:flutter_market/generated/locale_keys.g.dart';
import 'package:flutter_market/presentation/bloc/bloc/card_bloc.dart';
import 'package:flutter_market/presentation/bloc/bloc/card_event.dart';
import 'package:flutter_market/presentation/bloc/bloc/card_state.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

class CardsPage extends StatelessWidget {
  const CardsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final apiClient = ApiClient(dio); 
    return BlocProvider(
      create: (context) => CardBloc(
        getCardsUseCase: GetCardsUseCase(
          CardsRepository(apiClient),
        ),
      )..add(CardLoad()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.Financs_cards.tr(), style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blueGrey,
        ),
        body: BlocBuilder<CardBloc, CardState>(
          builder: (context, state) {
            if (state is CardLoadInProgress) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CardLoadSuccess) {
              return ListView.builder(
                itemCount: state.cards.length,
                itemBuilder: (context, index) {
                  final card = state.cards[index];
                  return CardWidget(card: card);
                },
              );
            } else if (state is CardLoadFailure) {
              return Center(child: Text(LocaleKeys.Download_error.tr(), style: TextStyle(color: Colors.red)));
            } else {
              return Center(child: Text(LocaleKeys.Click_to_download.tr(), style: TextStyle(color: Colors.blueGrey)));
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.read<CardBloc>().add(CardLoad()),
          child: Icon(Icons.refresh),
          backgroundColor: Colors.deepPurple,
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final FinanceCard card;

  const CardWidget({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          card.imagePath != null 
            ? Image.network(
                card.imagePath!,
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              )
            : SizedBox(height: 200, child: Center(child: Text(LocaleKeys.Image_is_missing.tr()))),
          ListTile(
            title: Text(
              card.title ?? LocaleKeys.Without_name.tr(),
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            subtitle: Text(
              card.story ?? LocaleKeys.Description_is_missing.tr(),
              style: TextStyle(color: Colors.grey[600]),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          ),
        ],
      ),
    );
  }
}
