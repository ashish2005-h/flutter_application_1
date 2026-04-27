import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/model/stock_model.dart';
import 'package:flutter_application_1/view_model/bloc/watchlist_bloc.dart';
import 'package:flutter_application_1/view_model/bloc_event/watchlist_event.dart';

class EditWatchlistScreen extends StatefulWidget {
  const EditWatchlistScreen({super.key});

  @override
  State<EditWatchlistScreen> createState() => _EditWatchlistScreenState();
}

class _EditWatchlistScreenState extends State<EditWatchlistScreen> {
  late List<Stock> tempStocks;

  @override
  void initState() {
    super.initState();
    tempStocks = List.from(context.read<WatchlistBloc>().state.stocks);
  }

  void _onReorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    final item = tempStocks.removeAt(oldIndex);
    tempStocks.insert(newIndex, item);
    setState(() {});
  }

  void _onSave() {
    context.read<WatchlistBloc>().add(SaveReorderedStocks(tempStocks));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text("Edit Watchlist 1", style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ScrollConfiguration(
        behavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
        ),
        child: ReorderableListView.builder(
          buildDefaultDragHandles: false,
          padding: const EdgeInsets.only(bottom: 140),
          itemCount: tempStocks.length,
          onReorder: _onReorder,
          itemBuilder: (context, index) {
            final stock = tempStocks[index];
            return ReorderableDragStartListener(
              key: ValueKey("$index-${stock.name}"),
              index: index,
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Icon(Icons.drag_handle),
                          ),
                          Expanded(
                            child: Text(
                              stock.name,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () {
                              setState(() {
                                tempStocks.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.black12)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(child: Text("Edit other watchlists")),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: _onSave,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text("Save Watchlist", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}