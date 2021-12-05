abstract class NewsStates{}

class NewsInitialState extends NewsStates{}

class NewsBottomNavState extends NewsStates{}


//business
class NewsGetBusinessLoadingState extends NewsStates{}

class NewsGetBusinessStateSuccess extends NewsStates{}

class NewsGetBusinessStateFail extends NewsStates{
  final String error;
  NewsGetBusinessStateFail(this.error);
}
//science
class NewsGetScienceLoadingState extends NewsStates{}

class NewsGetScienceStateSuccess extends NewsStates{}

class NewsGetScienceStateFail extends NewsStates{
  final String error;
  NewsGetScienceStateFail(this.error);
}
//sports
class NewsGetSportsLoadingState extends NewsStates{}

class NewsGetSportsStateSuccess extends NewsStates{}

class NewsGetSportsStateFail extends NewsStates{
  final String error;
  NewsGetSportsStateFail(this.error);
}


//dark mode light mode
class AppChangeModeState extends NewsStates{}