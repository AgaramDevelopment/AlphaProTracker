//
//  BowlingLoad.h
//  AlphaProTracker
//
//  Created by Lexicon on 07/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrainingLoadCell.h"


@interface BowlingLoad : UIViewController
@property(nonatomic,strong) IBOutlet UIButton *DAILY;
@property(nonatomic,strong) IBOutlet UIButton *WEEKLY;
@property(nonatomic,strong) IBOutlet UIButton *MONTHLY;

@property (nonatomic,strong) IBOutlet  UITableView * detailsTbl;

@property (nonatomic,strong) IBOutlet  TrainingLoadCell * trload;
@property (nonatomic,strong) IBOutlet  NSString * Playercode;
@property (nonatomic,strong) IBOutlet  NSString * UserCode;

@end
