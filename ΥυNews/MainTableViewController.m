//
//  MainTableViewController.m
//  ΥυNews
//
//  Created by lanou3g on 15/11/16.
//  Copyright © 2015年 C. All rights reserved.
//

#import "MainTableViewController.h"
#import "MainTableViewCell.h"
#import "TodayNews.h"
#import "DeatilTodayModel.h"
#import "UIImageView+WebCache.h"
#import "PictureNewsModel.h"
#import "LoadingViewController.h"
#import "DetailTN1ViewController.h"

@interface MainTableViewController ()<UIScrollViewDelegate>

// 数组
@property (nonatomic,retain) NSArray *dataArray;
// 轮播图
@property (nonatomic,retain) UIScrollView *scroll;
@property (nonatomic,retain) UIPageControl *pageControl;
@property (nonatomic,retain) NSTimer *timer;
// 下拉刷新数据
@property (nonatomic,retain) UIRefreshControl *refrControl;

@property (nonatomic,retain) DeatilTodayModel *model;

@end

@implementation MainTableViewController

static NSString *identifier=@"MainCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // navigationItem
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"登陆/注册" style:UIBarButtonItemStylePlain target:self action:@selector(click:)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
    
    // 设置头视图
    UIScrollView *scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    
#pragma mark -- 可以直接把需要处理的数据放在刷新数据里面
    [TodayNews shareDataTodayNews].updataUI=^(){
        // 刷新数据
        [self.tableView reloadData];
        // 添加图片
        [self addPicture];
    };
    
    // 轮播显示
    self.scroll=scroll;
    [self scrollAndPaging];
    // 下拉刷新
    [self refreshView];
    
}

// 添加图片
- (void)addPicture{
    // 添加图片
    for (int i=0; i<5; i++) {
        // model
        PictureNewsModel *picModel=[TodayNews shareDataTodayNews].pictureArray[i];
        // image
        UIImageView *imgView=[[UIImageView alloc] init];
        imgView.frame=CGRectMake(0+self.view.bounds.size.width*i, 0, self.view.bounds.size.width, 200);
        [self.scroll addSubview:imgView];
        [imgView sd_setImageWithURL:[NSURL URLWithString:picModel.imagee]];
        
        // label
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(5, 3.0/4*imgView.bounds.size.height, self.view.bounds.size.width-10, 1.0/4*imgView.bounds.size.height)];
        label.text=picModel.title;
        label.numberOfLines=0;
        label.textColor=[UIColor whiteColor];
        [imgView addSubview:label];
    }
}

// 轮播显示
- (void)scrollAndPaging
{
    // scroll属性
    _scroll.contentSize=CGSizeMake(self.view.bounds.size.width*5, 200);
    // 是否允许整页翻
    _scroll.pagingEnabled=YES;
    // 代理
    _scroll.delegate=self;
    // 添加为tableHeaderView
    self.tableView.tableHeaderView=_scroll;
    
    // pageControl
    UIPageControl *pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    self.pageControl=pageControl;
    //    pageControl.currentPage=0;
    pageControl.numberOfPages=5;
    pageControl.currentPageIndicatorTintColor=[UIColor whiteColor];
    pageControl.pageIndicatorTintColor=[UIColor lightGrayColor];
    [pageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:pageControl];
    
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(change) userInfo:nil repeats:YES];
    self.timer=timer;
}

// 登陆/注册
- (void)click:(UIBarButtonItem *)sender{
    LoadingViewController *loadVC=[[LoadingViewController alloc] init];
    [self.navigationController pushViewController:loadVC animated:YES];
}

// 下拉刷新数据
- (void)refreshView
{
    // 初始化
    self.refrControl=[[UIRefreshControl alloc] init];
    // 添加事件
    [_refrControl addTarget:self action:@selector(tog:) forControlEvents:UIControlEventValueChanged];
    // 添加到视图上
    [self.tableView addSubview:_refrControl];
}

- (void)tog:(UIRefreshControl *)sender{
    // 开始刷新
    [sender beginRefreshing];
    // 刷新
    [self.tableView reloadData];
    // 结束刷新
    [sender endRefreshing];
}

// 轮播实现方法
- (void)pageChange:(UIPageControl *)sender{
    NSInteger currentPage=sender.currentPage;
    self.scroll.contentOffset=CGPointMake(self.view.bounds.size.width*currentPage, 0);
}

// 轮播实现方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger currentPage= scrollView.contentOffset.x/self.view.bounds.size.width;
    self.pageControl.currentPage=currentPage;
}

// 轮播实现方法
- (void)change{
//    NSLog(@"1");
    if ((long)self.pageControl.currentPage==4) {
        self.pageControl.currentPage=0;
        [self.pageControl setCurrentPage:0];
        [self.scroll setContentOffset:CGPointMake(0, 0)];
    }else{
        [self.pageControl setCurrentPage:(long)self.pageControl.currentPage+1];
        [self.scroll setContentOffset:CGPointMake(self.view.bounds.size.width*(long)self.pageControl.currentPage, 0)];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 打印多少分组
    return [TodayNews shareDataTodayNews].dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 重用池
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    // model
    self.model=[TodayNews shareDataTodayNews].dataArray[indexPath.row];
    // model赋值
    cell.nameLabel.text=self.model.title;
    cell.nameLabel.font=[UIFont systemFontOfSize:20];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:self.model.image]];
    return cell;
}

// 改变导航条的颜色
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"offset--scroll:%f",scrollView.contentOffset.y);
//    NSLog(@"offset--scroll:%f",elf.tableView.contentOffset.y);
    CGFloat offset=self.tableView.contentOffset.y;
    if (offset<134) {
        self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    }else{
        self.navigationController.navigationBar.barTintColor=[UIColor blueColor];
    }
}

// lazy load
-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSArray array];
    }
    return _dataArray;
}

// 点击cell触发事件操作
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
#pragma mark -- cell重用问题，多个cell被选中
//    MainTableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
//    // 点击选中cell时的颜色
//    cell.selectionStyle=UITableViewCellSelectionStyleGray;
//    // cell选中后显示的颜色
//    cell.backgroundColor=[UIColor lightGrayColor];
    // 新闻详情界面
    DetailTN1ViewController *detail=[DetailTN1ViewController new];
    // 必须重新给model赋值，否则数据不会刷新
    self.model=[TodayNews shareDataTodayNews].dataArray[indexPath.row];
    // ID赋值
    detail.ID=self.model.ID;
    // push(保留导航条)
    [self.navigationController pushViewController:detail animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
