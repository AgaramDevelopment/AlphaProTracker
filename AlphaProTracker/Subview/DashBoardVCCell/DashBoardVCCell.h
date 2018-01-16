//
//  DashBoardVCCell.h
//  AlphaProTracker
//
//  Created by Lexicon on 24/08/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashBoardVCCell : UICollectionViewCell
@property (nonatomic,strong) IBOutlet UIImageView * photos;
@property (nonatomic,strong) IBOutlet UILabel * photos_title_lbl;

@property (strong, nonatomic) IBOutlet UILabel *seprator_lbl;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *sepratorXposition;

@property (strong,nonatomic) IBOutlet UIButton *myButton;

@property (strong,nonatomic) IBOutlet UIView *bgview;

@end
