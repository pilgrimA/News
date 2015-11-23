//
//  MusicNewsModel.m
//  ΥυNews
//
//  Created by lanou3g on 15/11/23.
//  Copyright © 2015年 C. All rights reserved.
//

#import "MusicNewsModel.h"

@implementation MusicNewsModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqual:@"id"]) {
        value=_ID;
    }
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%@--%@",_ID,_title];
}

@end
