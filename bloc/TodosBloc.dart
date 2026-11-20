import 'package:bloc/bloc.dart';

import 'event/TodoEvent.dart';
import 'state/TodoState.dart';

//제네릭 타입 : <이벤트 타입, 상태 타입>
class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc() : super(TodosState([])) {
    //상위 생성자 호출하면서.. 상태 초기값 지정.
    on<AddTodoEvent>((event, emit) {
      //이벤트 콜백 함수 등록.. 매개변수 : 발생이벤트, 상태 발생함수
      List<Todo> newTodos =
          List.from(state.todos) //state.. 이전 상태..
            ..add(event.todo);
      emit(TodosState(newTodos));
    });

    on<DeleteTodoEvent>((event, emit) {
      List<Todo> newTodos = List.from(state.todos)..remove(event.todo);
      emit(TodosState(newTodos));
    });

    on<ToggleCompletedTodoEvent>((event, emit) {
      List<Todo> newTodos = List.from(state.todos);
      int index = newTodos.indexOf(event.todo);
      newTodos[index].toggleCompleted();
      emit(TodosState(newTodos));
    });
  }

  //이벤트 발생시마다 정보 전달 목적으로 호출..
  @override
  void onTransition(Transition<TodosEvent, TodosState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}
