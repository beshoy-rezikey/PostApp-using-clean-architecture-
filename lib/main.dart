
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postapp2/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:postapp2/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:postapp2/posts/presentation/pages/postPage.dart';
import 'injection_container.dart' as di;

import 'core/appTheme/appTheme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();


  runApp( MyApp());
}

class MyApp extends StatelessWidget  {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)  {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
          BlocProvider(create: (_)=>di.sl<AddDeleteUpdatePostBloc>())],
        child: MaterialApp(
          theme: appTheme,
          debugShowCheckedModeBanner: false,
          title: 'Posts App',
          home:PostPage() ,
        ));
  }
}
