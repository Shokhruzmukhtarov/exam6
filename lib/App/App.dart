import 'package:exam5/Blocs_Cubits/Cubit/Single_Cubit/Single_Random_User_Cubit.dart';
import 'package:exam5/Blocs_Cubits/Cubit/Tabbox_Cubit/tab_box_cubit.dart';
import 'package:exam5/Data/Repos/Notification_Repo.dart';
import 'package:exam5/Data/Services/Api_Serviece.dart';
import 'package:exam5/ui/TabBox/TabBox.dart';
import 'package:exam5/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Data/Repos/Random_User_Repo.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context)=>NotificationRepo()),
          RepositoryProvider(
              create: (context) => RandomUserRepo(apiservices: getIt<Apiservices>()))
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => SingleRandomUserCubit(
                    randomUserRepository: context.read<RandomUserRepo>())),
            BlocProvider(create: (context)=>TabBoxCubit())
          ],
          child: MyApp(),
        ));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TabBox(),
    );
  }
}
