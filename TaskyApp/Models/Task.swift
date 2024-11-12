//
//  Task.swift
//  TaskyApp
//
//  Created by Thayanne Mendes on 09/10/24.
//
struct Task {
    var title: String
    var description: String?
    var isCompleted: Bool = false
}

var tasks: [Task] = [
    Task(title: "café"),
    Task(title: "estudar", description: "MVC"),
    Task(title: "faculdade")
]

