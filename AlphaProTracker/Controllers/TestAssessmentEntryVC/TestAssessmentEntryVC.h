//
//  TestAssessmentEntryVC.h
//  AlphaProTracker
//
//  Created by Lexicon on 01/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestAssessmentEntryVC : UIViewController

@property (nonatomic,strong) NSDictionary * selectAllValueDic;
@property (nonatomic,strong) NSString * SectionTestCodeStr;
@property (nonatomic,strong) NSString * SelectTestStr;
@property (nonatomic,strong) NSString * SelectTestTypecode;
@property (nonatomic,strong) NSString * SelectScreenId;

@property (nonatomic,assign) BOOL IsEdit;
@property (nonatomic,strong) NSString * ModuleStr;


@property (nonatomic,strong) IBOutlet UILabel * AssessmentLbl;
@property (nonatomic,strong) IBOutlet UILabel * SectionLbl;
@property (nonatomic,strong) IBOutlet UILabel * TestLbl;
@property (nonatomic,strong) IBOutlet UILabel * dateLbl;
@property (nonatomic,strong) IBOutlet UILabel * PlayerNameLbl;

@property (nonatomic,strong) IBOutlet UIView *right1view;
@property (nonatomic,strong) IBOutlet UIView *right2view;
@property (nonatomic,strong) IBOutlet UIView *left1view;
@property (nonatomic,strong) IBOutlet UIView *left2view;
@property (nonatomic,strong) IBOutlet UIView *centrl1view;
@property (nonatomic,strong) IBOutlet UIView *centrl2view;
@property (nonatomic,strong) IBOutlet UIView *descview;
@property (nonatomic,strong) IBOutlet UIView *interfaceview;
@property (nonatomic,strong) IBOutlet UIView *valueview;
@property (nonatomic,strong) IBOutlet UIView *remarksview;
@property (weak, nonatomic) IBOutlet UIScrollView *CommScroll;

@property (nonatomic,strong) IBOutlet UIView * rightCombview;
@property (nonatomic,strong) IBOutlet UIView * rightView;
@property (nonatomic,strong) IBOutlet UIView * leftCombView;
@property (nonatomic,strong) IBOutlet UIView * leftView;
@property (nonatomic,strong) IBOutlet UIView * centralcombView;
@property (nonatomic,strong) IBOutlet UIView * descriptionCombView;
@property (nonatomic,strong) IBOutlet UIView * centralview;
@property (nonatomic,strong) IBOutlet UIView * interfacecombView;
@property (nonatomic,strong) IBOutlet UIView * valueCombView;
@property (nonatomic,strong) IBOutlet UIView * remarkView;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * rightCombViewYposition;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * rightViewYposition;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * leftCombViewYposition;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * leftViewYposition;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * centralCombViewYposition;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * descriptionCombViewYposition;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * centralViewYposition;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * interfaceCombYposition;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * ValueViewYposition;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * RemarkViewYposition;



@property (nonatomic,strong) IBOutlet UITextField * remark_Txt;
@property (nonatomic,strong) IBOutlet UITextField * right_Txt;
@property (nonatomic,strong) IBOutlet UITextField * left_Txt;
@property (nonatomic,strong) IBOutlet UITextField * centeral_Txt;
@property (nonatomic,strong) IBOutlet UITextField * interface_Txt;
@property (nonatomic,strong) IBOutlet UILabel      * value_lbl;
@property (nonatomic,strong) IBOutlet UILabel    * description_lbl;

@property (nonatomic,strong) IBOutlet UITableView * popTbl;

@end

