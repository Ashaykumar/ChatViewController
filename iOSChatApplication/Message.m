// Created by Ashok on 30/09/2018.
//Copy rights 2018
//contact ashok_kumarcs@yahoo.com

#import "Message.h"

@implementation Message
+ (Message*)initWithContent:(NSString*)content isOutgoing:(BOOL)isOutgoing {
    Message* result = [[Message alloc] init];
    result.content = content;
    result.isOutgoing = isOutgoing;
    return result;
}
@end
