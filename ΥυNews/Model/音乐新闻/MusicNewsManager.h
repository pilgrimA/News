//
//  MusicNewsManager.h
//  ΥυNews
//
//  Created by lanou3g on 15/11/23.
//  Copyright © 2015年 C. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^myBlock)();

@class MusicNewsModel;

@interface MusicNewsManager : NSObject
// 单例
+ (MusicNewsManager *)shareMusicNewsManager;



@property (nonatomic,retain) NSString *image;
@property (nonatomic,retain) NSString *name;

// 存放model的数组
@property (nonatomic,retain) NSMutableArray *storyArray;
// model
@property (nonatomic,retain) MusicNewsModel *musicModel;

@property (nonatomic,copy) myBlock block;

@end
