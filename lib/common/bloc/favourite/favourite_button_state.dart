abstract class FavouriteButtonState{}

class FavouriteButtonInitialize extends FavouriteButtonState {}

class FavouriteButtonUpdated extends FavouriteButtonState {
  final bool isFavourite;
  FavouriteButtonUpdated({required this.isFavourite});
}

