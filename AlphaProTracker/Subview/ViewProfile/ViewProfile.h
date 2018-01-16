//
//  ViewProfile.h
//  AlphaProTracker
//
//  Created by Lexicon on 06/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewProfile : UIViewController

@property (nonatomic,strong) IBOutlet  NSString * Playercode;
@property (nonatomic,strong) IBOutlet  NSString * Teamcode;
@property (nonatomic,strong) IBOutlet  NSString * UserCode;


@property (nonatomic,strong) IBOutlet  UILabel * doblbl;
@property (nonatomic,strong) IBOutlet  UILabel * heightlbl;
@property (nonatomic,strong) IBOutlet  UILabel * weightlbl;
@property (nonatomic,strong) IBOutlet  UILabel * nativelbl;
@property (nonatomic,strong) IBOutlet  UILabel * nationalitylbl;
@property (nonatomic,strong) IBOutlet  UILabel * teamslbl;
@property (nonatomic,strong) IBOutlet  UILabel * gameslbl;

@property (nonatomic,strong) IBOutlet  UILabel * colorlbl;

@end
