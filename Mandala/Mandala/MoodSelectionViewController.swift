import UIKit

class MoodSelectionViewController: UIViewController {
    
    @IBOutlet var moodSelector: ImageSelector!
    @IBOutlet var addMoodButton: UIButton!
    
    var moodsConfigurable: MoodConfigurable!
    
    private var moods: [Mood] = [] {
        didSet {
            currentMood = moods.first
//            moodButtons = moods.map { mood in
//                let moodButton = UIButton()
//                moodButton.setImage(mood.image, for: .normal)
//                moodButton.imageView?.contentMode = .scaleAspectFill
//                moodButton.adjustsImageWhenHighlighted = false
//                moodButton.addTarget(self, action: #selector(moodSelectionChanged(_:)), for: .touchUpInside)
//                return moodButton
//            }
            moodSelector.images = moods.map { $0.image }
        }
    }
    
//    var moodButtons: [UIButton] = [] {
//        didSet {
//            oldValue.forEach { $0.removeFromSuperview() }
//            moodButtons.forEach { stackView.addArrangedSubview($0) }
//        }
//    }
    
    var currentMood: Mood? {
        didSet {
            guard let currentMood = currentMood else {
                addMoodButton?.setTitle(nil, for: .normal)
                addMoodButton?.backgroundColor = nil
                return
            }
            
            addMoodButton?.setTitle("I'm \(currentMood.name)", for: .normal)
            addMoodButton?.backgroundColor = currentMood.color

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        moods = [.happy, .sad, .angry, .goofy, .crying, .confused, .sleepy, .meh]
        addMoodButton.layer.cornerRadius = addMoodButton.bounds.height / 2
    }
    
    @IBAction func moodSelectionChanged(_ sender: ImageSelector) {
//        guard let selectedIndex = moodButtons.firstIndex(of: sender) else {
//            preconditionFailure("Unable to find the tapped button in the buttons array.")
//        }
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

