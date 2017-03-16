//
//  ViewController.m
//  成都生活
//
//  Created by 刘晓微 on 15/8/13.
//  Copyright (c) 2015年 刘晓微. All rights reserved.
//
#define back_color [UIColor colorWithRed:154/255.0 green:37/255.0 blue:21/255.0 alpha:1]
#import "ViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "ForthViewController.h"
#import "RegisterController.h"
#import "DatabaseHelper.h"
#import "User.h"

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    //隐藏自带的标题栏navigation
    self.navigationController.navigationBarHidden = YES;
    //出现logo
    UIImageView *logoImageView =[[UIImageView alloc]initWithFrame:CGRectMake(90, 147, 183, 158)];
    logoImageView.image = [UIImage imageNamed:@"logo3"];
    [self.view addSubview:logoImageView];
    //如何操作键盘
    _nameField = [[UITextField alloc]initWithFrame:CGRectMake(26, 316, 332, 41)];
    _nameField.placeholder = @"请输入账号";
    _nameField.borderStyle = UITextBorderStyleRoundedRect;
    _nameField.keyboardType = UIKeyboardTypeDefault;//键盘类型
    _nameField.returnKeyType = UIReturnKeyDone;//返回键是done
    //全部删除，自动删除
    _nameField.clearButtonMode = UITextFieldViewModeWhileEditing;//编辑时出现删除键
    _nameField.clearsOnBeginEditing = YES;//开始编辑时清空
    //text.secureTextEntry = YES;//密文输入
    _nameField.delegate = self;//让下一级别的对象知道上一层／／将键盘的回调事件交给self
    //给text增加一个tag值
    _nameField.tag = 100;
    [self.view addSubview:_nameField];
    
    _passwordField = [[UITextField alloc]initWithFrame:CGRectMake(26, 372, 332, 41)];
    _passwordField.placeholder = @"请输入密码";
    _passwordField.borderStyle = UITextBorderStyleRoundedRect;
    _passwordField.tag = 200;
    _passwordField.secureTextEntry = YES;
    [self.view addSubview:_passwordField];
    //按钮登陆
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor colorWithRed:154/255.0 green:37/255.0 blue:21/255.0 alpha:1]];
    button.frame = CGRectMake(26, 440, 150, 47) ;
    [button setTitle:@"登陆" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(toLogin) forControlEvents:UIControlEventTouchUpInside];
    //button的圆角
    button.layer.cornerRadius = 7;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//在点击未放的过程中
    //*********按钮添加事件*********
    [self.view addSubview:button];
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setBackgroundColor:[UIColor colorWithRed:154/255.0 green:37/255.0 blue:21/255.0 alpha:1]];
    registerButton.frame = CGRectMake(180, 440, 150, 47) ;
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
    registerButton.layer.cornerRadius = 7;
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:registerButton];
    
}

/**********注册账号信息**************/
- (void)registerUser {
    
    RegisterController *registerController = [[RegisterController alloc] init];
    [self presentViewController:registerController animated:YES completion:nil];
}

/**********键盘弹出或消失，视图上移和下移的位置必须固定**************/
//开始输入时，视图上移
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField.tag == 100){
        self.view.center = CGPointMake(self.view.center.x, 689/2-50);
    }else{
        self.view.center = CGPointMake(self.view.center.y, 689/2-100);
    }
}
//键盘收起时，视图下移
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];//取消第一响应
    self.view.center = [UIApplication sharedApplication].keyWindow.center;
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    UITextField *field = (UITextField *)[self.view viewWithTag:100];
    [_nameField resignFirstResponder];
//    UITextField *field2 = (UITextField *)[self.view viewWithTag:200];
    [_passwordField resignFirstResponder];
    self.view.center = [UIApplication sharedApplication].keyWindow.center;
}

- (void)toLogin
{
    //如果等于，输出登陆成功
    NSLog(@"%@",NSHomeDirectory());
//    UITextField *passwordField = (UITextField  *)[self.view viewWithTag:200];
    
//    self.name = [(UITextField *)[self.view viewWithTag:100] text];
//    self.password = passwordField.text;
    
    User *user = [[User alloc] init];
    self.userArray = [DatabaseHelper getAllUsers];
    self.name = self.nameField.text;
    self.password = self.passwordField.text;
    
    for (int i = 0; i < [self.userArray count]; i++) {
        user = self.userArray[i];
        
        if ( [self.name isEqualToString:user.name] && [self.password isEqualToString:user.password] )
        {
            //tabBar
            FirstViewController *fvc = [[FirstViewController alloc]init];
            id obj1 = [self setTabBarInfoWithVC:fvc imageName:@"icon_menu_hp_press" slectedName:@"icon_menu_hp_selected"title:@"热门推荐"];
            SecondViewController *svc = [[SecondViewController alloc]init];
            id obj2 = [self setTabBarInfoWithVC:svc imageName:@"icon_menu_x_press" slectedName:@"icon_menu_x_selected" title:@"专线航程"];
            ThirdViewController *thc = [[ThirdViewController alloc]init];
            id obj3 = [self setTabBarInfoWithVC:thc imageName:@"icon_menu_ihave_press" slectedName:@"icon_menu_ihave_selected" title:@"游记攻略"];
            ForthViewController *fvc2 = [[ForthViewController alloc]init];
            id obj4 = [self setTabBarInfoWithVC:fvc2 imageName:@"icon_menu_profile_press" slectedName:@"icon_menu_profile_selected" title:@"我"];
            UITabBarController *tab = [[UITabBarController alloc]init];
            tab.viewControllers = @[obj1,obj2,obj3,obj4];
            tab.tabBar.barTintColor = back_color;
            tab.tabBar.tintColor = [UIColor whiteColor];
            [self presentViewController:tab animated:YES completion:nil];
            
            
        } else if (![self.password isEqualToString:@"123456"]) {
            
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"position.x";
            animation.values = @[@0, @10, @-10, @10, @0];
            animation.keyTimes = @[@0, @(1/6.0), @(3/6.0), @(5/6.0), @1];
            animation.duration = 0.4;
            animation.additive = YES;
            [_passwordField.layer addAnimation:animation forKey:@"shake"];
            
        }
    }

    
//    else{
//               UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请输入用户名和密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//                [alertView show];
//    }
}
- (id)setTabBarInfoWithVC:
(UIViewController *)vc imageName:
(NSString *)imageName slectedName:
(NSString *)selectedName title:
(NSString *)title
{
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedName];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    nav.navigationBarHidden = YES;
    return nav;
}

//- (void)GetName:(GetTextBlock)block1 getPassword:(GetTextBlock)block2 {
//    self.getNameBlock = block1;
//    self.getPasswordBlock = block2;
//}
//- (void)viewWillDisappear:(BOOL)animated {
//    if (self.getNameBlock != nil && self.getPasswordBlock != nil) {
////        self.get
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
