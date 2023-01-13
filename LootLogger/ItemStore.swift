import UIKit

class ItemStore {
// Bronze Challenge: Sections Have the UITableView display two sections – one for items worth more than $50 and one for the rest, p. 376
    var allItems = (lower50: [Item](), above50: [Item]())
    
    init() {
        for _ in 0 ... 5 {
            createItem()
        }
    }
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        isLessThan50(newItem) ? allItems.lower50.append(newItem) : allItems.above50.append(newItem)
        return newItem
    }
    
    func removeItem(_ item: Item) {
        if isLessThan50(item) {
            if let index = allItems.lower50.firstIndex(of: item){
                allItems.lower50.remove(at: index)
            }
            
        } else {
            if let index = allItems.above50.firstIndex(of: item) {
                allItems.above50.remove(at: index)
            }
        }
    }
    
    func moveItem(from sourceIndexPath: IndexPath, to destinationiIdexPath: IndexPath) {
        if sourceIndexPath.row == destinationiIdexPath.row {
            return
        }
        
        // Get reference to object being moved so you can reinsert it
        
        if sourceIndexPath.section == 0 {
            let movedItem = allItems.lower50[sourceIndexPath.row]
            // Remove item form array
            removeItem(movedItem)
            
            // Insert item in array at new location
            allItems.lower50.insert(movedItem, at: destinationiIdexPath.row)
        } else {
            let movedItem = allItems.above50[sourceIndexPath.row]
            // Remove item form array
            removeItem(movedItem)
            
            // Insert item in array at new location
            allItems.above50.insert(movedItem, at: destinationiIdexPath.row)
        }
        

    }
    
    func isLessThan50(_ item: Item) -> Bool {
        item.valuesInDoller <= 50
    }
}
