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

@property (nonatomic,strong) IBOutlet UIView * multiseliectPopView;
@property (nonatomic,strong) IBOutlet UIView * tapView;
@property (nonatomic,strong) IBOutlet MultiInjurylistCell * objCell;


@property (nonatomic,strong) IBOutlet UITableView * multiSelectTbl;
@property (nonatomic,strong) IBOutlet UITableView * injuryTbl;

@end
