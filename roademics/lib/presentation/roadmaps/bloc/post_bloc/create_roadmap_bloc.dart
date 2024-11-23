import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roademics/core/utils/resources/generic_resource.dart';
import 'package:roademics/data/roadmaps/repository/roadmap_repository.dart';
import 'package:roademics/domain/roadmaps/entities/roadmap_entity.dart';
import 'package:roademics/presentation/roadmaps/bloc/post_bloc/create_roadmap_event.dart';
import 'package:roademics/presentation/roadmaps/bloc/post_bloc/create_roamap_state.dart';

class CreateRoadmapBloc extends Bloc<CreateRoadmapEvent, CreateRoadmapState> {
  CreateRoadmapBloc() : super(const CreateRoadmapInitial()) {
    on<RoadmapSubmitted>((event, emit) async {
      emit(const CreateRoadmapLoading());

      GenericResource<Roadmap> result = await RoadmapRepository().createRoadmap(
        ownerId: event.ownerId,
        title: event.title,
        description: event.description,
        aiInteractionId: event.aiInteractionId,
      );

      if (result is Success) {
        emit(CreateRoadmapSuccess(roadmap: result.data!));
      } else {
        emit(CreateRoadmapError(message: result.message!));
      }
    });
  }
}
