//Copy rights
//created by ashok kumar
//contact ashok_kumarcs@yahoo.com

#import "ChatroomOutgoingTableViewCell.h"


@implementation ChatroomOutgoingTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
    [self.labelMessage setTextColor:[UIColor whiteColor]];
    self.viewMessage.backgroundColor =  self.viewMessage.backgroundColor = [UIColor colorWithRed:161.0/255.0 green:212.0/255.0 blue:90.0/255.0 alpha:1.0];

}



@end
