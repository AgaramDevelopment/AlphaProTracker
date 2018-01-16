//
//  WellnessRating.m
//  AlphaProTracker
//
//  Created by Lexicon on 07/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "WellnessRating.h"
#import "AppCommon.h"
#import "HomeVC.h"
#import "CustomNavigation.h"
#import "Config.h"
#import "WebService.h"
#import "MCBarChartView.h"
#import "AlphaProTracker-Bridging-Header.h"
#import "HACBarChart.h"



@interface WellnessRating ()
{
    NSString * SelectClientCode;
    NSString * Selectteamcode;
    NSString * Selectplayercode;
    
    NSMutableArray *data3;
    
    NSString * ratingValue;
    NSString *ratingDate;
    
    NSArray *values;
    
    
}


@property (weak, nonatomic) IBOutlet HACBarChart *chart3;
@property (nonatomic,strong) IBOutlet NSMutableArray *datelist;
@property (nonatomic,strong) IBOutlet NSMutableArray *ratinglist;

@property (nonatomic,strong) IBOutlet NSMutableArray *myarray;

@property (strong, nonatomic) NSArray * titles_1;
@property (strong, nonatomic) MCBarChartView * BarChartView;





@end

@implementation WellnessRating

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.datelist =[[NSMutableArray alloc]init];
    self.ratinglist =[[NSMutableArray alloc]init];
    
    data3 =[[NSMutableArray alloc]init];
    values =[[NSArray alloc]init];
    
    for(int i=0; self.selecteddetailslist.count>i;i++)
    {
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        dictionary=[self.selecteddetailslist objectAtIndex:i];
        
        
        ratingValue = [dictionary valueForKey:@"wellnessrating"];
        
        
        int x =[ratingValue intValue];
        
        ratingDate = [dictionary valueForKey:@"wellnessdate"];
        
        [self.ratinglist addObject:[NSNumber numberWithInt:x]];
        [self.datelist addObject:ratingDate];
        
        // data3 = @[@{kHACPercentage:[NSNumber numberWithInt:x], kHACColor  : [UIColor colorWithRed:0.000f green:0.620f blue:0.890f alpha:1.0f], kHACCustomText :ratingDate}];
        
        
    }
    
    self.myarray =[[NSMutableArray alloc]init];
    
    for(int i=0; self.ratinglist.count>i;i++)
    {
        values = @[@{kHACPercentage:[self.ratinglist objectAtIndex:i], kHACColor  : [UIColor colorWithRed:0.000f green:0.620f blue:0.890f alpha:1.0f], kHACCustomText : [self.datelist objectAtIndex:i]}];
        
        [self.myarray addObjectsFromArray:values];
    }
    for(int i=0; self.myarray.count>i;i++)
    {
        
        [data3 addObject:[self.myarray objectAtIndex:i]];
    }
    
    NSLog(@"%@", data3);
    
    _chart3.showAxis                 = YES;   // Show axis line
    _chart3.showProgressLabel        = YES;   // Show text for bar
    _chart3.vertical                 = NO;   // Orientation chart
    _chart3.reverse                  = NO;   // Orientation chart
    _chart3.showDataValue            = YES;   // Show value contains _data, or real percent value
    _chart3.showCustomText           = YES;   // Show custom text, in _data with key kHACCustomText
    _chart3.barsMargin               = 5;     // Margin between bars
    _chart3.sizeLabelProgress        = 50;    // Width of label progress text
    _chart3.numberDividersAxisY      = 8;
    _chart3.animationDuration        = 2;
    //    _chart.axisMaxValue             = 1500;    // If no define maxValue, get maxium of _data
    _chart3.progressTextColor        = [UIColor blackColor];
    _chart3.axisYTextColor           = [UIColor blackColor];
    _chart3.progressTextFont         = [UIFont fontWithName:@"DINCondensed-Bold" size:12];
    _chart3.typeBar                  = HACBarType1;
    _chart3.dashedLineColor          = [UIColor blueColor];
    _chart3.axisXColor               = [UIColor blackColor];
    _chart3.axisYColor               = [UIColor blackColor];
    _chart3.data = data3;
    
    ////// CHART SET DATA
    [_chart3 draw];
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
