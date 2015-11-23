//
//  DeatilTodayModel.m
//  ΥυNews
//
//  Created by lanou3g on 15/11/16.
//  Copyright © 2015年 C. All rights reserved.
//

#import "DeatilTodayModel.h"

@implementation DeatilTodayModel

// 容错处理
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
//    [super setValue:value forUndefinedKey:key];
    if ([key isEqualToString:@"id"]) {
        _ID=value;
    }
    if ([key  isEqualToString:@"images"]) {
        _image=value[0];
    }
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%@--%@--%@",_title,_ID,_image];
}

@end
