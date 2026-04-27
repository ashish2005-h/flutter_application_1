import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/bottom_navbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_application_1/view_model/bloc/watchlist_bloc.dart';
import 'package:flutter_application_1/view_model/bloc_state/watchlist_state.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  Color getColor(double value) =>
      value >= 0 ? Colors.green : Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("Watchlist 1",
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black),
            onPressed: () => context.push('/edit'),
          )
        ],
      ),

      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black12)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Expanded(
                            child: Text(
                              "SENSEX 18TH Sep 2026khdbbchk",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 6),
                          Text("BSE"),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "1,225.55  +144.50",
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  width: 1,
                  color: Colors.grey.shade300,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                ),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("NIFTY BANK"),
                      Text(
                        "54,174.45  -12.45",
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.search),
                hintText: "Search for instruments",
                border: InputBorder.none,
              ),
            ),
          ),

          const _SortBySection(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: const [
                Text("Watchlist 1",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 16),
                Text("Watchlist 5", style: TextStyle(color: Colors.grey)),
                SizedBox(width: 16),
                Text("Watchlist 6", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),

          const Divider(),

          Expanded(
            child: BlocBuilder<WatchlistBloc, WatchlistState>(
              builder: (context, state) {
                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: state.stocks.length,
                  itemBuilder: (context, index) {
                    final stock = state.stocks[index];
                    final color = getColor(stock.change);

                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.black12)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(stock.name),
                                const SizedBox(height: 4),
                                Text(
                                  stock.exchange,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.end,
                            children: [
                              Text(
                                stock.price.toStringAsFixed(2),
                                style: TextStyle(color: color),
                              ),
                              Text(
                                "${stock.change}%",
                                style: TextStyle(
                                    color: color, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),

      bottomNavigationBar: const AppBottomNav(),
    );
  }
}

class _SortBySection extends StatelessWidget {
  const _SortBySection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: const [
                Icon(
                  Icons.tune,
                  size: 18,
                  color: Colors.black,
                ),
                SizedBox(width: 8),
                Text(
                  "Sort by",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}