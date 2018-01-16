//
//  TeamsVC.h
//  AlphaProTracker
//
//  Created by Lexicon on 05/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileVCCell.h"

@interface TeamsVC : UIViewController
@property (nonatomic,strong) NSString * selectteamcode;
@property (nonatomic,strong) NSString * selectTeamname;
@property (nonatomic,strong) IBOutlet  UILabel * Teamname;
@property (weak, nonatomic) IBOutlet UIView *containerUIView;

@property (nonatomic,strong) IBOutlet UITableView *playersTbl;
@property (nonatomic,strong) IBOutlet ProfileVCCell *objProfilecell;
@property (nonatomic,strong) IBOutlet UIImageView * teamImg;



@end
