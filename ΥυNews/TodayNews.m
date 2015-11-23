
//
//  TodayNews.m
//  ΥυNews
//
//  Created by lanou3g on 15/11/16.
//  Copyright © 2015年 C. All rights reserved.
//

#import "TodayNews.h"
#import "NewsURL.h"
#import "DeatilTodayModel.h"
#import "PictureNewsModel.h"

@interface TodayNews ()



@end

static TodayNews *todayNews=nil;

@implementation TodayNews

// 单例
+ (TodayNews *)shareDataTodayNews{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        todayNews=[TodayNews new];
        [todayNews requestData];
    });
    return todayNews;
}

// 数据解析
- (void)requestData{
//    NSLog(@"我来过这儿");
    // 在子线程中请求数据，防止假死
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //构造url
        NSURL *url=[NSURL URLWithString:kTodayNewsURL];
        // 请求
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
        // 建立会话
        NSURLSession *session=[NSURLSession sharedSession];
        NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (self.dataArray!=nil) {
                // 最外围的大字典
                NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                //  NSLog(@"%@",dic);
                // 在字典里面遍历
                NSArray *array  = dict[@"stories"];
                NSArray *pArray=dict[@"top_stories"];
                for (NSDictionary *dic in array) {
                    //                DeatilTodayModel * detailModel=[DeatilTodayModel new];
                    // model
                    self.detailModel=[DeatilTodayModel new];
                    // 给model赋值
                    [self.detailModel setValuesForKeysWithDictionary:dic];
                    // 将model放入数组
                    [self.dataArray addObject:self.detailModel];
                }
                for (NSDictionary *dic in pArray) {
                    self.pictureModel=[PictureNewsModel new];
                    [self.pictureModel setValuesForKeysWithDictionary:dic];
                    // 图片放到数组里
//                    [self.picArray addObject:self.pictureModel.imagee];
//                    NSLog(@"%@",[self.picArray lastObject]);
                    // 存放model
                    [self.pictureArray addObject:self.pictureModel];
                }
                
                // 返回主线程
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 判断block是否为空
                    if (!self.updataUI) {
                        NSLog(@"block没有数据");
                    }else{
                        // block实现
                        self.updataUI();
//                        NSLog(@"111");
                    }
                });
                // 返回主线程
            }
            // 查看处理结果(stories)
//            for (DeatilTodayModel *detail in _dataArray) {
//                NSLog(@"%@",detail);
//            }
            
            // 查看处理结果(top_stories)
//            for (PictureNewsModel *pict in self.pictureArray) {
//                NSLog(@"%@",pict);
//            }
        }];
        // 启动任务
        [task resume];
    });
}

// lazy load
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}

-(NSMutableArray *)pictureArray{
    if (!_pictureArray) {
        _pictureArray=[NSMutableArray array];
    }
    return _pictureArray;
}

//-(NSMutableArray *)picArray{
//    if (!_picArray) {
//        _picArray=[NSMutableArray array];
//    }
//    return _picArray;
//}

//-(DeatilTodayModel *)detailModel{
//    if (!_detailModel) {
//        _detailModel=[DeatilTodayModel new];
//    }
//    return _detailModel;
//}

@end
