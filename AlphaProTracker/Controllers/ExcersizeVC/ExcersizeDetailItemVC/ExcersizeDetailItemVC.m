//
//  ExcersizeDetailItemVC.m
//  AlphaProTracker
//
//  Created by MAC on 19/01/18.
//  Copyright © 2018 agaraminfotech. All rights reserved.
//

#import "ExcersizeDetailItemVC.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AppCommon.h"

@interface ExcersizeDetailItemVC () <UIWebViewDelegate>

@end

@implementation ExcersizeDetailItemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor lightTextColor];
    
    //Load View based on Item.
    if(self.isImage) {
        self.playerImageView.hidden = NO;
        self.webView.hidden = YES;
        [self loadImageView];
    } else if (self.isVideo) {
        self.playerImageView.hidden = YES;
        self.webView.hidden = YES;
        [self videoPlayer];
    } else if (self.isPDF) {
        self.playerImageView.hidden = YES;
        self.webView.hidden = NO;
        [self loadWebView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadImageView {
    
    NSURL *url=[NSURL URLWithString:self.URL];
    [self.playerImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"profileImg"]];
}
-(void) videoPlayer {
    
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    
    NSURL *videoURL = [NSURL URLWithString:self.URL];
    
    self.avPlayer = [AVPlayer playerWithURL:videoURL];
    self.avPlayerViewController = [AVPlayerViewController new];
    self.avPlayerViewController.player = self.avPlayer;
    self.avPlayerViewController.view.frame = _videoView.bounds;
    [self.videoView addSubview:self.avPlayerViewController.view];
    [self.avPlayer play];
}

- (IBAction)closeVideo:(id)sender {
    
    self.playerImageView.hidden = YES;
    self.webView.hidden = YES;
    
    if(self.isVideo) {
        [self.avPlayer seekToTime:CMTimeMake(0, 1)];
        [self.avPlayer pause];
        [self.avPlayerViewController.view removeFromSuperview];
        self.avPlayer = NULL;
    }
    self.videoView.hidden = YES;
    
    //   [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)loadWebView {
    [COMMON loadingIcon:self.view];
    self.webView.delegate=self;
    NSURL*url=[[NSURL alloc]initWithString:self.URL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [COMMON RemoveLoadingIcon];
    NSLog(@"webViewDidFinishLoad");
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
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

