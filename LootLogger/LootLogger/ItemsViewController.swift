import UIKit

class ItemsViewController: UITableViewController {
    var itemStore: ItemStore!
    @IBOutlet var favoriteSwitch: UISwitch!
    
    @IBAction func addNewItem(_ sender: UIButton) {
        // Create a new item and add it to the store
        let newItem = Item(random: true)
        newItem.isFavorite = favoriteSwitch.isOn ? true : false
           
        // Figure out where the item is in the array
        let section = newItem.valuesInDollar <= 50 ? 0 : 1
        itemStore.allItems[section].append(newItem)
        evaluateFavs()
        tableView.reloadData()
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
    
    @IBAction func toggleFavoriteSwitch(_ sender: UISwitch){
        if sender.isOn {
            evaluateFavs()
        }
        tableView.reloadData()
    }
    
    func evaluateFavs(){
        itemStore.below50HasFavorite = itemStore.allItems[0].contains(where: {
        (item: Item) in
            if item.isFavorite {
                switch item.name{
                case "", "No items!", "No favorite items!":
                    return false
                default:
                    return true
                }
            }
            return false
            
        })
        itemStore.above50HasFavorite = itemStore.allItems[1].contains(where: {
            (item: Item) in
                if item.isFavorite {
                    switch item.name{
                    case "", "No items!", "No favorite items!":
                        return false
                    default:
                        return true
                    }
                }
                return false
            })
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
        
        
        if item.name == "" || item.name == "No items!" || item.name == "No favorite items!",
           item.valuesInDollar == 0,
           item.serialNumber == nil {
            item.name = favoriteSwitch.isOn ? "No favorite items!" : "No items!"
            cell.textLabel?.text = item.name
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
            
            if item.name != "" || item.name != "No items!" || item.name != "No favorite items!",
               item.valuesInDollar > 0,
               item.serialNumber != nil {
                
                // Remove the item from the store
                itemStore.allItems[indexPath.section].remove(at: indexPath.row)
            }
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let item = self.itemStore.allItems[indexPath.section][indexPath.row]
        if item.name == "No items!",
            item.serialNumber == nil,
           item.valuesInDollar == 0 {
            return nil
        }
        let contextualAction = UIContextualAction(style: .normal, title: "⭐") { action, view, completion in
            
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = itemStore.allItems[indexPath.section][indexPath.row]
        if itemStore.allItems[indexPath.section].count > 1{
            if favoriteSwitch.isOn {
                if item.name == "" || item.name == "No items!" || item.name == "No favorite items!",
                   item.valuesInDollar == 0,
                   item.serialNumber == nil {
                    if (indexPath.section == 0 ? itemStore.below50HasFavorite : itemStore.above50HasFavorite) {
                        return 0
                    } else {
                        return tableView.rowHeight
                    }
                } else {
                    if item.isFavorite {
                        return tableView.rowHeight
                    } else {
                        return 0
                    }
                }
            } else {
                // > 1 not favorite
                if item.name == "" || item.name == "No items!" || item.name == "No favorite items!",
                   item.valuesInDollar == 0,
                   item.serialNumber == nil {
                    return 0
                } else {
                    return tableView.rowHeight
                }
            }
        } else {
            return tableView.rowHeight
        }
    }
}
