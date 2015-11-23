//
//  PictureNewsModel.m
//  ΥυNews
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 C. All rights reserved.
//

#import "PictureNewsModel.h"

@implementation PictureNewsModel

// 容错处理
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"image"]) {
        _imagee=value;
    }
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%@--%@",_title,_imagee];
}

@end
