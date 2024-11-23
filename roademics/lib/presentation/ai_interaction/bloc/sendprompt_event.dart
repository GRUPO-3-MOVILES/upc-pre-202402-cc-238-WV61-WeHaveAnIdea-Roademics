abstract class SendPromptEvent {
  const SendPromptEvent();
}

class AIInteractionRequested extends SendPromptEvent {
  final String prompt;

  const AIInteractionRequested({required this.prompt});
}
