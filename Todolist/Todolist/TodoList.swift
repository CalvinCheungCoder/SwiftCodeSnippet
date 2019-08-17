//
//  TodoList.swift
//  Todolist
//
//  Created by Calvin on 2019/8/17.
//  Copyright © 2019 Calvin. All rights reserved.
//

import SwiftUI

var exampletTodos: [Todo] = [
    Todo(title: "学习 Swift", dueDate: Date()),
    Todo(title: "学习 Python", dueDate: Date()),
    Todo(title: "学习强国", dueDate: Date()),
    Todo(title: "学习 HTML", dueDate: Date().addingTimeInterval(200000)),
    Todo(title: "看美剧", dueDate: Date()),
    Todo(title: "打扫卫生", dueDate: Date())
]


struct TodoList: View {
    @ObservedObject var main: Main
    
    var body: some View {
        NavigationView{
            ScrollView{
                ForEach(main.todos){ todo in
                    VStack{
                        if todo.i == 0 || formatter.string(from: todo.dueDate) != formatter.string(from: self.main.todos[todo.i - 1].dueDate)
                        {
                            HStack{
                                Spacer().frame(width: 30)
                                Text(date2Word(date: todo.dueDate))
                                Spacer()
                            }
                        }
                        HStack{
                            Spacer().frame(width: 20)
                            TodoItem(main: self.main, todoIndex:.constant(todo.i))
                                .cornerRadius(10)
                                .clipped()
                                .shadow(color: Color("todoItemShadow"), radius: 5)
                            Spacer().frame(width: 25)
                        }
                        Spacer().frame(height: 20)
                    }
                }
                Spacer().frame(height: 150)
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitle(Text("待办事项").foregroundColor(Color("theme")))
            .onAppear {
                if let data = UserDefaults.standard.object(forKey: "todos") as? Data {
                    let todolist = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Todo] ?? []
                    for todo in todolist {
                        if !todo.checked {
                            self.main.todos.append(todo)
                        }
                    }
                    self.main.sort()
                } else {
                    self.main.todos = exampletTodos
                    self.main.sort()
                }
            }
        }
    }
}

#if DEBUG
struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        TodoList(main: Main())
    }
}
#endif
