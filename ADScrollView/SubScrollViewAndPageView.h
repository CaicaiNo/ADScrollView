//
//  SubScrollViewAndPageView.h
//  day12_TMusic_exercise
//
//  Created by sheng on 15/11/25.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SubScrollViewAndPageView;

@protocol SubScrollViewAndPageViewDelegate

@required

-(void)clickPage:(SubScrollViewAndPageView*)view atIndex:(NSInteger)index;

@optional

@end

@interface SubScrollViewAndPageView : UIView <UIScrollViewDelegate>

@property (nonatomic,strong) NSTimer *subTimer;

@property (nonatomic,strong) NSMutableArray *allImageView;

@property (nonatomic,strong) id<SubScrollViewAndPageViewDelegate> delegate;

@property (nonatomic,strong,readonly) UIScrollView *subScrollView;

@property (nonatomic,strong,readonly) UIPageControl *subPageControl;

@property (nonatomic,assign) BOOL autoPlay;

-(void)shouldAutoPlay:(BOOL)isPlay;


@end
