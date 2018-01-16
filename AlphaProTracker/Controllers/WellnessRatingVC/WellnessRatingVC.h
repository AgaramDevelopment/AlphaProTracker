//
//  WellnessRatingVC.h
//  AlphaProTracker
//
//  Created by Lexicon on 02/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPieChart.h"


@interface WellnessRatingVC : UIViewController

@property (strong, nonatomic) IBOutlet NSString *selectPlayercode;

@property (strong,nonatomic) IBOutlet UIView * view_datepicker;

@property (strong, nonatomic) IBOutlet UIImageView *sleepPic;
@property (strong, nonatomic) IBOutlet UIImageView *fatiquePic;
@property (strong, nonatomic) IBOutlet UIImageView *musclePic;
@property (strong, nonatomic) IBOutlet UIImageView *stressPic;

@property (strong, nonatomic) IBOutlet UIView *bottomBar;

@property (strong, nonatomic) IBOutlet UIButton *UPDATE;
@property (strong, nonatomic) IBOutlet UIButton *SUBMIT;
@property (strong, nonatomic) IBOutlet UIButton *REMOVE;

@property (strong, nonatomic) IBOutlet UIButton *TeamBtn;
@property (strong, nonatomic) IBOutlet UIButton *PlayerBtn;

@property (strong, nonatomic) IBOutlet NSString *selectusercode;
@property (strong, nonatomic) IBOutlet UITableView *listTbl;

@property (strong, nonatomic) IBOutlet UITableView *multilistTbl;


//@property (strong, nonatomic) IBOutlet XYPieChart *pieChartRight;


@property (strong, nonatomic) IBOutlet UIView *teamView;
@property (strong, nonatomic) IBOutlet UIView *playerView;
@property (strong, nonatomic) IBOutlet UIView *dateView;
@property (strong, nonatomic) IBOutlet UIView *sleepView;
@property (strong, nonatomic) IBOutlet UIView *fatiqueView;
@property (strong, nonatomic) IBOutlet UIView *muscleView;
@property (strong, nonatomic) IBOutlet UIView *stressView;

@property (strong, nonatomic) IBOutlet UIView *datelblView;
@property (strong, nonatomic) IBOutlet UIView *teamlblView;
@property (strong, nonatomic) IBOutlet UIView *playerlblView;

@property (strong, nonatomic) IBOutlet UILabel *datelbl;
@property (strong, nonatomic) IBOutlet UILabel *teamlbl;
@property (strong, nonatomic) IBOutlet UILabel *playerlbl;

@property (strong, nonatomic) IBOutlet UILabel *SleepValue;
@property (strong, nonatomic) IBOutlet UILabel *FatiqueValue;
@property (strong, nonatomic) IBOutlet UILabel *MuscleValue;
@property (strong, nonatomic) IBOutlet UILabel *StreesValue;



@property (nonatomic,strong) IBOutlet NSLayoutConstraint * dateYposition;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * sleepYposition;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * fatiqueYposition;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * muscleYposition;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * stressYposition;

@property (strong, nonatomic) IBOutlet XYPieChart *pieChartLeft;
@property (strong, nonatomic) IBOutlet UILabel *percentageLabel;
@property(nonatomic, strong) NSArray        *sliceColors;



@end
