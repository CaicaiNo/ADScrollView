//
//  ViewController.m
//  ADScrollView
//
//  Created by sheng on 16/2/23.
//  Copyright © 2016年 Simply. All rights reserved.
//

#import "ViewController.h"
#import "SubScrollViewAndPageView.h"
@interface ViewController ()<SubScrollViewAndPageViewDelegate>
{
    SubScrollViewAndPageView *_subScrollViewAndPageControl;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat adWidth=self.view.bounds.size.width-8;
    CGFloat adHeight=(self.view.bounds.size.height-148)/3;
    _subScrollViewAndPageControl=[[SubScrollViewAndPageView alloc]initWithFrame:CGRectMake(4, 50, adWidth, adHeight)];
    NSMutableArray *tempArray=[NSMutableArray array];
    for (NSInteger i=0; i<5; i++) {
        UIImageView *subImageView=[[UIImageView alloc]init];
        subImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"ad0%ld",i+1]];
        [tempArray addObject:subImageView];
    }
    _subScrollViewAndPageControl.delegate=self;
    _subScrollViewAndPageControl.allImageView = tempArray;
    [_subScrollViewAndPageControl shouldAutoPlay:YES];
    [self.view addSubview:_subScrollViewAndPageControl];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)clickPage:(SubScrollViewAndPageView *)view atIndex:(NSInteger)index
{
    NSLog(@"Clicked %ld",index+1);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
