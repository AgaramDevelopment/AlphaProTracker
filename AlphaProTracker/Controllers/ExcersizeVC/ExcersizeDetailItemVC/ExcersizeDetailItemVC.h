//
//  ExcersizeDetailItemVC.h
//  AlphaProTracker
//
//  Created by MAC on 19/01/18.
//  Copyright © 2018 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ExcersizeDetailItemVC : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *playerImageView;
@property (strong, nonatomic) IBOutlet UIView *videoView;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong,nonatomic) AVPlayerViewController *avPlayerViewController;
@property (strong,nonatomic) AVPlayer *avPlayer;
@end