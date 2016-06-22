//
//  PhotoDetailViewController.m
//  多照片选取
//
//  Created by MAC on 15/10/24.
//  Copyright © 2015年 mini. All rights reserved.
//

#import "PhotoDetailViewController.h"

@interface PhotoDetailViewController ()
{
    UIImage *photeImage;
    CGFloat photoHeight;
    CGFloat photoWidth;
}
@end

@implementation PhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self culculateImageSize];
    
    self.view.backgroundColor = BackGround;
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.imageView];
    
    [self.view addSubview:self.messageLabel];
    
    [self setImageViewCenter];
    
    [self setUIfig];
    
    self.title = @"照片详情";
    
    BackItem;
}

- (void)culculateImageSize
{
    CGImageRef ref = [[_asset  defaultRepresentation] fullResolutionImage];
    UIImage *img = [[UIImage alloc]initWithCGImage:ref];
    photeImage = img;
    if (img.size.width > 320) {
        photoWidth = 320;
        photoHeight = img.size.height * (320 / img.size.width);
        
    }else {
        photoHeight = img.size.height;
        photoWidth = img.size.width;
    }
    
    if (photoHeight > 400) {
        photoHeight = 400;
        photoWidth = img.size.width * (400 / img.size.height);
    }
}

- (void)back:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIScrollView *)scrollView
{
    if (! _scrollView) {
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, photoWidth > 320?320:photoWidth, photoHeight)];
        _scrollView.delegate = self;
        _scrollView.center = CGPointMake(160, 64 + 20 + photoHeight/2);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(photoWidth, photoHeight);
        _scrollView.multipleTouchEnabled=YES; //是否支持多点触控
        _scrollView.minimumZoomScale = 0.5;
        _scrollView.maximumZoomScale = 3;
    }
    return _scrollView;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0-64, photoWidth, photoHeight)];
        _imageView.backgroundColor = [UIColor purpleColor];
    }
    return _imageView;
}

- (UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 442, 240, 30)];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.font = [UIFont systemFontOfSize:16.0];
    }
    return _messageLabel;
}

- (void)setUIfig
{
    
    self.imageView.image = photeImage;
    
    NSDictionary *dic = [[_asset  defaultRepresentation]metadata];
    
    id dateTime = [[dic  objectForKey:@"{TIFF}"]objectForKey:@"DateTime"];
    
    if (dateTime!=nil) {
        
        NSArray *time = [dateTime componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        NSString *dataStr = [time objectAtIndex:0];
        
        self.messageLabel.text = dataStr;
        
    }
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)aScrollView

{
    [self setImageViewCenter];
}

- (void)setImageViewCenter
{
    CGFloat offsetX = (_scrollView.bounds.size.width > _scrollView.contentSize.width)?(_scrollView.bounds.size.width - _scrollView.contentSize.width)/2 : 0.0;
    
    CGFloat offsetY = (_scrollView.bounds.size.height > _scrollView.contentSize.height)?(_scrollView.bounds.size.height - _scrollView.contentSize.height)/2 : 0.0;
    
    self.imageView.center = CGPointMake(_scrollView.contentSize.width/2 + offsetX,_scrollView.contentSize.height/2 + offsetY - 64);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
