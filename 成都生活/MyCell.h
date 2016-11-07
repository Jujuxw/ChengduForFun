//
//  MyCell.h
//  成都生活
//
//  Created by 刘晓微 on 15/8/14.
//  Copyright (c) 2015年 刘晓微. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *pictureLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;

@end
