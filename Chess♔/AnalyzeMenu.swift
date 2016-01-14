//
//  AnalyzeMenu.swift
//  
//
//  Created by Johannes Berge on 12/01/16.
//
//

import UIKit
import Parse

class AnalyzeMenu: UIViewController,UITableViewDelegate {
    
    var analyzeIDS:Array<String> = []
    var analyzeID = ""
    
    var usernameArray: Array<String> = []
    var ratingArray: Array<Int> = []
    var updatedArray: Array<String> = []
    var profilePicArray: Array<UIImage> = []
    var imageDataArray: Array<NSData> = []
    
    var yourturnArray: Array<String> = []
    var yourturnUpdateSince: Array<NSTimeInterval> = []
    var yourTurnColor: Array<String> = []

    
    var instructionsLabel = UILabel()

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.navigationBar.topItem?.title = "Analyze"
        self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Didot", size: 20)!]
        
        
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
        lightOrDarkMode()

        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        let cell:AnalyzeMenuTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("analyzeCell",forIndexPath: indexPath) as! AnalyzeMenuTableViewCell
        
        
        if darkMode {cell.backgroundColor = UIColor.clearColor() //(red:0.22, green:0.22, blue:0.22, alpha:1.0)
            
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            
            cell.rating.textColor = UIColor.lightTextColor()
            
            
            cell.username.textColor = UIColor.whiteColor()
            
        }
        else {cell.backgroundColor = UIColor.whiteColor()
            
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            cell.rating.textColor = UIColor.darkGrayColor()
            cell.username.textColor = UIColor.blackColor()
            
            
        }
        // cell.userProfileImage.image = nil
        cell.username.text = ""
        
        
        func find(name:String) {
            
            cell.username.text = name
            cell.userProfileImage.image = nil
            
            
            
            let query = PFQuery(className: "_User")
            
            query.whereKey("username", equalTo: name)
            query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
                if (error == nil) {
                    
                    if let userArray = objects as? [PFUser] {
                        for user in userArray {
                            
                            cell.rating.text = String(user["rating"] as! Int)
                            
                            if let userPicture = user["profile_picture"] as? PFFile {
                                
                                userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                                    if (error == nil) {
                                        cell.userProfileImage.alpha = 0
                                        cell.userProfileImage.image = UIImage(data: imageData!)
                                        self.imageDataArray.append(imageData!)
                                        
                                        UIView.animateWithDuration(0.3, animations: { () -> Void in
                                            cell.userProfileImage.alpha = 1
                                            
                                            
                                        })
                                        
                                    } else {
                                    }
                                }
                                
                            }
                        }
                        
                    }
                } else {
                    // Log details of the failure
                    print("query error: \(error) \(error!.userInfo)")
                }
                
            }
        }
        
        
        
        
        
        
        
        // cell.rating.text = "601"
        // cell.updated.text = "Last Update: 1h 5min"
        
            find(yourturnArray[indexPath.row])
            
            if yourTurnColor[indexPath.row] == "white" {
                cell.pieceIndicator.backgroundColor = UIColor.whiteColor()
            }
            else {
                cell.pieceIndicator.backgroundColor = UIColor.blackColor()
            }
            

            
            var since = yourturnUpdateSince[indexPath.row]
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

            gameID = analyzeIDS[indexPath.row]
 
            
        
        print("this is \(gameID)")
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if yourturnArray.count == 0 {
            
            tableView.hidden = true

        }
        else {
            
            instructionsLabel.hidden = true
            tableView.hidden = false
            
            
        }
        
  
            return yourturnArray.count

        
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
    
    //func to check if dark or light mode should be enabled, keep this at the bottom
    func lightOrDarkMode() {
        if darkMode == true {
            
            
            self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
            self.navigationController?.navigationBar.barTintColor = UIColor.darkGrayColor()
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.05, green: 0.05 , blue: 0.05, alpha: 1)
            self.view.backgroundColor = UIColor(red: 0.15, green: 0.15 , blue: 0.15, alpha: 1)
            self.tabBarController?.tabBar.barStyle = UIBarStyle.Black
            self.tabBarController?.tabBar.tintColor = blue
            self.navigationController?.navigationBar.tintColor = blue
            
            
            
        }
        else if darkMode == false {
            
            self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
            self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
            self.view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            self.tabBarController?.tabBar.barStyle = UIBarStyle.Default
            self.tabBarController?.tabBar.tintColor = blue
            self.navigationController?.navigationBar.tintColor = blue
            
            
        }
        
        
    }
    
    
}
