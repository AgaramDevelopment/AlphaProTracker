//
//  MessangerTableViewCell.h
//  AlphaProTracker
//
//  Created by user on 26/01/18.
//  Copyright © 2018 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessangerTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *SenderIMG;
@property (weak, nonatomic) IBOutlet UILabel *SenderDate;
@property (weak, nonatomic) IBOutlet UILabel *SenderMsg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *SenderIMGHeight;

@property (weak, nonatomic) IBOutlet UILabel *ReceiverName;
@property (weak, nonatomic) IBOutlet UILabel *ReceiverDate;
@property (weak, nonatomic) IBOutlet UILabel *ReceiverMsg;
@property (weak, nonatomic) IBOutlet UIImageView *ReceiverIMG;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ReceiverIMGHeight;


-(void)calculateMsgSize;





@end
