import 'package:flutter_application_1/model/stock_model.dart';

abstract class WatchlistEvent {}

class LoadWatchlist extends WatchlistEvent {}

class ReorderStocks extends WatchlistEvent {
  final int oldIndex;
  final int newIndex;

  ReorderStocks(this.oldIndex, this.newIndex);
}

class DeleteStock extends WatchlistEvent {
  final int index;

  DeleteStock(this.index);
}

class SaveReorderedStocks extends WatchlistEvent {
  final List<Stock> stocks;

  SaveReorderedStocks(this.stocks);
}

class UpdatePrices extends WatchlistEvent {}