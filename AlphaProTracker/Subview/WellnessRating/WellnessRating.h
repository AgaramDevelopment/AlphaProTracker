//
//  WellnessRating.h
//  AlphaProTracker
//
//  Created by Lexicon on 07/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HACBarChart.h"
@import Charts;


@interface WellnessRating : UIViewController

@property (nonatomic,strong) IBOutlet  NSString * Playercode;

@property (nonatomic,strong) IBOutlet  UIScrollView * detailsView;

@property (nonatomic,strong) IBOutlet NSMutableArray *selecteddetailslist;

@property (nonatomic,strong) IBOutlet NSString *selectedUsercode;

@property (weak, nonatomic) IBOutlet HorizontalBarChartView *viewHorizontalBar;

@end
