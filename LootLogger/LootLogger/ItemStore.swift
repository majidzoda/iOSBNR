import UIKit

class ItemStore {
    static var allItems = [Item]()
    
    let itemArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("items.plist")
    }()
    
    init() {
        do {
            let data = try Data(contentsOf: itemArchiveURL)
            let unarchiver = PropertyListDecoder()
            let items = try unarchiver.decode([Item].self, from: data)
            ItemStore.allItems = items
        } catch {
            print("Error reading in saced items: \(error)")
        }
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(saveChanges),
                                       name: UIScene.didEnterBackgroundNotification,
                                       object: nil)
    }
    
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        
        ItemStore.allItems.append(newItem)
        return newItem
    }
    
    func removeItem(_ item: Item) {
        if let index = ItemStore.allItems.firstIndex(of: item) {
            ItemStore.allItems.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        // Get reference to object being moved so you can reinsert it
        let movedItem = ItemStore.allItems[fromIndex]
        
        // Remove item form array
        removeItem(movedItem)
        
        // Insert item in array at new location
        ItemStore.allItems.insert(movedItem, at: toIndex)
    }
    
    @objc func saveChanges()throws  {
        print("Saving items to: \(itemArchiveURL)")

        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(ItemStore.allItems)
            try data.write(to: itemArchiveURL, options: [.atomic])
            print("Saved all of the items")
        } catch let encodingError{
            print("Error encoding allItems \(encodingError)")
            fatalError()
        }
    }
}
