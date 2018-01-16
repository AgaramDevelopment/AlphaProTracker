//
//  AddFoodDiaryVC.h
//  AlphaProTracker
//
//  Created by Mac on 18/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddFoodDiaryVC : UIViewController

@property (nonatomic,strong) NSDictionary * fooddiarydetailDic;

@property (nonatomic,strong) NSMutableArray * mealsArray;
@property (nonatomic,strong) IBOutlet UITableView * popviewTbl;
@property (nonatomic,assign) BOOL Isupdate;
@property (nonatomic,assign) NSString* key;

@property (strong,nonatomic) IBOutlet UIView * view_datepicker;

@end
