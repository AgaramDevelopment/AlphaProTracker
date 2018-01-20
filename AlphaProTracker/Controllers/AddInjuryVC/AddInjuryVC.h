//
//  AddInjuryVC.h
//  AlphaProTracker
//
//  Created by Mac on 21/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StepSlider.h"
@interface AddInjuryVC : UIViewController
@property (nonatomic,assign)  BOOL isUpdate;
@property (nonatomic,strong) NSMutableArray * objSelectInjuryArray;

@property (nonatomic,strong)IBOutlet UISlider * VasSlider;
@property (nonatomic,strong)IBOutlet StepSlider * StSlider;

@property (nonatomic,strong)IBOutlet UIButton * multiInjuryBtn;

@property (nonatomic,strong) NSString * ismulti;


@end

