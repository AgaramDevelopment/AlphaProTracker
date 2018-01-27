//
//  GroupChat.h
//  AlphaProTracker
//
//  Created by Apple on 26/01/18.
//  Copyright © 2018 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupChat : UIViewController

@property (nonatomic,strong) IBOutlet UITableView *PlayerListTbl;
@property (nonatomic,strong) IBOutlet UITextField *GroupnameTxt;
@property (nonatomic,strong) IBOutlet UILabel *Playerlistlbl;
@property (nonatomic,strong) IBOutlet UILabel *selectedPlayerlbl;

@property (nonatomic,strong) IBOutlet NSMutableArray *playerListArray;
@property (nonatomic,strong) IBOutlet UIButton *CreatBtn;
@property (nonatomic,strong) IBOutlet UIButton *CloseBtn;
@property (nonatomic,strong) IBOutlet UIButton *multiSelectBtn;

@property (nonatomic,strong) IBOutlet UIView *multiSelectViewView;


@end
