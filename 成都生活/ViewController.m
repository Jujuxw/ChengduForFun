//
//  ViewController.m
//  成都生活
//
//  Created by 刘晓微 on 15/8/13.
//  Copyright (c) 2015年 刘晓微. All rights reserved.
//

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
    UIImageView *logoImageView =[[UIImageView alloc] init];
    logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    logoImageView.image = [UIImage imageNamed:@"logo3"];
    [self.view addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(JMediumMargin);
        make.right.mas_equalTo(-JMediumMargin);
        make.top.mas_equalTo(100);
        make.height.mas_equalTo(158);
    }];
    //如何操作键盘
    self.nameField = [[UITextField alloc] init];
    self.nameField.placeholder = @"请输入账号";
    self.nameField.borderStyle = UITextBorderStyleRoundedRect;
    self.nameField.keyboardType = UIKeyboardTypeDefault;//键盘类型
    self.nameField.returnKeyType = UIReturnKeyDone;//返回键是done
    //全部删除，自动删除
    self.nameField.clearButtonMode = UITextFieldViewModeWhileEditing;//编辑时出现删除键
    self.nameField.clearsOnBeginEditing = YES;//开始编辑时清空
    self.nameField.delegate = self;
    self.nameField.tag = 100;
    [self.view addSubview:self.nameField];
    [self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImageView.mas_bottom).offset(JDefaultMargin);
        make.left.mas_equalTo(JDefaultMargin);
        make.right.mas_equalTo(-JDefaultMargin);
        make.height.mas_equalTo(JDefaultSize);
    }];
    
    self.passwordField = [[UITextField alloc] init];
    self.passwordField.placeholder = @"请输入密码";
    self.passwordField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordField.tag = 200;
    self.passwordField.secureTextEntry = YES;
    [self.view addSubview:self.passwordField];
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameField.mas_bottom).offset(JDefaultMargin);
        make.left.mas_equalTo(JDefaultMargin);
        make.right.mas_equalTo(-JDefaultMargin);
        make.height.mas_equalTo(JDefaultSize);
    }];
    
    //按钮登陆
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.backgroundColor = JButtonColor;
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(goToLogin) forControlEvents:UIControlEventTouchUpInside];
    loginButton.layer.cornerRadius = JDefaultRadius;
    [self.view addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(JDefaultMargin);
        make.top.equalTo(self.passwordField.mas_bottom).offset(JDefaultMargin);
        make.size.mas_equalTo(CGSizeMake((JDefaultScreenWidth - JMediumMargin) / 2, JDefaultSize));
    }];
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.backgroundColor = JButtonColor;
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(gotoRegister) forControlEvents:UIControlEventTouchUpInside];
    registerButton.layer.cornerRadius = JDefaultRadius;
    [self.view addSubview:registerButton];
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-JDefaultMargin);
        make.top.equalTo(self.passwordField.mas_bottom).offset(JDefaultMargin);
        make.size.mas_equalTo(CGSizeMake((JDefaultScreenWidth - JMediumMargin) / 2, JDefaultSize));
    }];
}

/**********注册账号信息**************/
- (void)gotoRegister {
    RegisterController *registerController = [[RegisterController alloc] init];
    [self.navigationController pushViewController:registerController animated:YES];
}

/**********键盘弹出或消失，视图上移和下移的位置必须固定**************/
//开始输入时，视图上移
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if(textField.tag == 100){
        self.view.center = CGPointMake(self.view.center.x, 689/2-50);
    }else{
        self.view.center = CGPointMake(self.view.center.y, 689/2-100);
    }
}
//键盘收起时，视图下移
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];//取消第一响应
    self.view.center = [UIApplication sharedApplication].keyWindow.center;
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    UITextField *field = (UITextField *)[self.view viewWithTag:100];
    [_nameField resignFirstResponder];
//    UITextField *field2 = (UITextField *)[self.view viewWithTag:200];
    [_passwordField resignFirstResponder];
    self.view.center = [UIApplication sharedApplication].keyWindow.center;
}

- (void)goToLogin {
    //如果等于，输出登陆成功
    NSLog(@"%@",NSHomeDirectory());
//    UITextField *passwordField = (UITextField  *)[self.view viewWithTag:200];
    
//    self.name = [(UITextField *)[self.view viewWithTag:100] text];
//    self.password = passwordField.text;
    
    User *user = [[User alloc] init];
    self.userArray = [DatabaseHelper getAllUsers];
    self.name = self.nameField.text;
    self.password = self.passwordField.text;
    
//    for (int i = 0; i < [self.userArray count]; i++) {
//        user = self.userArray[i];
    
//        if ( [self.name isEqualToString:user.name] && [self.password isEqualToString:user.password] ) {
            //tabBar
            FirstViewController *fvc = [[FirstViewController alloc] init];
            id obj1 = [self setTabBarInfoWithVC:fvc imageName:@"icon_menu_hp_press" slectedName:@"icon_menu_hp_selected"title:@"热门推荐"];
            SecondViewController *svc = [[SecondViewController alloc] init];
            id obj2 = [self setTabBarInfoWithVC:svc imageName:@"icon_menu_x_press" slectedName:@"icon_menu_x_selected" title:@"专线航程"];
            ThirdViewController *thc = [[ThirdViewController alloc] init];
            id obj3 = [self setTabBarInfoWithVC:thc imageName:@"icon_menu_ihave_press" slectedName:@"icon_menu_ihave_selected" title:@"游记攻略"];
            ForthViewController *fvc2 = [[ForthViewController alloc] init];
            id obj4 = [self setTabBarInfoWithVC:fvc2 imageName:@"icon_menu_profile_press" slectedName:@"icon_menu_profile_selected" title:@"我"];
            UITabBarController *tab = [[UITabBarController alloc] init];
            tab.viewControllers = @[obj1,obj2,obj3,obj4];
            tab.tabBar.barTintColor = JButtonColor;
            tab.tabBar.tintColor = [UIColor whiteColor];
            [self presentViewController:tab animated:YES completion:nil];
//        } else if (![self.password isEqualToString:@"123456"]) {
//            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
//            animation.keyPath = @"position.x";
//            animation.values = @[@0, @10, @-10, @10, @0];
//            animation.keyTimes = @[@0, @(1/6.0), @(3/6.0), @(5/6.0), @1];
//            animation.duration = 0.4;
//            animation.additive = YES;
//            [_passwordField.layer addAnimation:animation forKey:@"shake"];
//        }
//    }
//    else{
//               UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请输入用户名和密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//                [alertView show];
//    }
}

- (id)setTabBarInfoWithVC:(UIViewController *)vc
                imageName:(NSString *)imageName
              slectedName:(NSString *)selectedName
                    title:(NSString *)title {
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
