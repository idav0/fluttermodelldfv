// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repository/model_repository.dart';
import 'presentation/cubit/model_cubit.dart'; // Asegúrate de que esta ruta sea correcta
import 'presentation/screens/model_get_all_screen.dart'; // Corregido el nombre del archivo

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ModelRepository(), // Corregido el nombre del repositorio
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ModelCubit(
              modelRepository: RepositoryProvider.of<ModelRepository>(context),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Model CRUD',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: ModelGetAllScreen(), // Corregido el nombre del screen
        ),
      ),
    );
  }
}
