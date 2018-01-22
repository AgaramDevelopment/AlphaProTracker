//
//  AssessmentFilterView.h
//  AlphaProTracker
//
//  Created by user on 03/01/18.
//  Copyright © 2018 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SACalendar.h"

@protocol AssessmentFilterDelegate
-(void)SelectPlayerMovetoAnother:(NSDictionary *) playerDetail:(NSString *)AssessmentCode;
@end

@interface AssessmentFilterView : UIView <SACalendarDelegate, UITextFieldDelegate>
@property (nonatomic,strong) id AssessmentFilterDelegate;

@property (nonatomic,strong) NSString *moduleStr;
@property (nonatomic,strong) NSString * assessmentCode;



@property(nonatomic,strong) NSMutableArray * AssessmentTitleArray;




@property (nonatomic,strong) IBOutlet UITableView * popTblView;
@property (nonatomic,strong) IBOutlet UITableView * playerTbl;
@property (nonatomic,strong) IBOutlet UIView * moduleView;
@property (nonatomic,strong) IBOutlet UIView * titleView;
@property (nonatomic,strong) IBOutlet UIView * dateView;
@property (nonatomic,strong) IBOutlet UIView * teamView;
@property (nonatomic,strong) IBOutlet UIView * searchView;
@property (nonatomic,strong) IBOutlet UILabel * moduleLbl;
@property (nonatomic,strong) IBOutlet UILabel * titleLbl;
@property (nonatomic,strong) IBOutlet UILabel * teamLbl;
@property (nonatomic,strong) IBOutlet UILabel * datelbl;
@property (nonatomic,strong) IBOutlet UITextField * playerTxt;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * popviewyposition;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * popviewXposition;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * popviewWidth;
@property (nonatomic, strong) NSArray *searchResult;
@property(assign) BOOL searchEnabled;
@end
