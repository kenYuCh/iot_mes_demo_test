import 'package:flutter/material.dart';

/// 可套用於任意列表的統一搜尋列。
class ListSearchBar extends StatelessWidget {
  const ListSearchBar({
    super.key,
    required this.controller,
    required this.query,
    required this.onChanged,
    this.hintText = '搜尋',
  });

  final TextEditingController controller;
  final String query;
  final ValueChanged<String> onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: controller,
      hintText: hintText,
      leading: const Icon(Icons.search),
      trailing: [
        if (query.isNotEmpty)
          IconButton(
            tooltip: '清除搜尋',
            onPressed: () {
              controller.clear();
              onChanged('');
            },
            icon: const Icon(Icons.close),
          ),
      ],
      onChanged: onChanged,
    );
  }
}

/// 不分大小寫的多關鍵字搜尋；以空白分隔的詞必須全部命中。
bool matchesListSearch(String query, Iterable<String?> fields) {
  final terms = query
      .trim()
      .toLowerCase()
      .split(RegExp(r'\s+'))
      .where((term) => term.isNotEmpty);
  if (terms.isEmpty) return true;
  final haystack = fields.whereType<String>().join(' ').toLowerCase();
  return terms.every(haystack.contains);
}
