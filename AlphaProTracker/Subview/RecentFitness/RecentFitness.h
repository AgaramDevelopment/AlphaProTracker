//
//  RecentFitness.h
//  AlphaProTracker
//
//  Created by Lexicon on 07/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecentFitness : UIViewController

@property (nonatomic,strong) IBOutlet UIView *dropDownview;
@property (nonatomic,strong) IBOutlet UIScrollView *barchartScroll;
@property (nonatomic,strong) IBOutlet  NSString * Playercode;
@property (nonatomic,strong) IBOutlet  NSString * UserCode;
@property (nonatomic,strong) IBOutlet  UITableView * detailsTbl;

@property (nonatomic,strong) IBOutlet UILabel *testlbl;

@end
