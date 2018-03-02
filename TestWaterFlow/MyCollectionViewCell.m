//
//  MyCollectionViewCell.m
//  TestWaterFlow
//
//  Created by 颜仁浩 on 2018/3/1.
//  Copyright © 2018年 颜仁浩. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createCell];
    }
    return self;
}


- (void)createCell {
    self.myImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.myImageView];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.myImageView.frame = self.contentView.frame;
}


- (void)setMyImage:(UIImage *)myImage {
    _myImage = myImage;
    self.myImageView.image = myImage;
}

@end
