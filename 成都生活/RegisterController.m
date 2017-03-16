//
//  RegisterController.m
//  成都生活
//
//  Created by juju on 2017/3/13.
//  Copyright © 2017年 刘晓微. All rights reserved.
//

#import "RegisterController.h"
#import <sqlite3.h>
#import <SMS_SDK/SMSSDK.h>

@interface RegisterController ()<UITextFieldDelegate>

@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userArray = [NSMutableArray array];
    self.userArray = [DatabaseHelper getAllUsers];
    
    _codeNumber = 60;
    [SMSSDK registerApp:@"1c053d80b4260" withSecret:@"3793b53c0d787ee538764bd6818b7a0"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTextFieldAndLabel];
    [self setDefaultButton];
    [self setBackButton:self.backBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//获取所有用户

- (void)setBackButton:(UIButton *)backBtn {
    
    self.backBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 50, 30, 30)];
//    [self.backBtn setImage:[UIImage imageNamed:@"return.png"] forState:UIControlStateNormal];
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"return.png"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(backViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backBtn];
}

- (void)backViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setTextFieldAndLabel {
    /************设置TextField************/
    //设置用户名
    self.userName = [[UITextField alloc]initWithFrame:CGRectMake(26, 100, 250, 41)];
    self.userName.placeholder = @"请输入用户名";
    self.userName.borderStyle = UITextBorderStyleRoundedRect;
    self.userName.keyboardType = UIKeyboardTypeDefault;//键盘类型
    self.userName.returnKeyType = UIReturnKeyDone;//返回键是done
    //全部删除，自动删除
    self.userName.clearButtonMode = UITextFieldViewModeWhileEditing;//编辑时出现删除键
    self.userName.clearsOnBeginEditing = YES;//开始编辑时清空
    //text.secureTextEntry = YES;//密文输入
    self.userName.delegate = self;//让下一级别的对象知道上一层／／将键盘的回调事件交给self
    //给text增加一个tag值
    self.userName.tag = 100;
    [self.view addSubview:self.userName];
   
    //设置密码
    self.password = [[UITextField alloc]initWithFrame:CGRectMake(26, 160, 250, 41)];
    self.password.placeholder = @"请输入密码";
    self.password.borderStyle = UITextBorderStyleRoundedRect;
    self.password.tag = 200;
    self.password.secureTextEntry = YES;
    [self.view addSubview:self.password];
    
    self.phoneNumber = [[UITextField alloc] initWithFrame:CGRectMake(26, 220, 250, 41)];
    self.phoneNumber.placeholder = @"请输入电话号码";
    self.phoneNumber.borderStyle = UITextBorderStyleRoundedRect;
    self.phoneNumber.tag = 300;
    [self.view addSubview:self.phoneNumber];
    
    self.checkNumber = [[UITextField alloc] initWithFrame:CGRectMake(26, 300, 200, 41)];
    self.checkNumber.placeholder = @"验证码";
    self.checkNumber.borderStyle = UITextBorderStyleRoundedRect;
    self.checkNumber.tag = 400;
    [self.view addSubview:self.checkNumber];
    
    /************设置Label************/
    //设置nameLabel
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(300, 100, 70, 41)];
    self.nameLabel.backgroundColor = [UIColor redColor];
    self.nameLabel.text = @"用户名";
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.tintColor = [UIColor blackColor];
    [self.view addSubview:self.nameLabel];
    
    self.passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(300, 160, 70, 41)];
    self.passwordLabel.backgroundColor = [UIColor redColor];
    self.passwordLabel.text = @"密码";
    self.passwordLabel.textAlignment = NSTextAlignmentCenter;
    self.passwordLabel.tintColor = [UIColor blackColor];
    [self.view addSubview:self.passwordLabel];
    
    self.phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(300, 220, 70, 41)];
    self.phoneLabel.text = @"电话号码";
    self.phoneLabel.backgroundColor = [UIColor redColor];
    self.phoneLabel.textAlignment = NSTextAlignmentCenter;
    self.phoneLabel.tintColor = [UIColor blackColor];
    [self.view addSubview:self.phoneLabel];
}

- (void)setDefaultButton {
    
    self.checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.checkBtn.frame = CGRectMake(280, 300, 120, 41);
    self.checkBtn.backgroundColor = [UIColor redColor];
    self.checkBtn.layer.cornerRadius = 7;
    [self.checkBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.checkBtn setTintColor:[UIColor blackColor]];
    [self.checkBtn addTarget:self action:@selector(getVerificationCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.checkBtn];
    
    self.RegisterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.RegisterBtn.frame = CGRectMake(50, 430, 300, 50);
    self.RegisterBtn.backgroundColor = [UIColor redColor];
    self.RegisterBtn.layer.cornerRadius = 7;
    [self.RegisterBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.RegisterBtn setTintColor:[UIColor blackColor]];
    [self.RegisterBtn addTarget:self action:@selector(nextTapAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.RegisterBtn];
}

- (void)getVerificationCodeAction:(id)sender {
    
    BOOL result = YES;
    [self checkAllField:result];
    
    User *user = [[User alloc] init];
    for (int i = 0; i < [self.userArray count]; i++) {
        user = [self.userArray objectAtIndex:i];
        if (self.phoneNumber.text == user.phoneNumber) {
            [self addAlertControllerWithTitle:nil message:@"号码已注册"];
        }
    }
    
    if (_codeNumber == 60 && result) {
        [self cycleTimeOutAction:nil];
        _codeNimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(cycleTimeOutAction:) userInfo:nil repeats:YES];
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phoneNumber.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
            if (!error) {
                NSLog(@"获取验证码成功");
            }else {
                NSLog(@"获取验证码失败");
                [self addAlertControllerWithTitle:nil message:@"验证失败"];
                
                [_codeNimer invalidate];
                [_checkBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                _codeNumber = 60;
            }
        }];
    }
    NSLog(@"点击了");
    
}

- (void)checkAllField:(BOOL)result {
    
    if ([self judgeStringIsNull:_phoneNumber.text] && [self judgeStringIsNull:self.userName.text] && [self judgeStringIsNull:self.password.text]) {
        
    }else if(![self judgeStringIsNull:self.userName.text]) {
        result = NO;
        [self addAlertControllerWithTitle:nil message:@"请输入用户名"];
    }else if (![self judgeStringIsNull:self.password.text]) {
        result = NO;
        [self addAlertControllerWithTitle:nil message:@"请输入密码"];
    }else {
        result = NO;
        [self addAlertControllerWithTitle:nil message:@"请输入验证码"];
    }
}

- (void)nextTapAction:(id)sender {

    [self.view endEditing:YES];
    BOOL result = YES;
    BOOL resultcode = YES;
    [self checkAllField:result];
   
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    if (result && resultcode) {
        [SMSSDK commitVerificationCode:_checkNumber.text phoneNumber:_phoneNumber.text zone:@"86" result:^(SMSSDKUserInfo *userInfo, NSError *error) {
            if (!error) {
                [self insertOne];
                [self.navigationController popViewControllerAnimated:YES];
                NSLog(@"验证成功");
                [self addAlertControllerWithTitle:nil message:@"验证成功!"];
            }else {
                NSLog(@"验证失败");
                if ([self judgeStringIsNull:_checkNumber.text]) {
                    [self addAlertControllerWithTitle:nil message:@"验证码错误"];
                }else {
                    [self addAlertControllerWithTitle:nil message:@"请重新输入验证码"];
                }
            }
        }];
    }
    
}

- (void)insertOne {
    User *user = [[User alloc] init];
    user.phoneNumber = self.phoneNumber.text;
    user.name = self.userName.text;
    user.password = self.password.text;
    
    BOOL result = [DatabaseHelper insertUser:user];
    NSLog(@"看插进去没有：%d", result);
}

- (void)cycleTimeOutAction:(id)sender {
    
    [_checkBtn setTitle:[NSString stringWithFormat:@"重新发送(%ld)", (long)_codeNumber] forState:UIControlStateNormal];
    _codeNumber = _codeNumber - 1;
    if (_codeNumber == -1) {
        
        [_codeNimer invalidate];
        [_checkBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _codeNumber = 60;
    }
    
}

//判断输入是否为空
- (BOOL)judgeStringIsNull:(NSString *)string {
    
    BOOL result = NO;
    if (string != nil && string.length > 0) {
        for (int i = 0; i < string.length; i++) {
            NSString *subStr = [string substringWithRange:NSMakeRange(i, 1)];
            if (![subStr isEqualToString:@" "] && ![subStr isEqualToString:@""]) {
                result = YES;
            }
        }
    }
    return result;
}

- (void)addAlertControllerWithTitle:(NSString *)title message:(NSString *)message{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [controller addAction:action];
    [self presentViewController:controller animated:true completion:nil];
    
}
@end
