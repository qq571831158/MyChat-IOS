//
//  QQFriendModel.m
//  MyChat
//
//  Created by Apple on 2017/3/8.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "QQFriendModel.h"

@implementation QQFriendModel

-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self == [super init]){
        self.username = [aDecoder decodeObjectForKey:@"username"];
        self.user_picture = [aDecoder decodeObjectForKey:@"user_picture"];
        self.nickname = [aDecoder decodeObjectForKey:@"nickname"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.user_picture forKey:@"user_picture"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
}
@end
