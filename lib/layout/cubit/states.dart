abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}

class NewsGetBusinessSuccessState extends NewsStates {}

class NewsGetBusinessErorrState extends NewsStates {
  final String error;
  NewsGetBusinessErorrState(this.error);
}

class NewsGetBusinessLoadingState extends NewsStates {}


class NewsGetSportsSuccessState extends NewsStates {}

class NewsGetSportsErorrState extends NewsStates {
  final String error;
  NewsGetSportsErorrState(this.error);
}

class NewsGetSportsLoadingState extends NewsStates {}


class NewsGetScienceSuccessState extends NewsStates {}

class NewsGetSciencesErorrState extends NewsStates {
  final String error;
  NewsGetSciencesErorrState(this.error);
}

class NewsGetScienceLoadingState extends NewsStates {}

class NewsGetSearchSuccessState extends NewsStates {}

class NewsGetSearchErorrState extends NewsStates {
  final String error;
  NewsGetSearchErorrState(this.error);
}

class NewsGetSearchLoadingState extends NewsStates {}



