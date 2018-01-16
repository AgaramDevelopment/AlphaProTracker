//
//  AddInjuryVC.h
//  AlphaProTracker
//
//  Created by Mac on 21/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddInjuryVC : UIViewController
@property (nonatomic,assign)  BOOL isUpdate;
@property (nonatomic,strong) NSMutableArray * objSelectInjuryArray;

@property (nonatomic,strong)IBOutlet UISlider * VasSlider;

@end
