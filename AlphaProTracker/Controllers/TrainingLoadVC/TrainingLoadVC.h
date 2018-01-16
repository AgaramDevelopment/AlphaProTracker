//
//  TrainingLoadVC.h
//  AlphaProTracker
//
//  Created by Lexicon on 02/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrainingLoadVCCell.h"

@interface TrainingLoadVC : UIViewController
@property (nonatomic,strong) IBOutlet UIView *borderview;
@property (nonatomic,strong) IBOutlet UIView *borderview1;
@property (nonatomic,strong) IBOutlet UIView *borderview2;
@property (nonatomic,strong) IBOutlet UIView *borderview3;
@property (nonatomic,strong) IBOutlet UIView *borderview4;
@property (nonatomic,strong) IBOutlet UIView *borderview5;
@property (nonatomic,strong) IBOutlet UIView *borderview6;
@property (nonatomic,strong) IBOutlet UIView *borderview7;

@property (nonatomic,strong) IBOutlet TrainingLoadVCCell *objtrCell;

@property (nonatomic,strong) IBOutlet UIView *teamTotalView;
@property (nonatomic,strong) IBOutlet UIView *playerTotalview;

@property (nonatomic,strong) IBOutlet UIView *teamview;
@property (nonatomic,strong) IBOutlet UIView *playerview;
@property (nonatomic,strong) IBOutlet UIView *dateview;
@property (nonatomic,strong) IBOutlet UIView *actview;
@property (nonatomic,strong) IBOutlet UIView *rpeview;
@property (nonatomic,strong) IBOutlet UIView *timeview;
@property (nonatomic,strong) IBOutlet UIView *ballsview;
@property (nonatomic,strong) IBOutlet UIView *ballslblview;

@property (nonatomic,strong) IBOutlet UIView *teamview1;
@property (nonatomic,strong) IBOutlet UIView *playerview1;
@property (nonatomic,strong) IBOutlet UIView *dateview1;
@property (nonatomic,strong) IBOutlet UIView *actview1;
@property (nonatomic,strong) IBOutlet UIView *rpeview1;
@property (nonatomic,strong) IBOutlet UIView *timeview1;
@property (nonatomic,strong) IBOutlet UIView *ballsview1;
@property (nonatomic,strong) IBOutlet UIView *ballslblview1;

@property (nonatomic,strong) IBOutlet UIView *teamview2;
@property (nonatomic,strong) IBOutlet UIView *playerview2;
@property (nonatomic,strong) IBOutlet UIView *dateview2;
@property (nonatomic,strong) IBOutlet UIView *actview2;
@property (nonatomic,strong) IBOutlet UIView *rpeview2;
@property (nonatomic,strong) IBOutlet UIView *timeview2;
@property (nonatomic,strong) IBOutlet UIView *ballsview2;
@property (nonatomic,strong) IBOutlet UIView *ballslblview2;

@property (nonatomic,strong) IBOutlet UIView *teamview3;
@property (nonatomic,strong) IBOutlet UIView *playerview3;
@property (nonatomic,strong) IBOutlet UIView *dateview3;
@property (nonatomic,strong) IBOutlet UIView *actview3;
@property (nonatomic,strong) IBOutlet UIView *rpeview3;
@property (nonatomic,strong) IBOutlet UIView *timeview3;
@property (nonatomic,strong) IBOutlet UIView *ballsview3;
@property (nonatomic,strong) IBOutlet UIView *ballslblview3;

@property (nonatomic,strong) IBOutlet UIView *teamview4;
@property (nonatomic,strong) IBOutlet UIView *playerview4;
@property (nonatomic,strong) IBOutlet UIView *dateview4;
@property (nonatomic,strong) IBOutlet UIView *actview4;
@property (nonatomic,strong) IBOutlet UIView *rpeview4;
@property (nonatomic,strong) IBOutlet UIView *timeview4;
@property (nonatomic,strong) IBOutlet UIView *ballsview4;
@property (nonatomic,strong) IBOutlet UIView *ballslblview4;

@property (nonatomic,strong) IBOutlet UIView *teamview5;
@property (nonatomic,strong) IBOutlet UIView *playerview5;
@property (nonatomic,strong) IBOutlet UIView *dateview5;
@property (nonatomic,strong) IBOutlet UIView *actview5;
@property (nonatomic,strong) IBOutlet UIView *rpeview5;
@property (nonatomic,strong) IBOutlet UIView *timeview5;
@property (nonatomic,strong) IBOutlet UIView *ballsview5;
@property (nonatomic,strong) IBOutlet UIView *ballslblview5;

@property (nonatomic,strong) IBOutlet UIView *teamview6;
@property (nonatomic,strong) IBOutlet UIView *playerview6;
@property (nonatomic,strong) IBOutlet UIView *dateview6;
@property (nonatomic,strong) IBOutlet UIView *actview6;
@property (nonatomic,strong) IBOutlet UIView *rpeview6;
@property (nonatomic,strong) IBOutlet UIView *timeview6;
@property (nonatomic,strong) IBOutlet UIView *ballsview6;
@property (nonatomic,strong) IBOutlet UIView *ballslblview6;

@property (nonatomic,strong) IBOutlet UIView *teamview7;
@property (nonatomic,strong) IBOutlet UIView *playerview7;
@property (nonatomic,strong) IBOutlet UIView *dateview7;
@property (nonatomic,strong) IBOutlet UIView *actview7;
@property (nonatomic,strong) IBOutlet UIView *rpeview7;
@property (nonatomic,strong) IBOutlet UIView *timeview7;
@property (nonatomic,strong) IBOutlet UIView *ballsview7;
@property (nonatomic,strong) IBOutlet UIView *ballslblview7;


@property (nonatomic,strong) IBOutlet UIView *countview;
@property (nonatomic,strong) IBOutlet UIView *count1view;

@property (nonatomic,strong) IBOutlet UIView *RemoveView1;
@property (nonatomic,strong) IBOutlet UIView *RemoveView2;
@property (nonatomic,strong) IBOutlet UIView *RemoveView3;
@property (nonatomic,strong) IBOutlet UIView *RemoveView4;
@property (nonatomic,strong) IBOutlet UIView *RemoveView5;
@property (nonatomic,strong) IBOutlet UIView *RemoveView6;
@property (nonatomic,strong) IBOutlet UIView *RemoveView7;


@property (nonatomic,strong) IBOutlet UIButton *addActivity;
@property (nonatomic,strong) IBOutlet UIScrollView *scrollView;

@property (strong,nonatomic) IBOutlet UIView * view_datepicker;
@property (strong,nonatomic) IBOutlet UILabel * teamlbl;
@property (strong,nonatomic) IBOutlet UILabel * playerlbl;
@property (strong,nonatomic) IBOutlet UILabel * activitylbl;
@property (strong,nonatomic) IBOutlet UILabel * rpelbl;
@property (strong,nonatomic) IBOutlet UILabel * datelbl;


@property (strong,nonatomic) IBOutlet UILabel * activitylbl1;
@property (strong,nonatomic) IBOutlet UILabel * rpelbl1;
@property (nonatomic,strong) IBOutlet UITextField *timecount1;
@property (nonatomic,strong) IBOutlet UITextField *ballscount1;

@property (strong,nonatomic) IBOutlet UILabel * activitylbl2;
@property (strong,nonatomic) IBOutlet UILabel * rpelbl2;
@property (nonatomic,strong) IBOutlet UITextField *timecount2;
@property (nonatomic,strong) IBOutlet UITextField *ballscount2;

@property (strong,nonatomic) IBOutlet UILabel * activitylbl3;
@property (strong,nonatomic) IBOutlet UILabel * rpelbl3;
@property (nonatomic,strong) IBOutlet UITextField *timecount3;
@property (nonatomic,strong) IBOutlet UITextField *ballscount3;

@property (strong,nonatomic) IBOutlet UILabel * activitylbl4;
@property (strong,nonatomic) IBOutlet UILabel * rpelbl4;
@property (nonatomic,strong) IBOutlet UITextField *timecount4;
@property (nonatomic,strong) IBOutlet UITextField *ballscount4;

@property (strong,nonatomic) IBOutlet UILabel * activitylbl5;
@property (strong,nonatomic) IBOutlet UILabel * rpelbl5;
@property (nonatomic,strong) IBOutlet UITextField *timecount5;
@property (nonatomic,strong) IBOutlet UITextField *ballscount5;

@property (strong,nonatomic) IBOutlet UILabel * activitylbl6;
@property (strong,nonatomic) IBOutlet UILabel * rpelbl6;
@property (nonatomic,strong) IBOutlet UITextField *timecount6;
@property (nonatomic,strong) IBOutlet UITextField *ballscount6;

@property (strong,nonatomic) IBOutlet UILabel * activitylbl7;
@property (strong,nonatomic) IBOutlet UILabel * rpelbl7;
@property (nonatomic,strong) IBOutlet UITextField *timecount7;
@property (nonatomic,strong) IBOutlet UITextField *ballscount7;

@property (strong,nonatomic) IBOutlet UILabel * countlbl;

@property (nonatomic,strong) IBOutlet UITableView *listTbl;

@property (nonatomic,strong) IBOutlet UITableView *ViewsTbl;

@property (nonatomic,strong) IBOutlet UITextField *timecount;

@property (nonatomic,strong) IBOutlet UITextField *ballscount;

@property (nonatomic,strong) IBOutlet UIButton *Update;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * dateYposition;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * BottomCountViewYPosition;

@property (nonatomic,strong) IBOutlet UITableView *MultiTbl;

@property (nonatomic,strong) IBOutlet UIView *commonView;

@property (nonatomic,strong) IBOutlet UIButton *Cancel;
@property (nonatomic,strong) IBOutlet UIButton *Submit;

@end
