//
//  QQChatModel.m
//  MyChat
//
//  Created by Apple on 2017/3/9.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "QQChatModel.h"

@implementation QQChatModel
-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self == [super init]){
        self.messageType = [aDecoder decodeObjectForKey:@"messageType"];
        self.imageName = [aDecoder decodeObjectForKey:@"imageName"];
        self.iconName = [aDecoder decodeObjectForKey:@"iconName"];
        self.text = [aDecoder decodeObjectForKey:@"text"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.messageType forKey:@"messageType"];
    [aCoder encodeObject:self.imageName forKey:@"imageName"];
    [aCoder encodeObject:self.iconName forKey:@"iconName"];
    [aCoder encodeObject:self.text forKey:@"text"];
}
//- (NSString *)description{
//    return [NSString stringWithFormat:@"%@--%@--%ld岁",self.text,self.iconName,(long)self.imageName];
//}
@end
