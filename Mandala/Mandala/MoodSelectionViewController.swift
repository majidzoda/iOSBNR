import UIKit

class MoodSelectionViewController: UIViewController {
    
    @IBOutlet var moodSelector: ImageSelector!
    @IBOutlet var addMoodButton: UIButton!
    
    var moodsConfigurable: MoodConfigurable!
    
    var moods: [Mood] = [] {
        didSet {
            currentMood = moods.first
            moodSelector.images = moods.map { $0.image }
            moodSelector.highlitColors = moods.map { $0.color }
        }
    }
    
    var currentMood: Mood? {
        didSet {
            guard let currentMood = currentMood else {
                addMoodButton?.setTitle(nil, for: .normal)
                addMoodButton?.backgroundColor = nil
                return
            }
            
            addMoodButton?.setTitle("I'm \(currentMood.name)", for: .normal)
//            addMoodButton?.backgroundColor = currentMood.color
            let selectionAnimator = UIViewPropertyAnimator(duration: 0.3,
                                                           dampingRatio: 0.7,
                                                           animations: {
                self.addMoodButton.backgroundColor = currentMood.color
            })
            selectionAnimator.startAnimation()

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        moods = [.happy, .sad, .angry, .goofy, .crying, .confused, .sleepy, .meh]
        addMoodButton.layer.cornerRadius = addMoodButton.bounds.height / 2
    }
    
    @IBAction func moodSelectionChanged(_ sender: ImageSelector) {

        let selectedIndex = sender.selectedIndex
        currentMood = moods[selectedIndex]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "embedContainerViewController":
            guard let moodsConfigurable = segue.destination as? MoodConfigurable else {
                preconditionFailure("View controller expected to conform to MoosdConfigurable")
            }
            self.moodsConfigurable = moodsConfigurable
            segue.destination.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 160, right: 0)
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
    
    @IBAction func addMoodTapped(_ sender: Any) {
        guard let currentMood = currentMood else {
            return
        }
        
        let newMoodEntry = MoodEntry(mood: currentMood, timestamp: Date())
        moodsConfigurable.add(newMoodEntry)
        
    }
}

