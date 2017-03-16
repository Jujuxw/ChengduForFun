//
//  RegisterController.h
//  成都生活
//
//  Created by juju on 2017/3/13.
//  Copyright © 2017年 刘晓微. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseHelper.h"
#import "User.h"

@interface RegisterController : UIViewController

@property (strong, nonatomic) UITextField *userName;
@property (strong, nonatomic) UITextField *password;
@property (strong, nonatomic) UITextField *phoneNumber;
@property (strong, nonatomic) UITextField *checkNumber;

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *passwordLabel;
@property (strong, nonatomic) UILabel *phoneLabel;

@property (strong, nonatomic) UIButton *checkBtn;
@property (strong, nonatomic) UIButton *RegisterBtn;
@property (strong, nonatomic) UIButton *backBtn;

@property (strong, nonatomic) NSTimer *codeNimer;
@property (assign, nonatomic) NSInteger codeNumber;

@property (strong, nonatomic) NSMutableArray *userArray;
@end
