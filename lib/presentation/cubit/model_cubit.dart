// lib/presentation/cubit/model_cubit.dart

import 'package:bloc/bloc.dart';
import '../../data/models/model_model.dart';
import '../../data/repository/model_repository.dart';
import 'model_state.dart';

class ModelCubit extends Cubit<ModelState> {
  final ModelRepository modelRepository;

  ModelCubit({required this.modelRepository}) : super(ModelInitial());

  Future<void> createModel(Model model) async {
    try {
      emit(ModelLoading());
      await modelRepository.createModel(model);
      final models = await modelRepository.getModels();
      emit(ModelSuccess(models: models));
    } catch (e) {
      emit(ModelError(message: e.toString()));
    }
  }

  Future<void> getModel(int id) async {
    try {
      emit(ModelLoading());
      final models = await modelRepository.getModels();
      final model = models.firstWhere((element) => element.id == id);
      emit(ModelSuccess(models: [model]));
    } catch (e) {
      emit(ModelError(message: e.toString()));
    }
  }

  Future<void> updateModel(Model model) async {
    try {
      emit(ModelLoading());
      await modelRepository.updateModel(model);
      final models = await modelRepository.getModels();
      emit(ModelSuccess(models: models));
    } catch (e) {
      emit(ModelError(message: e.toString()));
    }
  }

  Future<void> deleteModel(int id) async {
    try {
      emit(ModelLoading());
      await modelRepository.deleteModel(id); // Asegúrate de que 'id' es un int
      final models = await modelRepository.getModels();
      emit(ModelSuccess(models: models));
    } catch (e) {
      emit(ModelError(message: e.toString()));
    }
  }

  Future<void> fetchAllModels() async {
    try {
      emit(ModelLoading());
      final models = await modelRepository.getModels();
      emit(ModelSuccess(models: models));
    } catch (e) {
      emit(ModelError(message: e.toString()));
    }
  }
}
