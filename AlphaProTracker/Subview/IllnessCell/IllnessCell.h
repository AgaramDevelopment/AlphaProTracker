//
//  IllnessCell.h
//  AlphaProTracker
//
//  Created by Mac on 26/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IllnessCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel * dateofOnsetlbl;
@property (nonatomic,strong) IBOutlet UILabel * illnessNamelbl;
@property (nonatomic,strong) IBOutlet UILabel * recoverylbl;

@end
