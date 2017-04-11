//
//  SYScrollAnimationView.m
//  圆环动画
//
//  Created by 段世宜 on 2017/4/7.
//  Copyright © 2017年 段世宜. All rights reserved.
//

#import "SYScrollAnimationView.h"
#import "SYLayout.h"

@interface SYScrollAnimationView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation SYScrollAnimationView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    float width = [UIScreen mainScreen].bounds.size.width;
    float height = [UIScreen mainScreen].bounds.size.height;
    // Drawing code
//    CGContextRef con = UIGraphicsGetCurrentContext();
//    CGContextAddEllipseInRect(con, CGRectMake(width/2-height/2,0,height,height));
//    CGContextSetFillColorWithColor(con, [UIColor blackColor].CGColor);
//    CGContextFillPath(con);
    // 获取绘图上下文
     CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect myRect=CGRectMake(width/2-height/2,0,height,height);
         CGContextAddEllipseInRect(context, myRect);
         //设置属性
         [[UIColor blueColor] set];
//         CGColorRef color = [UIColor redColor].CGColor;
//         // offset:偏移量 blur:模糊度 color:阴影颜色
//        CGContextSetShadowWithColor(context, CGSizeMake(3, 3), 0.8, color);
         //绘制
        CGContextDrawPath(context, kCGPathFill);
    
}


@end
