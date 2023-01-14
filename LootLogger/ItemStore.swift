import UIKit

class ItemStore {
    var allItems = [[Item](), [Item]()]
    
    init(){
        allItems[0].append(Item(random: false))
        allItems[1].append(Item(random: false))
    }
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        newItem.valuesInDollar <= 50 ? allItems[0].append(newItem) : allItems[1].append(newItem)
        return newItem
    }
    
    func removeItem(_ item: Item) {
        let section = item.valuesInDollar <= 50 ? 0 : 1
        if let index = allItems[section].firstIndex(of: item) {
            allItems[section].remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: IndexPath, to toIndex: IndexPath) {
        if fromIndex == toIndex {
            return
        }
        
        // Get reference to object being moved so you can reinsert it
        let movedItem = allItems[fromIndex.section][fromIndex.row]
        
        // Remove item from array
        allItems[fromIndex.section].remove(at: fromIndex.row)
        
        // Insert item in array at new location
        allItems[toIndex.section].insert(movedItem, at: toIndex.row)
    }
}
