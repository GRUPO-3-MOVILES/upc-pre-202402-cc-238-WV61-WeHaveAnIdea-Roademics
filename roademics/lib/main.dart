import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roademics/presentation/authentication/bloc/login_bloc.dart';
import 'package:roademics/presentation/ai_interaction/bloc/sendprompt_bloc.dart';
import 'package:roademics/presentation/roadmaps/bloc/get_bloc/get_roadmaps_bloc.dart';
import 'package:roademics/presentation/roadmaps/bloc/post_bloc/create_roadmap_bloc.dart';
import 'package:roademics/presentation/authentication/pages/login_page.dart';
import 'package:roademics/presentation/registration/pages/sign_up_flow.dart';
import 'package:roademics/shared/presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => GetRoadmapsBloc()),
        BlocProvider(create: (_) => CreateRoadmapBloc()),
        BlocProvider(create: (_) => SendPromptBloc()), // <-- Add this here
      ],
      child: MaterialApp(
        title: 'Roademics',
        theme: ThemeData(
          fontFamily: 'Raleway',
        ),
        routes: {
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const SignUpFlowPage(),
        },
        initialRoute: '/login',
        onGenerateRoute: (settings) {
          if (settings.name == '/home') {
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (_) => HomePage(
                key: args['key'] as Key?,
                userId: args['userId'] as String?,
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}
