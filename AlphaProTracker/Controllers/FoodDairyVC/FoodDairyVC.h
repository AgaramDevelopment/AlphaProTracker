//
//  FoodDairyVC.h
//  AlphaProTracker
//
//  Created by Lexicon on 31/08/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodDairy.h"
@interface FoodDairyVC : UIViewController

@property (nonatomic,strong) IBOutlet UIView *gameview;
@property (nonatomic,strong) IBOutlet UIView *teamview;
@property (nonatomic,strong) IBOutlet UIView *playerview;
@property (nonatomic,strong) IBOutlet UIView *daterview;
@property (nonatomic,strong) IBOutlet FoodDairy * objFood;
@property (strong,nonatomic) IBOutlet UIView * view_datepicker;
@property (strong,nonatomic)  NSString * check;

@end
