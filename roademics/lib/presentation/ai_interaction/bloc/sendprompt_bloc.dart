import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roademics/core/utils/resources/generic_resource.dart';
import 'package:roademics/data/ai_interaction/repository/ai_repository.dart';
import 'package:roademics/domain/ai_interaction/entities/ai_interaction.dart';
import 'package:roademics/presentation/ai_interaction/bloc/sendprompt_event.dart';
import 'package:roademics/presentation/ai_interaction/bloc/sendprompt_state.dart';

class SendPromptBloc extends Bloc<SendPromptEvent, SendPromptState> {
  SendPromptBloc() : super(const SendPromptInitial()) {
    on<AIInteractionRequested>((event, emit) async {
      emit(const SendPromptLoading());

      GenericResource<AIInteraction> result =
          (await AIRepository().sendPrompt(prompt: event.prompt));

      if (result is Success) {
        emit(SendPromptSuccess(aiInteraction: result.data!));
      } else {
        emit(SendPromptError(message: result.message!));
      }
    });
  }
}
