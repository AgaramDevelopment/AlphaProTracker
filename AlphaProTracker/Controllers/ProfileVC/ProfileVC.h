//
//  ProfileVC.h
//  AlphaProTracker
//
//  Created by Lexicon on 04/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileVCCell.h"

@interface ProfileVC : UIViewController

@property (nonatomic,strong) IBOutlet UITableView *teamsTbl;
@property (nonatomic,strong) IBOutlet ProfileVCCell *objProfilecell;
@property (nonatomic,strong) IBOutlet UILabel *Teamsname;
@property (nonatomic,strong) IBOutlet UIImageView *teamLogo;
@property (nonatomic,strong) NSString * teamcode1;
@property (nonatomic,strong) NSString * teamname;
@property (nonatomic,strong) NSString * check;




@end
