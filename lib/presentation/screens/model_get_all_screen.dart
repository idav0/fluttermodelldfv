import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/model_cubit.dart';
import '../cubit/model_state.dart';
import '../../data/models/model_model.dart';
import 'model_update_screen.dart';
import 'model_insert_screen.dart';

class ModelGetAllScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Models'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => context.read<ModelCubit>().fetchAllModels(),
          ),
        ],
      ),
      body: BlocBuilder<ModelCubit, ModelState>(
        builder: (context, state) {
          if (state is ModelLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ModelSuccess) {
            final models = state.models;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: models.length,
                itemBuilder: (context, index) {
                  final model = models[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      title: Text(
                        model.nombre,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4),
                          Text('Tipo: ${model.tipo}', style: TextStyle(color: Colors.black54)),
                          SizedBox(height: 4),
                          Text('Velocidad Máxima: ${model.velocidadMaxima} km/h', style: TextStyle(color: Colors.black54)),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => context.read<ModelCubit>().deleteModel(model.id),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => ModelUpdateScreen(model: model)),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          } else if (state is ModelError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Center(child: Text('No data available.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => ModelCreateScreen()),
        ),
      ),
    );
  }
}
