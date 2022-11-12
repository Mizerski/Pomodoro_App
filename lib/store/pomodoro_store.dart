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

  @action
  void iniciar() {
    iniciado = true;
  }

  @action
  void parar() {
    iniciado = false;
  }

  @action
  void reiniciar() {
    iniciado = false;
  }

  @action
  void incrementarTempo() {
    tempoTrabalho++;
  }

  @action
  void decrementarTempo() {
    tempoTrabalho--;
  }

  @action
  void incrementarDescanso() {
    tempoDescanso++;
  }

  @action
  void decrementarDescanso() {
    tempoDescanso--;
  }

  bool estaTrabalhando() {
    return tipoIntervalo == TipoIntervalo.emTrabalho;
  }

  bool estaDescansado() {
    return tipoIntervalo == TipoIntervalo.emDescanso;
  }
}
