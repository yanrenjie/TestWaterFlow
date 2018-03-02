//
//  WaterFlowLayout.h
//  TestWaterFlow
//
//  Created by 颜仁浩 on 2018/1/4.
//  Copyright © 2018年 颜仁浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterFlowLayout;

@protocol WaterFlowLayoutDelegate<NSObject>

@required

- (CGFloat)waterFlowLayout:(WaterFlowLayout *)waterFlowLayout heightForItemAtIndex:(NSInteger)index width:(CGFloat)width;

@optional

- (NSInteger)waterFlowLayoutColumnCount:(WaterFlowLayout *)waterFlowLayout;

- (CGFloat)waterFlowLayoutColumnSpace:(WaterFlowLayout *)waterFlowLayout;

- (CGFloat)waterFlowLayoutRowSpace:(WaterFlowLayout *)waterFlowLayout;

- (UIEdgeInsets)waterFlowLayoutEdgeInsets:(WaterFlowLayout *)waterFlowLayout;

@end

@interface WaterFlowLayout : UICollectionViewLayout

@property(nonatomic, assign)id<WaterFlowLayoutDelegate>delegate;

@end
