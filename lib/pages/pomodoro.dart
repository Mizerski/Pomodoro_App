import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:t/components/cronometro.dart';
import 'package:t/components/entrada_tempo.dart';
import 'package:provider/provider.dart';
import '../store/pomodoro_store.dart';

class Pomodoro extends StatelessWidget {
  const Pomodoro({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(child: Cronometro()),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Observer(
              builder: (_) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  EntradaTempo(
                    titulo: 'Trabalho',
                    valor: store.tempoTrabalho,
                    inc: store.iniciado && store.estaTrabalhando()
                        ? null
                        : store.incrementarTempo,
                    //
                    dec: store.iniciado && store.estaTrabalhando()
                        ? null
                        : store.decrementarTempo,
                  ),
                  EntradaTempo(
                    titulo: 'Descanso',
                    valor: store.tempoDescanso,
                    inc: store.iniciado && store.estaDescansado()
                        ? null
                        : store.incrementarDescanso,
                    //
                    dec: store.iniciado && store.estaDescansado()
                        ? null
                        : store.decrementarDescanso,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
