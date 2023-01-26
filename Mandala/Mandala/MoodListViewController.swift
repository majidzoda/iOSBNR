import UIKit

class MoodListViewController: UITableViewController {
    var moodEntry: [MoodEntry] = []
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return moodEntry.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let moodEntry = moodEntry[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.imageView?.image = moodEntry.mood.image
        cell.textLabel?.text = "I was \(moodEntry.mood.name)"
        
        let dateString = DateFormatter.localizedString(from: moodEntry.timestamp,
                                                       dateStyle: .medium,
                                                       timeStyle: .short)
        
        cell.detailTextLabel?.text = "on \(dateString)"
        return cell
    }
}
