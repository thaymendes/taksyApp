//
//  TasksViewController.swift
//  TaskyApp
//
//  Created by Thayanne Mendes on 08/10/24.
//

import UIKit

class TasksViewController: UIViewController {
    
    private lazy var taskTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .white
        table.delegate = self
        table.dataSource = self
        table.layer.cornerRadius = 24
        let header = TasksTableViewHeader(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64.0))
        table.tableHeaderView = header
        return table
    }()
    
    private lazy var taskIlustrationImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: AssestsConstants.taskIlustration))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackgroundGradient()
        setupNavigationBar()
        addSubviews()
        setupConstraints()
    }
    
    private func setupNavigationBar(){
        navigationItem.hidesBackButton = true
    }
    
    private func addSubviews(){
        view.addSubview(taskIlustrationImageView)
        view.addSubview(taskTableView)
        
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            
            taskIlustrationImageView.topAnchor.constraint(equalTo: view.topAnchor),
            taskIlustrationImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            taskTableView.topAnchor.constraint(equalTo: taskIlustrationImageView.bottomAnchor, constant: -10),
            taskTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            taskTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            taskTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
}

extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = tasks[indexPath.row].title
        content.secondaryText = tasks[indexPath.row].description ?? ""
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Toque no botão de remover")
        }
    }
}

