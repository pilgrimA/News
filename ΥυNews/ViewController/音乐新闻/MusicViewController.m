//
//  MusicViewController.m
//  ΥυNews
//
//  Created by lanou3g on 15/11/23.
//  Copyright © 2015年 C. All rights reserved.
//

#import "MusicViewController.h"
#import "MusicNewsManager.h"
#import "MusicTableViewCell.h"
#import "MusicNewsModel.h"
#import "RESideMenu.h"

@interface MusicViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,retain) UITableView *tableView;

@end

@implementation MusicViewController

static NSString *identifier=@"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView=[[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    
    // 注册register
    [self.tableView registerNib:[UINib nibWithNibName:@"MusicTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
    
    [MusicNewsManager shareMusicNewsManager].block=^(){
        // 刷新
        [self.tableView reloadData];
        self.title=[MusicNewsManager shareMusicNewsManager].name;
    };
    // 代理
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    // 添加到视图上
    [self.view addSubview:self.tableView];
}

// number of sections
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//number of rows
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [MusicNewsManager shareMusicNewsManager].storyArray.count;
}

// rowHeight
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

// cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MusicTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    //imgView
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[MusicNewsManager shareMusicNewsManager].image]];
    // model
    MusicNewsModel *model=[MusicNewsManager shareMusicNewsManager].storyArray[indexPath.row];
    // labeltext
    cell.label.text=model.title;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
