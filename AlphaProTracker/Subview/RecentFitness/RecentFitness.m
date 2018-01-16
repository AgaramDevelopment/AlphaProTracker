//
//  RecentFitness.m
//  AlphaProTracker
//
//  Created by Lexicon on 07/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "RecentFitness.h"
#import "AppCommon.h"
#import "HomeVC.h"
#import "CustomNavigation.h"
#import "Config.h"
#import "WebService.h"
#import "MCBarChartView.h"

@interface RecentFitness ()<MCBarChartViewDataSource,MCBarChartViewDelegate>
{
    NSString * SelectClientCode;
    NSString * Selectteamcode;
    NSString * Selectplayercode;
    
    MCBarChartView *objBarchart;
    
    NSString * yValue;
    NSString * zValue;
    
}
@property (strong, nonatomic) IBOutlet UIButton *fitnessButton;
@property (nonatomic,strong) IBOutlet NSMutableArray *fitneslist;

@property (nonatomic,strong) IBOutlet NSMutableArray *ylist;
@property (nonatomic,strong) IBOutlet NSMutableArray *zlist;

@property (strong, nonatomic) NSArray * titles_1;
@property (strong, nonatomic) MCBarChartView * BarChartView;
@end

@implementation RecentFitness

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dropDownview.layer.borderWidth=0.5f;
    self.dropDownview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    self.detailsTbl.hidden = YES;
    [self profileWebservice:SelectClientCode :Selectteamcode:Selectplayercode];
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)profileWebservice :(NSString *) cliendcode :(NSString *) PlyCode :(NSString *) TmeCode
{
    //[COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",playerDetailsKey]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        
        NSString *cliendcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
        
        NSString *rolecode = [[NSUserDefaults standardUserDefaults]stringForKey:@"RoleCode"];
        
        NSString *usercode1 = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
        
        NSString *TmeCode;
        if( [rolecode isEqualToString:@"ROL0000002"] )
        {
            TmeCode = usercode1;
        }
        else
            
        {
            TmeCode = self.UserCode;
        }
        
        
        
        NSString * PlyCode = self.Playercode;
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(cliendcode)   [dic    setObject:cliendcode     forKey:@"Clientcode"];
        if(PlyCode)   [dic    setObject:PlyCode     forKey:@"PlayerCode"];
        if(TmeCode)   [dic    setObject:TmeCode     forKey:@"Usercode"];
        
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            if(responseObject >0)
            {
                
                
                self.fitneslist = [[NSMutableArray alloc]init];
                self.fitneslist = [responseObject valueForKey:@"lstPlayerRecentPerformance"];
                
            }
            
            
            
            NSLog(@"%@", self.fitneslist);
            
            [self.detailsTbl reloadData];
            //[COMMON RemoveLoadingIcon];
            [self.view setUserInteractionEnabled:YES];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed");
            [COMMON webServiceFailureError];
            [self.view setUserInteractionEnabled:YES];
            
        }];
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.fitneslist.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellid = @"cell";
    
    
    UITableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellid];
    }
    
    
    cell.textLabel.text = [[self.fitneslist valueForKey:@"Test"] objectAtIndex:indexPath.row];
    self.testlbl.text = [[self.fitneslist valueForKey:@"Test"] objectAtIndex:0];
    
    
    cell.textLabel.font = [UIFont systemFontOfSize:12.0];
    cell.selectionStyle=UITableViewCellSelectionStyleNone ;
    [self getDetailsofbarchart];
    
    return cell;
}

-(void)getDetailsofbarchart
{
    self.ylist = [[NSMutableArray alloc]init];
    self.zlist = [[NSMutableArray alloc]init];
    
    if(self.fitneslist.count>0)
    {
        for(int i=0; self.fitneslist.count>i;i++)
        {
            NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
            dictionary=[self.fitneslist objectAtIndex:i];
            NSString*  strckercode;
            strckercode =([dictionary valueForKey:@"Test"]);
            
            //NSString * strckercode =[dictionary valueForKey:@"STRIKERCODE"];
            if([self.testlbl.text isEqualToString:strckercode])
            {
                
                
                yValue = [dictionary valueForKey:@"y"];
                zValue = [dictionary valueForKey:@"z"];
                
                
                
                [self.ylist addObject:yValue];
                [self.zlist addObject:zValue];
                
                
                
            }
            
            
        }
        [self BarChartMethod];
        
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.testlbl.text = [[self.fitneslist valueForKey:@"Test"] objectAtIndex:indexPath.row];
    self.detailsTbl.hidden = YES;
    [self getDetailsofbarchart];
    
}
//BarChart

-(void) BarChartMethod
{
    if(self.BarChartView != nil)
    {
        
        [self.BarChartView removeFromSuperview];
    }
    NSMutableArray * runValue=[[NSMutableArray alloc]init];
    // self.datelist =[[NSMutableArray alloc]init];
    //self.datelist =[self.detailslist valueForKey:@"wellnessdate"];
    
    
    //self.ratinglist =[[NSMutableArray alloc]init];
    //self.ratinglist =[self.detailslist valueForKey:@"wellnessrating"];
    
    runValue =self.ylist;
    
    id max = [self.ylist valueForKeyPath:@"@max.intValue"];
    
    
    _titles_1 = self.zlist;
    
    if(IS_IPHONE_DEVICE)
    {
        self.BarChartView = [[MCBarChartView alloc] initWithFrame:CGRectMake(10,10, [UIScreen mainScreen].bounds.size.width, 250)];
    }
    else
    {
        self.BarChartView = [[MCBarChartView alloc] initWithFrame:CGRectMake(20,10, [UIScreen mainScreen].bounds.size.width-200, 250)];
    }
    
    ///self.BarChartView.tag = 111;
    self.BarChartView.dataSource = self;
    self.BarChartView.delegate = self;
    self.BarChartView.maxValue = max;
    
    self.BarChartView.colorOfXAxis = [UIColor blackColor];
    self.BarChartView.colorOfXText = [UIColor blackColor];
    self.BarChartView.colorOfYAxis = [UIColor blackColor];
    self.BarChartView.colorOfYText = [UIColor blackColor];
    [self.barchartScroll addSubview:self.BarChartView];
    
}




- (NSInteger)numberOfSectionsInBarChartView:(MCBarChartView *)barChartView {
    
    
    //if (barChartView == self.BarChartView) {
    return [self.zlist count];
    //}
    
    //return [_dataSource count];
    
    
}

- (NSInteger)barChartView:(MCBarChartView *)barChartView numberOfBarsInSection:(NSInteger)section {
    
    //    if(barChartView == self.BarChartView)
    //    {
    return [self.ylist  count];
    //}
    
    //return nil;
}

- (id)barChartView:(MCBarChartView *)barChartView valueOfBarInSection:(NSInteger)section index:(NSInteger)index {
    
    // if (barChartView == self.BarChartView) {
    
    return self.ylist [section];
    
    //}
    
    
    
    //return nil;
    
}

- (UIColor *)barChartView:(MCBarChartView *)barChartView colorOfBarInSection:(NSInteger)section index:(NSInteger)index {
    
    
    //if (index == 0) {
    return [UIColor blueColor];
    //}
    //return [UIColor colorWithRed:(35/255.0f) green:(116/255.0f) blue:(203/255.0f) alpha:1.0];
    
}

- (NSString *)barChartView:(MCBarChartView *)barChartView titleOfBarInSection:(NSInteger)section {
    
    //if (barChartView ==  self.BarChartView) {
    
    return _titles_1[section];
    
    //}
    //return nil;
    
}

- (NSString *)barChartView:(MCBarChartView *)barChartView informationOfBarInSection:(NSInteger)section index:(NSInteger)index {
    
    return nil;
}

//- (NSMutableArray *)barChartView:(MCBarChartView *)barChartView informationOfWicketInSection:(NSInteger)section
//{
//    if(barChartView == self.BarChartView)
//    {
//        return com2Wicket;
//    }
//    else if(barChartView == self.barChartView_2)
//    {
//        return com3inningsWicket;
//    }
//    return nil;
//}


- (CGFloat)barWidthInBarChartView:(MCBarChartView *)barChartView {
    
    if(IS_IPHONE_DEVICE)
    {
        return 17;
    }
    else
    {
        return 17;
    }
    
    
}

- (CGFloat)paddingForSectionInBarChartView:(MCBarChartView *)barChartView {
    return 60;
    
}


- (IBAction)didClickFitnessBtn:(id)sender {
    
    self.detailsTbl.hidden = NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    return 30;
}

@end
