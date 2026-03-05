import 'dart:convert';

import '../../domain/storages/app_storage.dart';
import '../models/watch_history_model.dart';

class WatchHistoryLocalDataSource {
  final AppStorage _storage;

  static const String _storageKey = 'watch_history_items';

  WatchHistoryLocalDataSource(this._storage);

  Future<List<WatchHistoryModel>> getAll() async {
    final jsonString = await _storage.getString(_storageKey);
    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }

    final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;
    return jsonList.map((e) => WatchHistoryModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> saveAll(List<WatchHistoryModel> items) async {
    final jsonList = items.map((e) => e.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await _storage.setString(_storageKey, jsonString);
  }

  Future<void> deleteByIds(Set<String> ids) async {
    final items = await getAll();
    final remaining = items.where((item) => !ids.contains(item.id)).toList();
    await saveAll(remaining);
  }

  Future<void> addItem(WatchHistoryModel item) async {
    final items = await getAll();
    // Remove duplicate (same id) and prepend the new item
    final updated = [item, ...items.where((e) => e.id != item.id)];
    await saveAll(updated);
  }
}
