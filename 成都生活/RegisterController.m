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

@interface RegisterController () <UITextFieldDelegate>

@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userArray = [NSMutableArray array];
    self.userArray = [DatabaseHelper getAllUsers];
    
    self.codeNumber = 60;
    [SMSSDK registerApp:@"1c053d80b4260" withSecret:@"3793b53c0d787ee538764bd6818b7a0"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupNavBar {
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"注册";
}

- (void)setupUI {
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.backgroundColor = JButtonColor;
    self.nameLabel.text = @"用户名";
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(JDefaultMargin);
        make.top.mas_equalTo(100);
        make.size.mas_equalTo(CGSizeMake(100, JDefaultSize));
    }];
    
    self.userNameField = [[UITextField alloc] init];
    self.userNameField.placeholder = @"请输入用户名";
    self.userNameField.borderStyle = UITextBorderStyleRoundedRect;
    self.userNameField.keyboardType = UIKeyboardTypeDefault;//键盘类型
    self.userNameField.returnKeyType = UIReturnKeyDone;//返回键是done
    self.userNameField.clearButtonMode = UITextFieldViewModeWhileEditing;//编辑时出现删除键
    self.userNameField.clearsOnBeginEditing = YES;//开始编辑时清空
    self.userNameField.delegate = self;//让下一级别的对象知道上一层／／将键盘的回调事件交给self
    self.userNameField.tag = 100;
    [self.view addSubview:self.userNameField];
    [self.userNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(10);
        make.right.mas_equalTo(-JDefaultMargin);
        make.top.equalTo(self.nameLabel.mas_top);
        make.height.mas_equalTo(JDefaultSize);
    }];
    
    self.passwordLabel = [[UILabel alloc] init];
    self.passwordLabel.backgroundColor = JButtonColor;
    self.passwordLabel.text = @"密码";
    self.passwordLabel.textAlignment = NSTextAlignmentCenter;
    self.passwordLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.passwordLabel];
    [self.passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(JDefaultMargin);
        make.top.equalTo(self.nameLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(100, JDefaultSize));
    }];
    
    self.passwordField = [[UITextField alloc] init];
    self.passwordField.placeholder = @"请输入密码";
    self.passwordField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordField.tag = 200;
    self.passwordField.secureTextEntry = YES;
    [self.view addSubview:self.passwordField];
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passwordLabel.mas_right).offset(10);
        make.right.mas_equalTo(-JDefaultMargin);
        make.top.equalTo(self.passwordLabel.mas_top);
        make.height.mas_equalTo(JDefaultSize);
    }];
    
    self.phoneLabel = [[UILabel alloc] init];
    self.phoneLabel.text = @"电话号码";
    self.phoneLabel.backgroundColor = JButtonColor;
    self.phoneLabel.textAlignment = NSTextAlignmentCenter;
    self.phoneLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.phoneLabel];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(JDefaultMargin);
        make.top.equalTo(self.passwordLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(100, JDefaultSize));
    }];
    
    self.phoneNumberField = [[UITextField alloc] init];
    self.phoneNumberField.placeholder = @"请输入电话号码";
    self.phoneNumberField.borderStyle = UITextBorderStyleRoundedRect;
    self.phoneNumberField.tag = 300;
    [self.view addSubview:self.phoneNumberField];
    [self.phoneNumberField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneLabel.mas_right).offset(10);
        make.right.mas_equalTo(-JDefaultMargin);
        make.top.equalTo(self.phoneLabel.mas_top);
        make.height.mas_equalTo(JDefaultSize);
    }];
    
    self.checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.checkBtn.backgroundColor = JButtonColor;
    self.checkBtn.layer.cornerRadius = JDefaultRadius;
    [self.checkBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.checkBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.checkBtn addTarget:self action:@selector(getVerificationCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.checkBtn];
    [self.checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(JDefaultMargin);
        make.top.equalTo(self.phoneLabel.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(100, JDefaultSize));
    }];
    
    self.checkNumberField = [[UITextField alloc] init];
    self.checkNumberField.placeholder = @"验证码";
    self.checkNumberField.borderStyle = UITextBorderStyleRoundedRect;
    self.checkNumberField.tag = 400;
    [self.view addSubview:self.checkNumberField];
    [self.checkNumberField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.checkBtn.mas_right).offset(10);
        make.right.mas_equalTo(-JDefaultMargin);
        make.top.equalTo(self.checkBtn.mas_top);
        make.height.mas_equalTo(JDefaultSize);
    }];
    
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerBtn.backgroundColor = JButtonColor;
    self.registerBtn.layer.cornerRadius = JDefaultRadius;
    [self.registerBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.registerBtn addTarget:self action:@selector(nextTapAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registerBtn];
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(JDefaultMargin);
        make.right.mas_equalTo(-JDefaultMargin);
        make.height.mas_equalTo(JDefaultSize);
        make.bottom.mas_equalTo(-JMediumMargin);
    }];
}

- (void)getVerificationCodeAction:(id)sender {
    
    BOOL result = YES;
    [self checkAllField:result];
    
    User *user = [[User alloc] init];
    for (int i = 0; i < [self.userArray count]; i++) {
        user = [self.userArray objectAtIndex:i];
        if (self.phoneNumberField.text == user.phoneNumber) {
            [self showAlertWithTitle:nil message:@"号码已注册"];
        }
    }
    if (self.codeNumber == 60 && result) {
        [self cycleTimeOutAction:nil];
        self.codeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(cycleTimeOutAction:) userInfo:nil repeats:YES];
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneNumberField.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
            if (!error) {
                NSLog(@"获取验证码成功");
            } else {
                NSLog(@"获取验证码失败");
                [self showAlertWithTitle:nil message:@"验证失败"];
                [self.codeTimer invalidate];
                [self.checkBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                self.codeNumber = 60;
            }
        }];
    }
}

- (void)checkAllField:(BOOL)result {
    
    if ([self judgeStringIsNull:self.phoneNumberField.text] && [self judgeStringIsNull:self.userNameField.text] && [self judgeStringIsNull:self.passwordField.text]) {
        
    }else if(![self judgeStringIsNull:self.userNameField.text]) {
        result = NO;
        [self showAlertWithTitle:nil message:@"请输入用户名"];
    }else if (![self judgeStringIsNull:self.passwordField.text]) {
        result = NO;
        [self showAlertWithTitle:nil message:@"请输入密码"];
    }else {
        result = NO;
        [self showAlertWithTitle:nil message:@"请输入验证码"];
    }
}

- (void)nextTapAction:(id)sender {
    [self.view endEditing:YES];
    BOOL result = YES;
    BOOL resultcode = YES;
    [self checkAllField:result];
    [self dismissViewControllerAnimated:YES completion:nil];
    if (result && resultcode) {
        [SMSSDK commitVerificationCode:self.checkNumberField.text phoneNumber:self.phoneNumberField.text zone:@"86" result:^(SMSSDKUserInfo *userInfo, NSError *error) {
            if (!error) {
                [self insertOne];
                [self.navigationController popViewControllerAnimated:YES];
                NSLog(@"验证成功");
                [self showAlertWithTitle:nil message:@"验证成功!"];
            }else {
                NSLog(@"验证失败");
                if ([self judgeStringIsNull:self.checkNumberField.text]) {
                    [self showAlertWithTitle:nil message:@"验证码错误"];
                }else {
                    [self showAlertWithTitle:nil message:@"请重新输入验证码"];
                }
            }
        }];
    }
    
}

- (void)insertOne {
    User *user = [[User alloc] init];
    user.phoneNumber = self.phoneNumberField.text;
    user.name = self.userNameField.text;
    user.password = self.passwordField.text;
    
    BOOL result = [DatabaseHelper insertUser:user];
    NSLog(@"看插进去没有：%d", result);
}

- (void)cycleTimeOutAction:(id)sender {
    [self.checkBtn setTitle:[NSString stringWithFormat:@"重新发送(%ld)", (long)_codeNumber] forState:UIControlStateNormal];
    self.codeNumber -= 1;
    if (_codeNumber == -1) {
        [self.codeTimer invalidate];
        [self.checkBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.codeNumber = 60;
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

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [controller addAction:action];
    [self presentViewController:controller animated:true completion:nil];
    
}
@end
