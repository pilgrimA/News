//
//  LoadingViewController.m
//  ΥυNews
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 C. All rights reserved.

//登陆/注册界面

#import "LoadingViewController.h"
#import "MainTableViewController.h"

@interface LoadingViewController ()

// 控件--用户名，密码，确认密码，邮箱
@property (nonatomic,retain) UILabel *label;
@property (retain, nonatomic) UITextField *textField;
@property (nonatomic,retain) UIButton *btn;
// 确定在哪个界面(登陆/注册)使用按钮
@property (nonatomic,assign) BOOL isEding;

// 背景颜色渐变
@property (nonatomic,retain) CAGradientLayer *gradientLayer;

@end

@implementation LoadingViewController

-(instancetype)init{
    if (self=[super init]) {
        NSArray *labelArray=@[@"用户名",@"密码",@"确认密码",@"邮箱"];
        NSArray *textArray=@[@"请输入用户名",@"请输入密码",@"请确认密码",@"请输入邮箱"];
        NSArray *btnArray=@[@"确认",@"注册"];
        for (int i=0; i<4; i++) {
            // label
            self.label=[[UILabel alloc] initWithFrame:CGRectMake(80, 120+80*i, 80, 40)];
            self.label.text=labelArray[i];
            self.label.textAlignment=NSTextAlignmentCenter;
//            self.label.textColor=[UIColor yellowColor];
            self.label.tag=1000+i;
            [self.view addSubview:self.label];
            
            // textField
            self.textField=[[UITextField alloc] initWithFrame:CGRectMake(180, 120+80*i, 120, 40)];
            self.textField.placeholder=textArray[i];
            self.textField.layer.masksToBounds=YES;
            if (i==2 || i==1) {
                // 允许密文输入
                self.textField.secureTextEntry=YES;
            }
            self.textField.tag=1004+i;
            self.textField.layer.cornerRadius=5;
//            self.textField.backgroundColor=[UIColor greenColor];
            if (i==2 || i==3) {
                self.textField.hidden=YES;
                self.label.hidden=YES;
            }
            [self.view addSubview:self.textField];
            
            if (i<2) {
                self.btn=[UIButton buttonWithType:UIButtonTypeCustom];
                self.btn.frame=CGRectMake(100+100*i, 300, 80, 38);
                [self.btn setTitle:btnArray[i] forState:UIControlStateNormal];
                self.btn.backgroundColor=[UIColor orangeColor];
                self.btn.layer.masksToBounds=YES;
                self.btn.layer.cornerRadius=5;
                [self.btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
                self.btn.tag=1008+i;
                [self.view addSubview:self.btn];
            }
        }
    }
    return self;
}

// btn点击事件
- (void)click:(UIButton *)sender{
    // 如果点击的是注册按钮的情况
    if (sender.tag==1009) {
        // btn
        UIButton *sureBtn=(UIButton *)[self.view viewWithTag:1008];
        UIButton *registerBtn=(UIButton *)[self.view viewWithTag:1009];
        CGRect rect=sureBtn.frame;
        CGRect rect1=registerBtn.frame;
        // label
        UILabel *secondPasswordLabel=(UILabel *)[self.view viewWithTag:1002];
        UILabel *emailLabel=(UILabel *)[self.view viewWithTag:1003];
        // textField
        UITextField *secondPasswordText=(UITextField *)[self.view viewWithTag:1006];
        UITextField *emailText=(UITextField *)[self.view viewWithTag:1007];
        if (_isEding) {
            _isEding=NO;
            // 改变btn位置
            rect.origin.y+=140;
            rect1.origin.y+=140;
            
            // 改变注册按钮为登陆按钮
            [registerBtn setTitle:@"登陆" forState:UIControlStateNormal];
            
            // 显示label
            secondPasswordLabel.hidden=NO;
            emailLabel.hidden=NO;
            
            // 显示textField
            secondPasswordText.hidden=NO;
            emailText.hidden=NO;
        }else{
            _isEding=YES;
            // 改变btn位置
            rect.origin.y-=140;
            rect1.origin.y-=140;
            
            // 改变注册按钮为注册按钮
            [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
            
            // 显示label
            secondPasswordLabel.hidden=YES;
            emailLabel.hidden=YES;
            
            // 显示textField
            secondPasswordText.hidden=YES;
            emailText.hidden=YES;
        }
        sureBtn.frame=rect;
        registerBtn.frame=rect1;
    }else if (sender.tag==1008) {
        // 直接返回主界面
#warning 此处应该返回收藏界面(如果已登录，否则返回主界面，或者无效)
        [self.navigationController popViewControllerAnimated:YES];
    }
}

// 隐藏键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView *firstResponder = [keyWindow performSelector:@selector(firstResponder)];
    [firstResponder resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    // 初始化
    self.gradientLayer=[CAGradientLayer layer];
    self.gradientLayer.frame=self.view.frame;
    // 添加到layer层
    [self.view.layer addSublayer:self.gradientLayer];
    // 设置渐变颜色
    self.gradientLayer.startPoint=CGPointMake(0, 0);
    self.gradientLayer.endPoint=CGPointMake(0, 1);
    // 设定颜色组
    self.gradientLayer.colors=@[(__bridge id)[UIColor cyanColor].CGColor,(__bridge id)[UIColor purpleColor].CGColor];
    // 设定颜色分割点
    self.gradientLayer.locations=@[@(0.5f),@(1.0f)];
    
    self.isEding=YES;
}

#warning 检测用户输入问题，以及用户数据保存

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
