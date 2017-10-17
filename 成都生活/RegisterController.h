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

@property (nonatomic, strong) UITextField *userNameField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) UITextField *phoneNumberField;
@property (nonatomic, strong) UITextField *checkNumberField;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *passwordLabel;
@property (nonatomic, strong) UILabel *phoneLabel;

@property (nonatomic, strong) UIButton *checkBtn;
@property (nonatomic, strong) UIButton *registerBtn;

@property (nonatomic, strong) NSTimer *codeTimer;
@property (nonatomic, assign) NSInteger codeNumber;

@property (nonatomic, strong) NSMutableArray *userArray;
@end
