//
//  AssessmentMultiPlayerReportVC.h
//  AlphaProTracker
//
//  Created by Lexicon on 01/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AAChartView.h"

@interface AssessmentMultiPlayerReportVC : UIViewController
@property (nonatomic,strong) IBOutlet UIView *gameview;
@property (nonatomic,strong) IBOutlet UIView *teamview;
@property (nonatomic,strong) IBOutlet UIView *playerview;
@property (nonatomic,strong) IBOutlet UIView *dateview;
@property (nonatomic,strong) IBOutlet UIView *asv1view;
@property (nonatomic,strong) IBOutlet UIView *asv2view;

@property (strong,readwrite) NSString* ModuleCode;
@property (weak, nonatomic) IBOutlet UILabel *lblGameName;
@property (weak, nonatomic) IBOutlet UILabel *lblTeamName;
@property (weak, nonatomic) IBOutlet UILabel *lblPlayersName;
@property (weak, nonatomic) IBOutlet UILabel *lblFromDate;
@property (weak, nonatomic) IBOutlet UILabel *lblAssValue1;
@property (weak, nonatomic) IBOutlet UILabel *lblAssValue2;
@property (weak, nonatomic) IBOutlet UITableView *tblDropDown;
- (IBAction)actionShowDropDown:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)actionViewMultiPlayerChart:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *customChartView;
@property (nonatomic, strong) AAChartModel *chartModel;
@property (nonatomic, strong) AAChartView  *chartView;
@property (weak, nonatomic) IBOutlet UIView *tableTopView;

@end
