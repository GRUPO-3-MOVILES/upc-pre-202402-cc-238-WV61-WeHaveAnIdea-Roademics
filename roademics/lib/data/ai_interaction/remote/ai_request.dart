class AIRequest {
  final String prompt;

  AIRequest({
    required this.prompt,
  });

  Map<String, dynamic> toMap() {
    return {
      'prompt': prompt,
    };
  }
}
