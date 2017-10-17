//
//  TitleBaseViewController.m
//  成都生活
//
//  Created by 刘晓微 on 15/8/13.
//  Copyright (c) 2015年 刘晓微. All rights reserved.
//

#import "TitleBaseViewController.h"
#import "SecondViewController.h"
#define KBackgroundColor [UIColor colorWithRed:154/255.0 green:37/255.0 blue:21/255.0 alpha:1]
@interface TitleBaseViewController ()

@end

@implementation TitleBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //导航
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 375, 75)];
    self.view.userInteractionEnabled= YES;
    _imageView.backgroundColor = KBackgroundColor;
    [self.view addSubview:_imageView];
    //控件属性初始化
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, 375, 60)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = @"详情";
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:22];
    [self.view addSubview:_titleLabel];
    //返回控件
    _backButton = [[UIButton alloc ]initWithFrame:CGRectMake(5, 50, 30, 20)];
    [_backButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [self.view addSubview:_backButton];
    [_backButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchDown];
    _backButton.hidden = YES;
    //轻扫手势，翻页
    // handleSwipeFrom 是偵測到手势，所要呼叫的方法
    _recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom)];
    [_recognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:_recognizer];
    
}

-(void)handleSwipeFrom
{
    if (self.recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        self.tabBarController.selectedIndex = self.tabBarController.selectedIndex+1;
    }
}
-(void)click
{
    [self dismissViewControllerAnimated:YES completion:nil];
//    if (button.tag ==1) {
//        [self.navigationController pushViewController:<#(UIViewController *)#> animated:YES];
//    }else if (button.tag == 2){
//        [self.navigationController pushViewController:<#(UIViewController *)#> animated:YES];
//    }else if (button.tag ==3){
//        [self.navigationController pushViewController:(UIViewController *) animated:YES];
//    }else if (button.tag == 4){
//        [self.navigationController pushViewController:<#(UIViewController *)#> animated:YES];
//    }else if (button.tag ==5){
//        [self.navigationController pushViewController:<#(UIViewController *)#> animated:YES];
//    }
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
