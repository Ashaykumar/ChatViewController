// Created by Ashok on 30/09/2018.
//Copy rights 2018
//contact ashok_kumarcs@yahoo.com

#import <Foundation/Foundation.h>

@interface Message : NSObject
@property (strong, nonatomic) NSString* content;
@property (assign, nonatomic) BOOL isOutgoing;

+ (Message*)initWithContent:(NSString*)content isOutgoing:(BOOL)isOutgoing;
@end
