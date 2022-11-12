import 'dart:async';

import 'package:mobx/mobx.dart';

part 'pomodoro_store.g.dart';

class PomodoroStore = _PomodoroStore with _$PomodoroStore;

enum TipoIntervalo { emTrabalho, emDescanso }

abstract class _PomodoroStore with Store {
  @observable
  bool iniciado = false;

  @observable
  int minutos = 2;

  @observable
  int segundos = 0;

  @observable
  int tempoTrabalho = 2;

  @observable
  int tempoDescanso = 1;

  @observable
  TipoIntervalo tipoIntervalo = TipoIntervalo.emTrabalho;

  Timer? cronometro;

  @action
  void iniciar() {
    iniciado = true;
    cronometro = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (minutos == 0 && segundos == 0) {
          _trocarTipoIntervalo();
        } else if (segundos == 0) {
          segundos = 59;
          minutos--;
        } else {
          segundos--;
        }
      },
    );
  }

  @action
  void parar() {
    iniciado = false;
    cronometro?.cancel();
  }

  @action
  void reiniciar() {
    parar();
    minutos = estaTrabalhando() ? tempoTrabalho : tempoDescanso;
    segundos = 0;
  }

  @action
  void incrementarTempo() {
    tempoTrabalho++;
    if (estaTrabalhando()) {
      reiniciar();
    }
  }

  @action
  void decrementarTempo() {
    tempoTrabalho--;
    if (estaTrabalhando()) {
      reiniciar();
    }
  }

  @action
  void incrementarDescanso() {
    tempoDescanso++;
    if (estaDescansado()) {
      reiniciar();
    }
  }

  @action
  void decrementarDescanso() {
    tempoDescanso--;
    if (estaDescansado()) {
      reiniciar();
    }
  }

  bool estaTrabalhando() {
    return tipoIntervalo == TipoIntervalo.emTrabalho;
  }

  bool estaDescansado() {
    return tipoIntervalo == TipoIntervalo.emDescanso;
  }

  void _trocarTipoIntervalo() {
    if (estaTrabalhando()) {
      tipoIntervalo = TipoIntervalo.emDescanso;
      minutos = tempoDescanso;
    } else {
      tipoIntervalo = TipoIntervalo.emTrabalho;
      minutos = tempoTrabalho;
    }
    segundos = 0;
  }
}
