

// Created by Ashok on 30/09/2018.
//Copy rights 2018
//contact ashok_kumarcs@yahoo.com
#import "ChatMessageViewController.h"
#import "ChatroomOutgoingTableViewCell.h"
#import "ChatroomIncomingTableViewCell.h"
#import "Message.h"

@interface ChatMessageViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableViewMessageList;

@property (weak, nonatomic) IBOutlet UIView *viewSendMessage;
@property (weak, nonatomic) IBOutlet UITextView *textViewInputMessage;
@property (weak, nonatomic) IBOutlet UIButton *buttonSend;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutConstraintContentViewBottomWithSendMessageViewBottom;

@property (strong, nonatomic) NSMutableArray *messageList;
@end

static NSString* incomingCellIdentifier = @"incomingCell";
static NSString* outgoingCellIdentifier = @"outgoingCell";

@implementation ChatMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.messageList = [self createDummyMessageList];
    
    self.tableViewMessageList.rowHeight = UITableViewAutomaticDimension;
    self.tableViewMessageList.estimatedRowHeight = 50.0;
    self.tableViewMessageList.delegate = self;
    self.tableViewMessageList.dataSource = self;
    
    self.textViewInputMessage.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textViewInputMessage.layer.borderWidth = 1;
    self.textViewInputMessage.layer.cornerRadius = 5;
    
    self.buttonSend.layer.borderWidth = 1;
    self.buttonSend.layer.cornerRadius = 5;
    self.buttonSend.layer.borderColor = self.buttonSend.backgroundColor.CGColor;
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Add keyboard observer
    [self addKeyboardObserver];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    // Remove observer
    [self removeKeyboardObserver];
    [super viewDidDisappear:animated];
    
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.messageList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Message* message = self.messageList[indexPath.row];
    
    
    if (message.isOutgoing) {
        
        ChatroomOutgoingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:outgoingCellIdentifier forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[ChatroomOutgoingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:outgoingCellIdentifier];
        }
        [cell setMessage:self.messageList[indexPath.row]];
        
        return cell;
    } else {
        ChatroomIncomingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:incomingCellIdentifier forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[ChatroomIncomingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:incomingCellIdentifier];
        }
        [cell setMessage:self.messageList[indexPath.row]];
        
        return cell;
    }
    return nil;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
}

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

# pragma mark - Keyboard

- (void)addKeyboardObserver {
    // add observer for keyboard
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChange:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
}

- (void)removeKeyboardObserver{
    // remove observer for keyboard
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillChangeFrameNotification
                                                  object:nil];
}


- (void)keyboardWillChange:(NSNotification *)notification
{
    
    // Get duration of keyboard appearance/ disappearance animation
    UIViewAnimationCurve animationCurve = [[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    UIViewAnimationOptions animationOptions = animationCurve | (animationCurve << 16); // Convert animation curve to animation option
    NSTimeInterval animationDuration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // Get the final size of the keyboard
    CGRect keyboardEndFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // Calculate the new bottom constraint, which is equal to the size of the keyboard
    CGRect screen = [UIScreen mainScreen].bounds;
    CGFloat newBottomConstraint = (screen.size.height-keyboardEndFrame.origin.y);
    
    // Keep old y content offset and height before they change
    CGFloat oldYContentOffset = self.tableViewMessageList.contentOffset.y;
    CGFloat oldTableViewHeight = self.tableViewMessageList.bounds.size.height;
    
    [UIView animateWithDuration:animationDuration delay:0 options:animationOptions animations:^{
        // Set the new bottom constraint
        self.layoutConstraintContentViewBottomWithSendMessageViewBottom.constant = newBottomConstraint;
        // Request layout with the new bottom constraint
        [self.view layoutIfNeeded];
        
        // Calculate the new y content offset
        CGFloat newTableViewHeight = self.tableViewMessageList.bounds.size.height;
        CGFloat contentSizeHeight = self.tableViewMessageList.contentSize.height;
        CGFloat newYContentOffset = oldYContentOffset - newTableViewHeight + oldTableViewHeight;
        
        // Prevent new y content offset from exceeding max, i.e. the bottommost part of the UITableView
        CGFloat possibleBottommostYContentOffset = contentSizeHeight - newTableViewHeight;
        newYContentOffset = MIN(newYContentOffset, possibleBottommostYContentOffset);
        
        // Prevent new y content offset from exceeding min, i.e. the topmost part of the UITableView
        CGFloat possibleTopmostYContentOffset = 0;
        newYContentOffset = MAX(possibleTopmostYContentOffset, newYContentOffset);
        
        // Create new content offset
        CGPoint newTableViewContentOffset = CGPointMake(self.tableViewMessageList.contentOffset.x, newYContentOffset);
        self.tableViewMessageList.contentOffset = newTableViewContentOffset;
        
    } completion:nil];
}


#pragma mark - Private
- (NSMutableArray *)createDummyMessageList {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    [result addObject:[Message initWithContent:@"Hi!" isOutgoing:YES]];
    [result addObject:[Message initWithContent:@"How are you?" isOutgoing:NO]];
    [result addObject:[Message initWithContent:@"Whats'up" isOutgoing:NO]];
    
    return result;
}
@end

