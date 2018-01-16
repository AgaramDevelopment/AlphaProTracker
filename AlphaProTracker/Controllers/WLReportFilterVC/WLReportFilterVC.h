//
//  WLReportFilterVC.h
//  AlphaProTracker
//
//  Created by Lexicon on 01/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLReportFilterVC : UIViewController
@property (nonatomic,strong) IBOutlet UIView *rangeview;
@property (nonatomic,strong) IBOutlet UIView *monthview;
@property (nonatomic,strong) IBOutlet UIView *yearview;
@property (nonatomic,strong) IBOutlet UIView *gameview;
@property (nonatomic,strong) IBOutlet UIView *teamview;
@property (nonatomic,strong) IBOutlet UIView *playersview;
@property (nonatomic,strong) IBOutlet UIView *axis1view;
@property (nonatomic,strong) IBOutlet UIView *axis2view;

@property (nonatomic,strong) IBOutlet UITableView *listTbl;

@property (nonatomic,strong) IBOutlet UILabel *rangelbl;
@property (nonatomic,strong) IBOutlet UILabel *monthlbl;
@property (nonatomic,strong) IBOutlet UILabel *yearlbl;
@property (nonatomic,strong) IBOutlet UILabel *gamelbl;
@property (nonatomic,strong) IBOutlet UILabel *teamlbl;
@property (nonatomic,strong) IBOutlet UILabel *playerslbl;
@property (nonatomic,strong) IBOutlet UILabel *axis1lbl;
@property (nonatomic,strong) IBOutlet UILabel *axis2lbl;

@property (nonatomic,strong) IBOutlet UIView *strdView;
@property (nonatomic,strong) IBOutlet UIView *endView;
@property (nonatomic,strong) IBOutlet UILabel *startLbl;
@property (nonatomic,strong) IBOutlet UILabel *endlbl;
@property (nonatomic,strong) IBOutlet UILabel *startitle;
@property (nonatomic,strong) IBOutlet UILabel *endtitle;

@property (nonatomic,strong) IBOutlet UILabel *monthtitle;
@property (nonatomic,strong) IBOutlet UILabel *yeartitle;


@property (nonatomic,strong) IBOutlet UILabel *gameTxt;
@property (nonatomic,strong) IBOutlet UILabel *teamTxt;
@property (nonatomic,strong) IBOutlet UILabel *playerTxt;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * axis1position;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * axis1viewposition;


@end
