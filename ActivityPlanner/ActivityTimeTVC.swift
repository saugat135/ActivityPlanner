import UIKit

protocol ActivityTimeTVCDelegate {
    func didPickActivityTime(time: ActivityTime)
}

class ActivityTimeTVC: UITableViewController {
    
    var delegate: ActivityTimeTVCDelegate?
    
    var activityTimes = ActivityTime.allActivityTimes() {
        didSet {
            self.tableView.reloadData()
        }
    }
    private var selectedCell = UITableViewCell()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Activity Times"
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityTimes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ActivityTimeCellID", forIndexPath: indexPath)
        let activityTime = self.activityTimes[indexPath.row]
        cell.textLabel?.text = "\(activityTime.stringValue())" + " " + "(" + "\(activityTime.timeIntervalString())" + ")"
        if tableView.indexPathForCell(self.selectedCell) == indexPath {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedCell = self.tableView.cellForRowAtIndexPath(indexPath)!
        self.selectedCell.accessoryType = .Checkmark
        self.delegate?.didPickActivityTime(self.activityTimes[indexPath.row])
        self.navigationController?.popViewControllerAnimated(true)
    }

}
