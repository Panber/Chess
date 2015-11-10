//
//  GameInvitesPage.swift
//  Chess♔
//
//  Created by Johannes Berge on 10/11/15.
//  Copyright © 2015 Panber. All rights reserved.
//

import UIKit
import Parse

class GameInvitesPage: UIViewController,UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    var invites: Array<String> = ["d"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        self.title = "Invites"
        findRequests()
    }
    
    
    func findRequests() {
    
        let requestQuery = PFQuery(className: "Games")
        requestQuery.whereKey("players", equalTo: (PFUser.currentUser()?.username)!)
    
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 170
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invites.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:GameInvitesTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("GameInviteCell", forIndexPath: indexPath) as! GameInvitesTableViewCell
        
        return cell
    
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    
    
    }

}
