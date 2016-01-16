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
    
    var notationsArray:Array<Array<String>> = []

    
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
                            if games["player"] as? String == PFUser.currentUser()?.username {
                                
                                    self.notationsArray.append( (games["piecePosition"] as? Array)!)
                                
                                    self.turnArray.append((games["name"] as? String)!)
                                    
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
        
        
        
        
        var moves: Array<String> = []
        
        func loadMoves() {
            
            var lastNotationsWithNumber: Array<String> = []
            moves = []
            notationsWithNumber = ""
            var t = 1
            for var i = 0; i < notationsArray[indexPath.row].count; i++ {
                
                if i % 2 == 0{
                    lastNotationsWithNumber.append("\(t). ")
                    notationsWithNumber +=  "\(t). "
                    t++
                }
                notationsWithNumber += "\(notationsArray[indexPath.row][i]) "
                lastNotationsWithNumber.append("\(notationsArray[indexPath.row][i]) ")
                
                print("\(i+1).")
                var t = (i+1)
                for var q = 0; q < 2; q++ {
           //         moveNum.append(t)
                }
                var putIntoMoves = ""
                for var o = 0; o < notationsArray[indexPath.row][i].characters.count; o++ {
                    let output = notationsArray[indexPath.row][i][o]
                    let letter = String(output)
                    
                    if letter.lowercaseString == String(output){
                        
                        if output != "-" && output != "x" {
                            //print(output)
                            putIntoMoves.append(output)
                            
                        }
                        
                    }
                }
                print(putIntoMoves)
                moves.append(putIntoMoves)
            }
            print(moves)
          //  movesCap = moves
            var cc = lastNotationsWithNumber.count
            
            if cc == 0 {}
            else if cc == 2 {

                let ss3 =  lastNotationsWithNumber[cc-2]
                let ss4 = lastNotationsWithNumber[cc-1]
                
                cell.notations.text = ss3 + ss4
            }
            else if cc == 3 {

                let ss2 = lastNotationsWithNumber[cc-3]
                let ss3 =  lastNotationsWithNumber[cc-2]
                let ss4 = lastNotationsWithNumber[cc-1]

                cell.notations.text = ss2 + ss3 + ss4

            }
            else {
                let ss1 = lastNotationsWithNumber[cc-4]
                let ss2 = lastNotationsWithNumber[cc-3]
                let ss3 =  lastNotationsWithNumber[cc-2]
                let ss4 = lastNotationsWithNumber[cc-1]
                
                cell.notations.text = "..." + ss1 + ss2 + ss3 + ss4
            
            }
            
            cell.notations.textAlignment = .Left
            
            
        }
        loadMoves()
        
        

        
        

        
        
        
        
        
        
        
        
        cell.lineChartView.delegate = self

        cell.lineChartView.noDataText = "NO DATA YET"
        
 
        
        var numberOfMovesMaterial: Array<String> = []
        
        

        func setChart(dataPoints: [String], values: [Double]) {
            
            
            
            cell.lineChartView.noDataText = "NO DATA YET"
            
            var dataEntries: [ChartDataEntry] = []
            
            for i in 0..<dataPoints.count {
                let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
                dataEntries.append(dataEntry)
            }
            
            let chartDataSet = LineChartDataSet(yVals: dataEntries, label: "Units Sold")
            let chartData = LineChartData(xVals: numberOfMovesMaterial, dataSet: chartDataSet)
            cell.lineChartView.descriptionText = ""
            cell.lineChartView.data = chartData
            cell.lineChartView.xAxis.labelPosition = .Bottom
            cell.lineChartView.legend.enabled = false
            
            chartDataSet.colors = ChartColorTemplates.liberty()
            chartDataSet.colors = [blue]

            
//            cell.lineChartView.leftAxis.customAxisMin = max(-10000.0, chartData.yMin - 0.0)
//            cell.lineChartView.leftAxis.customAxisMax = min(10000.0, chartData.yMax + 0.0)
//            cell.lineChartView.leftAxis.labelCount = Int(cell.lineChartView.leftAxis.customAxisMax - cell.lineChartView.leftAxis.customAxisMin)
//            cell.lineChartView.leftAxis.startAtZeroEnabled = false
            
            cell.lineChartView.animate(xAxisDuration: 0.5, yAxisDuration: 0.5,easingOption: .EaseInOutCubic)
            cell.lineChartView.backgroundColor = UIColor.clearColor()
            let ll = ChartLimitLine(limit: 0.0, label: "")
            ll.lineColor = red
    
            cell.lineChartView.rightAxis.addLimitLine(ll)
            
        }
        
        
        //change ID!!!! to analyzeID
        
        let materialPoints = NSUserDefaults.standardUserDefaults().arrayForKey("material"+"DeQVtaRZEN") as! Array<Double>
        print(materialPoints)
        
        for var xVC = 0; xVC < materialPoints.count; xVC++ {
            numberOfMovesMaterial.append("\(xVC)")
        }
        
        
        setChart(numberOfMovesMaterial, values: materialPoints)
        
        
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
        
        //regular
        let regularImage = UIImageView(frame: CGRectMake((screenWidth / 2) - 85,100,50,50))
        if darkMode {regularImage.image = UIImage(named:"reAnalysis-2.png")}
        else {regularImage.image = UIImage(named:"reAnalysis.png")}
        regularImage.contentMode = .ScaleAspectFill
        regularImage.alpha = 0.7
        visualEffectSub.addSubview(regularImage)
        
        let regularButton = UIButton(frame: CGRectMake((screenWidth / 2) - 120,80,120,120))
        regularButton.setTitle("Regular", forState: .Normal)
        regularButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        regularButton.titleLabel?.font = UIFont(name: "Times", size: 16)
        regularButton.contentVerticalAlignment = UIControlContentVerticalAlignment.Bottom
        regularButton.setBackgroundImage(UIImage(named:"dBlackBC.png"), forState: .Highlighted)
        regularButton.layer.cornerRadius = cornerRadius
        regularButton.clipsToBounds = true
        regularButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0)
        regularButton.addTarget(self, action: "regularButtonPressed:", forControlEvents: .TouchUpInside)
        visualEffectSub.addSubview(regularButton)
        //-----regular end
        
        
        //empty
        let emptyImage = UIImageView(frame: CGRectMake((screenWidth / 2) + 35,100,50,50))
        if darkMode {emptyImage.image = UIImage(named:"emAnalysis-2.png")}
        else {emptyImage.image = UIImage(named:"emAnalysis.png")}
        emptyImage.contentMode = .ScaleAspectFill
        emptyImage.alpha = 0.7
        visualEffectSub.addSubview(emptyImage)
        
        let emptyButton = UIButton(frame: CGRectMake((screenWidth / 2),80,120,120))
        emptyButton.setTitle("Empty", forState: .Normal)
        emptyButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        emptyButton.titleLabel?.font = UIFont(name: "Times", size: 16)
        emptyButton.contentVerticalAlignment = UIControlContentVerticalAlignment.Bottom
        emptyButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0)
        emptyButton.setBackgroundImage(UIImage(named:"dBlackBC.png"), forState: .Highlighted)
        emptyButton.layer.cornerRadius = cornerRadius
        emptyButton.clipsToBounds = true
        emptyButton.addTarget(self, action: "emptyButtonPressed:", forControlEvents: .TouchUpInside)
        visualEffectSub.addSubview(emptyButton)
        //------empty end
        
      
        
        let gesture3 = UITapGestureRecognizer(target: self, action: "effectSubPressed:")
        visualEffectSub.userInteractionEnabled = true
        visualEffectSub.addGestureRecognizer(gesture3)
        
    }
    
    func effectSubPressed(sender:UITapGestureRecognizer){
        removeNewView()
        
    }
    func regularButtonPressed(sender: UIButton!) {
        removeNewView()
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("analyzeRegular")
        self.showViewController(vc as! UIViewController, sender: vc)
    }

    func emptyButtonPressed(sender: UIButton!) {
        
        removeNewView()

        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("analyzeEmpty")
        self.showViewController(vc as! UIViewController, sender: vc)
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        usernameArray = []
        turnArray = []

        
        usernameArray = []
        updatedArray = []

        turnUpdateSince = []

        
        
        tableView.alpha = 0
        tableView.reloadData()
        
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
