import 'package:roademics/domain/ai_interaction/entities/ai_interaction.dart';

abstract class SendPromptState {
  const SendPromptState();
}

class SendPromptInitial extends SendPromptState {
  const SendPromptInitial();
}

class SendPromptLoading extends SendPromptState {
  const SendPromptLoading();
}

class SendPromptSuccess extends SendPromptState {
  final AIInteraction aiInteraction;

  const SendPromptSuccess({required this.aiInteraction});
}

class SendPromptError extends SendPromptState {
  final String message;

  const SendPromptError({required this.message});
}
