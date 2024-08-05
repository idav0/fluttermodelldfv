// lib/presentation/screens/model_create_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/model_cubit.dart';
import '../../data/models/model_model.dart';

class ModelCreateScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _tipoController = TextEditingController();
  final _longitudController = TextEditingController();
  final _velocidadMaximaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear Nuevo Modelo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _tipoController,
                decoration: InputDecoration(labelText: 'Tipo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el tipo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _longitudController,
                decoration: InputDecoration(labelText: 'Longitud'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la longitud';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _velocidadMaximaController,
                decoration: InputDecoration(labelText: 'Velocidad Máxima (km/h)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la velocidad máxima';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newModel = Model(
                      id: 0, // ID no se necesita al crear
                      nombre: _nombreController.text,
                      tipo: _tipoController.text,
                      longitud: _longitudController.text,
                      velocidadMaxima: _velocidadMaximaController.text,
                    );
                    context.read<ModelCubit>().createModel(newModel);
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Crear Modelo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
