import UIKit

class ItemsViewController: UITableViewController {
    var itemStore: ItemStore!
    
    @IBAction func addNewItem(_ sender: UIButton) {
        // Create a new item and add it to the store
        let newItem = Item(random: true)
           
        // Figure out where the item is in the array
        let section = newItem.valuesInDollar <= 50 ? 0 : 1
        
        if itemStore.allItems[section].count == 1,
           itemStore.allItems[section][0].name == "No items!",
           itemStore.allItems[section][0].serialNumber == nil,
           itemStore.allItems[section][0].valuesInDollar == 0 {
            itemStore.allItems[section].remove(at: 0)
            
            tableView.deleteRows(at: [IndexPath(row: 0, section: section)], with: .automatic)
        }
        itemStore.allItems[section].append(newItem)
           if let index = itemStore.allItems[section].firstIndex(of: newItem){
               let indexPath = IndexPath(row: index, section: section)
               
               // Insert this new row into the table
               tableView.insertRows(at: [indexPath], with: .automatic)
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
        return itemStore.allItems[section].count
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
        let item = itemStore.allItems[indexPath.section][indexPath.row]
        
        
        if itemStore.allItems[indexPath.section].count == 1,
            item.name == "",
           item.valuesInDollar == 0,
           item.serialNumber == nil {
            item.name = "No items!"
            cell.textLabel?.text = "No items!"
            cell.detailTextLabel?.text = ""
            cell.isUserInteractionEnabled = false
        
        } else {
            cell.textLabel?.text = item.isFavorite ? "\(item.name) ⭐" : item.name
            cell.detailTextLabel?.text = "$\(item.valuesInDollar)"
            cell.isUserInteractionEnabled = true
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // if the table view is asking to commit a delete command...
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.section][indexPath.row]
            
            if item.name != "",
               item.valuesInDollar > 0,
               item.serialNumber != nil {
                
                // Remove the item from the store
                itemStore.allItems[indexPath.section].remove(at: indexPath.row)
                
                // Also remove that roe from the table view with an animation
                
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            
            if itemStore.allItems[indexPath.section].count == 0 {
                itemStore.allItems[indexPath.section].append(Item(random: false))
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextualAction = UIContextualAction(style: .normal, title: "⭐") { action, view, completion in
            let item = self.itemStore.allItems[indexPath.section][indexPath.row]
            switch item.isFavorite {
            case true:
                item.isFavorite = false
                item.name = item.name.trimmingCharacters(in: ["⭐"])
            case false:
                item.isFavorite = true
            }
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        
        }
        return UISwipeActionsConfiguration(actions: [contextualAction])
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
