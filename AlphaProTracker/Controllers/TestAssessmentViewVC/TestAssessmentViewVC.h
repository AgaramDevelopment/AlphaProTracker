//
//  AssesmentVC.h
//  AlphaProTracker
//
//  Created by Lexicon on 24/08/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "assemntCell.h"
#import "AssessmentFilterView.h"

@interface TestAssessmentViewVC : UIViewController

@property (nonatomic,strong) IBOutlet UIButton *New;
@property (nonatomic,strong) IBOutlet UIButton *Pending;
@property (nonatomic,strong) IBOutlet UIButton *Completed;

@property (nonatomic,strong) IBOutlet UIView *AssesView;
@property (nonatomic,strong) IBOutlet UIView *calView;
@property (nonatomic,strong) IBOutlet UITableView *pop_view;
@property (nonatomic,strong) IBOutlet UITableView *detailsTbl;

@property (nonatomic,strong) IBOutlet UILabel *colorlbl;

@property (nonatomic,strong) IBOutlet UILabel *assesmntlbl;

@property (nonatomic,strong) IBOutlet UILabel *callbl;


@property (nonatomic,strong) IBOutlet assemntCell *objhomecell;

@property (nonatomic,strong)  NSString *ModuleCode;

@property (nonatomic ,strong) NSMutableArray *AsstValue;

@property (strong, nonatomic) IBOutlet AssessmentFilterView *objAssessmentSideView;

@end
