//
//  TitleBaseViewController.m
//  成都生活
//
//  Created by 刘晓微 on 15/8/13.
//  Copyright (c) 2015年 刘晓微. All rights reserved.
//

#import "TitleBaseViewController.h"
#import "SecondViewController.h"

@interface TitleBaseViewController ()

@end

@implementation TitleBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //导航
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 375, 75)];
    self.view.userInteractionEnabled= YES;
    _imageView.backgroundColor = JButtonColor;
    [self.view addSubview:_imageView];
    //控件属性初始化
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 375, 60)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = @"详情";
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = JMediumFont(22.0f);
    [self.view addSubview:_titleLabel];
    //轻扫手势，翻页
    // handleSwipeFrom 是偵測到手势，所要呼叫的方法
    _recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom)];
    [_recognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:_recognizer];
    
}

-(void)handleSwipeFrom {
    if (self.recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        self.tabBarController.selectedIndex += 1;
    } else if (self.recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        self.tabBarController.selectedIndex -= 1;
    }
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
