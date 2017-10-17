//
//  ThirdViewController1.m
//  成都生活
//
//  Created by 刘晓微 on 15/8/15.
//  Copyright (c) 2015年 刘晓微. All rights reserved.
//

#import "ThirdViewController1.h"

@interface ThirdViewController1 ()

@end

@implementation ThirdViewController1

//-(instancetype)init{
//    self = [super init];
//    if (self) {
//        <#statements#>
//    }
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.backButton];
    self.backButton.hidden = NO;
    
    _nextbackLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 75, 375, 305)];
    self.nextbackLabel.backgroundColor = [UIColor blackColor];
    _nextTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 310 , 350,678-310)];
    _nextTextLabel.numberOfLines = 0;
    _nextTextLabel.font = [UIFont systemFontOfSize:15];
    _nextView = [[UIImageView alloc]initWithFrame:CGRectMake(75, 75, 225, 305)];
    [self.view addSubview:self.nextbackLabel];
    [self.view addSubview:self.nextView];
    [self.view addSubview:self.nextTextLabel];
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
