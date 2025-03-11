//
//  TasksViewController.swift
//  TaskyApp
//
//  Created by Thayanne Mendes on 08/10/24.
//

import UIKit

protocol TaskDelegate: AnyObject {
    func didAddTask(newTask: Task)
}

class TasksViewController: UIViewController {
    
    private  var taskRepository: TaskRepository
    
    private lazy var taskTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .white
        table.delegate = self
        table.dataSource = self
        table.layer.cornerRadius = 24
        let header = TasksTableViewHeader(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64.0))
        header.delegate = self
        table.tableHeaderView = header
        return table
    }()
    
    private lazy var taskIlustrationImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: AssestsConstants.taskIlustration))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    init(taskRepository: TaskRepository = TaskRepository()) {
        self.taskRepository = taskRepository
        super.init(nibName: nil, bundle: nil) 
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        return taskRepository.tasks.count
    }
    
    private func createTaskCheckmarkButton(for index: Int) -> UIButton {
         let completeButton = UIButton()
        let task = taskRepository.tasks[index]
         
         let symbolName = task.isCompleted ? "checkmark.circle.fill" : "checkmark.circle"
         let configuration = UIImage.SymbolConfiguration(pointSize: 24)
         let image = UIImage(systemName: symbolName, withConfiguration: configuration)
         
         completeButton.setImage(image, for: .normal)
         completeButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
         completeButton.tag = index
         
        completeButton.addTarget(self, action: #selector(didTapCheckmarkButton(_:)), for: .touchUpInside)

         return completeButton
     }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = taskRepository.tasks[indexPath.row].title
        content.secondaryText = taskRepository.tasks[indexPath.row].description ?? ""
        cell.contentConfiguration = content
        let checkmarkButton = createTaskCheckmarkButton(for: indexPath.row)
        cell.accessoryView = checkmarkButton
        return cell
    }
    
    @objc private func didTapCheckmarkButton(_ sender: UIButton) {
        guard let cell = sender.superview as? UITableViewCell else { return }
        guard let indexPath = taskTableView.indexPath(for: cell) else { return }
        taskRepository.completeTask(at: indexPath.row)
        taskTableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            taskRepository.removeTask(at: indexPath.row)
            taskTableView.reloadData()
        }
    }
}


extension TasksViewController: TaskDelegate {
    func didAddTask(newTask: Task) {
        taskRepository.addTask(newTask: newTask)
        taskTableView.reloadData()
    }
}

extension TasksViewController: TasksTableViewHeaderDelegate {
    func didTapAddTaskButton() {
        let addTaskVC = AddTaskViewController()
        addTaskVC.delegate = self
        navigationController?.present(addTaskVC, animated: true)
    }
}
