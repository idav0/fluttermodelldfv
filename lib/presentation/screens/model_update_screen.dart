// lib/presentation/screens/model_update_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/model_cubit.dart';
import '../../data/models/model_model.dart';

class ModelUpdateScreen extends StatelessWidget {
  final Model model;
  ModelUpdateScreen({required this.model});

  @override
  Widget build(BuildContext context) {
    final _nombreController = TextEditingController(text: model.nombre);
    final _tipoController = TextEditingController(text: model.tipo);
    final _longitudController = TextEditingController(text: model.longitud);
    final _velocidadMaximaController = TextEditingController(text: model.velocidadMaxima);

    return Scaffold(
      appBar: AppBar(title: Text('Actualizar Modelo')),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextFormField(
                controller: _tipoController,
                decoration: InputDecoration(labelText: 'Tipo'),
              ),
              TextFormField(
                controller: _longitudController,
                decoration: InputDecoration(labelText: 'Longitud'),
              ),
              TextFormField(
                controller: _velocidadMaximaController,
                decoration: InputDecoration(labelText: 'Velocidad Máxima'),
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                onPressed: () {
                  final updatedModel = Model(
                    id: model.id,
                    nombre: _nombreController.text,
                    tipo: _tipoController.text,
                    longitud: _longitudController.text,
                    velocidadMaxima: _velocidadMaximaController.text,
                  );
                  context.read<ModelCubit>().updateModel(updatedModel);
                  Navigator.of(context).pop();
                },
                child: Text('Guardar Cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
