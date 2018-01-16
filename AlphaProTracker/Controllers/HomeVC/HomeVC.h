//
//  HomeVC.h
//  AlphaProTracker
//
//  Created by Lexicon on 23/08/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeVC : UIViewController

@property (nonatomic,strong) IBOutlet UICollectionView * photo_collection_view;

@property (nonatomic,strong) NSString * usercodeStr;

@property (nonatomic,strong) NSString * clientcodeStr;

@property (nonatomic,strong) NSString * userreferencecodeStr;

@end
