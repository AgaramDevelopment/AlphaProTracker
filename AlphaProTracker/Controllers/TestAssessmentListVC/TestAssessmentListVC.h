//
//  SubAssessmentVC.h
//  AlphaProTracker
//
//  Created by Lexicon on 30/08/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubAssessmentCell.h"

@interface TestAssessmentListVC : UIViewController

@property (nonatomic,strong) IBOutlet SubAssessmentCell *objsubcell;

@property (nonatomic,strong) IBOutlet UITableView *playersTbl;

@property (nonatomic,strong) IBOutlet UILabel *textLabel;

@property (nonatomic,strong)  NSString *AssessmentName;
@property (nonatomic,strong)  NSString *DateOfASSE;
@property (nonatomic,strong)  NSString *Section;
@property (nonatomic,strong)  NSString *Testname;

@property (nonatomic,strong) IBOutlet UILabel *AssessmentNamelbl;
@property (nonatomic,strong) IBOutlet UILabel *DateOfASSElbl;
@property (nonatomic,strong) IBOutlet UILabel *Sectionlbl;
@property (nonatomic,strong) IBOutlet UILabel *Testnamelbl;


@end
