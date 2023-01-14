import UIKit

class ItemsViewController: UITableViewController {
    var itemStore: ItemStore!
    
    @IBAction func addNewItem(_ sender: UIButton) {
        // Create a new Item and add it to the store
        let newItem = itemStore.createItem()
        
        // Figure out where that item is in the array
        if itemStore.isLessThan50(newItem) {
            if let index = itemStore.allItems.lower50.firstIndex(of: newItem) {
                let indexPath = IndexPath(row: index, section: 0)
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        } else {
            if let index = itemStore.allItems.above50.firstIndex(of: newItem) {
                let indexPath = IndexPath(row: index, section: 1)
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        }
        
    }
    
    @IBAction func toggleEditingMode(_ sender: UIButton){
        // If you are currently in editing mode
        if isEditing {
            // Change text of button to inform userof state
            sender.setTitle("Edit", for: .normal)
            
            // Turn off editing mode
            setEditing(false, animated: true)
        } else {
            // Change text of button to inform user state
            sender.setTitle("Done", for: .normal)
            
            // Enter editing mode
            setEditing(true, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return itemStore.allItems.lower50.count
        } else {
            return itemStore.allItems.above50.count
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "<$50"
        } else {
            return ">=$50"
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create a new or recycled cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of item, where n = row this cell
        // will appear in on the table view
        let item = indexPath.section == 0 ? itemStore.allItems.lower50[indexPath.row] : itemStore.allItems.above50[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valuesInDoller)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // if the table view is asking to commit a delete command...
        if editingStyle == .delete {
            let item = indexPath.section == 0 ? itemStore.allItems.lower50[indexPath.row] : itemStore.allItems.above50[indexPath.row]
            
            // Remove the item for the store
            itemStore.removeItem(item)
            
            // Also remove that row from the table view with an animation
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if sourceIndexPath.section == proposedDestinationIndexPath.section {
            if sourceIndexPath.row == proposedDestinationIndexPath.row {
                return sourceIndexPath
            }
            return proposedDestinationIndexPath
        } else {
            return sourceIndexPath
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if destinationIndexPath.section != sourceIndexPath.section {
            // Update the model
            itemStore.moveItem(from: sourceIndexPath, to: destinationIndexPath)
        }
    }
}
