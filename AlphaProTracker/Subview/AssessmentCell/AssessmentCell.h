//
//  AssessmentCell.h
//  AlphaProTracker
//
//  Created by user on 04/01/18.
//  Copyright © 2018 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssessmentCell : UITableViewCell

@property(nonatomic,strong) IBOutlet UIImageView * player_Img;
@property(nonatomic,strong) IBOutlet UILabel * playername_lbl;
@property (nonatomic,strong) IBOutlet UILabel * title_lbl;

@end
