//
//  MessangerSelectorVC.h
//  AlphaProTracker
//
//  Created by apple on 25/01/18.
//  Copyright © 2018 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InboxTableViewCell.h"

@interface MessangerSelectorVC : UIViewController
{
    NSMutableArray *inboxArray;
    NSMutableArray *contactsArray;
    NSMutableArray *groupsArray;
    NSMutableArray *commonArray;
    NSMutableArray *recipientsArray;
    BOOL isInbox;
    BOOL isContacts;
    BOOL isGroups;
}
@property (strong, nonatomic)  NSString *referenceKey;
@property (strong, nonatomic) IBOutlet UIButton *inboxBtn;
@property (strong, nonatomic) IBOutlet UIButton *contactsBtn;
@property (strong, nonatomic) IBOutlet UIButton *groupsBtn;
@property (strong, nonatomic) IBOutlet UITableView *messangerTableView;
//@property (strong, nonatomic) IBOutlet InboxTableViewCell *reqcell;

@property (strong, nonatomic) IBOutlet UIView *naviView;

@end
