//Copy rights 2018
//created by ashok kumar
//contact ashok_kumarcs@yahoo.com
#import "ChatroomIncomingTableViewCell.h"


@implementation ChatroomIncomingTableViewCell

- (void)awakeFromNib {
     // Initialization code
    [super awakeFromNib];
    
    self.labelMessage.textColor = [UIColor whiteColor];
    self.viewMessage.backgroundColor = [UIColor colorWithRed:90.0/255.0 green:195.0/255.0 blue:212.0/255.0 alpha:1.0];
}

@end
