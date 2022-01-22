//
//  ViewController.swift
//  infiniteToDoList
//
//  Created by Евгений Старшов on 22.01.2022.
//

import UIKit

class ParentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var addButton: UIBarButtonItem!
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
    
    private func addFolder() {
        let textController = UIAlertController(title: "Enter folder name", message: nil, preferredStyle: .alert)
        textController.addTextField()
        textController.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned textController] _ in
            let answerName = textController.textFields![0]
            let answerDesc = textController.textFields![1]
            self.tasks.append(RootFolder(name: answerName.text ?? "No name", description: answerDesc.text ?? {
                let taskNames = self.tasks.compactMap {$0.description}.joined(separator: ",")
                return "tasks \(taskNames)"
            }()))
            print("Appending folder \(answerName.text ?? "empty name")")
            self.tableView.reloadData()
        }
        textController.addAction(submitAction)
        present(textController, animated: true)
    }
    

    
    
}


extension UIViewController {
    
    func configureChildViewController(childController: UIViewController, onView: UIView?) {
        var holderView = self.view
        if let onView = onView {
            holderView = onView
        }
        addChild(childController)
        holderView?.addSubview(childController.view)
        constrainViewEqual(holderView: holderView!, view: childController.view)
        childController.didMove(toParent: self)
    }


    func constrainViewEqual(holderView: UIView, view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        //pin 100 points from the top of the super
        let pinTop = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal,
                                    toItem: holderView, attribute: .top, multiplier: 1.0, constant: 0)
        let pinBottom = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal,
                                       toItem: holderView, attribute: .bottom, multiplier: 1.0, constant: 0)
        let pinLeft = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal,
                                     toItem: holderView, attribute: .left, multiplier: 1.0, constant: 0)
        let pinRight = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal,
                                      toItem: holderView, attribute: .right, multiplier: 1.0, constant: 0)

        holderView.addConstraints([pinTop, pinBottom, pinLeft, pinRight])
    }
}
