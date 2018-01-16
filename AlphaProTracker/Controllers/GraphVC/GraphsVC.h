//
//  GraphsVC.h
//  AlphaProTracker
//
//  Created by Lexicon on 27/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GraphsVC : UIViewController

@property (nonatomic,strong)  NSString *range;
@property (nonatomic,strong)  NSString *month;
@property (nonatomic,strong)  NSString *year;
@property (nonatomic,strong)  NSString *strdate;
@property (nonatomic,strong)  NSString *enddate;
@property (nonatomic,strong)  NSString *playerCode;
@property (nonatomic,strong)  NSString *axis1;
@property (nonatomic,strong)  NSString *axis2;
@property (nonatomic,strong)  NSString *axis1name;
@property (nonatomic,strong)  NSString *axis2name;

@property (nonatomic,strong)  NSString *Sdate;
@property (nonatomic,strong)  NSString *Edate;

@property (nonatomic,strong) IBOutlet UIScrollView *barchartScroll;



@end


