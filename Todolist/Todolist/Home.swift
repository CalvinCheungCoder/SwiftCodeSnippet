//
//  Home.swift
//  Todolist
//
//  Created by Calvin on 2019/8/17.
//  Copyright © 2019 Calvin. All rights reserved.
//

import SwiftUI

var editingMode: Bool = false
var editingTodo: Todo = emptyTodo
var editingIndex: Int = 0
var detailsShouldUpdateTitle: Bool = false


class Main: ObservableObject {
    @Published var todos: [Todo] = []
    @Published var detailDueDate: Date = Date()
    @Published var detailsShowing: Bool = false
    @Published var detailsTitle: String = ""
    
    func sort() {
        self.todos.sort(by: {$0.dueDate.timeIntervalSince1970 < $1.dueDate.timeIntervalSince1970})
        for i in 0 ..< self.todos.count {
            self.todos[i].i = i
        }
    }
}

struct Home: View {
    @ObservedObject var main: Main
    var body: some View {
        ZStack {
            TodoList(main: main)
                .blur(radius: main.detailsShowing ? 10 : 0)
                .animation(.spring())
            Button(action: {
                editingMode = false
                editingTodo = emptyTodo
                detailsShouldUpdateTitle = true
                self.main.detailsTitle = ""
                self.main.detailDueDate = Date()
                self.main.detailsShowing = true
            }) {
                btnAdd()
            }
            .blur(radius: main.detailsShowing ? 10 : 0)
            .offset(x: UIScreen.main.bounds.width/2 - 60, y: UIScreen.main.bounds.height/2 - 80)
            .animation(.spring())
            TodoDetails(main: main)
                .offset(x: 0, y: main.detailsShowing ? 0 : UIScreen.main.bounds.height)
                .animation(.spring())
        }
    }
}

struct btnAdd: View {
    var size: CGFloat = 65.0
    var body: some View {
        ZStack {
            Group {
                Circle()
                    .fill(Color("btnAdd-bg"))
            }.frame(width: self.size, height: self.size)
                .shadow(color: Color("btnAdd-shadow"), radius: 10)
            Group {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: size, height: size)
                    .foregroundColor(Color("theme"))
            }
        }
    }
}

//#if DEBUG
//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
////        TodoItem(main: Main(), todoIndex: .contant(0))
//    }
//}
//#endif
