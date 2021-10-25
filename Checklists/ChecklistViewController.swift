//
//  ViewController.swift
//  Checklists
//
//  Created by Nikolay Shiderov on 20.10.21.
//

import UIKit

var ChecklistVC = ChecklistViewController()

class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {
    
    var items = [Landmark]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - Add Item ViewController Delegates
    func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: Landmark) {
        let newRowIndex = items.count
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let controller = segue.destination as! AddItemViewController
            controller.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        fetchLandmarks()
    }
    
    func fetchLandmarks() {
        do {
            self.items = try context.fetch(Landmark.fetchRequest())
        } catch {
            
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ChecklistItem",
            for: indexPath)
        let landmark = items[indexPath.row]
        let label = cell.viewWithTag(1000) as! UILabel
        let description = cell.viewWithTag(2000) as! UILabel
        label.text = landmark.lmname
        description.text = landmark.lmdescription
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let action = UIContextualAction(style: .destructive, title: "Delete") {
            (action, view, completionHandler) in
            
            let itemToRemove = self.items[indexPath.row]
            self.context.delete(itemToRemove)
            do {
                try self.context.save()
            } catch {
                
            }
            self.fetchLandmarks()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}
