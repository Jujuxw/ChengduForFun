//
//  TitleBaseViewController.h
//  成都生活
//
//  Created by 刘晓微 on 15/8/13.
//  Copyright (c) 2015年 刘晓微. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleBaseViewController : UIViewController
@property (strong,nonatomic)UILabel *titleLabel;
@property (strong,nonatomic)UIImageView *imageView;
@property (strong,nonatomic)UIButton *backButton;
@property (strong,nonatomic)UISwipeGestureRecognizer *recognizer;

@end
