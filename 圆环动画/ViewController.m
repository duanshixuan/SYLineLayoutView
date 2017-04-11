//
//  ViewController.m
//  圆环动画
//
//  Created by 段世宜 on 2017/4/7.
//  Copyright © 2017年 段世宜. All rights reserved.
//

#import "ViewController.h"
#import "SYScrollAnimationView.h"
#import "SYLayout.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation ViewController
{
    int indexSelect;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    indexSelect = 1;
    // Do any additional setup after loading the view, typically from a nib.
    float width = [UIScreen mainScreen].bounds.size.width;
    float height = [UIScreen mainScreen].bounds.size.height;
    self.view .backgroundColor = [UIColor yellowColor];
    SYScrollAnimationView *animationView = [[SYScrollAnimationView alloc]initWithFrame:CGRectMake(0, height/2, width, height/2)];
    [self.view addSubview:animationView];
    animationView.backgroundColor = [UIColor yellowColor];
    
    SYLayout * layout = [[SYLayout alloc]init];
    UICollectionView * collect  = [[UICollectionView alloc]initWithFrame:CGRectMake(0, height/2-100, width, 200) collectionViewLayout:layout];
    collect.delegate=self;
    collect.dataSource=self;
    collect.backgroundColor = [UIColor clearColor];
    
    [collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    [self.view addSubview:collect];
    collect.contentOffset = CGPointMake(width/2*indexSelect, 0);

}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 50;
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
