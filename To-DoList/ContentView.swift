//
//  ContentView.swift
//  To-DoList
//
//  Created by scholar on 8/2/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    private func deleteTask(offsets: IndexSet) {
            withAnimation {
                offsets.map { toDoItems[$0] }.forEach(context.delete)

                do {
                    try context.save()
                } catch {
                    print(error)
                }
            }
        }
    @FetchRequest(
            entity: ToDo.entity(), sortDescriptors: [ NSSortDescriptor(keyPath: \ToDo.id, ascending: false) ])
        
    var toDoItems: FetchedResults<ToDo>
    @State private var showNewTask = false
    var body: some View {
        VStack{
            HStack{
                Text("To Do List")
                    .font(.system(size: 40))
                        .fontWeight(.black)
                        .padding()
                Spacer()
                Button(action: {
                    self.showNewTask = true
                }) {
                Text("+")
                        .padding()
                }//end of button
            }//HStack
            Spacer()
            .padding()
        }//VStack
        List {
                ForEach (toDoItems) { toDoItem in
                    if toDoItem.isImportant == true {
                        Text("‼️" + (toDoItem.title ?? "No title"))
                    } else {
                                        Text(toDoItem.title ?? "No title")
                    }
                    }.onDelete(perform: deleteTask)
        }//list
        .listStyle(.plain)
        if showNewTask {
            NewToDoView(title: "", isImportant: false, showNewTask: $showNewTask)
                }
    }//some view
}//struct

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
