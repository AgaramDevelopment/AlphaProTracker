//
//  PlayerVC.h
//  AlphaProTracker
//
//  Created by Lexicon on 06/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DashBoardVCCell.h"

@interface PlayerVC : UIViewController

@property (nonatomic,strong) IBOutlet  NSString * selectTeamcode;
@property (nonatomic,strong) IBOutlet  NSString * selectPlayercode;
@property (nonatomic,strong) IBOutlet  NSString * selectPlayer;
@property (nonatomic,strong) IBOutlet  NSString * selectPlayerimg;

@property (nonatomic,strong) IBOutlet  NSString * Playerusercde;

@property (nonatomic,strong)   NSString * check;

@property (nonatomic,strong) IBOutlet  DashBoardVCCell * objCell;



@property (nonatomic,strong) IBOutlet  UILabel * playername;

@property (nonatomic,strong) IBOutlet  UIImageView * playerpic;

@property (nonatomic,strong) IBOutlet UICollectionView * title_collection_view;







@end
