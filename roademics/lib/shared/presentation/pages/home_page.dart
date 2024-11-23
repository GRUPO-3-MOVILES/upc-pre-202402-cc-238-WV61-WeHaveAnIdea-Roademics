import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roademics/domain/ai_interaction/entities/ai_interaction.dart';
import 'package:roademics/presentation/ai_interaction/bloc/sendprompt_event.dart';
import 'package:roademics/presentation/ai_interaction/bloc/sendprompt_state.dart';
import 'package:roademics/presentation/roadmaps/bloc/get_bloc/get_roadmaps_bloc.dart';
import 'package:roademics/presentation/roadmaps/bloc/get_bloc/get_roadmaps_event.dart';
import 'package:roademics/presentation/roadmaps/bloc/get_bloc/get_roadmaps_state.dart';
import 'package:roademics/presentation/roadmaps/bloc/post_bloc/create_roadmap_bloc.dart';
import 'package:roademics/presentation/ai_interaction/bloc/sendprompt_bloc.dart';
import 'package:roademics/domain/roadmaps/entities/roadmap_entity.dart';
import 'package:roademics/presentation/roadmaps/bloc/post_bloc/create_roadmap_event.dart';

class HomePage extends StatelessWidget {
  final String userId;

  const HomePage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Roadmaps")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showRoadmapDecisionDialog(context),
          child: const Text("¿Quieres crear un Roadmap?"),
        ),
      ),
    );
  }

  void _showRoadmapDecisionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Crear Roadmap"),
        content: const Text("¿Quieres crear un nuevo roadmap?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showUserRoadmaps(context);
            },
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showPromptDialog(context);
            },
            child: const Text("Sí"),
          ),
        ],
      ),
    );
  }

  void _showUserRoadmaps(BuildContext context) {
    BlocProvider.of<GetRoadmapsBloc>(context)
        .add(RoadmapRequested(ownerId: userId));
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocBuilder<GetRoadmapsBloc, GetRoadmapsState>(
          builder: (context, state) {
            if (state is GetRoadmapsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetRoadmapsSuccess) {
              if (state.roadmaps.isEmpty) {
                return Center(
                  child: ElevatedButton(
                    onPressed: () => _showPromptDialog(context),
                    child: const Text("Crear Roadmap"),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: state.roadmaps.length,
                  itemBuilder: (context, index) {
                    final roadmap = state.roadmaps[index];
                    return ListTile(
                      title: Text(roadmap.title),
                      subtitle: Text(roadmap.description),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RoadmapDetailPage(roadmap: roadmap),
                        ),
                      ),
                    );
                  },
                );
              }
            } else if (state is GetRoadmapsError) {
              return Center(child: Text("Error: ${state.message}"));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _showPromptDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController controller = TextEditingController();
        return AlertDialog(
          title: const Text("¿A qué te gustaría dedicarte?"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: "Escribe tu idea..."),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                BlocProvider.of<SendPromptBloc>(context).add(
                  AIInteractionRequested(prompt: controller.text),
                );
                _handleAiResponse(context, controller.text);
              },
              child: const Text("Enviar"),
            ),
          ],
        );
      },
    );
  }

  void _handleAiResponse(BuildContext context, String prompt) {
    BlocBuilder<SendPromptBloc, SendPromptState>(
      builder: (context, state) {
        if (state is SendPromptLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SendPromptSuccess) {
          final aiInteraction = state.aiInteraction;
          _createRoadmapFromAiInteraction(context, aiInteraction);
        } else if (state is SendPromptError) {
          return Center(child: Text("Error: ${state.message}"));
        }
        return const SizedBox.shrink();
      },
    );
  }

  void _createRoadmapFromAiInteraction(
      BuildContext context, AIInteraction aiInteraction) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Crear Roadmap"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(hintText: "Título del Roadmap"),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(hintText: "Descripción"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              BlocProvider.of<CreateRoadmapBloc>(context).add(
                RoadmapSubmitted(
                  id: DateTime.now().toIso8601String(),
                  ownerId: userId,
                  title: titleController.text,
                  description: descriptionController.text,
                  aiInteractionId: aiInteraction.id,
                ),
              );
            },
            child: const Text("Crear"),
          ),
        ],
      ),
    );
  }
}

class RoadmapDetailPage extends StatelessWidget {
  final Roadmap roadmap;

  const RoadmapDetailPage({Key? key, required this.roadmap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(roadmap.title)),
      body: Center(
        child: Text("Detalles del Roadmap: ${roadmap.description}"),
      ),
    );
  }
}
