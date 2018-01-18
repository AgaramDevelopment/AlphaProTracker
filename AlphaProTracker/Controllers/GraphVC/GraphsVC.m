//
//  GraphsVC.m
//  AlphaProTracker
//
//  Created by Lexicon on 27/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "GraphsVC.h"
#import "CustomNavigation.h"
#import "AppCommon.h"
#import "HomeVC.h"
#import "WebService.h"
#import "Config.h"
#import "MCBarChartView.h"

#import "AAChartView.h"
#import "SACalendar.h"

@interface GraphsVC ()
{
    WebService *objWebservice;
    
    
     NSString *value;
}

@property (nonatomic, strong) AAChartModel *chartModel;
@property (nonatomic, strong) AAChartView  *chartView;

@property (nonatomic, strong) NSArray  *AAr;

@property (nonatomic, strong) NSArray  *AA;

@property (strong, nonatomic)  NSMutableArray *firstArr;
@property (strong, nonatomic)  NSMutableArray *secondArr;


@property (strong, nonatomic) NSMutableArray *BarArr;
@property (strong, nonatomic) NSMutableArray *LineArr;
@property (strong, nonatomic) NSMutableArray *dayArr;

@property (strong, nonatomic) NSMutableArray *data;

@property (strong, nonatomic) NSMutableArray *line2;

//@property (strong, nonatomic) MCBarChartView * BarChartView;

//@property (strong, nonatomic) NSArray * titles_1;

@end

@implementation GraphsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //[COMMON AddMenuView:self.view];
    objWebservice = [[WebService alloc]init];
    
    self.firstArr = [[NSMutableArray alloc]init];
    self.secondArr = [[NSMutableArray alloc]init];
    
    self.BarArr = [[NSMutableArray alloc]init];
    self.LineArr = [[NSMutableArray alloc]init];
    self.dayArr = [[NSMutableArray alloc]init];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self GraphsWebservice];
    
    NSLog(@"%@", _range);
    NSLog(@"%@", _month);
    NSLog(@"%@", _year);
    NSLog(@"%@", _axis1);
    NSLog(@"%@", _axis2);
    NSLog(@"%@", _axis1name);
    NSLog(@"%@", _axis2name);
    NSLog(@"%@", _playerCode);
    
    [self customnavigationmethod];
    
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    //[COMMON AddMenuView:self.view];
}
-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    
    
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"Report Filter";
    objCustomNavigation.btn_back.hidden =NO;
    objCustomNavigation.menu_btn.hidden = YES;
    [objCustomNavigation.menu_btn addTarget:self action:@selector(MenuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [objCustomNavigation.btn_back addTarget:self action:@selector(btn_back:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)configureTheChartView:(AAChartType)chartType {
    
    self.chartView = [[AAChartView alloc]init];
    self.view.backgroundColor = [UIColor clearColor];
    //self.chartView.backgroundColor = [UIColor clearColor];
    self.chartView.frame = CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height);
    self.chartView.contentHeight = self.view.frame.size.height-100;
    //self.chartView.backgroundColor = [UIColor clearColor];

    [self.view addSubview:self.chartView];
    
    self.chartModel = [self configureTheChartModel:chartType];
    
    
    [self.chartView aa_drawChartWithChartModel:_chartModel];
}
- (AAChartModel *)configureTheChartModel:(NSString *)chartType {
    
    if ([chartType isEqualToString:@"mixed"]) {
        
        self.data = [[NSMutableArray alloc]init];
        
        for(int i=0;self.BarArr.count>i;i++)
        {
            value = [self.BarArr objectAtIndex:i];
            
            NSArray *vv = [[NSArray alloc]init];
            
            vv = @[@0.0,value];
            
            [self.data addObject:vv];
            
        }
        
        self.line2 = [[NSMutableArray alloc]init];
        for(int i=0;self.LineArr.count>i;i++)
        {
            NSString *str= [self.LineArr objectAtIndex:i];
            int num = [str intValue ];
            
            //[self.line2 addObject:num];
            [self.line2 addObject:[NSNumber numberWithInt:num]];
        }
        
        NSString *title = [NSString  stringWithFormat:@"%@  Vs  %@" ,self.axis1name,self.axis2name];
        
        NSLog(@"%@", title);
        //self.data = @[@[@0.0,@29],@[@0.0,@29]];
        
        
        AAChartModel *chartModel= AAObject(AAChartModel)
        .titleSet(title)
        .subtitleSet(@"")
        .yAxisTitleSet(@"")
        
        
        //.categoriesSet(@[@"A", @"B", @"C", @"D", @"F",@"F",@"F",@"F",@"F",@"F",@"F"])
        
        .categoriesSet(self.dayArr)
        
        .dataLabelEnabledSet(true)
        
        .seriesSet(@[
                     AAObject(AASeriesElement)
                     .typeSet(AAChartTypeColumnrange)
                     .nameSet(self.axis1name)
                     
                     //.dataSet(@[@[@0.0,value]]),
                     
                     .dataSet(self.data),
                     
                     AAObject(AASeriesElement)
                     .typeSet(AAChartTypeSpline)
                     .nameSet(self.axis2name)
                     //.dataSet(@[@7.0, @6.9, @9.5, @14.5, @18.2,@7.0, @6.9, @9.5, @14.5, @18.2]),
                     .dataSet(self.line2),
                     
                     ]
                   )
        ;
        
        return chartModel;
        
    }
    return nil;
}



-(void)GraphsWebservice
{
    
    NSString *clientcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    NSString * value1;
    NSString * value2;
    if([self.range isEqualToString:@"MONTHLY RANGE"])
    {
        value1 =[NSString  stringWithFormat:@"%@-%@-01" ,self.year,self.month];
        value2 =[NSString  stringWithFormat:@"%@-%@-30" ,self.year,self.month];
    }
    else
    {
        value1 =self.Sdate;
        value2 =self.Edate;
    }
    
    
    [objWebservice getGraphsDetails :GraphsKey :clientcode :value1 :value2:self.playerCode: self.axis1:self.axis2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject=%@",responseObject);
        if(responseObject >0)
        {
            self.firstArr = [responseObject valueForKey:@"firstChartList"];
            self.secondArr = [responseObject valueForKey:@"secordChartList"];
            
            
            self.BarArr = [self.firstArr valueForKey:@"trainingLoad"];
            self.LineArr = [self.secondArr valueForKey:@"trainingLoadSleep"];
            
            self.dayArr = [self.secondArr valueForKey:@"workLoadDay"];
            
           
            AAChartType chartType;
            
            self.AAr = [[NSArray alloc]init];
            self.AA = [[NSArray alloc]init];
            //value = @"29.5";
            
            //self.AAr = @[@"A", @"B", @"C", @"D", @"F",@"F",@"F",@"F",@"F",@"F",@"F"];
            
            //self.AA = @[@7.0, @6.9, @9.5, @14.5, @18.2,@7.0, @6.9, @9.5, @14.5, @18.2];
            
            chartType = @"mixed";
            self.title = [NSString stringWithFormat:@"%@ chart",chartType];
            
            [self configureTheChartView:chartType];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, id error) {
        NSLog(@"failed");
        [COMMON webServiceFailureError];
    }];
    
}



-(IBAction)MenuBtnAction:(id)sender
{
    [COMMON ShowsideMenuView];
    
}

-(IBAction)HomeBtnAction:(id)sender
{
    HomeVC  * objTabVC=[[HomeVC alloc]init];
    objTabVC = (HomeVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
    [self.navigationController pushViewController:objTabVC animated:YES];
    
    
    
}

-(IBAction)btn_back:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
