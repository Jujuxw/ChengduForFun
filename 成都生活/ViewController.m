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
    UITextField *text = [[UITextField alloc]initWithFrame:CGRectMake(26, 316, 332, 41)];
    text.placeholder = @"请输入账号";
    text.borderStyle = UITextBorderStyleRoundedRect;
    text.keyboardType = UIKeyboardTypeDefault;//键盘类型
    text.returnKeyType = UIReturnKeyDone;//返回键是done
    //全部删除，自动删除
    text.clearButtonMode = UITextFieldViewModeWhileEditing;//编辑时出现删除键
    text.clearsOnBeginEditing = YES;//开始编辑时清空
    //text.secureTextEntry = YES;//密文输入
    text.delegate = self;//让下一级别的对象知道上一层／／将键盘的回调事件交给self
    //给text增加一个tag值
    text.tag = 100;
    [self.view addSubview:text];
    
    UITextField *password = [[UITextField alloc]initWithFrame:CGRectMake(26, 372, 332, 41)];
    password.placeholder = @"请输入密码";
    password.borderStyle = UITextBorderStyleRoundedRect;
    password.tag = 200;
    password.secureTextEntry = YES;
    [self.view addSubview:password];
    //按钮登陆
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor colorWithRed:154/255.0 green:37/255.0 blue:21/255.0 alpha:1]];
    button.frame = CGRectMake(26, 440, 330, 47) ;
    [button setTitle:@"登陆" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(toLogin) forControlEvents:UIControlEventTouchUpInside];
    //button的圆角
    button.layer.cornerRadius = 7;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//在点击未放的过程中
    //*********按钮添加事件*********
    [self.view addSubview:button];
    // Do any additional setup after loading the view, typically from a nib.
    
    
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
    UITextField *field = (UITextField *)[self.view viewWithTag:100];
    [field resignFirstResponder];
    UITextField *field2 = (UITextField *)[self.view viewWithTag:200];
    [field2 resignFirstResponder];
    self.view.center = [UIApplication sharedApplication].keyWindow.center;
}
- (void)toLogin
{
    //输出用户的输入账号密码
    //判定是否等于admin 和123456
    //如果等于，输出登陆成功
        NSLog(@"%@",NSHomeDirectory());
    self.name = [(UITextField *)[self.view viewWithTag:100] text];
    self.password = [(UITextField  *)[self.view viewWithTag:200]  text];

    if ( [self.name isEqualToString:@"admin"] && [self.password isEqualToString:@"123456"] )
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
    
    
    }
    else{
               UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请输入用户名和密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
    }
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
