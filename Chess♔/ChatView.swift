//

//  ChatView.swift

//  Chess♔

//

//  Created by Johannes Berge on 05/09/15.

//  Copyright © 2015 Panber. All rights reserved.

//



import UIKit

import Parse

import Firebase



class ChatView: JSQMessagesViewController {
    
    
    
    var user: FAuthData?
    
    
    
    var messages = [Message]()
    
    var avatars = Dictionary<String, UIImage>()
    
    var outgoingBubbleImageView = JSQMessagesBubbleImageFactory.outgoingMessageBubbleImageViewWithColor(UIColor.jsq_messageBubbleLightGrayColor())
    
    var incomingBubbleImageView = JSQMessagesBubbleImageFactory.incomingMessageBubbleImageViewWithColor(UIColor.jsq_messageBubbleBlueColor())
    
    var senderImageUrl: String!
    
    var batchMessages = true
    
    var ref: Firebase!
    
    
    
    
    
    // Firebase reference
    
    var messagesRef: Firebase!
    
    
    
    func setupFirebase() {
        
        // Get messages from firebase
        
        messagesRef = ref.childByAppendingPath("messages")
        
        
        
        messagesRef.queryLimitedToNumberOfChildren(25).observeEventType(FEventType.ChildAdded, withBlock: { (snapshot) in
            
            print(snapshot)
            
            let text = snapshot.value.objectForKey("text") as? String
            
            let sender = snapshot.value.objectForKey("sender") as? String
            
            let imageUrl = snapshot.value.objectForKey("sender") as? String
            
            
            
            let message = Message(text: text, sender: sender, imageUrl: imageUrl)
            
            self.messages.append(message)
            
            self.finishReceivingMessage()
            
        })
        
    }
    
    
    
    func sendMessage(text: String!, sender: String!) {
        
        // Add message to firebase
        
        messagesRef.childByAutoId().setValue([
            
            "text":text,
            
            "sender":sender,
            
            "imageUrl":senderImageUrl
            
            ])
        
    }
    
    
    
    func tempSendMessage(text: String!, sender: String!) {
        
        let message = Message(text: text, sender: sender, imageUrl: senderImageUrl)
        
        messages.append(message)
        
    }
    
    
    
    func setupAvatarImage(name: String, imageUrl: String?, incoming: Bool) {
        
        if let stringUrl = imageUrl {
            
            if let url = NSURL(string: stringUrl) {
                
                if let data = NSData(contentsOfURL: url) {
                    
                    let image = UIImage(data: data)
                    
                    let diameter = incoming ? UInt(collectionView!.collectionViewLayout.incomingAvatarViewSize.width) : UInt(collectionView!.collectionViewLayout.outgoingAvatarViewSize.width)
                    
                    let avatarImage = JSQMessagesAvatarFactory.avatarWithImage(image, diameter: diameter)
                    
                    avatars[name] = avatarImage
                    
                    return
                    
                }
                
            }
            
        }
        
        
        
        // At some point, we failed at getting the image (probably broken URL), so default to avatarColor
        
        setupAvatarColor(name, incoming: incoming)
        
    }
    
    
    
    func setupAvatarColor(name: String, incoming: Bool) {
        
        let diameter = incoming ? UInt(collectionView!.collectionViewLayout.incomingAvatarViewSize.width) : UInt(collectionView!.collectionViewLayout.outgoingAvatarViewSize.width)
        
        
        
        let rgbValue = name.hash
        
        let r = CGFloat(Float((rgbValue & 0xFF0000) >> 16)/255.0)
        
        let g = CGFloat(Float((rgbValue & 0xFF00) >> 8)/255.0)
        
        let b = CGFloat(Float(rgbValue & 0xFF)/255.0)
        
        let color = UIColor(red: r, green: g, blue: b, alpha: 0.5)
        
        
        
        let nameLength = name.characters.count
        
        let initials : String? = name.substringToIndex(sender.startIndex.advancedBy(min(3, nameLength)))
        
        let userImage = JSQMessagesAvatarFactory.avatarWithUserInitials(initials, backgroundColor: color, textColor: UIColor.blackColor(), font: UIFont.systemFontOfSize(CGFloat(13)), diameter: diameter)
        
        
        
        avatars[name] = userImage
        
    }
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        inputToolbar!.contentView!.leftBarButtonItem = nil
        
        automaticallyScrollsToMostRecentMessage = true
        
        sender = meUserName
        
        sender = (sender != nil) ? sender : "Anonymous"
        
        let profileImageUrl = user?.providerData["cachedUserProfile"]?["profile_image_url_https"] as? NSString
        
        if let urlString = profileImageUrl {
            
            setupAvatarImage(sender, imageUrl: urlString as String, incoming: false)
            
            senderImageUrl = urlString as String
            
        } else {
            
            setupAvatarColor(sender, incoming: false)
            
            senderImageUrl = ""
            
        }
        
        ref = Firebase(url: "https://chess-panber.firebaseio.com/messages")
        
        setupFirebase()
        
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        collectionView!.collectionViewLayout.springinessEnabled = true
        
    }
    
    
    
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        
        
        if ref != nil {
            
            ref.unauth()
            
        }
        
    }
    
    
    
    // ACTIONS
    
    
    
    func receivedMessagePressed(sender: UIBarButtonItem) {
        
        // Simulate reciving message
        
        showTypingIndicator = !showTypingIndicator
        
        scrollToBottomAnimated(true)
        
    }
    
    
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, sender: String!, date: NSDate!) {
        
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        
        
        
        sendMessage(text, sender: sender)
        
        
        
        finishSendingMessage()
        
    }
    
    
    
    override func didPressAccessoryButton(sender: UIButton!) {
        
        print("Camera pressed!")
        
    }
    
    
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        
        return messages[indexPath.item]
        
    }
    
    
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, bubbleImageViewForItemAtIndexPath indexPath: NSIndexPath!) -> UIImageView! {
        
        let message = messages[indexPath.item]
        
        
        
        if message.sender() == sender {
            
            return UIImageView(image: outgoingBubbleImageView.image, highlightedImage: outgoingBubbleImageView.highlightedImage)
            
        }
        
        
        
        return UIImageView(image: incomingBubbleImageView.image, highlightedImage: incomingBubbleImageView.highlightedImage)
        
    }
    
    
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageViewForItemAtIndexPath indexPath: NSIndexPath!) -> UIImageView! {
        
        let message = messages[indexPath.item]
        
        if let avatar = avatars[message.sender()] {
            
            return UIImageView(image: avatar)
            
        } else {
            
            setupAvatarImage(message.sender(), imageUrl: message.imageUrl(), incoming: true)
            
            return UIImageView(image:avatars[message.sender()])
            
        }
        
    }
    
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return messages.count
        
    }
    
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! JSQMessagesCollectionViewCell
        
        
        
        let message = messages[indexPath.item]
        
        if message.sender() == sender {
            
            cell.textView!.textColor = UIColor.blackColor()
            
        } else {
            
            cell.textView!.textColor = UIColor.whiteColor()
            
        }
        
        
        
        let attributes = [NSForegroundColorAttributeName:cell.textView!.textColor!, NSUnderlineStyleAttributeName: 1]
        
        cell.textView!.linkTextAttributes = attributes
        
        
        
        //        cell.textView.linkTextAttributes = [NSForegroundColorAttributeName: cell.textView.textColor,
        
        //            NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle]
        
        return cell
        
    }
    
    
    
    
    
    // View  usernames above bubbles
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
        
        let message = messages[indexPath.item];
        
        
        
        // Sent by me, skip
        
        if message.sender() == sender {
            
            return nil;
            
        }
        
        
        
        // Same as previous sender, skip
        
        if indexPath.item > 0 {
            
            let previousMessage = messages[indexPath.item - 1];
            
            if previousMessage.sender() == message.sender() {
                
                return nil;
                
            }
            
        }
        
        
        
        return NSAttributedString(string:message.sender())
        
    }
    
    
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        
        let message = messages[indexPath.item]
        
        
        
        // Sent by me, skip
        
        if message.sender() == sender {
            
            return CGFloat(0.0);
            
        }
        
        
        
        // Same as previous sender, skip
        
        if indexPath.item > 0 {
            
            let previousMessage = messages[indexPath.item - 1];
            
            if previousMessage.sender() == message.sender() {
                
                return CGFloat(0.0);
                
            }
            
        }
        
        
        
        return kJSQMessagesCollectionViewCellLabelHeightDefault
        
    }
    
}