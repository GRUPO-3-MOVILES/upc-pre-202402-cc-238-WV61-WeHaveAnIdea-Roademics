import 'package:roademics/core/utils/resources/generic_resource.dart';
import 'package:roademics/data/ai_interaction/remote/ai_dto.dart';
import 'package:roademics/data/ai_interaction/remote/ai_service.dart';
import 'package:roademics/domain/ai_interaction/entities/ai_interaction.dart';

class AIRepository {
  final AiService _aiService = AiService();

  Future<GenericResource<AIInteraction>> SendPrompt(
      {required String prompt}) async {
    GenericResource<AiDto> result = await _aiService.SendPrompt(prompt: prompt);

    if (result is Success) {
      return Success(result.data!.toAIInteraction());
    } else {
      return Error(result.message!);
    }
  }
}
