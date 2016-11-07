//
//  ViewController.h
//  成都生活
//
//  Created by 刘晓微 on 15/8/13.
//  Copyright (c) 2015年 刘晓微. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void (^GetTextBlock)(NSString *name, NSString *password);

@interface ViewController : UIViewController<UITextFieldDelegate>

//@property (nonatomic, copy) GetTextBlock getNameBlock;
//@property (nonatomic, copy) GetTextBlock getPasswordBlock;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *password;

//- (void)GetName: (GetTextBlock)block1 getPassword:(GetTextBlock)block2;

@end

