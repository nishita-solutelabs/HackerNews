import 'package:get_it/get_it.dart';
import 'package:hackernews_topstories/services/article_details.dart';
import 'package:hackernews_topstories/services/networking.dart';

final GetIt locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton<Network>(
    () => Network(),
  );
  locator.registerLazySingleton<ArticleDetails>(
    () => ArticleDetails(),
  );
}
