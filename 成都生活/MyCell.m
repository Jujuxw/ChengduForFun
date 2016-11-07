//
//  MyCell.m
//  成都生活
//
//  Created by 刘晓微 on 15/8/14.
//  Copyright (c) 2015年 刘晓微. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

- (void)awakeFromNib {
    // Initialization code
    //添加图片和文本的适应处理
    self.adressLabel.numberOfLines = 0;
    self.pictureLabel.layer.shadowColor = [UIColor blackColor].CGColor;//设置阴影颜色
    self.pictureLabel.layer.shadowOffset = CGSizeMake(3, 3);
    self.pictureLabel.layer.shadowOpacity = 0.5;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
