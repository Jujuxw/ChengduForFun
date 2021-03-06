//
//  MyCell.m
//  成都生活
//
//  Created by 刘晓微 on 15/8/14.
//  Copyright (c) 2015年 刘晓微. All rights reserved.
//

#import "MyCells.h"

@implementation MyCells

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.imageViewLabel.layer.shadowColor = [UIColor blackColor].CGColor;
    self.imageViewLabel.layer.shadowOffset = CGSizeMake(3, 3);
    self.imageViewLabel.layer.shadowOpacity = 0.5;
    self.imageViewLabel.layer.cornerRadius = 10;
    self.imageViewLabel.layer.masksToBounds = YES;
    
    self.detailLabel.font = JFont(15);
    self.detailLabel.textColor = [UIColor blackColor];
    self.detailLabel.textAlignment = NSTextAlignmentCenter;
    self.detailLabel.numberOfLines = 0;
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
