//
//  LJFAdertisementView.m
//  广告栏
//
//  Created by mini on 15/11/9.
//  Copyright © 2015年 mini. All rights reserved.
//

#import "LJFAdertisementView.h"
#import "UIImageView+WebCache.h"

@implementation LJFAdertisementView
{
    NSInteger _timeInterval;
    NSTimer *_timer;
    NSArray *_imagesArray;//图片数组
    NSArray *_linksArray;//与图片相关联的数据
    BOOL _isDownload;
    CGFloat _scroll_with; //宽
    CGFloat _scroll_height;//高
}

- (UIView *)initWithFrame:(CGRect)frame andImagesArray:(NSArray *)imagesArray isUrl:(BOOL)isUrl linkStrs:(NSArray *)linkStrs delegate:(id)delegate TimeInterval:(CGFloat)timeInterval
{
    self = [[LJFAdertisementView alloc]initWithFrame:frame];
        
    _timeInterval = timeInterval;
    
    _scroll_height = frame.size.height;
    
    _scroll_with = frame.size.width;
    
    _imagesArray = imagesArray;
    
    _isDownload = isUrl;
    
    self.delegate = delegate;
    
    [self creatTimer];
    
    [self initData];
    
    return self;
}

#pragma mark - 初始化scrollView

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _scroll_with, _scroll_height)];
        NSInteger count = _imagesArray.count;
        if (_imagesArray.count >1) {
            count += 2;
        }
        _scrollView.contentSize = CGSizeMake(count * _scroll_with, _scroll_height);
        _scrollView.showsHorizontalScrollIndicator = NO;//水平
        _scrollView.showsVerticalScrollIndicator = NO;//垂直
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(photoImageBeClicked:)];
        [_scrollView addGestureRecognizer:tap];
    }
    return _scrollView;
}

- (LJFPageControl *)pageControl
{
    if (_pageControl == nil) {
        _pageControl = [[LJFPageControl alloc]initWithFrame:CGRectMake(0, _scroll_height - 20, self.frame.size.width, 20)];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.numberOfPages = _imagesArray.count;
    }
    return _pageControl;
}

#pragma mark - 初始化数据

- (void)initData
{
    NSMutableArray *dataArray = [NSMutableArray arrayWithArray:_imagesArray];
    
    if (_imagesArray.count > 1) {
        [dataArray addObject:_imagesArray[0]];
        [dataArray insertObject:_imagesArray.lastObject atIndex:0];
        self.scrollView.contentOffset = CGPointMake(_scroll_with, 0);
    }else{
        self.scrollView.scrollEnabled = NO;
        [_timer invalidate];
    }
    
    for (int i = 0; i <dataArray.count ; i ++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*_scroll_with, 0, _scroll_with, _scroll_height)];
        imageView.userInteractionEnabled = YES;
        if (_isDownload) {
            [imageView sd_setImageWithURL:dataArray[i] placeholderImage:nil];
        }else{
            imageView.image = [UIImage imageNamed:dataArray[i]];
        }
        [self.scrollView addSubview:imageView];
    }
    
    [self addSubview:self.scrollView];
    
    [self addSubview:self.pageControl];
}

#pragma mark - 创建定时器

- (void)creatTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
}

#pragma mark - 定时器更新

- (void)updateTime
{
    NSInteger currentPage = self.pageControl.currentPage;
    currentPage ++;
    [self.scrollView setContentOffset:CGPointMake(_scroll_with * (currentPage + 1), 0) animated:YES];
    if (currentPage == _imagesArray.count) {
        [self.scrollView setContentOffset:CGPointMake(_scroll_with, 0) animated:NO];
        currentPage = 0;
    }
    self.pageControl.currentPage = currentPage;
}

#pragma mark - 视图被点击

- (void)photoImageBeClicked:(UITapGestureRecognizer *)tap
{
    [self.delegate LJFAdertisementViewBeSelected:_pageControl.currentPage with:_linksArray!=nil? _linksArray[_pageControl.currentPage]:nil];
}

#pragma mark - 滚动视图的代理方法

//将要拖拽

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
    _timer = nil;
}

//停止滑动

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x == _scroll_with * (_imagesArray.count + 1)) {
        [self.scrollView setContentOffset:CGPointMake(_scroll_with, 0) animated:NO];
    }else if (scrollView.contentOffset.x == 0){
        [self.scrollView setContentOffset:CGPointMake(_scroll_with * _imagesArray.count, 0) animated:NO];
    }
}

//结束拖拽

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self creatTimer];
}

//正在滑动

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/_scroll_with - 1;
    if (index >= _imagesArray.count) {
        index = 0;
    }
    self.pageControl.currentPage = index;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
