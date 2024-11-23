import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roademics/presentation/roadmaps/bloc/get_bloc/get_roadmaps_bloc.dart';
import 'package:roademics/presentation/roadmaps/bloc/get_bloc/get_roadmaps_event.dart';
import 'package:roademics/presentation/roadmaps/bloc/get_bloc/get_roadmaps_state.dart';
import 'package:roademics/presentation/roadmaps/bloc/post_bloc/create_roadmap_bloc.dart';
import 'package:roademics/presentation/ai_interaction/bloc/sendprompt_bloc.dart';
import 'package:roademics/presentation/ai_interaction/bloc/sendprompt_state.dart';
import 'package:roademics/presentation/ai_interaction/bloc/sendprompt_event.dart';
import 'package:roademics/domain/ai_interaction/entities/ai_interaction.dart';
import 'package:roademics/presentation/roadmaps/bloc/post_bloc/create_roadmap_event.dart';
import 'package:roademics/shared/presentation/widgets/loading_widget.dart';

class HomePage extends StatelessWidget {
  final String? userId;

  const HomePage({Key? key, this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Roadmaps")),
      body: BlocListener<SendPromptBloc, SendPromptState>(
        listener: (context, state) {
          if (state is SendPromptSuccess) {
            _createRoadmapFromAiInteraction(context, state.aiInteraction);
          } else if (state is SendPromptError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        child: Center(
          child: ElevatedButton(
            onPressed: () => _showRoadmapDecisionDialog(context),
            child: const Text("¿Quieres crear un Roadmap?"),
          ),
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
        .add(RoadmapRequested(ownerId: userId ?? ""));
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocBuilder<GetRoadmapsBloc, GetRoadmapsState>(
          builder: (context, state) {
            if (state is GetRoadmapsLoading) {
              return const LoadingWidget();
            } else if (state is GetRoadmapsSuccess) {
              return ListView.builder(
                itemCount: state.roadmaps.length,
                itemBuilder: (context, index) {
                  final roadmap = state.roadmaps[index];
                  return ListTile(
                    title: Text(roadmap.title),
                    subtitle: Text(roadmap.description),
                  );
                },
              );
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
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
              context.read<SendPromptBloc>().add(
                    AIInteractionRequested(prompt: controller.text),
                  );
            },
            child: const Text("Enviar"),
          ),
        ],
      ),
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
                  ownerId: userId ?? '',
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
