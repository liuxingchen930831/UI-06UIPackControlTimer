//
//  XCView.m
//  UIPageControlPack
//
//  Created by liuxingchen on 16/9/7.
//  Copyright © 2016年 Liuxingchen. All rights reserved.
//

#import "XCView.h"

@interface XCView ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property(nonatomic,strong)NSTimer * timer;
@end

@implementation XCView
+(instancetype)LoadXib
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

-(void)setImageNames:(NSArray *)imageNames
{
    _imageNames = imageNames;
    for (int i = 0 ; i<imageNames.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:imageNames[i]];
        [self.scrollView addSubview:imageView];
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat scrollW = self.scrollView.frame.size.width;
    CGFloat scrollH = self.scrollView.frame.size.height;
    self.scrollView.contentSize = CGSizeMake(self.imageNames.count * scrollW, 0);
    
    for (int i = 0; i< self.imageNames.count; i++) {
        UIImageView *image  = self.scrollView.subviews[i];
        image.frame = CGRectMake(i *scrollW, 0, scrollW, scrollH);
    }
    self.pageControl.numberOfPages = self.imageNames.count;
}
-(void)awakeFromNib
{
    [self startTimer];
}
#pragma mark <UIScrollViewDelegate>
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (int)(scrollView.contentOffset.x / scrollView.frame.size.width +0.5);
    self.pageControl.currentPage = page;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}
#pragma mark Timer
-(void)startTimer
{
    //设置定时器
   self.timer =  [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    /**
     定时器如果和其他控件一起操作，主线程会暂时执行其他控件，所以需要并行执行
     下面这行代码就是让多个控件一起联动
     */
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}
-(void)stopTimer
{
    //停止定时器
    [self.timer invalidate];
    self.timer = nil;
}
-(void)nextPage
{
    NSUInteger page = self.pageControl.currentPage +1;
    if (page == self.pageControl.numberOfPages) {
        page = 0;
    }
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = page * self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:offset animated:YES];
    NSLog(@"---");
}
@end
