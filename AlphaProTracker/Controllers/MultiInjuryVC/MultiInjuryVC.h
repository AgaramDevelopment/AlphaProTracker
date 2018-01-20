//
//  MultiInjuryVC.h
//  AlphaProTracker
//
//  Created by Mac on 16/01/18.
//  Copyright © 2018 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultiInjurylistCell.h"

@interface MultiInjuryVC : UIViewController
{
    NSString *mrData;
    NSString *ctData;
    NSString *xrData;
    NSString *bloodData;
}



@property (nonatomic,strong) IBOutlet UIView * siteView;
@property (nonatomic,strong) IBOutlet UIView * sideView;
@property (nonatomic,strong) IBOutlet UIView * causeView;
@property (nonatomic,strong) IBOutlet UIView * locationView;
@property (nonatomic,strong) IBOutlet UIView * typeView;

@property (nonatomic,strong) IBOutlet UIButton * siteBtn;
@property (nonatomic,strong) IBOutlet UIButton * sideBtn;
@property (nonatomic,strong) IBOutlet UIButton * causeBtn;
@property (nonatomic,strong) IBOutlet UIButton * locationBtn;
@property (nonatomic,strong) IBOutlet UIButton * typeBtn;

@property (nonatomic,strong) IBOutlet UIButton * UPDATEBtn;
@property (nonatomic,strong) IBOutlet UIButton * DELETEBtn;
@property (nonatomic,strong) IBOutlet UIButton * CLOSEBtn;


@property (nonatomic,strong) IBOutlet UILabel * sitelbl;
@property (nonatomic,strong) IBOutlet UILabel * sidelbl;
@property (nonatomic,strong) IBOutlet UILabel * causelbl;
@property (nonatomic,strong) IBOutlet UILabel * locationlbl;
@property (nonatomic,strong) IBOutlet UILabel * typelbl;

@property (nonatomic,strong) IBOutlet UIView * multiseliectPopView;
@property (nonatomic,strong) IBOutlet UIView * tapView;
@property (nonatomic,strong) IBOutlet MultiInjurylistCell * objCell;


@property (nonatomic,strong) IBOutlet UITableView * multiSelectTbl;
@property (nonatomic,strong) IBOutlet UITableView * injuryTbl;
@property (nonatomic,strong)  NSMutableArray * injuryCauseArray;
@property (nonatomic,strong)  NSMutableArray * injuryTypeArray;
@property (nonatomic,strong)  NSMutableArray * injuryLocationArray;
@property (nonatomic,strong)  NSMutableArray * injurySideArray;
@property (nonatomic,strong)  NSMutableArray * injurySiteArray;

@property (nonatomic,strong)  NSString * onsetCode;
@property (nonatomic,strong)  NSString * injurycode;
@property (nonatomic,strong)  NSString * injuryName;
@property (nonatomic,strong)  NSString * playercode;
@property (nonatomic,strong)  NSString * clientcode;
@property (nonatomic,strong)  NSString * createdby;
@property (nonatomic,strong)  NSString * usercode;

@property (nonatomic,strong)  NSString * occurenceCode;
@property (nonatomic,strong)  NSString * occurenceSubCode;
@property (nonatomic,strong)  NSString * dateofAssessment;
@property (nonatomic,strong)  NSString * onsetDate;
@property (nonatomic,strong)  NSString * chiefComplaint;
@property (nonatomic,strong)  NSString * expectedOpinionCode;
@property (nonatomic,strong)  NSString * recoverydate;
@property (nonatomic,strong)  NSString * vasValue;

@property (nonatomic,strong)  NSString * gamecode;
@property (nonatomic,strong)  NSString * teamcode;



@end

