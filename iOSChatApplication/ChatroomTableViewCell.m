//Copy rights 2018
//created by ashok kumar
//contact ashok_kumarcs@yahoo.com
#import "ChatroomTableViewCell.h"
#import "Message.h"


@implementation ChatroomTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];

    
    self.labelMessage.numberOfLines = 0;
    self.labelMessage.lineBreakMode = NSLineBreakByWordWrapping;
    
    
    self.viewMessage.layer.cornerRadius = 5;
    self.viewMessage.clipsToBounds = YES;
    self.viewMessage.layer.masksToBounds = YES;
    

    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
}

- (void)setMessage:(Message *)message {

    [self.labelMessage setText:message.content];
    
}




@end
