//
//  AssessmentSinglePlayerReportVC.h
//  AlphaProTracker
//
//  Created by Lexicon on 01/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AAChartView.h"

@interface AssessmentSinglePlayerReportVC : UIViewController

@property (strong,readwrite) NSString* ModuleCode;
@property (nonatomic,strong) IBOutlet UIView *gameview;
@property (nonatomic,strong) IBOutlet UIView *teamview;
@property (nonatomic,strong) IBOutlet UIView *playerview;
@property (nonatomic,strong) IBOutlet UIView *fromview;
@property (nonatomic,strong) IBOutlet UIView *toview;
@property (nonatomic,strong) IBOutlet UIView *asv1view;
@property (nonatomic,strong) IBOutlet UIView *asv2view;
@property (weak, nonatomic) IBOutlet UILabel *lblGameName;
@property (weak, nonatomic) IBOutlet UILabel *lblTeamName;
@property (weak, nonatomic) IBOutlet UILabel *lblPlayerName;
@property (weak, nonatomic) IBOutlet UILabel *lblFromDate;
@property (weak, nonatomic) IBOutlet UILabel *lblToDate;
@property (weak, nonatomic) IBOutlet UILabel *lblAssessmentValue1;
@property (weak, nonatomic) IBOutlet UILabel *lblAssessmentValue2;
@property (weak, nonatomic) IBOutlet UITableView *tblDropDown;
@property (weak, nonatomic) IBOutlet UIView *dropDownView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerChang;
@property (weak, nonatomic) IBOutlet UIView *customView;
@property (nonatomic, strong) AAChartModel *chartModel;
@property (nonatomic, strong) AAChartView  *chartView;
@property (weak, nonatomic) IBOutlet UIView *customChartView;

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


- (IBAction)actionViewGraph:(id)sender;
- (IBAction)actionShowDropDown:(id)sender;

@end
