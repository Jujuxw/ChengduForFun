//
//  SecondViewController.m
//  成都生活
//
//  Created by 刘晓微 on 15/8/13.
//  Copyright (c) 2015年 刘晓微. All rights reserved.
//

#import "SecondViewController.h"
#import "SecondViewController1.h"
#import "SecondViewController2.h"
#import "SecondViewController3.h"
#import "SecondViewController4.h"
#import "SecondViewController5.h"

@interface SecondViewController ()

@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *TagLabel;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = NO;
    self.titleLabel.text = @"专线航程";
    _array = [NSMutableArray array];
    _TagLabel = [[UILabel alloc]init];
    for(int i=0;i<5;i++) {
        _button = [[UIButton alloc]initWithFrame:CGRectMake(15 + 120*(i%3), 90+110*(i/3), 100, 100)];
        [_button setImage:[UIImage imageNamed:[NSString stringWithFormat:(@"icon%d.png"),i+1]] forState:UIControlStateNormal];
        [_array addObject:_button];
        _button.tag = i+1;
        [self.view addSubview:_button];
        [_button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
        
    }
//    for (int i=0; i < 5; i++) {
//        [_array[i] addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDragInside];
//    }
    // Do any additional setup after loading the view.
}

- (void)click:(UIButton *)button {
    if (button.tag == 1) {
        SecondViewController1 *svc1 = [[SecondViewController1 alloc]init];
        [self presentViewController:svc1 animated:YES completion:nil];
        self.tabBarController.tabBar.hidden = NO;
    } else if (button.tag == 2) {
        SecondViewController2 *svc2 = [[SecondViewController2 alloc]init];
        [self presentViewController:svc2 animated:YES completion:nil];
    } else if (button.tag == 3) {
        SecondViewController3 *svc3 = [[SecondViewController3 alloc]init];
        [self presentViewController:svc3 animated:YES completion:nil];
    } else if (button.tag == 4)  {
        SecondViewController4 *svc4 = [[SecondViewController4 alloc]init];
        [self presentViewController:svc4 animated:YES completion:nil];
    } else if (button.tag == 5) {
        SecondViewController5 *svc5 = [[SecondViewController5 alloc]init];
        [self presentViewController:svc5 animated:YES completion:nil];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        for (int j=0; j<5; j++) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:1];
            [UIView setAnimationDelay:j];
            [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(viewAppear) userInfo:nil repeats:YES];
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.array[j] cache:NO];
            [UIView commitAnimations];
        }
    });
}

- (void)viewAppear {
    for (int j=0; j<5; j++) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        [UIView setAnimationDelay:j];
        [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(viewDidAppear:) userInfo:nil repeats:NO];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.array[j] cache:YES];
        [UIView commitAnimations];
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
