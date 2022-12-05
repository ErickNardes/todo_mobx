import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_mobx/screens/login_screen.dart';
import 'package:todo_mobx/stores/list_store.dart';
import 'package:todo_mobx/stores/login_store.dart';
import 'package:todo_mobx/widgets/custom_text_field.dart';

import '../widgets/custom_icon.dart';

class ListScreen extends StatelessWidget {
  ListScreen({super.key});

  ListStore listStore = ListStore();

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: const EdgeInsets.fromLTRB(32, 0, 32, 32),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tarefas',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      Provider.of<LoginStore>(context, listen: false).logout();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (contex) => LoginScreen(),
                      ));
                    },
                    icon: const Icon(Icons.exit_to_app),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 16,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Observer(builder: (_) {
                        return CustomTextField(
                            controller: controller,
                            hint: 'Adicionar novas Tarefas',
                            onChanged: listStore.setNewTodoTitle,
                            enable: null,
                            obscure: false,
                            prefix: null,
                            suffix: listStore.isFormValid
                                ? CustomIconButton(
                                    color: Colors.deepPurpleAccent,
                                    radius: 32,
                                    iconData: Icons.add,
                                    onTap: () {
                                      listStore.addTodo();
                                      controller.clear();
                                    },
                                  )
                                : null);
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      Observer(builder: (_) {
                        return Expanded(
                            child: ListView.separated(
                                itemCount: listStore.todoList.length,
                                itemBuilder: (_, index) {
                                  final todo = listStore.todoList[index];
                                  return Observer(builder: (_) {
                                    return ListTile(
                                      title: Text(
                                        todo.title,
                                        style: TextStyle(
                                            decoration: todo.done
                                                ? TextDecoration.lineThrough
                                                : null,
                                            color: todo.done
                                                ? Colors.grey
                                                : Colors.black),
                                      ),
                                      onTap: todo.toggleDone,
                                      trailing: CustomIconButton(
                                        color: Colors.red,
                                        radius: 32,
                                        onTap: listStore.removeTodo,
                                        iconData: Icons.delete,
                                      ),
                                    );
                                  });
                                },
                                separatorBuilder: (_, __) {
                                  return const Divider();
                                }));
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
