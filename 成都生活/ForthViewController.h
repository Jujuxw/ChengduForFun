//
//  ForthViewController.h
//  Homework7
//
//  Created by 刘晓微 on 15/8/12.
//  Copyright (c) 2015年 刘晓微. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleBaseViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ForthViewController : TitleBaseViewController

//@property (strong, nonatomic) IBOutlet UILabel *userName;
//@property (strong, nonatomic) IBOutlet UILabel *userPassword;

@property (strong, nonatomic) IBOutlet UISwitch *mSwitch;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property(strong,nonatomic) AVAudioPlayer *player;

- (IBAction)switchChanged:(id)sender;
- (IBAction)sliderChanged:(id)sender;
- (void)startMusic;

@end
