//
//  DetailTodatNewsCell.m
//  ΥυNews
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 C. All rights reserved.

// cell自定义高度

#import "DetailTodatNewsCell.h"

@implementation DetailTodatNewsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.label=[[UILabel alloc] initWithFrame:CGRectMake(5, 5, 365, 60)];
        //_label.backgroundColor=[UIColor cyanColor];
        // 设置多行
        _label.numberOfLines=0;
        [self addSubview:_label];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
