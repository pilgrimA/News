//
//  DetailTN1ViewController.m
//  ΥυNews
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 C. All rights reserved.
//

#import "DetailTN1ViewController.h"

@interface DetailTN1ViewController ()<UIWebViewDelegate>

// webView
@property (nonatomic,retain) UIWebView *webView;

@end

@implementation DetailTN1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置背景颜色
    self.view.backgroundColor=[UIColor clearColor];
    
    self.webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, -64, self.view.bounds.size.width, self.view.bounds.size.height+64)];
    //自适应界面大小
    self.webView.scalesPageToFit=YES;
    [self.view addSubview:self.webView];
    // 边框是否允许滑动
    self.webView.scrollView.bounces=NO;
    // 解析数据
    [self parse];
}

// 解析数据
- (void)parse{
    NSString *string2=kDetailTodayNewsURL;
    NSString *string1 = [string2 stringByAppendingString:[NSString stringWithFormat:@"%@",self.ID]];
    // url
    NSURL *url=[NSURL URLWithString:string1];
    // 请求
    NSMutableURLRequest *request1=[NSMutableURLRequest requestWithURL:url];
    // 建立会话
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request1 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSString *body=dict[@"share_url"];
        NSLog(@"%@",body);
        NSURL *url=[NSURL URLWithString:body];
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
        // 返回主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            // 刷新界面数据
            [self.webView reload];
        });
    }];
    [task resume];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"webViewDidStartLoad");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"webViewDidFinishLoad");
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"didFailLoadWithError");
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
