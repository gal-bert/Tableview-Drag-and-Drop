//
//  ViewController.swift
//  SDL-DragDrop
//
//  Created by Gregorius Albert on 22/04/22.
//

import UIKit

class ViewController: UIViewController {

    /**
     Connect the tableview from the Storyboard scene into the view controller
     */
    @IBOutlet weak var tableView: UITableView!

    /**
     Prepare the array that contains data to bind into the tableview.
     The array type can be anything (array of Any). Doesn't always have to be string.
     You can gather the data to be appended to the array from an API request, Core Data, UserDefaults, etc.
     */
    var arrFruits = ["Apple", "Banana", "Cider", "Papaya", "Orange", "Watermelon"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**
         You can register the tableview cell on viewDidLoad().
         But it is usually used if you are using a custom cell like using an XIB cell.
         Registering the cell is not really mandatory in this case.
         */
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        /**
         Initialize the tableview delegate, datasource, and dragdrop interface
         */
        tableView.delegate = self
        tableView.dataSource = self
        tableView.dragDelegate = self
        
        /**
         To enable drag and drop actions, don't forget to set the drag interaction to true.
         */
        tableView.dragInteractionEnabled = true
    }

}

/**
 We can use extensions to split our protocol stubs outside the class closure for tidiness.
 */

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    /**
     The `numberOfRowsInSection` stub controls how many cells to render into the tableview.
     Usually, we want to render the cells dynamically based on the number of contents inside our array.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFruits.count
    }
    
    /**
     The `cellForRowAt` stub enables you to set what happen to the cell on each row.
     Here, we define each cell on each row to show our fruit name.
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /**
         Declare and initialize the reusable `UITableViewCell` you've inserted from the storyboard.
         Make sure the identifier name is IDENTICAL.
         */
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        /**
         Use the `textLabel?.text` attribute on the cell to put value into the title section on each cell.
         */
        cell?.textLabel?.text = arrFruits[indexPath.row]
        
        /**
         Don't forget to return the `UITableViewCell` you've initialized
         */
        return cell!
    }
    
    /**
     The `didSelectRowAt` stub enables you to control what will happen when the user clicks on each cell.
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row \(indexPath.row)")
        // Put logic here
    }
    
    /**
     The `commit` editingStyle stub enables you to set a default swipe actions on the tableview cell.
     Usually used for the delete function.
     */
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        /**
//         Selection for when the user selects the `delete` button
//         */
//
//        if editingStyle == .delete {
//            arrFruits.remove(at: indexPath.row)
//            // Put logic here
//
//            /**
//             Don't forget to always reload the tableView data to rebind the updated data into the tableview.
//             */
//            tableView.reloadData()
//        }
//    }
    
    /**
     The `editActionsForRowAt` stub enables you to set a custom swipe actions on the tableview cell.
     */
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        /**
         Create what action you want the user to click.
         Initialize a variable with a `UITableViewRowAction` and put your logic inside the closure
         */
        
        let action = UITableViewRowAction(style: .normal, title: "Include") { (action, indexPath) in
            // Put logic here
            print("BUTTON IS CLICKED")
        }
        
        /**
         You can change the background color on the swipe action button by using `backgroundColor` attribute.
         */
        action.backgroundColor = UIColor(red: 1.00, green: 0.67, blue: 1.00, alpha: 1.00)
        
        /**
         You can add multiple actions here. So just create another actions and add it on the return value.
         */
        return [action]
    }
    
}

/**
 This part will show about the drag and drop
 */
extension ViewController : UITableViewDragDelegate {
    
    /**
     You have to declare a `UIDragItem` to tell the tableview which object you want to detach from the tableview.
     This stub will execute when you first click and hold and detach the cell on the tableview
     */
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        dragItem.localObject = arrFruits[indexPath.row]
        return [dragItem]
    }
    
    
    /**
     Tell the tableview the source index and the destination index.
     This stub will execute when you put the cell on a new position
     */
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let mv = arrFruits[sourceIndexPath.row]
        arrFruits.remove(at: sourceIndexPath.row)
        arrFruits.insert(mv, at: destinationIndexPath.row)
        print("Object reattached")
    }
    
}

