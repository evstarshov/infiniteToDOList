//
//  ChildViewController.swift
//  infiniteToDoList
//
//  Created by Евгений Старшов on 22.01.2022.
//

import UIKit

class ChildViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!


    var tasks: [TaskProtocol] = []
    
    let child = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "TaskTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "taskCell")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell") as! TaskTableViewCell
        cell.configureTask(with: tasks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("connecting child")
        let vc = storyboard!.instantiateViewController(withIdentifier: "ChildVC") as! ChildViewController
        configureChildViewController(childController: vc, onView: nil)
    }
    
    
    @IBAction func addTask() {
        addFolder()
    }
    
    
    @IBAction func backButtonTapped() {
        print("reversing child")
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    private func addFolder() {
        let textController = UIAlertController(title: "Enter folder name", message: nil, preferredStyle: .alert)
        textController.addTextField()
        textController.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned textController] _ in
            let answerName = textController.textFields![0]
            let answerDesc = textController.textFields![1]
            self.tasks.append(RootFolder(name: answerName.text ?? "No name", description: answerDesc.text ?? "no description"))
            print("Appending folder \(answerName.text ?? "empty name")")
            self.tableView.reloadData()
        }
        textController.addAction(submitAction)
        present(textController, animated: true)
    }
    

}
