//
//  MessangerSendVC.h
//  AlphaProTracker
//
//  Created by apple on 25/01/18.
//  Copyright © 2018 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessangerSendVC : UIViewController

@property (strong,readwrite) NSString* CommID;
@property (strong,readwrite) NSString* iSread;
@property (strong,readwrite) NSString* SelectedName;
@property (strong,readwrite) NSMutableArray* arrReceiverCodes;
@property  BOOL isBroadCastMsg;

@property (weak, nonatomic) IBOutlet UIButton *btnToName;

@property (weak, nonatomic) IBOutlet UITableView *tblChatList;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewBottomSpace;
@property (weak, nonatomic) IBOutlet UITextField *txtMessage;
@property (strong, nonatomic) IBOutlet UIView *viewTolist;
@property (weak, nonatomic) IBOutlet UIView *imgView;
@property (weak, nonatomic) IBOutlet UIImageView *currentlySelectedImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ImgViewBottomConst;

@property (weak, nonatomic) IBOutlet UITextView *txtViewMsg;
@property (weak, nonatomic) IBOutlet UITableView *tblContactLIst;
- (IBAction)actionSendMessage:(id)sender;
- (IBAction)actionShowContactList:(id)sender;
@end
