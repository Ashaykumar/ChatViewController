//Copy rights 2018
//created by ashok kumar
//contact ashok_kumarcs@yahoo.com
#import <UIKit/UIKit.h>


@interface ChatroomTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *viewMessage;
@property (weak, nonatomic) IBOutlet UILabel *labelMessage;



- (void)setMessage:(NSString *)message;

@end
