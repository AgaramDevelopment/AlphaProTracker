//
//  MultiSelectTableViewCell.h
//  AlphaProTracker
//
//  Created by user on 25/01/18.
//  Copyright © 2018 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultiSelectTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *checkImg;

@property (weak, nonatomic) IBOutlet UILabel *lblPlayerName;
@property (weak, nonatomic) IBOutlet UIButton *btnCheck;
@end
