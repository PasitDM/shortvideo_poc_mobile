import 'dart:convert';

import '../../domain/storages/app_storage.dart';
import '../models/history1_model.dart';

class History1LocalDataSource {
  final AppStorage _storage;

  static const String _storageKey = 'history1_items';

  History1LocalDataSource(this._storage);

  Future<List<History1Model>> getAll() async {
    final jsonString = await _storage.getString(_storageKey);
    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }

    try {
      final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;
      return jsonList.map((e) => History1Model.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> saveAll(List<History1Model> items) async {
    final jsonList = items.map((e) => e.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await _storage.setString(_storageKey, jsonString);
  }

  Future<void> deleteByIds(Set<String> ids) async {
    final items = await getAll();
    final remaining = items.where((item) => !ids.contains(item.id)).toList();
    await saveAll(remaining);
  }

  Future<void> addItem(History1Model item) async {
    final items = await getAll();
    // Remove duplicate (same id) and prepend the new item
    final updated = [item, ...items.where((e) => e.id != item.id)];
    await saveAll(updated);
  }
}
