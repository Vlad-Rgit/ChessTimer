abstract class HomeIntent {
  factory HomeIntent.refresh() => RefreshHomeIntent();
}

class RefreshHomeIntent implements HomeIntent {}
