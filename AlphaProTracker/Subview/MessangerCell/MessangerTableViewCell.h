//
//  MessangerTableViewCell.h
//  AlphaProTracker
//
//  Created by user on 26/01/18.
//  Copyright © 2018 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessangerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblSenderName;
@property (weak, nonatomic) IBOutlet UILabel *lblReceivedMsg;
@property (weak, nonatomic) IBOutlet UILabel *lblReceivedDate;

@property (weak, nonatomic) IBOutlet UILabel *lblSendDate;
@property (weak, nonatomic) IBOutlet UILabel *lblYourMessage;


@property (weak, nonatomic) IBOutlet UIImageView *yourImg;
@property (weak, nonatomic) IBOutlet UILabel *YourMsg;
@property (weak, nonatomic) IBOutlet UILabel *YourMsgDate;

@property (weak, nonatomic) IBOutlet UIImageView *ReceivedImg;
@property (weak, nonatomic) IBOutlet UILabel *lblReceivedName;
@property (weak, nonatomic) IBOutlet UILabel *lblReceivedMsgDate;
@property (weak, nonatomic) IBOutlet UILabel *lblReceivedMsgContent;

//@property (weak, nonatomic) IBOutlet UILabel *lblUrMsg1;
@property (weak, nonatomic) IBOutlet UILabel *lblUrMSgDate1;
@property (weak, nonatomic) IBOutlet UILabel *lblUrMsg1;

@property (weak, nonatomic) IBOutlet UIImageView *imgUr2;
@property (weak, nonatomic) IBOutlet UILabel *lblUrDate2;
@property (weak, nonatomic) IBOutlet UILabel *lblUrMsg2;
@property (weak, nonatomic) IBOutlet UILabel *lblReceiverName2;


@property (weak, nonatomic) IBOutlet UILabel *lblDate3;
@property (weak, nonatomic) IBOutlet UILabel *lblName3;
@property (weak, nonatomic) IBOutlet UILabel *lblMsg3;

@property (weak, nonatomic) IBOutlet UIImageView *img4;
@property (weak, nonatomic) IBOutlet UILabel *lblDate4;
@property (weak, nonatomic) IBOutlet UILabel *lblName4;
@property (weak, nonatomic) IBOutlet UILabel *lblMsg4;








@end
