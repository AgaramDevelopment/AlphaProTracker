//
//  InboxTableViewCell.h
//  AlphaProTracker
//
//  Created by MAC on 26/01/18.
//  Copyright © 2018 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InboxTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *unreadMssgLbl;
@property (strong, nonatomic) IBOutlet UILabel *messageLbl;
@property (strong, nonatomic) IBOutlet UILabel *dateTimeLbl;

@end
