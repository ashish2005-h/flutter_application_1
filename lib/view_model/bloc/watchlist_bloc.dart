import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/model/stock_model.dart';
import 'package:flutter_application_1/view_model/bloc_event/watchlist_event.dart';
import 'package:flutter_application_1/view_model/bloc_state/watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  List<Stock> _stocks = [];

  Timer? _timer;
  final Random _random = Random();

  WatchlistBloc() : super(WatchlistState([])) {


    on<LoadWatchlist>((event, emit) {
      _stocks = [
        Stock(name: "RELIANCE", exchange: "NSE | EQ", price: 1374.10, change: -0.32),
        Stock(name: "HDFCBANK", exchange: "NSE | EQ", price: 966.95, change: 0.10),
        Stock(name: "ASIANPAINT", exchange: "NSE | EQ", price: 2537.40, change: 0.26),
        Stock(name: "NIFTY IT", exchange: "NSE | INDEX", price: 31245.50, change: -0.45),

        /// OPTIONS
        Stock(name: "RELIANCE SEP 1880 CE", exchange: "NFO | OPT", price: 12.50, change: 1.20),
        Stock(name: "RELIANCE SEP 1370 CE", exchange: "NFO | OPT", price: 45.80, change: -2.10),

        /// DUPLICATE TEST
        Stock(name: "MRF", exchange: "NSE | EQ", price: 124500.00, change: 0.75),
        Stock(name: "MRF", exchange: "NSE | EQ", price: 124480.00, change: -0.30),
      ];

      emit(WatchlistState(List.from(_stocks)));

      /// 🔥 Start auto updates
      _startAutoUpdate();
    });

  
    on<ReorderStocks>((event, emit) {
      int oldIndex = event.oldIndex;
      int newIndex = event.newIndex;

      if (newIndex > oldIndex) newIndex--;

      final item = _stocks.removeAt(oldIndex);
      _stocks.insert(newIndex, item);

      emit(WatchlistState(List.from(_stocks)));
    });

  
    on<DeleteStock>((event, emit) {
      _stocks.removeAt(event.index);
      emit(WatchlistState(List.from(_stocks)));
    });

    
    on<UpdatePrices>((event, emit) {
      _stocks = _stocks.map((stock) {
        // Random % change between -1% to +1%
        final percentChange = (_random.nextDouble() * 2 - 1);

        final newPrice = stock.price * (1 + percentChange / 100);

        return Stock(
          name: stock.name,
          exchange: stock.exchange,
          price: double.parse(newPrice.toStringAsFixed(2)),
          change: double.parse(percentChange.toStringAsFixed(2)),
        );
      }).toList();

      emit(WatchlistState(List.from(_stocks)));
    });

    on<SaveReorderedStocks>((event, emit) {
  _stocks = List.from(event.stocks);
  emit(WatchlistState(List.from(_stocks)));
});
  }


  void _startAutoUpdate() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      add(UpdatePrices());
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  
}