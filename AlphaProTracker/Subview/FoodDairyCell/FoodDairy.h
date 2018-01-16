//
//  FoodDairy.h
//  AlphaProTracker
//
//  Created by Mac on 18/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodDairy : UITableViewCell
@property (nonatomic,strong) IBOutlet UILabel * datelbl;
@property (nonatomic,strong) IBOutlet UILabel * fromlbl;
@property (nonatomic,strong) IBOutlet UILabel * tolbl;

@property (nonatomic,strong) IBOutlet UILabel * mealslbl;

@end
