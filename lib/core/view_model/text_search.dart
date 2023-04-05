import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:flutter/foundation.dart';

class TextSearch extends ChangeNotifier {
  String _searchText = "";
  late HitsSearcher _hitSearch;

  void initHitSearcher(String index) {
    _hitSearch = HitsSearcher(
    applicationID: "LEPUBBA9NX", 
    apiKey: "558b4a129c0734cd6cc62f5d78e585d2", 
    indexName: index);
  }

  get getSearchText => _searchText;
  HitsSearcher get getHitsSearcher => _hitSearch;
  void setSearchText(String text) {
    if (text.isNotEmpty) {
      _searchText = text;
    } else {
      _searchText = "";
    }
    notifyListeners();
  } 

  void clearSearchText() {
    _searchText = "";
  }
}