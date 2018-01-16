//
//  DashBoardVC.h
//  AlphaProTracker
//
//  Created by Lexicon on 24/08/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashBoardVC : UIViewController

@property (nonatomic,strong) IBOutlet UICollectionView * photo_collection_view;

@property (nonatomic,strong)  NSString * selectedModule;

@property (nonatomic,strong)  NSString * ScreenName;


@end
