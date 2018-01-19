//
//  ExcersizeDetailItemVC.m
//  AlphaProTracker
//
//  Created by MAC on 19/01/18.
//  Copyright © 2018 agaraminfotech. All rights reserved.
//

#import "ExcersizeDetailItemVC.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ExcersizeDetailItemVC () <UIWebViewDelegate>

@end

@implementation ExcersizeDetailItemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ExcersizeDetailItemVC" owner:self options:nil];
    
//    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//    self.view.backgroundColor = [UIColor clearColor];

    [self setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    [self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    self.view.backgroundColor = [UIColor clearColor];
    self.playerImageView.hidden = NO;
//    self.webView.hidden = YES;
    NSURL *url=[NSURL URLWithString:@"http://images.indianexpress.com/2018/01/rahul-main-image.jpg"];
    
    [self.playerImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"default_image"]];
//    [self videoPlayer];
    [self loadWebView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) videoPlayer {
    
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    NSString *url = @"https://s3.ap-south-1.amazonaws.com/agaram-sports/SRI+LANKA+TOUR+OF+INDIA+T20I+SERIES+2017-18/INDIAVSSRILANKA1STT20I201217/INDIAVSSRILANKA1STT20I201217-IND-INN1-OVER4-BALL4.mp4";
    NSURL *videoURL = [NSURL URLWithString:url];
    
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
    
    [self.avPlayer seekToTime:CMTimeMake(0, 1)];
    [self.avPlayer pause];
        [self.avPlayerViewController.view removeFromSuperview];
        self.avPlayer = NULL;
    
        self.videoView.hidden = YES;
//    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)loadWebView {
    self.webView.delegate=self;
    NSString *urlString = @"https://www.tutorialspoint.com/ios/ios_tutorial.pdf";
    NSURL*url=[[NSURL alloc]initWithString:urlString];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    
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
