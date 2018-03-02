//
//  WaterFlowLayout.m
//  TestWaterFlow
//
//  Created by 颜仁浩 on 2018/1/4.
//  Copyright © 2018年 颜仁浩. All rights reserved.
//

#import "WaterFlowLayout.h"

#define Main_Width      [UIScreen mainScreen].bounds.size.width
#define Main_Height     [UIScreen mainScreen].bounds.size.height

static NSInteger const columnCount = 3;
static CGFloat const column_space = 10;
static CGFloat const row_space = 10;
static UIEdgeInsets const default_edge = {10, 10, 10, 10};

@interface WaterFlowLayout()
@property(nonatomic, retain)NSMutableArray *attributes_arr;
@property(nonatomic, retain)NSMutableArray *maxYArr;

- (NSInteger)getColumnCount;

- (CGFloat)getColumnSpace;

- (CGFloat)getRowSpace;

- (UIEdgeInsets)getEdgeInsets;

@end

@implementation WaterFlowLayout

- (NSInteger)getColumnCount {
    if ([self.delegate respondsToSelector:@selector(waterFlowLayoutColumnCount:)]) {
        return [self.delegate waterFlowLayoutColumnCount:self];
    }
    return columnCount;
}


- (CGFloat)getColumnSpace {
    if ([self.delegate respondsToSelector:@selector(waterFlowLayoutColumnSpace:)]) {
        return [self.delegate waterFlowLayoutColumnSpace:self];
    }
    return column_space;
}


- (CGFloat)getRowSpace {
    if ([self.delegate respondsToSelector:@selector(waterFlowLayoutRowSpace:)]) {
        return [self.delegate waterFlowLayoutRowSpace:self];
    }
    return row_space;
}


- (UIEdgeInsets)getEdgeInsets {
    if ([self.delegate respondsToSelector:@selector(waterFlowLayoutEdgeInsets:)]) {
        return [self.delegate waterFlowLayoutEdgeInsets:self];
    }
    return default_edge;
}


- (NSMutableArray *)attributes_arr {
    if (!_attributes_arr) {
        _attributes_arr = [[NSMutableArray alloc] init];
    }
    return _attributes_arr;
}


- (NSMutableArray *)maxYArr {
    if (!_maxYArr) {
        _maxYArr = [[NSMutableArray alloc] init];
    }
    return _maxYArr;
}


- (void)prepareLayout {
    [super prepareLayout];
    
    [self.attributes_arr removeAllObjects];
    [self.maxYArr removeAllObjects];
    
    for (int i = 0; i < [self getColumnCount]; i++) {
        [self.maxYArr addObject:@([self getEdgeInsets].top)];
    }
    
    NSInteger item_count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < item_count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [self.attributes_arr addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributes_arr;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    UIEdgeInsets temp_edgeInsets = [self getEdgeInsets];
    CGFloat width = (CGRectGetWidth(self.collectionView.frame) - temp_edgeInsets.left - temp_edgeInsets.right - [self getColumnSpace] * ([self getColumnCount] - 1)) / [self getColumnCount];
    CGFloat height = [self.delegate waterFlowLayout:self heightForItemAtIndex:indexPath.item width:width];
    NSInteger __block min_column_count = 0;
    CGFloat __block min_height = [self.maxYArr[min_column_count] floatValue];
    [self.maxYArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat temp_height = [(NSNumber *)obj floatValue];
        if (min_height > temp_height) {
            min_height = temp_height;
            min_column_count = idx;
        }
    }];
    
    CGFloat origin_x = temp_edgeInsets.left + min_column_count * (width + [self getColumnSpace]);
    CGFloat origin_y = min_height;
    if (origin_y != temp_edgeInsets.top) {
        origin_y += [self getRowSpace];
    }
    [attributes setFrame:CGRectMake(origin_x, origin_y, width, height)];
    self.maxYArr[min_column_count] = @(CGRectGetMaxY(attributes.frame));
        
    return attributes;
}


- (CGSize)collectionViewContentSize {
    CGFloat __block max_height = [self.maxYArr[0] floatValue];
    [self.maxYArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat temp_height = [(NSNumber *)obj floatValue];
        if (temp_height > max_height) {
            max_height = temp_height;
        }
    }];
    return CGSizeMake(0, max_height + [self getEdgeInsets].bottom);
}

@end
