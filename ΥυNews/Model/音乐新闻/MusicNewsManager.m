//
//  MusicNewsManager.m
//  ΥυNews
//
//  Created by lanou3g on 15/11/23.
//  Copyright © 2015年 C. All rights reserved.
//

#import "MusicNewsManager.h"
#import "MusicNewsModel.h"
#import "DEMOLeftMenuViewController.h"
#import "NewsURL.h"

@implementation MusicNewsManager

static MusicNewsManager *musicNM=nil;
// 单例
+ (MusicNewsManager *)shareMusicNewsManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        musicNM=[MusicNewsManager new];
        [musicNM dequestData];
    });
    return musicNM;
}

// 数据解析
- (void)dequestData{
    NSLog(@"😜😜😜😜😜😜");
        // 构造url
        NSURL *url=[NSURL URLWithString:kMusicURL];
        NSLog(@"url=%@",url);
    
        // 请求
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
        // 建立会话
        NSURLSession *session=[NSURLSession sharedSession];
        NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (self.storyArray!=nil) {
                // 最外围大字典
                NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                self.name=dict[@"name"];
                self.image=dict[@"image"];
                NSArray *array=dict[@"stories"];
                for (NSDictionary *dic in array) {
                    // 数组初始化
                    self.musicModel=[MusicNewsModel new];
                    // 给model赋值
                    [self.musicModel setValuesForKeysWithDictionary:dic];
                    // 添加model到数组
                    [self.storyArray addObject:self.musicModel];
//                    NSLog(@"%ld",self.storyArray.count);
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (!self.block) {
                        NSLog(@"没有数据");
                    }else{
                        // 调用
                        self.block();
                    }
                });
            }
        }];
        // 启动任务
        [task resume];
}

// lazy load
-(NSArray *)storyArray{
    if (!_storyArray) {
        _storyArray=[NSMutableArray arrayWithCapacity:5];
    }
    return _storyArray;
}

@end
