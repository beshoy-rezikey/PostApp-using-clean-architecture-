
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:postapp2/posts/data/dataSoureces/LocalDataSource.dart';
import 'package:postapp2/posts/data/dataSoureces/RemoteDataSource.dart';
import 'package:postapp2/posts/data/repo/repoImp.dart';
import 'package:postapp2/posts/domain/repo/postRepo.dart';
import 'package:postapp2/posts/domain/useCases/addPost.dart';
import 'package:postapp2/posts/domain/useCases/deletePost.dart';
import 'package:postapp2/posts/domain/useCases/getAllPosts.dart';
import 'package:postapp2/posts/domain/useCases/updatePost.dart';
import 'package:postapp2/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:postapp2/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/networkInfo.dart';

final GetIt sl = GetIt.instance;
Future<void> init() async {
  /// features - post

//bloc

  sl.registerFactory(() =>  PostsBloc(getAllPosts: sl()));
  sl.registerFactory(() => AddDeleteUpdatePostBloc(
      addPost: sl(), deletePost: sl(), updatePost: sl()));

//usecases
  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));

//repo
  sl.registerLazySingleton<PostRepo>(() => PostRepoImplement(
      networkInfo: sl(), remoteDataSource: sl(), localDataSource: sl()));

// data sources

sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImplement(client: sl()));
sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImplement(sharedPreferences: sl()));

  ///core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkINfoImpl(sl()));

  ///external
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(()=>sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());


  }
