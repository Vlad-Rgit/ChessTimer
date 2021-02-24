import 'package:flutter/cupertino.dart';

abstract class HomeIntent {
  factory HomeIntent.refresh() => RefreshHomeIntent();
  factory HomeIntent.updateSearchQuery(String newQuery) {
    return UpdateSearchQueryIntent(newQuery: newQuery);
  }
}

class RefreshHomeIntent implements HomeIntent {}

class UpdateSearchQueryIntent implements HomeIntent {
  final String newQuery;
  const UpdateSearchQueryIntent({@required this.newQuery});
}
