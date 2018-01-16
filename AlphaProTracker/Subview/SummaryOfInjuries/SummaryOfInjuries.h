//
//  SummaryOfInjuries.h
//  AlphaProTracker
//
//  Created by Lexicon on 07/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrainingLoadCell.h"


@interface SummaryOfInjuries : UIViewController

@property (nonatomic,strong) IBOutlet  TrainingLoadCell * trload;
@property (nonatomic,strong) IBOutlet  NSString * Playercode;
@property (nonatomic,strong) IBOutlet  NSString * UserCode;

@property (nonatomic,strong) IBOutlet  UITableView * injuryTbl;

@end
