//
//  SYLayout.m
//  圆环动画
//
//  Created by 段世宜 on 2017/4/7.
//  Copyright © 2017年 段世宜. All rights reserved.
//

#import "SYLayout.h"

@implementation SYLayout
{
    float width ;
    float height;
    //弧线半径
    float l;
    
}
- (instancetype)init{
    if (self = [super init]) {
        
        width = [UIScreen mainScreen].bounds.size.width;
        height = [UIScreen mainScreen].bounds.size.height;
        l= height/2;
        self.itemSize = CGSizeMake(100, 100);
        self.minimumLineSpacing = width/2-100;
        self.minimumInteritemSpacing = 10;
        //        self.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
    }
    return self;
}

/**
 *  collectionView的显示范围发生改变的时候，调用下面这个方法是否重新刷新
 *
 *  @param newBounds
 *
 *  @return 是否重新刷新
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
/**
 *  布局的初始化操作
 */
- (void)prepareLayout
{
    [super prepareLayout];
    //获取item的个数
    _itemCount = (int)[self.collectionView numberOfItemsInSection:0];
    // 设置为水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 设置内边距
    CGFloat insetGap = (self.collectionView.frame.size.width - self.itemSize.width) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, insetGap, 0, insetGap);
}

/**
 *  设置cell的显示大小
 *
 *  @param rect 范围
 *
 *  @return 返回所有元素的布局
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // 获取计算好的布局属性
    NSArray *arr = [[NSArray alloc]initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    for (int i = 0; i < arr.count; i ++) {
        UICollectionViewLayoutAttributes *att = arr[i];
        //算比例
        //拿到每个item的位置  算出itemCenterX  和collectionCenterX 的一个距离
        CGFloat distance = ABS(att.center.x - self.collectionView.frame.size.width * 0.5 - self.collectionView.contentOffset.x);
        CGFloat distanceX=att.center.x - self.collectionView.contentOffset.x;
        
        CGFloat scale = 0.5;
        CGFloat w = (self.collectionView.frame.size.width + self.itemSize.width) * 0.5;
        // 每一个item的中点x
        CGPoint center = att.center;
        
        if (distance >= w) {
            scale = 0.5;
        }else{
            scale = scale +  (1- distance / w ) * 0.5;
        }
        if (distanceX>self.collectionView.bounds.size.width/2+l||distanceX<self.collectionView.bounds.size.width/2-l ) {
            
        }else{
            center.y =  -sqrt( l*l-(distanceX-self.collectionView.bounds.size.width/2)*(distanceX-self.collectionView.bounds.size.width/2))+self.collectionView.bounds.size.height/2+l;
        }
        att.center = center;
        //        att.transform = CGAffineTransformMakeScale(scale, scale);
        
        att.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(((att.center.x - self.collectionView.frame.size.width * 0.5 - self.collectionView.contentOffset.x)/w)*M_PI_4), scale, scale);
        
        
    }
    return arr;
}
//滑动完成后，会来到此方法 - 线性滑动
//proposedContentOffset  最后停止的 contentOffset
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //proposedContentOffset 滑动之后最后停的位置
    CGRect  rect;
    rect.origin = proposedContentOffset;
    rect.size = self.collectionView.frame.size;
    //获取停止时，显示的cell的frame
    //NSArray *tempArray  = [super  layoutAttributesForElementsInRect:rect];
    NSArray *tempArray = [[NSArray alloc]initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    CGFloat  gap = 1000;
    CGFloat  a = 0;
    for (int i = 0; i < tempArray.count; i++) {
        //判断和中心的距离，得到最小的那个
        if (gap > ABS([tempArray[i] center].x - proposedContentOffset.x - self.collectionView.frame.size.width * 0.5)) {
            gap =  ABS([tempArray[i] center].x - proposedContentOffset.x - self.collectionView.frame.size.width * 0.5);
            a = [tempArray[i] center].x - proposedContentOffset.x - self.collectionView.frame.size.width * 0.5;
        }
    }
    CGPoint  point  =CGPointMake(proposedContentOffset.x + a , proposedContentOffset.y);
    return point;
}

@end
