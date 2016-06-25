

import UIKit

protocol FrequencyPickerDelegate {
    
    func didDecreaseFrequency()
    func didIncreaseFrequency()
    
}

class FrequencyPicker: UIView {
    
    static let nibName = "FrequencyPicker"
    
    var delegate: FrequencyPickerDelegate?
    
    @IBOutlet var minusButton: UIButton!
    @IBOutlet var plusButton: UIButton!
    @IBOutlet var frequencyLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func decreaseFrequency(sender: AnyObject) {
        self.delegate?.didDecreaseFrequency()
    }
    
    @IBAction func increaseFrequency(sender: AnyObject) {
        self.delegate?.didIncreaseFrequency()
    }
    
}
