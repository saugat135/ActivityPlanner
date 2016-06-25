import UIKit

protocol ActivityPlannerTVCDelegate {
  func didIncreaseFrequency(frequency: Int)
  func didDecreaseFrequency(frequency: Int)
  func didPickActivityTime(time: ActivityTime)
}

class ActivityPlannerTVC: UITableViewController {
  
  private enum Section: Int {
    case frequency = 0
    case summary
    
    func headerView(frame: CGRect) -> UIView {
      
      let headerLabel = UILabel(frame: frame)
      headerLabel.text = self.headerText()
      headerLabel.font = UIFont.systemFontOfSize(15)
      headerLabel.numberOfLines = 0
      headerLabel.lineBreakMode = .ByWordWrapping
      
      headerLabel.textColor = UIColor(red: 109/255, green: 109/255, blue: 114/255, alpha: 1.0)
      headerLabel.sizeToFit()
      
      let view = UIView(frame: frame)
      view.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1.0)
      headerLabel.frame.origin.y = 10
      headerLabel.frame.origin.x = 16
      
      view.sizeToFit()
      view.frame.size.height = CGRectGetHeight(headerLabel.frame)
      view.frame.size.height += headerLabel.frame.origin.y + 5
      
      view.clipsToBounds = true
      view.addSubview(headerLabel)
      
      return view
    }
    
    func headerText() -> String {
    
      var frequencyHeaderText = "Set the frequency you will be having your medication."
      var summaryHeaderText = "Your activity summary for this day."
      
      switch self {
      case .frequency:
        return frequencyHeaderText
      case .summary:
        return summaryHeaderText
      }
    }
  }
  
  var delegate: ActivityPlannerTVCDelegate?
  
  private var sections: [Section] = [.frequency, .summary]
  var activityTimes: [ActivityTime] = []
  var currentFrequency: Int!
  
  var minFrequency: Int!
  var maxFrequency: Int!
  
  private var activityTimesTVC: ActivityTimeTVC!
  
  private var selectedIndexPath: NSIndexPath!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1.0)
    self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    self.currentFrequency = self.activityTimes.count
    
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.tableView.reloadData()
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return sections.count
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    guard let sectionEnum = Section(rawValue: section) else {
      return 0
    }
    switch sectionEnum {
    case .frequency:
      return 1
    case .summary:
      return self.activityTimes.count
    }
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    guard let section = Section(rawValue: indexPath.section) else {
      return UITableViewCell(frame: CGRectZero)
    }
    switch section {
    case .frequency:
      return self.configureFrequencySection()
    case .summary:
      return self.configureSummarySection(indexPath.row)
    }
  }
  
  override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let sectionEnum = Section(rawValue: section) else {
      return nil
    }
    
    var frame = CGRectZero
    frame.size = CGSize(width: (self.tableView.frame.width - CGFloat(16)), height: 12)
    return sectionEnum.headerView(frame)
  }
  
  override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    let tableSection = Section(rawValue: section)!
    var frame = CGRectZero
    frame.size = CGSize(width: (self.tableView.frame.width - CGFloat(16)), height: 12)
    let headerView = tableSection.headerView(frame)
    return headerView.frame.height
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    guard let section = Section(rawValue: indexPath.section) else {
      return
    }
    switch section {
    case .frequency:
      break
    case .summary:
      self.selectedIndexPath = indexPath
      self.segueToActivityTimeTVC()
      break
    }
  }
  
  func reset() {
    self.currentFrequency = 0
    self.activityTimes = []
    self.tableView.reloadData()
  }
  
  private func configureFrequencySection() -> FrequencyPickerCell {
    let cell = self.tableView.dequeueReusableCellWithIdentifier("FrequencyCellID") as! FrequencyPickerCell
    cell.delegate = self
    cell.frequency = self.currentFrequency
    return cell
  }
  
  private func configureSummarySection(row: Int) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCellWithIdentifier("TimeIntervalCellID")
    cell?.textLabel?.text = self.activityTimes[row].stringValue()
    cell?.detailTextLabel?.text = self.activityTimes[row].timeIntervalString()
    return cell!
  }
  
  private func segueToActivityTimeTVC() {
    let sb = UIStoryboard(name: "Activity", bundle: nil)
    self.activityTimesTVC = sb.instantiateViewControllerWithIdentifier("ActivityTimeTVCID") as! ActivityTimeTVC
    self.activityTimesTVC.delegate = self
    for activityTime in activityTimesTVC.activityTimes {
      if self.activityTimes.contains(activityTime) {
        activityTimesTVC.activityTimes.removeAtIndex(activityTimesTVC.activityTimes.indexOf(activityTime)!)
      }
    }
    self.navigationController?.pushViewController(activityTimesTVC, animated: true)
  }
  
  private func activityTimesAccordingToFrequency(frequency: Int) -> [ActivityTime] {
    // Start with morning time
    // Divide the default activity times with the current frequency.
    // Map the activity times
    // Return
    guard frequency > 0 else { return [] }
    let totalActivityTime = ActivityTime.allActivityTimes().count + 1
    var activityTimes: [ActivityTime] = []
    let interval = totalActivityTime / frequency
    var currentInterval: Int = 0
    
    for i in 1...frequency {
      if currentInterval > 10 {
        currentInterval = 10
      } else if currentInterval < 0 {
        currentInterval = 0
      }
      activityTimes.append(ActivityTime.allActivityTimes()[currentInterval])
      print(currentInterval)
      currentInterval = interval + currentInterval
    }
    return activityTimes
  }
  
  
}

extension ActivityPlannerTVC: FrequencyPickerCellDelegate {
  
  func didIncreaseFrequency() {
    guard self.currentFrequency < 11 else { return }
    self.currentFrequency = self.currentFrequency + 1
    
    self.activityTimes = activityTimesAccordingToFrequency(self.currentFrequency)

    self.activityTimes.sortInPlace { (time1, time2) -> Bool in
      time1.sortIndex() < time2.sortIndex()
    }
    self.tableView.reloadData()
    self.delegate?.didIncreaseFrequency(self.currentFrequency)
  }
  
  func didDecreaseFrequency() {
    guard self.currentFrequency > 0 else { return }
    self.currentFrequency = self.currentFrequency - 1
    self.activityTimes = activityTimesAccordingToFrequency(self.currentFrequency)
    self.tableView.reloadData()
    self.delegate?.didDecreaseFrequency(self.currentFrequency)
  }
  
}

extension ActivityPlannerTVC: ActivityTimeTVCDelegate {
  
  func didPickActivityTime(time: ActivityTime) {
    
    self.activityTimes[selectedIndexPath.row] = time
    self.activityTimes.sortInPlace { (time1, time2) -> Bool in
      time1.sortIndex() < time2.sortIndex()
    }
    self.currentFrequency = self.activityTimes.count
    
  }
}

