# ChatViewController
Chat Message : using Objective C sample application using tableview controller with keyboard handle. 

# Change Background Color and Border Corner in TableViewCell as (ChatroomTableViewCell)

   self.viewMessage.layer.cornerRadius = 5; 
   
   // you can change it as per your requirement.
   
   if you want to change the background color (change RGB value)
   
   self.viewMessage.backgroundColor =  self.viewMessage.backgroundColor = [UIColor colorWithRed:161.0/255.0 green:212.0/255.0  blue:90.0/255.0 alpha:1.0];


# Change Incoming and Outgoing message

  change incoming and outgoing message in sendButtonTouchUpInside
  
  set BOOL (isOutgoing:NO ,isOutgoing:YES)
  
  // Message *message = [Message initWithContent:text isOutgoing:NO];

- (IBAction)sendButtonTouchUpInside:(id)sender {

    NSString *text = self.textViewInputMessage.text;
    
    // If nothing is inputted, just return
    
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (text.length == 0) {
        return;
    }
    
    Message *message = [Message initWithContent:text isOutgoing:NO];
    
    [self.messageList addObject:message];
    
    [self.tableViewMessageList reloadData];
    
    self.textViewInputMessage.text = @"";
    
    // Scroll to bottom
    
    if ([self.messageList count] > 0) {
    
    [self.tableViewMessageList scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(self.messageList.count-1) inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        
    }
    
    
}

# Screen Shots

![3](https://user-images.githubusercontent.com/5592080/46257367-be04e180-c4d1-11e8-9bcc-9179a94071a5.png)
![ipad-landscape](https://user-images.githubusercontent.com/5592080/46257368-be04e180-c4d1-11e8-8540-b84dbe995cb3.png)
![1](https://user-images.githubusercontent.com/5592080/46257369-be9d7800-c4d1-11e8-8199-89d8eb1466e0.png)
![ipad-portrait](https://user-images.githubusercontent.com/5592080/46257370-be9d7800-c4d1-11e8-8677-2f0c6107b766.png)
![2](https://user-images.githubusercontent.com/5592080/46257371-bf360e80-c4d1-11e8-84f7-12f2c7b1cbc9.png)

