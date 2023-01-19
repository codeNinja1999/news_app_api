class NewsCategoryUrl {
  static const String appleUrl =
      'everything?q=apple&from=2023-01-16&to=2023-01-16&sortBy=popularity&apiKey=';

  static const String teslaUrl =
      'everything?q=tesla&from=2022-12-19&sortBy=publishedAt&apiKey=';
  //need to update url otherwise use dateandtime to update date in realtime
  //for fetching data otherwise

  static const String usHeadlineUrl =
      'top-headlines?country=us&category=business&apiKey=';

  static const String techCrunchHeadlineUrl =
      'top-headlines?sources=techcrunch&apiKey=';

  static const String wallStreetJournalUrl =
      'everything?domains=wsj.com&apiKey=';
}
