//
//  AnalyzeMenu.swift
//  
//
//  Created by Johannes Berge on 12/01/16.
//
//

import UIKit
import Parse
import Charts


class AnalyzeMenu: UIViewController,UITableViewDelegate,ChartViewDelegate {
    
    var analyzeIDS:Array<String> = []
    var analyzeID = ""
    
    var usernameArray: Array<String> = []
    var updatedArray: Array<String> = []
    
    var turnArray: Array<String> = []
    var turnUpdateSince: Array<NSTimeInterval> = []

    
    var instructionsLabel = UILabel()

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.navigationBar.topItem?.title = "Analyze"
        self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Didot", size: 20)!]
        
        
    }
    
    func findGames() {
        
        //tableView.hidden = true
        let gamesQuery = PFQuery(className: "Analyze")
        //fix this
        gamesQuery.orderByDescending("updatedAt")
        gamesQuery.whereKey("players", equalTo: PFUser.currentUser()!.username!)
        gamesQuery.findObjectsInBackgroundWithBlock { (games:[AnyObject]?, error:NSError?) -> Void in
            if error == nil {
                if let games = games as! [PFObject]! {
                    for games in games {
                        
                        
                        
                        
                        if games["confirmed"] as? Bool == true {
                            if games["whitePlayer"] as? String == PFUser.currentUser()?.username {
                                
                                
                                
                                    self.turnArray.append((games["blackPlayer"] as? String)!)
                                    
                                    //adding updated since
                                    let lastupdate = games.updatedAt!
                                    let since = NSDate().timeIntervalSinceDate(lastupdate)
                                    self.turnUpdateSince.append(since)
                                    
                                    
                                    //adding time left
                                    
                                    self.analyzeIDS.append(games.objectId!)
                                    

                                
                            }
                        
                        }
               
                        
                        
                    //has to do with laodinngng
                 //       self.loaded = false
                        
                        
                        
                        //self.ratingArray.append(games["blackPlayer"] as! Int)
                        //  updatedArrayppend(games["blackPlayer"] as! String)
                        //  timeleftArrayppend(games["blackPlayer"] as! String)
                        
                    }
                }
                
                self.tableView.reloadData()
                self.tableView.hidden = false
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.tableView.alpha = 1
                    }, completion: { (finished) -> Void in
                        if finished {
                            
                            
                            
                        }
                })
                
                
                
                
            }
            
        }
        
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    override func viewWillAppear(animated: Bool) {
        
        analyzeIDS = []
        analyzeID = ""
        
        findGames()
        
        lightOrDarkMode()

        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    

    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        print("\(entry.value) in \(entry.xIndex)")
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        let cell:AnalyzeMenuTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("analyzeCell",forIndexPath: indexPath) as! AnalyzeMenuTableViewCell
        
        cell.lineChartView.delegate = self

        cell.lineChartView.noDataText = "NO DATA YET"
        
        var months: [String]!
        
        

        func setChart(dataPoints: [String], values: [Double]) {
            
            
            
            cell.lineChartView.noDataText = "NO DATA YET"
            
            var dataEntries: [ChartDataEntry] = []
            
            for i in 0..<dataPoints.count {
                let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
                dataEntries.append(dataEntry)
            }
            
            let chartDataSet = LineChartDataSet(yVals: dataEntries, label: "Units Sold")
            let chartData = LineChartData(xVals: months, dataSet: chartDataSet)
            cell.lineChartView.descriptionText = ""
            cell.lineChartView.data = chartData
            cell.lineChartView.xAxis.labelPosition = .Bottom
            cell.lineChartView.legend.enabled = false
            
            chartDataSet.colors = ChartColorTemplates.liberty()
            chartDataSet.colors = [blue]

        
            cell.lineChartView.animate(xAxisDuration: 0.5, yAxisDuration: 0.5,easingOption: .EaseInOutCubic)
            cell.lineChartView.backgroundColor = UIColor.clearColor()
            let ll = ChartLimitLine(limit: 0.0, label: "")
            ll.lineColor = red
    
            cell.lineChartView.rightAxis.addLimitLine(ll)
            
        }
        
        months = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]
        var unitsSold = [0.0, -1.0, -2.0, -1.0, -2.0, -2.0, -2.0, -1.0, 2.0, 1.0, 0.0, 0.0, -1.0, -2.0, -1.0, -2.0, -2.0, -2.0, -1.0, 2.0, 1.0, 0.0, 0.0, -1.0, -2.0, -1.0, -2.0, -2.0, -2.0, -1.0, 2.0, 1.0, 0.0, 0.0, -1.0, -2.0, -1.0, -2.0, -2.0, -2.0, -1.0, 2.0, 1.0, 0.0, 0.0, -1.0, -2.0, -1.0, -2.0, -2.0, -2.0, -1.0, 2.0, 1.0, 0.0, 0.0]
        

        
        setChart(months, values: unitsSold)
        
        
        if darkMode {cell.backgroundColor = UIColor.clearColor() //(red:0.22, green:0.22, blue:0.22, alpha:1.0)
            
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            
            
            
            cell.username.textColor = UIColor.whiteColor()
            
        }
        else {cell.backgroundColor = UIColor.whiteColor()
            
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            cell.username.textColor = UIColor.blackColor()
            
            
        }
        // cell.userProfileImage.image = nil
        cell.username.text = ""
        
        
        func find(name:String) {
            
            cell.username.text = name

        }
        
        
        
        
        
        
        
        // cell.rating.text = "601"
        // cell.updated.text = "Last Update: 1h 5min"
        
            find(turnArray[indexPath.row])
            

            

            
            var since = turnUpdateSince[indexPath.row]
            //making to minutes
            cell.updated.text = "Last Updated: Now"
            
            if since >= 60 {
                since = since/60
                let sinceOutput = Int(since)
                cell.updated.text = "Last Updated: \(sinceOutput)min ago"
            }
            //making to hours
            if since >= 60 {
                since = since/60
                let sinceOutput = Int(since)
                cell.updated.text = "Last Updated: \(sinceOutput)h ago"
                
                //making to days
                if since >= 24 {
                    since = since/24
                    let sinceOutput = Int(since)
                    cell.updated.text = "Last Updated: \(sinceOutput)d ago"
                    
                }
                
            }

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //        let cell:GameMenuTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("gameCell",forIndexPath: indexPath) as! GameMenuTableViewCell

            analyzeID = analyzeIDS[indexPath.row]
 
            
        
        print("this is \(analyzeID)")
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if turnArray.count == 0 {
            
            tableView.hidden = true

        }
        else {
            
            instructionsLabel.hidden = true
            tableView.hidden = false
            
            
        }
        
  
            return turnArray.count

        
    }
    
    
    
    func tableView(tableView:UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?
    {
        
 
            var shareAction = UITableViewRowAction(style: .Destructive, title: "Resign") { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
                
                let drawAlert = UIAlertController(title: "Warning", message: "Are you sure you want to resign?", preferredStyle: UIAlertControllerStyle.Alert)
                
                drawAlert.addAction(UIAlertAction(title: "Resign", style: .Destructive, handler: { action in
                    switch action.style{
                        
                    case .Cancel:
                        print("cancel")
                        
                    case .Destructive:
                        print("destructive")
                        
                    case .Default:
                        print("default")
                        
                    }
                }))
                drawAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { action in
                    switch action.style{
                        
                    case .Cancel:
                        print("cancel")
                        
                    case .Destructive:
                        print("destructive")
                        
                    case .Default:
                        print("default")
                        
                    }
                }))
                
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.removeNewView()
                    } , completion: {finish in
                        self.presentViewController(drawAlert, animated: true, completion: nil)
                        
                })
                
            }
            shareAction.backgroundColor = red
            return [shareAction]
            
        
    }

    func removeNewView() {
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            visualEffectView.alpha = 0
            
            }, completion: {finish in
                
                for view in visualEffectSub.subviews {
                    view.removeFromSuperview()
                }
                
        })
        
        visualEffectView.userInteractionEnabled = false
        visualEffectSub.userInteractionEnabled = false
        
    }
    
    
    @IBAction func newPressed(sender: AnyObject) {
        
        
        UIView.animateWithDuration(0.3) { () -> Void in
            visualEffectView.alpha = 1
        }
        
        visualEffectView.userInteractionEnabled = true
        visualEffectSub.userInteractionEnabled = true
        
        //friends
        let friendsImage = UIImageView(frame: CGRectMake((screenWidth / 2) - 85,100,50,50))
        if darkMode {friendsImage.image = UIImage(named:"group4.png")}
        else {friendsImage.image = UIImage(named:"group4-2.png")}
        friendsImage.contentMode = .ScaleAspectFill
        friendsImage.alpha = 0.7
        visualEffectSub.addSubview(friendsImage)
        
        let friendsButton = UIButton(frame: CGRectMake((screenWidth / 2) - 120,80,120,120))
        friendsButton.setTitle("Friends", forState: .Normal)
        friendsButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        friendsButton.titleLabel?.font = UIFont(name: "Times", size: 16)
        friendsButton.contentVerticalAlignment = UIControlContentVerticalAlignment.Bottom
        friendsButton.setBackgroundImage(UIImage(named:"dBlackBC.png"), forState: .Highlighted)
        friendsButton.layer.cornerRadius = cornerRadius
        friendsButton.clipsToBounds = true
        friendsButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0)
        friendsButton.addTarget(self, action: "friendsButtonPressed:", forControlEvents: .TouchUpInside)
        visualEffectSub.addSubview(friendsButton)
        //-----friends end
        
        
        //random
        let randomImage = UIImageView(frame: CGRectMake((screenWidth / 2) + 35,100,50,50))
        if darkMode {randomImage.image = UIImage(named:"multimedia option23-2.png")}
        else {randomImage.image = UIImage(named:"multimedia option23.png")}
        randomImage.contentMode = .ScaleAspectFill
        randomImage.alpha = 0.7
        visualEffectSub.addSubview(randomImage)
        
        let randomButton = UIButton(frame: CGRectMake((screenWidth / 2),80,120,120))
        randomButton.setTitle("Random", forState: .Normal)
        randomButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        randomButton.titleLabel?.font = UIFont(name: "Times", size: 16)
        randomButton.contentVerticalAlignment = UIControlContentVerticalAlignment.Bottom
        randomButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0)
        randomButton.setBackgroundImage(UIImage(named:"dBlackBC.png"), forState: .Highlighted)
        randomButton.layer.cornerRadius = cornerRadius
        randomButton.clipsToBounds = true
        randomButton.addTarget(self, action: "randomButtonPressed:", forControlEvents: .TouchUpInside)
        visualEffectSub.addSubview(randomButton)
        //------random end
        
        //username
        let usernameImage = UIImageView(frame: CGRectMake((screenWidth / 2) - 85,100 + 140,50,50))
        if darkMode {usernameImage.image = UIImage(named:"search74.png")}
        else {usernameImage.image = UIImage(named:"search74-2.png")}
        usernameImage.contentMode = .ScaleAspectFill
        usernameImage.alpha = 0.7
        visualEffectSub.addSubview(usernameImage)
        
        let usernameButton = UIButton(frame: CGRectMake((screenWidth / 2) - 120,80 + 140,120,120))
        usernameButton.setTitle("Username", forState: .Normal)
        usernameButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        usernameButton.titleLabel?.font = UIFont(name: "Times", size: 16)
        usernameButton.contentVerticalAlignment = UIControlContentVerticalAlignment.Bottom
        usernameButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0)
        usernameButton.setBackgroundImage(UIImage(named:"dBlackBC.png"), forState: .Highlighted)
        usernameButton.layer.cornerRadius = cornerRadius
        usernameButton.clipsToBounds = true
        visualEffectSub.addSubview(usernameButton)
        //------username end
        
        //rating
        let ratingImage = UIImageView(frame: CGRectMake((screenWidth / 2) + 35,100 + 140,50,50))
        if darkMode {ratingImage.image = UIImage(named:"search74.png")}
        else {ratingImage.image = UIImage(named:"search74-2.png")}
        ratingImage.contentMode = .ScaleAspectFill
        ratingImage.alpha = 0.7
        visualEffectSub.addSubview(ratingImage)
        
        let ratingButton = UIButton(frame: CGRectMake((screenWidth / 2),80 + 140,120,120))
        ratingButton.setTitle("Rating", forState: .Normal)
        ratingButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        ratingButton.titleLabel?.font = UIFont(name: "Times", size: 16)
        ratingButton.contentVerticalAlignment = UIControlContentVerticalAlignment.Bottom
        ratingButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0)
        ratingButton.setBackgroundImage(UIImage(named:"dBlackBC.png"), forState: .Highlighted)
        ratingButton.layer.cornerRadius = cornerRadius
        ratingButton.clipsToBounds = true
        visualEffectSub.addSubview(ratingButton)
        //------rating end
        
        
        //location
        let locationImage = UIImageView(frame: CGRectMake((screenWidth / 2) - 25,100 + 140 + 140,50,50))
        if darkMode {locationImage.image = UIImage(named:"map-pointer7-2.png")}
        else{locationImage.image = UIImage(named:"map-pointer7.png")}
        locationImage.contentMode = .ScaleAspectFill
        locationImage.alpha = 0.7
        visualEffectSub.addSubview(locationImage)
        
        let locationButton = UIButton(frame: CGRectMake((screenWidth / 2) - 60,80 + 140 + 140,120,120))
        locationButton.setTitle("Nearby", forState: .Normal)
        locationButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        locationButton.titleLabel?.font = UIFont(name: "Times", size: 16)
        locationButton.contentVerticalAlignment = UIControlContentVerticalAlignment.Bottom
        locationButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0)
        locationButton.setBackgroundImage(UIImage(named:"dBlackBC.png"), forState: .Highlighted)
        locationButton.layer.cornerRadius = cornerRadius
        locationButton.clipsToBounds = true
        locationButton.addTarget(self, action: "nearbyButtonPressed:", forControlEvents: .TouchUpInside)
        visualEffectSub.addSubview(locationButton)
        //------location end
        
        let gesture3 = UITapGestureRecognizer(target: self, action: "effectSubPressed:")
        visualEffectSub.userInteractionEnabled = true
        visualEffectSub.addGestureRecognizer(gesture3)
        
    }
    
    //func to check if dark or light mode should be enabled, keep this at the bottom
    func lightOrDarkMode() {
        if darkMode == true {
            
            
            self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
            self.navigationController?.navigationBar.backgroundColor = UIColor(red: 0.05, green: 0.05 , blue: 0.05, alpha: 1)
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.07, green: 0.07 , blue: 0.07, alpha: 1)
            //this is to gamemenu black
            self.view.backgroundColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
            self.tabBarController?.tabBar.barStyle = UIBarStyle.Black
            self.tabBarController?.tabBar.tintColor = blue
            self.tabBarController?.tabBar.barTintColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
            self.navigationController?.navigationBar.tintColor = blue
            visualEffectView.effect = UIBlurEffect(style: .Dark)
            
            
            
            
            
            
            
            
            
            tableView.backgroundColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
            
            
            
        }
        else if darkMode == false {
            
            self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
            self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
            self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
            //this is to gamemenu white
            self.view.backgroundColor = UIColor.whiteColor()
            self.tabBarController?.tabBar.barStyle = UIBarStyle.Default
            self.tabBarController?.tabBar.tintColor = blue
            self.navigationController?.navigationBar.tintColor = blue
            self.tabBarController?.tabBar.barTintColor = UIColor.whiteColor()
            
            
            visualEffectView.effect = UIBlurEffect(style: .Light)
            
            tableView.backgroundColor = UIColor.whiteColor()
            
            
            
            
            
            
            
        }
        
        
    }
    
    
}
