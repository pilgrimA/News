//
//  TodayNews.h
//  ΥυNews
//
//  Created by lanou3g on 15/11/16.
//  Copyright © 2015年 C. All rights reserved.
//

// 数据管理manager

#import <Foundation/Foundation.h>
@class DeatilTodayModel;
@class PictureNewsModel;

// 定义一个block，刷新数据
typedef void (^UpdataUI)();

@interface TodayNews : NSObject

// 定义数组，盛放数据
@property (nonatomic, strong) NSMutableArray *dataArray;
// 盛放轮播图的数组
@property (nonatomic,retain) NSMutableArray *pictureArray;
//// 盛放轮播图图片的数组
//@property (nonatomic,retain) NSMutableArray *picArray;

// 单例
+ (TodayNews *)shareDataTodayNews;

// 新闻model
@property (nonatomic,retain) DeatilTodayModel *detailModel;
// 轮播图的model
@property (nonatomic,retain) PictureNewsModel *pictureModel;

// 声明block
@property (nonatomic,copy) UpdataUI updataUI;

@end
