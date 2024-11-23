import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roademics/core/utils/resources/generic_resource.dart';
import 'package:roademics/data/roadmaps/repository/roadmap_repository.dart';
import 'package:roademics/domain/roadmaps/entities/roadmap_entity.dart';
import 'package:roademics/presentation/roadmaps/bloc/get_bloc/get_roadmaps_event.dart';
import 'package:roademics/presentation/roadmaps/bloc/get_bloc/get_roadmaps_state.dart';

class GetRoadmapsBloc extends Bloc<GetRoadmapsEvent, GetRoadmapsState> {
  GetRoadmapsBloc() : super(const GetRoadmapsInitial()) {
    on<RoadmapRequested>((event, emit) async {
      emit(const GetRoadmapsLoading());

      GenericResource<List<Roadmap>> result =
          (await RoadmapRepository().getAllRoadmapsByUserId(event.ownerId));

      if (result is Success) {
        emit(GetRoadmapsSuccess(roadmaps: result.data!));
      } else {
        emit(GetRoadmapsError(message: result.message!));
      }
    });
  }
}
