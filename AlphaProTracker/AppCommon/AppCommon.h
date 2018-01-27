//
//  AppCommon.h
//  AlphaProTracker
//
//  Created by Mac on 21/08/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SKSTableViewCell.h"
#import "SKSTableView.h"
#import "AppDelegate.h"


@interface AppCommon : NSObject<SKSTableViewDelegate>
{
    UIView *loadingView;
    SKSTableView * tableview;
    UIView * menuview;
    UIView * backgroundTransview;
    UIView * commonview;
   // NSString *nn;
    BOOL isPlayer;
    UIAlertView *objAlter;
    
    
}
@property (nonatomic, strong) NSArray *contents;
@property (strong, nonatomic) UIWindow *window;

+ (AppCommon *)common;
-(void)loadingIcon:(UIView *)view;
-(void)RemoveLoadingIcon;
-(BOOL) isInternetReachable;
-(void)webServiceFailureError;
-(void)reachabilityNotReachableAlert;
- (CGSize)getControlHeight:(NSString *)string withFontName:(NSString *)fontName ofSize:(NSInteger)size withSize:(CGSize)LabelWidth;
-(void)AddMenuView:(UIView *)view;
-(void)ShowsideMenuView;
+(NSString *)GetUsercode;
+(NSString *)GetUserName;
+(NSString *) GetClientCode;
+(NSString *) GetuserReference;
+(NSString *)getFileType:(NSString *)filePath;
+(void)showAlertWithMessage:(NSString *)message;
+(void)showLoading;
+(void)hideLoading;

+(UIColor*)colorWithHexString:(NSString*)hex;

@end
extern AppCommon *sharedCommon;
#define COMMON (sharedCommon? sharedCommon:[AppCommon common])
