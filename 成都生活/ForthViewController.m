//
//  ForthViewController.m
//  Homework7
//
//  Created by 刘晓微 on 15/8/12.
//  Copyright (c) 2015年 刘晓微. All rights reserved.
//

#import "ForthViewController.h"
#import "ViewController.h"
@interface ForthViewController ()<AVAudioPlayerDelegate>

@end

@implementation ForthViewController
{
    ViewController *vc;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"更多";
//    ForthViewController *
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//  
//    vc = segue.destinationViewController;
//    
//    [vc GetName:^(NSString *name, NSString *password) {
//        self.userName.text = name;
//    } getPassword:^(NSString *name, NSString *password) {
//        self.userPassword.text = password;
//    }];
//}

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

- (IBAction)switchChanged:(id)sender {
    if ([_mSwitch isOn] == YES) {
        
        _slider.enabled = YES;
        [_slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
        [self startMusic];
        
    }else {
        [self.player pause];
        
        _slider.enabled = NO;
    }
}

- (void)startMusic {
    
    NSString *fileName = [[NSBundle mainBundle] pathForResource:@"A Little Love" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:fileName];
    NSError *err = nil;
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&err];
    
    if (!_player) {
        NSLog(@"播放失败");
    }else {
        
        if ([_mSwitch isOn] == YES) {
            _player.numberOfLoops = -1;
            [_player prepareToPlay];
            [_player play];
        }else {
            [_player pause];
        }
    }
}

- (IBAction)sliderChanged:(id)sender {
    CGFloat value = _slider.value;
    self.player.volume = value;
}

//- (void)playAudio
@end
