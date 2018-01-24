//
//  ExpandAssessmentVC.h
//  AlphaProTracker
//
//  Created by Lexicon on 01/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKSTableView.h"
@interface ExpandAssessmentVC : UIViewController
@property(nonatomic,strong)IBOutlet SKSTableView * tableview;

@property (nonatomic,strong) NSString * assessmentCodeStr;
@property (nonatomic,strong) NSString * ModuleCodeStr;
@property (nonatomic,strong) NSString * selectDate;
@end
