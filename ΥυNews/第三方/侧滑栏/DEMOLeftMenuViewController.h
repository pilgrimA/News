//
//  DEMOMenuViewController.h
//  RESideMenuExample
//
//  Created by Roman Efimov on 10/10/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"

@interface DEMOLeftMenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

// 单例
+ (DEMOLeftMenuViewController *)demol;

@property (nonatomic,retain) NSString *string;

- (void)creatString:(int)indexpath;

@end
