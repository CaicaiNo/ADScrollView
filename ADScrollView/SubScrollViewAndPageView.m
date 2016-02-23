//
//  SubScrollViewAndPageView.m
//  day12_TMusic_exercise
//
//  Created by sheng on 15/11/25.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "SubScrollViewAndPageView.h"

@interface SubScrollViewAndPageView ()
{
    
    UIView *_firstView;
    UIView *_middleView;
    UIView *_lastView;
    
    CGFloat _width;
    CGFloat _height;
    
    NSInteger _currentPage;
    UITapGestureRecognizer *_tap;
   
    
}
@end

@implementation SubScrollViewAndPageView
-(void)setAllImageView:(NSMutableArray *)allImageView
{
    if (allImageView) {
        _allImageView=allImageView;
        _currentPage = 0;
        _subPageControl.numberOfPages = allImageView.count;
    }
    [self reloadData];
}
#pragma  Source and Model
-(instancetype)initWithFrame:(CGRect)frame 
{
    if (self=[super initWithFrame:frame]) {
//width height
        _width=self.bounds.size.width;
        _height=self.bounds.size.height;
//subScrollView
        _subScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _width,_height)];
        _subScrollView.contentSize = CGSizeMake(_width*3, _height);
        _subScrollView.delegate = self;
        _subScrollView.pagingEnabled=YES;
        _subScrollView.showsHorizontalScrollIndicator=NO;
        _subScrollView.userInteractionEnabled=YES;
        [self addSubview:_subScrollView];
//subPageControl
        _subPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,_height-15, _width, 15)];
        _subPageControl.userInteractionEnabled=YES;
        _subPageControl.currentPage = 0;
        _subPageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _subPageControl.pageIndicatorTintColor = [UIColor whiteColor];
//        _subPageControl.backgroundColor = [UIColor redColor];
        [self addSubview:_subPageControl];
//tap
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        _tap.numberOfTapsRequired = 1;
        _tap.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:_tap];
        
    }
    return self;
}


//
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    [_subTimer invalidate];
    _subTimer = nil;
    _subTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(playPage) userInfo:nil repeats:YES];
   
    CGFloat x = _subScrollView.contentOffset.x;
    if (x <= 0){
        if (_currentPage == 0) {
            _currentPage = self.allImageView.count - 1;
        }else{
            _currentPage--;
        }
    }else if(x >= _width*2){
        if (_currentPage == self.allImageView.count - 1) {
            _currentPage = 0;
        }else{
             _currentPage++;
        }
    }
    [self reloadData];
}
-(void)reloadData
{
    [_firstView removeFromSuperview];
    [_middleView removeFromSuperview];
    [_lastView removeFromSuperview];
    if (_currentPage == self.allImageView.count - 1) {
        _firstView = [self.allImageView objectAtIndex:_currentPage - 1];
        _middleView = [self.allImageView objectAtIndex:_currentPage];
        _lastView = [self.allImageView objectAtIndex:0];
    }else if(_currentPage == 0 ){
        _firstView = [self.allImageView lastObject];
        _middleView = [self.allImageView objectAtIndex:_currentPage];
        _lastView = [self.allImageView objectAtIndex:_currentPage + 1];
        
    }else{
        _firstView = [self.allImageView objectAtIndex:_currentPage - 1] ;
        _middleView = [self.allImageView objectAtIndex:_currentPage];
        _lastView = [self.allImageView objectAtIndex:_currentPage + 1];
      
    }
    _firstView.frame = CGRectMake(0, 0, _width, _height);
    _middleView.frame = CGRectMake(_width, 0, _width, _height);
    _lastView.frame = CGRectMake(_width*2, 0, _width, _height);

    [_subScrollView addSubview:_firstView];
    [_subScrollView addSubview:_middleView];
    [_subScrollView addSubview:_lastView];
    _subPageControl.currentPage=_currentPage;
    [_subScrollView setContentOffset:CGPointMake(_width, 0)];
   
}



-(void)shouldAutoPlay:(BOOL)isPlay
{
    if (isPlay) {
        if (!_subTimer) {
             _subTimer=[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(playPage) userInfo:nil repeats:YES];
        }
        self.autoPlay = YES;
    }else
    {
        if (_subTimer.isValid) {
            [_subTimer invalidate];
            _subTimer = nil;
        }
        
    }
   
}
-(void)playPage
{
   
    if(_currentPage == self.allImageView.count - 1){
        _currentPage=0;
    }else{
        _currentPage ++;
    }
    [_subScrollView setContentOffset:CGPointMake(_width*2, 0) animated:YES];
    //为了防止timer在同一时间执行换页（需要时间）和刷新的同时，由于换页时间过长，跳过刷新，而倒致问题，我们将刷新置为换页后0.3秒执行，确保2个动作连贯进行；这是timer的误差所导致的，NSTimer不是绝对准确的,而且中间耗时或阻塞错过下一个点,那么下一个点就pass过去了.NSTimer可以精确到50-100毫秒.
     [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(toNextPage) userInfo:nil repeats:NO];
  
}
-(void)handleTap:(id)sender
{
    [self.delegate clickPage:self atIndex:_currentPage];
}

-(void)toNextPage{
   
    [self reloadData];
    NSLog(@"%ld",_currentPage+1);
}
@end






