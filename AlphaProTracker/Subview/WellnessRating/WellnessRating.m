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
#import "HorizontalXLblFormatter.h"
@import Charts;



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
@synthesize viewHorizontalBar;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    self.datelist =[[NSMutableArray alloc]init];
//    self.ratinglist =[[NSMutableArray alloc]init];
//
//    data3 =[[NSMutableArray alloc]init];
//    values =[[NSArray alloc]init];
//
//    for(int i=0; self.selecteddetailslist.count>i;i++)
//    {
//        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
//        dictionary=[self.selecteddetailslist objectAtIndex:i];
//
//
//        ratingValue = [dictionary valueForKey:@"wellnessrating"];
//
//
//        int x =[ratingValue intValue];
//
//        ratingDate = [dictionary valueForKey:@"wellnessdate"];
//
//        [self.ratinglist addObject:[NSNumber numberWithInt:x]];
//        [self.datelist addObject:ratingDate];
//
//        // data3 = @[@{kHACPercentage:[NSNumber numberWithInt:x], kHACColor  : [UIColor colorWithRed:0.000f green:0.620f blue:0.890f alpha:1.0f], kHACCustomText :ratingDate}];
//
//
//    }
//
//    self.myarray =[[NSMutableArray alloc]init];
//
//    for(int i=0; self.ratinglist.count>i;i++)
//    {
//        values = @[@{kHACPercentage:[self.ratinglist objectAtIndex:i], kHACColor  : [UIColor colorWithRed:0.000f green:0.620f blue:0.890f alpha:1.0f], kHACCustomText : [self.datelist objectAtIndex:i]}];
//
//        [self.myarray addObjectsFromArray:values];
//    }
//    for(int i=0; self.myarray.count>i;i++)
//    {
//
//        [data3 addObject:[self.myarray objectAtIndex:i]];
//    }
//
//    NSLog(@"%@", data3);
//
//    _chart3.showAxis                 = YES;   // Show axis line
//    _chart3.showProgressLabel        = YES;   // Show text for bar
//    _chart3.vertical                 = NO;   // Orientation chart
//    _chart3.reverse                  = NO;   // Orientation chart
//    _chart3.showDataValue            = YES;   // Show value contains _data, or real percent value
//    _chart3.showCustomText           = YES;   // Show custom text, in _data with key kHACCustomText
//    _chart3.barsMargin               = 5;     // Margin between bars
//    _chart3.sizeLabelProgress        = 50;    // Width of label progress text
//    _chart3.numberDividersAxisY      = 8;
//    _chart3.animationDuration        = 2;
//    //    _chart.axisMaxValue             = 1500;    // If no define maxValue, get maxium of _data
//    _chart3.progressTextColor        = [UIColor blackColor];
//    _chart3.axisYTextColor           = [UIColor blackColor];
//    _chart3.progressTextFont         = [UIFont fontWithName:@"DINCondensed-Bold" size:12];
//    _chart3.typeBar                  = HACBarType1;
//    _chart3.dashedLineColor          = [UIColor blueColor];
//    _chart3.axisXColor               = [UIColor blackColor];
//    _chart3.axisYColor               = [UIColor blackColor];
//    _chart3.data = data3;
//
//    ////// CHART SET DATA
//    [_chart3 draw];
    
    
    
    [self horizontalBarConfigure];
    
    
}

-(void)horizontalBarConfigure
{
    viewHorizontalBar.maxVisibleCount = 60;
    
    ChartXAxis *xAxis = viewHorizontalBar.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelFont = [UIFont systemFontOfSize:10.f];
    xAxis.drawAxisLineEnabled = YES;
    xAxis.drawGridLinesEnabled = NO;
    //xAxis.granularity = 10.0;
    // xAxis.granularity = 1.0; // only intervals of 1 day
    // xAxis.labelCount = 10;
    // viewHorizontalBar.xAxis.valueFormatter = HorizontalXLblFormatter
    
    //xAxis.valueFormatter = [[DayAxisValueFormatter alloc] initForChart:viewHorizontalBar];
    xAxis.valueFormatter = [[HorizontalXLblFormatter alloc] initForChart: self.selecteddetailslist];
    
    ChartYAxis *leftAxis = viewHorizontalBar.leftAxis;
    leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
    leftAxis.drawAxisLineEnabled = YES;
    leftAxis.drawGridLinesEnabled = YES;
    leftAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    //leftAxis.valueFormatter = [[DayAxisValueFormatter alloc] initForChart:viewHorizontalBar];
    
    ChartYAxis *rightAxis = viewHorizontalBar.rightAxis;
    rightAxis.enabled = YES;
    rightAxis.labelFont = [UIFont systemFontOfSize:10.f];
    rightAxis.drawAxisLineEnabled = YES;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    
    ChartLegend *l = viewHorizontalBar.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
    l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    l.orientation = ChartLegendOrientationHorizontal;
    l.drawInside = NO;
    l.form = ChartLegendFormSquare;
    l.formSize = 8.0;
    l.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
    l.xEntrySpace = 4.0;
    viewHorizontalBar.legend.enabled = false;
    
    viewHorizontalBar.fitBars = YES;
    
    
    [viewHorizontalBar animateWithYAxisDuration:2.5];
    [self updateChartData];
    
}
- (void)updateChartData
{
    //    if (self.shouldHideData)
    //    {
    //        _chartView.data = nil;
    //        return;
    //    }
    
    [self setDataCount:12.0 + 1 range:50.0];
}

- (void)setDataCount:(int)count range:(double)range
{
    double barWidth = 5.0;
    double spaceForBar = 10.0;
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    NSLog(@"%@", yVals);
    for (int i = 0; i < self.selecteddetailslist.count; i++)
    {
        //double mult = (range + 1);
        //double val = (double) (arc4random_uniform(mult));
        //        [yVals addObject:[[BarChartDataEntry alloc] initWithX:i * spaceForBar y:[[[self.ComfortArray valueForKey:@"level"]objectAtIndex:i] integerValue] icon: [UIImage imageNamed:@"icon"]]];
        
        [yVals addObject:[[BarChartDataEntry alloc] initWithX:i * spaceForBar y:[[[self.selecteddetailslist valueForKey:@"wellnessrating"]objectAtIndex:i] integerValue] icon: [UIImage imageNamed:@"icon"]]];
        
    }
    
    BarChartDataSet *set1 = nil;
    if (viewHorizontalBar.data.dataSetCount > 0)
    {
        set1 = (BarChartDataSet *)viewHorizontalBar.data.dataSets[0];
        set1.values = yVals;
        [viewHorizontalBar.data notifyDataChanged];
        [viewHorizontalBar notifyDataSetChanged];
    }
    else
    {
        set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@""];
        [set1 setColor:[UIColor blueColor]];
        
        set1.drawIconsEnabled = NO;
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
        data.barWidth = barWidth;
        
        
        viewHorizontalBar.xAxis.labelTextColor = [UIColor whiteColor];
        viewHorizontalBar.rightAxis.labelTextColor = [UIColor whiteColor];
        viewHorizontalBar.leftAxis.labelTextColor = [UIColor whiteColor];
        viewHorizontalBar.legend.accessibilityElementsHidden = YES;
       
        viewHorizontalBar.data = data;
    }
}


@end
