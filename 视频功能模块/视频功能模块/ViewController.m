//
//  ViewController.m
//  视频功能模块
//
//  Created by mini on 15/9/9.
//  Copyright (c) 2015年 mini. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>

#import <MyFramWork/MyFramWork.h>

@interface ViewController ()
//3.2之后,MPMoviePlayerController作为MPMoviePlayerViewController的一个属性存在。
@property (nonatomic,strong) MPMoviePlayerController *movie;
@property (nonatomic,strong) MPMoviePlayerViewController *viewController;
@property (nonatomic,strong) MPMoviePlayerViewController *playerViewController;


@end

@implementation ViewController

- (void)viewDidLoad {
    //模拟器不支持视频播放，火爆错

    [super viewDidLoad];
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"新的心跳" ofType:@"mp4"];
    
//    [self createMPPlayerController:filePath];
//    [self createMPPlayerViewController:filePath];
    [self playVideo:[NSURL fileURLWithPath:filePath]];
}

#pragma mark - 创建MPMoviePlayerController

- (void)createMPPlayerController:(NSString *)sFileNamePath
{
    
    NSURL *movieUrl = [NSURL fileURLWithPath:sFileNamePath];
    self.movie = [[MPMoviePlayerController alloc]initWithContentURL:movieUrl];
    [self.movie prepareToPlay];
    [self.view addSubview:self.movie.view];
    self.movie.shouldAutoplay = YES;
    [self.movie setControlStyle:MPMovieControlStyleDefault];
//    [self.movie setFullscreen:YES];
    [self.movie.view setFrame:self.view.bounds];
    self.movie.scalingMode = MPMovieScalingModeAspectFit;
//    [self.movie.view setTransform:CGAffineTransformMakeRotation(2 * M_PI - M_PI / 2)];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieFinishedCallback:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.movie];
}

- (void)movieFinishedCallback:(NSNotification *)notify
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:self.movie];
    [self.movie.view removeFromSuperview];
}


#pragma mark - 创建MPMoviePlayerViewController

- (void)createMPPlayerViewController:(NSString *)sFileNamePath
{
    _viewController = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL fileURLWithPath:sFileNamePath]];
    [_viewController.moviePlayer prepareToPlay];
    [self presentMoviePlayerViewControllerAnimated:_viewController];
    [self.view addSubview:_viewController.view];
    [_viewController.moviePlayer setControlStyle:MPMovieControlStyleFullscreen];
    [_viewController.view setBackgroundColor:[UIColor clearColor]];
    [_viewController.view setFrame:self.view.bounds];
    [_viewController.moviePlayer setFullscreen:YES];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(movieViewFinishedCallback:) name:MPMoviePlayerPlaybackDidFinishNotification object:_viewController.moviePlayer];
}

- (void)movieViewFinishedCallback:(NSNotification *)notify
{
    MPMoviePlayerController *theMovie = [notify object];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:theMovie];
    
    [_viewController dismissMoviePlayerViewControllerAnimated];
}

- (void) playVideo:(NSURL *) movieURL//根据视频url播放视频
{
    _playerViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:@"http://7xawdc.com2.z0.glb.qiniucdn.com/o_19p6vdmi9148s16fs1ptehbm1vd59.mp4"]];
    
    [_playerViewController.moviePlayer prepareToPlay];
    [self.view addSubview:_playerViewController.view];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playVideoFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:[_playerViewController moviePlayer]];
    
    _playerViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:_playerViewController animated:YES];
    [_playerViewController.view setTransform:CGAffineTransformMakeRotation(2 * M_PI - M_PI / 2)];
    MPMoviePlayerController *player = [_playerViewController moviePlayer];
    [player play];
}

- (void) playVideoFinished:(NSNotification *)theNotification//当点击Done按键或者播放完毕时调用此函数
{
    MPMoviePlayerController *player = [theNotification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];
    [player stop];
    [_playerViewController dismissModalViewControllerAnimated:YES];
    [_playerViewController.view removeFromSuperview];
}

//#pragma mark - 横屏
//-(BOOL) shouldAutorotate
//{
//    return YES;
//}
//
//-(NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskLandscape;
//}

/**
 *  NSString * const MPMoviePlayerScalingModeDidChangeNotification;
 播放器缩放产生改变时发送的通知
 
 NSString * const MPMoviePlayerPlaybackDidFinishNotification;
 播放结束时发送的通知

 NSString * const MPMoviePlayerPlaybackStateDidChangeNotification;
 播放状态改变时发送的通知
 
 NSString * const MPMoviePlayerLoadStateDidChangeNotification;
 缓冲状态改变时发送的通知
 
 NSString * const MPMoviePlayerNowPlayingMovieDidChangeNotification;
 当前播放的视频改变时发送的通知
 
 NSString * const MPMoviePlayerWillEnterFullscreenNotification;
 将要进入全屏模式时发送的通知
 
 NSString * const MPMoviePlayerDidEnterFullscreenNotification;
 已经进入全屏时发送的通知
 
 NSString * const MPMoviePlayerWillExitFullscreenNotification;
 将要退出全屏时发送的通知
 
 NSString * const MPMoviePlayerDidExitFullscreenNotification;
 已经退出全屏时发送的通知
 
 NSString * const MPMoviePlayerThumbnailImageRequestDidFinishNotification;
 获取缩略图完成时发送的通知
 @property (nonatomic, copy) NSURL *contentURL;
 视频文件的url地址
 
 @property (nonatomic, readonly) UIView *view;
 播放器view，在使用之前，必须设置frame大小，然后将其添加在我们的UI视图上
 
 @property (nonatomic, readonly) UIView *backgroundView;
 播放器背景颜色
 
 @property (nonatomic, readonly) MPMoviePlaybackState playbackState;
 播放器的当前播放状态，枚举定义如下：
 ?
 1
 2
 3
 4
 5
 6
 7
 8
 typedef NS_ENUM(NSInteger, MPMoviePlaybackState) {
 MPMoviePlaybackStateStopped,//停止播放
 MPMoviePlaybackStatePlaying,//正在播放
 MPMoviePlaybackStatePaused,//暂停播放
 MPMoviePlaybackStateInterrupted,//中断播放
 MPMoviePlaybackStateSeekingForward,//快进
 MPMoviePlaybackStateSeekingBackward//快退
 };
 
 @property (nonatomic, readonly) MPMovieLoadState loadState;
 播放器的网络缓存状态，枚举定义如下：
 ?
 1
 2
 3
 4
 5
 6
 typedef NS_OPTIONS(NSUInteger, MPMovieLoadState) {
 MPMovieLoadStateUnknown        = 0,//状态未知
 MPMovieLoadStatePlayable       = 1 << 0,//缓存数据足够开始播放，但是视频并没有缓存完全
 MPMovieLoadStatePlaythroughOK  = 1 << 1, //已经缓存完成，如果设置了自动播放，这时会自动播放
 MPMovieLoadStateStalled        = 1 << 2, //数据缓存已经停止，播放将暂停
 };
 
 @property (nonatomic) MPMovieControlStyle controlStyle;
 播放器风格，枚举如下:
 ?
 1
 2
 3
 4
 5
 6
 7
 typedef NS_ENUM(NSInteger, MPMovieControlStyle) {
 MPMovieControlStyleNone,       // 无控制器
 MPMovieControlStyleEmbedded,   // 嵌入视频风格
 MPMovieControlStyleFullscreen, // 全屏播放风格
 
 MPMovieControlStyleDefault = MPMovieControlStyleEmbedded
 };
 
 
 @property (nonatomic) MPMovieRepeatMode repeatMode;
 播放器的循环模式，枚举如下：
 ?
 1
 2
 3
 4
 typedef NS_ENUM(NSInteger, MPMovieRepeatMode) {
 MPMovieRepeatModeNone,//播放结束后不循环
 MPMovieRepeatModeOne//循环
 };
 
 @property (nonatomic) BOOL shouldAutoplay;
 是否开启自动播放
 
 
 
 
 @property (nonatomic, getter=isFullscreen) BOOL fullscreen;
 设置是否充满屏幕
 
 
 - (void)setFullscreen:(BOOL)fullscreen animated:(BOOL)animated;
 设置是否充满屏幕，带动画效果
 
 
 
 @property (nonatomic) MPMovieScalingMode scalingMode;
 设置播放器的填充方式，枚举定义如下：
 
 ?
 1
 2
 3
 4
 5
 6
 typedef NS_ENUM(NSInteger, MPMovieScalingMode) {
 MPMovieScalingModeNone,       // 无缩放
 MPMovieScalingModeAspectFit,  // 适应大小模式
 MPMovieScalingModeAspectFill, // 充满可视范围，可能会被裁剪
 MPMovieScalingModeFill        // 缩放到充满视图
 };
 
 
 @property (nonatomic, readonly) BOOL readyForDisplay NS_AVAILABLE_IOS(6_0);
 返回YES说明数据栈已经缓存好数据，返回NO则没有缓存好
 
 
 
 
 @property (nonatomic, readonly) MPMovieMediaTypeMask movieMediaTypes;
 数据文件的格式，枚举如下：
 
 ?
 1
 2
 3
 4
 5
 typedef NS_OPTIONS(NSUInteger, MPMovieMediaTypeMask) {
 MPMovieMediaTypeMaskNone  = 0,//格式未知
 MPMovieMediaTypeMaskVideo = 1 << 0,//音频格式
 MPMovieMediaTypeMaskAudio = 1 << 1//视频格式
 };
 
 
 @property (nonatomic) MPMovieSourceType movieSourceType;
 视频的数据类型，枚举如下：
 ?
 1
 2
 3
 4
 5
 typedef NS_ENUM(NSInteger, MPMovieSourceType) {
 MPMovieSourceTypeUnknown,//类型未知
 MPMovieSourceTypeFile,     // 文件类型
 MPMovieSourceTypeStreaming // 数据流
 };
 
 @property (nonatomic, readonly) NSTimeInterval duration;
 视频文件的时长
 
 @property (nonatomic, readonly) NSTimeInterval playableDuration;
 缓存完成能够播放的时长
 
 @property (nonatomic, readonly) CGSize naturalSize;
 视频的原始大小
 
 @property (nonatomic) NSTimeInterval initialPlaybackTime;
 播放器开始播放的时间
 
 @property (nonatomic) NSTimeInterval endPlaybackTime;
 播放器结束播放的时间
 
 @property (nonatomic) BOOL allowsAirPlay;
 是否允许云端播放
 
 - (void)requestThumbnailImagesAtTimes:(NSArray *)playbackTimes timeOption:(MPMovieTimeOption)optio;
 获取视频某一些时间点的缩略图，参数枚举如下，生成缩略图的数据回调在后面的通知中详说：
 ?
 1
 2
 3
 4
 typedef NS_ENUM(NSInteger, MPMovieTimeOption) {
 MPMovieTimeOptionNearestKeyFrame,//使用最近的关键帧生成缩略图
 MPMovieTimeOptionExact//使用精确的当前帧生成缩略图
 };

 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
