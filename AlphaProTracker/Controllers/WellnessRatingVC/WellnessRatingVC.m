//
//  WellnessRatingVC.m
//  AlphaProTracker
//
//  Created by Lexicon on 02/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "WellnessRatingVC.h"
#import "AppCommon.h"
#import "HomeVC.h"
#import "CustomNavigation.h"
#import "XYPieChart.h"
#import "Config.h"
#import "SACalendar.h"
#import "WebService.h"
#import <QuartzCore/QuartzCore.h>
#import "PieChartView.h"
#import "CRTableViewCell.h"




#define UIColorHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

static inline UIColor *GetRandomUIColor()
{
    CGFloat r = arc4random() % 255;
    CGFloat g = arc4random() % 255;
    CGFloat b = arc4random() % 255;
    UIColor * color = [UIColor colorWithRed:r/255 green:g/255 blue:b/255 alpha:1.0f];
    return color;
}


static const CGFloat dia = 80.0f;

static const CGRect kPieChartViewFrame = {{35.0f, 35.0f},{dia, dia}};
static const CGRect kHoleSliderFrame = {{35.0f, 300.0f},{dia, 20.0}};
static const CGRect kSlicesSliderFrame = {{35.0f, 330.0f},{dia, 20.0}};

static const CGRect kHoleLabelFrame = {{0.0f, 200.0f},{35.0, 20.0}};
static const CGRect kValueLabelFrame = {{0.0f, 230.0f},{35.0, 20.0}};

static const NSInteger tHoleLabelTag = 7;
static const NSInteger tValueLabelTag = 77;

@interface WellnessRatingVC ()<PieChartViewDelegate,PieChartViewDataSource>
{
    
    UIDatePicker * datePicker;
    
    NSString *value1;
    NSString *value2;
    NSString *value3;
    NSString *value4;
    
    float num1;
    float num2;
    float num3;
    float num4;
    
    WebService *objWebservice;
    
    NSString *metaSubCode1;
    NSString *metaSubCode2;
    NSString *metaSubCode3;
    NSString *metaSubCode4;
    
    NSString *teamcode;
    NSString *player;
    
    NSString *playerCode;
    NSString *  teamplyCode;
    
    BOOL isTeam;
    BOOL isPlayer;
    
    UIView *chart;
    
    NSString *actualDate;
    NSString *workload;
    
    PieChartView *pieChartView;
    
    
}


@property (strong, nonatomic) IBOutlet UISlider *sleepSlider;
@property (strong, nonatomic) IBOutlet UISlider *fatiqueSlider;
@property (strong, nonatomic) IBOutlet UISlider *muscleSlider;
@property (strong, nonatomic) IBOutlet UISlider *stressSlider;

@property (strong, nonatomic)  NSMutableArray *sleeplist;
@property (strong, nonatomic)  NSMutableArray *fatiqlist;
@property (strong, nonatomic)  NSMutableArray *sorelist;
@property (strong, nonatomic)  NSMutableArray *stresslist;

@property (strong, nonatomic)  NSMutableArray *teamlist;
@property (strong, nonatomic)  NSMutableArray *playerlist;
@property (strong, nonatomic)  NSMutableArray *updatedplayerlist;
@property (strong, nonatomic)  NSMutableArray *updatedplayercodes;

@property (strong, nonatomic)  NSMutableArray *teamcodelist;

@property (strong, nonatomic)  NSMutableArray *sleeplist1;
@property (strong, nonatomic)  NSMutableArray *fatiqlist1;
@property (strong, nonatomic)  NSMutableArray *sorelist1;
@property (strong, nonatomic)  NSMutableArray *stresslist1;

@property (strong, nonatomic)  NSMutableArray *selectedMarks;

@property (strong, nonatomic) IBOutlet UIView *commonview;


@property (strong, nonatomic) IBOutlet NSLayoutConstraint * tableWidth;



@property (strong, nonatomic) IBOutlet UIView *chart;

@property (strong, nonatomic) IBOutlet NSMutableArray *markers;

@end

@implementation WellnessRatingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customnavigationmethod];
    //[COMMON AddMenuView:self.view];
    self.selectedMarks = [[NSMutableArray alloc]init];
    self.markers = [[NSMutableArray alloc]initWithObjects:@"0",@"0",@"0",@"0", nil];
    //self.markers = [[NSMutableArray alloc]init];
    
    self.datelblView.layer.borderWidth=0.5f;
    self.datelblView.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.teamlblView.layer.borderWidth=0.5f;
    self.teamlblView.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.playerlblView.layer.borderWidth=0.5f;
    self.playerlblView.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.UPDATE.hidden = YES;
    self.REMOVE.hidden = YES;
    self.bottomBar.hidden = YES;
    
    self.view_datepicker.hidden=YES;
    self.listTbl.hidden = YES;
    self.commonview.hidden =YES;
    
    NSString *rolecode = [[NSUserDefaults standardUserDefaults]stringForKey:@"RoleCode"];
    
    if( [rolecode isEqualToString:@"ROL0000002"] )
    {
        self.teamView.hidden = YES;
        self.playerView.hidden = YES;
        
        self.dateYposition.constant = -50;
    }
    
    objWebservice=[[WebService alloc]init];
    //[self samplePieChart];
    [self metacodeWebservice];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [COMMON AddMenuView:self.view];
}
-(void)samplePieChart
{
    
    if(IS_IPHONE_DEVICE)
    {
        pieChartView = [[PieChartView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3,self.stressView.frame.origin.y+40,100,100)];
        pieChartView.delegate = self;
        pieChartView.datasource = self;
        [self.view addSubview:pieChartView];
    }
    else
    {
        pieChartView = [[PieChartView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3,self.stressView.frame.origin.y+100,300,300)];
        pieChartView.delegate = self;
        pieChartView.datasource = self;
        [self.view addSubview:pieChartView];
    }
    
    
    
}

-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    
    
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"WELLNESS RATING";
    objCustomNavigation.btn_back.hidden =NO;
    objCustomNavigation.menu_btn.hidden = YES;
    [objCustomNavigation.menu_btn addTarget:self action:@selector(MenuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [objCustomNavigation.btn_back addTarget:self action:@selector(btn_back:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark -    PieChartViewDelegate
-(CGFloat)centerCircleRadius
{
    if(IS_IPHONE_DEVICE)
    {
        return 40;
    }
    else
    {
        return 100;
    }
    
    
}
#pragma mark - PieChartViewDataSource
-(int)numberOfSlicesInPieChartView:(PieChartView *)pieChartView
{
    NSUInteger  obj = self.markers.count;
    return obj;
}
-(UIColor *)pieChartView:(PieChartView *)pieChartView colorForSliceAtIndex:(NSUInteger)index
{
    UIColor * color;
    if(index==0)
    {
         color = [UIColor colorWithRed:(210/255.0f) green:(105/255.0f) blue:(30/255.0f) alpha:1.0f];
    }
    if(index==1)
    {
        color = [UIColor colorWithRed:(0/255.0f) green:(100/255.0f) blue:(0/255.0f) alpha:1.0f];
    }
    if(index==2)
    {
        color = [UIColor colorWithRed:(0/255.0f) green:(139/255.0f) blue:(139/255.0f) alpha:1.0f];
    }
    if(index==3)
    {
        color = [UIColor colorWithRed:(165/255.0f) green:(42/255.0f) blue:(42/255.0f) alpha:1.0f];
    }
    return color;
    //return GetRandomUIColor();
}
-(double)pieChartView:(PieChartView *)pieChartView valueForSliceAtIndex:(NSUInteger)index
{
    //NSUInteger  obj = [[self.markers objectAtIndex:index] integerValue];
    //NSString *s= [self.markers objectAtIndex:index];
    float  obj = [[NSDecimalNumber decimalNumberWithString:[self.markers objectAtIndex:index]]floatValue] ;
    
    
    if(obj==0)
    {
        return 0;
    }
    else
    {
    
        if(index ==0)
        {
            return 100/obj;
        }
        if(index ==1)
        {
            return 100/obj;
        }
        if(index ==2)
        {
            return 100/obj;
        }
        if(index ==3)
        {
            return 100/obj;
        }
    }
    
    return 0;
}

-(NSString *)percentagevalue
{
    float a = num1;
    float b = num2;
    float c = num3;
    float d = num4;
    
    float Total = a+b+c+d;
    
    float per = (Total *100/28);
    
    NSString * obj;
    if(per == 0)
    {
        obj = @"";
    }
    else
    {
        
        obj =[NSString stringWithFormat:@"%f",per];
        
        NSString *a1 = [NSString stringWithFormat:@"%.02f",num1];
        NSString *a2 = [NSString stringWithFormat:@"%.02f",num2];
        NSString *a3 = [NSString stringWithFormat:@"%.02f",num3];
        NSString *a4 = [NSString stringWithFormat:@"%.02f",num4];
            self.SleepValue.text = a1;
            self.FatiqueValue.text = a2;
            self.MuscleValue.text = a3;
            self.StreesValue.text = a4;
        
    
    }
    
    return obj;
}

-(void)metacodeWebservice
{
    
    [COMMON loadingIcon:self.view];
    NSString *cliendcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    
    NSString *Rc=@"RC14";
    
    
    
    [objWebservice getmetacodelist :metasubKey :cliendcode :Rc success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject=%@",responseObject);
        if(responseObject >0)
        {
            self.sleeplist = [[NSMutableArray alloc]init];
            self.fatiqlist = [[NSMutableArray alloc]init];
            self.sorelist = [[NSMutableArray alloc]init];
            self.stresslist = [[NSMutableArray alloc]init];
            
            self.teamlist = [[NSMutableArray alloc]init];
            self.playerlist = [[NSMutableArray alloc]init];
            
            self.sleeplist1 = [[NSMutableArray alloc]init];
            self.fatiqlist1 = [[NSMutableArray alloc]init];
            self.sorelist1 = [[NSMutableArray alloc]init];
            self.stresslist1 = [[NSMutableArray alloc]init];
            
            
            self.sleeplist = [responseObject valueForKey:@"Sleeps"];
            self.fatiqlist = [responseObject valueForKey:@"Fatigues"];
            self.sorelist = [responseObject valueForKey:@"MuscleSoreNesses"];
            self.stresslist = [responseObject valueForKey:@"Stresses"];
            
            self.teamlist = [responseObject valueForKey:@"Teams"];
            self.playerlist = [responseObject valueForKey:@"Players"];
            
            
             self.teamcodelist = [self.teamlist valueForKey:@"TeamCode"];
            
            
            self.sleeplist1 = ([[self.sleeplist valueForKey:@"MetaSubCode"] isEqual:[NSNull null]])?@"":[self.sleeplist valueForKey:@"MetaSubCode"];
            
            self.fatiqlist1 = ([[self.fatiqlist valueForKey:@"MetaSubCode"] isEqual:[NSNull null]])?@"":[self.fatiqlist valueForKey:@"MetaSubCode"];
            
            self.sorelist1 = ([[self.sorelist valueForKey:@"MetaSubCode"] isEqual:[NSNull null]])?@"":[self.sorelist valueForKey:@"MetaSubCode"];
            
            self.stresslist1 = ([[self.stresslist valueForKey:@"MetaSubCode"] isEqual:[NSNull null]])?@"":[self.stresslist valueForKey:@"MetaSubCode"];
            
            
            [self samplePieChart];
            
            
        }
        [COMMON RemoveLoadingIcon];
        [self.view setUserInteractionEnabled:YES];

        //isgrid=NO;
        [self.listTbl reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, id error) {
        NSLog(@"failed");
        [COMMON webServiceFailureError];
    }];
    
}

-(IBAction)didClickTeamBtn:(id)sender
{
    
    
    isTeam = YES;
    isPlayer= NO;
    //self.listTbl.hidden = NO;
    
    self.commonview.hidden = NO;
    
//    self.x_position.constant = self.teamlblView.frame.origin.x-15;
//    self.y_position.constant = self.teamlblView.frame.origin.y+self.teamlblView.frame.size.height+40;
    [self.multilistTbl reloadData];
    
    
}
-(IBAction)didClickPlayerBtn:(id)sender
{
    if(isPlayer==NO)
    {
    isTeam = NO;
    isPlayer= YES;
    self.listTbl.hidden = NO;
    
    self.tableWidth.constant = self.playerlblView.frame.size.width;
    
    
    self.updatedplayerlist = [[NSMutableArray alloc]init];
    self.updatedplayercodes = [[NSMutableArray alloc]init];
    
     for(int i=0; self.selectedMarks.count>i;i++)
     {
         
         teamcode = [self.selectedMarks objectAtIndex:i];
         
         for(int j=0; self.playerlist.count>j;j++)
         {
     
             NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
             dictionary=[self.playerlist objectAtIndex:j];
             NSString*  strckercode;
             strckercode =([dictionary valueForKey:@"TeamCode"]);
             
             
             //NSString * strckercode =[dictionary valueForKey:@"STRIKERCODE"];
             if([teamcode isEqualToString:strckercode])
             {
                 
                 player = [dictionary valueForKey:@"PlayerName"];
                 
                 playerCode = [dictionary valueForKey:@"PlayerCode"];
                 
                 [self.updatedplayerlist addObject:player];
                 
                 [self.updatedplayercodes addObject:playerCode];
                 
                 
             }
             
         }
 
     }
    
    
    [self.listTbl reloadData];
    }
    else
    {
        isTeam = YES;
        isPlayer= NO;
        self.listTbl.hidden = YES;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(isTeam)
    {
        return self.teamlist.count;
    }
    else if(isPlayer)
    {
        return self.updatedplayerlist.count;
    }
    return nil;
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:nil];
        //cell.textColor = [UIColor blackColor];
    }
    
    if(isTeam)
    {
        
       // NSMutableArray *A1 = [[NSMutableArray alloc]init];
       // A1=[self.teamlist[indexPath.row] valueForKey:@"TeamName"];
        
        
        
        static NSString *CRTableViewCellIdentifier = @"cellIdentifier";
        
       
        CRTableViewCell *cell = (CRTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CRTableViewCellIdentifier];
        
        if (cell == nil) {
            cell = [[CRTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CRTableViewCellIdentifier];
        }
        
        
        teamcode = [self.teamcodelist objectAtIndex:indexPath.row];
        
        NSString *text = [self.teamlist[indexPath.row] valueForKey:@"TeamName"];
        cell.isSelected = [self.selectedMarks containsObject:teamcode] ? YES : NO;
        cell.textLabel.text = text;
        return cell;

        
    }
    
    if(isPlayer)
    {
        cell.textLabel.text = self.updatedplayerlist[indexPath.row] ;
        
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(isTeam)
    {
//        self.listTbl.hidden = YES;
//        self.teamlbl.text = [self.teamlist[indexPath.row] valueForKey:@"TeamName"];
//        teamcode = [self.teamlist[indexPath.row] valueForKey:@"TeamCode"];
//        NSLog(@"%@", teamcode);
        
        
        
        teamcode = [self.teamcodelist objectAtIndex:indexPath.row];
        if ([self.selectedMarks containsObject:teamcode])// Is selected?
            [self.selectedMarks removeObject:teamcode];
        else
            [self.selectedMarks addObject:teamcode];
        
        static NSString *CRTableViewCellIdentifier = @"cellIdentifier";
        
        CRTableViewCell *cell = (CRTableViewCell *)[self.multilistTbl dequeueReusableCellWithIdentifier:CRTableViewCellIdentifier];
        cell.isSelected = [self.selectedMarks containsObject:teamcode] ? YES : NO;
        
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        int a = self.selectedMarks.count;
        if(a == 0)
        {
            //NSString *b = [NSString stringWithFormat:@"%d", a];
            self.teamlbl.text = @"";
        }
        else if(a == 1)
        {
            //NSString *b = [NSString stringWithFormat:@"%d", a];
            self.teamlbl.text = [NSString stringWithFormat:@"%d item selected", a];
        }
        else
        {
            self.teamlbl.text = [NSString stringWithFormat:@"%d items selected", a];
        }

    }
    if(isPlayer)
    {
        self.listTbl.hidden = YES;
        self.playerlbl.text = self.updatedplayerlist[indexPath.row];
        
        
        teamplyCode = self.updatedplayercodes[indexPath.row];
        
    }
}

-(IBAction)SubmitAction:(id)sender
{
    
    self.commonview.hidden = YES;
    
}
-(IBAction)CancelAction:(id)sender
{
    
   self.commonview.hidden = YES;
    
}

-(IBAction)didClickcal:(id)sender
{
    
    [self DisplaydatePicker];
    
}

-(void)DisplaydatePicker
{
    if(datePicker!= nil)
    {
        [datePicker removeFromSuperview];
        
    }
    self.view_datepicker.hidden=NO;
    //isStartDate =YES;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    //   2016-06-25 12:00:00
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    
    datePicker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,self.view_datepicker.frame.origin.y-180,self.view.frame.size.width,100)];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [datePicker setLocale:locale];
    
    // [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    [datePicker reloadInputViews];
    [self.view_datepicker addSubview:datePicker];
    
}
-(IBAction)showSelecteddate:(id)sender{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *matchdate = [NSDate date];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    // for minimum date
    //[datePicker setMinimumDate:matchdate];
    
    // for maximumDate
    //int daysToAdd = 1;
    //NSDate *newDate1 = [matchdate dateByAddingTimeInterval:60*60*24*daysToAdd];
    
    //[datePicker setMaximumDate:newDate1];
    
    
    self.datelbl.text=[dateFormat stringFromDate:datePicker.date];
    
    //[dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    actualDate = [dateFormat stringFromDate:datePicker.date];
    
    
    
    NSLog(@"%@", actualDate);
    
    [self.view_datepicker setHidden:YES];
    [self dateWebservice];
    
}


-(void)dateWebservice
{
    
    [COMMON loadingIcon:self.view];
    NSString *playercde;
    NSString *date = actualDate;
    
    NSString *rolecode = [[NSUserDefaults standardUserDefaults]stringForKey:@"RoleCode"];
    
    if( [rolecode isEqualToString:@"ROL0000002"] )
    {
        playercde =self.selectPlayercode;
    }
    else
        
    {
        playercde = teamplyCode;
    }

    
    [objWebservice getdatelist :dateValidation :playercde :date success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject=%@",responseObject);
        if(responseObject >0)
        {
            NSString *sleeprating = [responseObject valueForKey:@"SleepRating"];
            NSString *fatiquerating = [responseObject valueForKey:@"FatigueRating"];
            NSString *musclerating = [responseObject valueForKey:@"SoreNessRating"];
            NSString *stressrating = [responseObject valueForKey:@"StreeRating"];
            
            
            workload = [responseObject valueForKey:@"WorkLoadCode"];
            
            
            
            
            if([[responseObject valueForKey:@"WorkLoadCode"] isEqual:[NSNull null]])
            {
                self.SUBMIT.hidden = NO;
                self.UPDATE.hidden = YES;
                self.REMOVE.hidden = YES;
                
                self.bottomBar.hidden = YES;
                
                self.sleepSlider.value =0;
                self.fatiqueSlider.value =0;
                self.muscleSlider.value =0;
                self.stressSlider.value =0;
                
                [self SleepSliderAction:0];
                [self FatiqueSliderAction:0];
                [self MuscleSliderAction:0];
                [self StressSliderAction:0];
                
                //[self.pieChartRight reloadData];
                [pieChartView reloadData];
                
                [self samplePieChart];
            
                
            }
            else
            {
                self.SUBMIT.hidden = YES;
                self.UPDATE.hidden = NO;
                self.REMOVE.hidden = NO;
                
                for( int i=0 ; self.sleeplist1.count>i;i++)
                {
                    if([[self.sleeplist1 objectAtIndex:i] isEqualToString:sleeprating])
                    {
                        NSString * sleepdesc = [responseObject valueForKey:@"SleepRatingDescription"];
                        
                        
                        NSString * a = [sleepdesc substringFromIndex:0];
                        int b = [a intValue];
                        
                        self.sleepSlider.value = b;
                        
                        // [self.sleepSlider addTarget:self action:@selector(SleepSliderAction:) forControlEvents:UIControlEventValueChanged];
                        [self SleepSliderAction:0];
                        
                        //[self samplePieChart];
                        
                    }
                    if([[self.fatiqlist1 objectAtIndex:i] isEqualToString:fatiquerating])
                    {
                        
                        NSString * fatiquedesc = [responseObject valueForKey:@"FatigueRatingDescription"];
                        
                        NSString * a = [fatiquedesc substringFromIndex:0];
                        int b = [a intValue];
                        
                        self.fatiqueSlider.value = b;
                        
                        // [self.fatiqueSlider addTarget:self action:@selector(FatiqueSliderAction:) forControlEvents:UIControlEventValueChanged];
                        [self FatiqueSliderAction:0];
                    }
                    if([[self.sorelist1 objectAtIndex:i] isEqualToString:musclerating])
                    {
                        
                        NSString * muscledesc = [responseObject valueForKey:@"SoreNessRatingDescription"];
                        
                        NSString * a = [muscledesc substringFromIndex:0];
                        int b = [a intValue];
                        
                        self.muscleSlider.value = b;
                        
                        // [self.muscleSlider addTarget:self action:@selector(MuscleSliderAction:) forControlEvents:UIControlEventValueChanged];
                        
                        [self MuscleSliderAction:0];
                        
                    }
                    if([[self.stresslist1 objectAtIndex:i] isEqualToString:stressrating])
                    {
                        
                        NSString * stressdesc = [responseObject valueForKey:@"StressRatingDescription"];
                        
                        NSString * a = [stressdesc substringFromIndex:0];
                        int b = [a intValue];
                        
                        self.stressSlider.value = b;
                        
                        // [self.stressSlider addTarget:self action:@selector(StressSliderAction:) forControlEvents:UIControlEventValueChanged];
                        
                        [self StressSliderAction:0];
                        
                        
                    }
                    
                    
                    
                    
                }
                
                
            }
            
        }
        
        [COMMON RemoveLoadingIcon];
        [self.view setUserInteractionEnabled:YES];
        
        //isgrid=NO;
        //[self.pop_view reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, id error) {
        NSLog(@"failed");
        [COMMON webServiceFailureError];
    }];
    
}

-(void)caluculateAction
{
    int a = [value1 intValue];
    int b = [value2 intValue];
    int c = [value3 intValue];
    int d = [value4 intValue];
    
    int Total = a+b+c+d;
    
    int per = (Total *100/28);
    
    
}


//-(void)setpiechartValues
//{
//    self.markers = [[NSMutableArray alloc]init];
//    //[self.markers addObject:@"value1"];
//
//
//    [self.pieChartRight setDataSource:self];
//    if(IS_IPHONE_DEVICE)
//    {
//        [self.pieChartRight setPieCenter:CGPointMake(60, 80)];
//    }
//    else{
//        [self.pieChartRight setPieCenter:CGPointMake(250, 150)];
//
//    }    [self.pieChartRight setShowPercentage:NO];
//    [self.pieChartRight reloadData];
//
//}

- (IBAction)SleepSliderAction:(id)sender {
    
    NSLog(@"%.f",self.sleepSlider.value);
   // value1 = [NSString stringWithFormat:@"%.f",self.sleepSlider.value];
    
    num1 = [self.sleepSlider value];
    
    NSLog(@"%f",num1);
    
    if(num1 ==0)
    {
        
        self.sleepPic.image = [UIImage imageNamed:@""];
        
    }
    
    if(num1 >0.1 && num1 <=1 )
    {
        self.sleepPic.image = [UIImage imageNamed:@"ico_smiley01"];
        
        metaSubCode1 = [self.sleeplist1 objectAtIndex:0];
        
        self.bottomBar.hidden = NO;
        
        
    }
    if(num1 >1.1 && num1 <= 2)
    {
        self.sleepPic.image = [UIImage imageNamed:@"ico_smiley02"];
        
        metaSubCode1 = [self.sleeplist1 objectAtIndex:1];
        self.bottomBar.hidden = NO;
    }
    
    if(num1 >2.1 && num1 <= 3)
    {
        self.sleepPic.image = [UIImage imageNamed:@"ico_smiley03"];
        
        metaSubCode1 = [self.sleeplist1 objectAtIndex:2];
        self.bottomBar.hidden = NO;
    }
    
    if(num1 > 3.1 && num1 <= 4 )
    {
        
        self.sleepPic.image = [UIImage imageNamed:@"ico_smiley04"];
        metaSubCode1 = [self.sleeplist1 objectAtIndex:3];
        self.bottomBar.hidden = NO;
    }
    
    if(num1 >4.1 && num1 <= 5 )
    {
        self.sleepPic.image = [UIImage imageNamed:@"ico_smiley05"];
        metaSubCode1 = [self.sleeplist1 objectAtIndex:4];
        self.bottomBar.hidden = NO;
    }
    if(num1 >5.1 && num1 <= 6)
    {
        self.sleepPic.image = [UIImage imageNamed:@"ico_smiley06"];
        metaSubCode1 = [self.sleeplist1 objectAtIndex:5];
        self.bottomBar.hidden = NO;
    }
    if(num1 >6.1 && num1 <= 7)
    {
        self.sleepPic.image = [UIImage imageNamed:@"ico_smiley07"];
        metaSubCode1 = [self.sleeplist1 objectAtIndex:6];
        self.bottomBar.hidden = NO;
    }
    
    //[self.markers replaceObjectAtIndex:0 withObject:value1];
    
    value1 = [NSString stringWithFormat:@"%f",num1];
    NSLog(@"%@", value1);
    [self.markers replaceObjectAtIndex:0 withObject:value1];
    
       [pieChartView reloadData];
    
    
}

- (IBAction)FatiqueSliderAction:(id)sender {
    
    
    num2 = [self.fatiqueSlider value];
   
    
    NSLog(@"%f",num2);
    
    if(num2 ==0)
    {
        
        self.fatiquePic.image = [UIImage imageNamed:@""];
        
    }
    
    if(num2 >0.1 && num2 <=1 )
    {
        self.fatiquePic.image = [UIImage imageNamed:@"ico_smiley01"];
        
        metaSubCode2 = [self.fatiqlist1 objectAtIndex:0];
        
        self.bottomBar.hidden = NO;
        
        
    }
    if(num2 >1.1 && num2 <= 2)
    {
        self.fatiquePic.image = [UIImage imageNamed:@"ico_smiley02"];
        
        metaSubCode2 = [self.fatiqlist1 objectAtIndex:1];
        self.bottomBar.hidden = NO;
    }
    
    if(num2 >2.1 && num2 <= 3)
    {
        self.fatiquePic.image = [UIImage imageNamed:@"ico_smiley03"];
        
        metaSubCode2 = [self.fatiqlist1 objectAtIndex:2];
        self.bottomBar.hidden = NO;
    }
    
    if(num2 > 3.1 && num2 <= 4 )
    {
        
        self.fatiquePic.image = [UIImage imageNamed:@"ico_smiley04"];
        metaSubCode2 = [self.fatiqlist1 objectAtIndex:3];
        self.bottomBar.hidden = NO;
    }
    
    if(num2 >4.1 && num2 <= 5 )
    {
        self.fatiquePic.image = [UIImage imageNamed:@"ico_smiley05"];
        metaSubCode2 = [self.fatiqlist1 objectAtIndex:4];
        self.bottomBar.hidden = NO;
    }
    if(num2 >5.1 && num2 <= 6)
    {
        self.fatiquePic.image = [UIImage imageNamed:@"ico_smiley06"];
        metaSubCode2 = [self.fatiqlist1 objectAtIndex:5];
        self.bottomBar.hidden = NO;
    }
    if(num2 >6.1 && num2 <= 7)
    {
        self.fatiquePic.image = [UIImage imageNamed:@"ico_smiley07"];
        metaSubCode2 = [self.fatiqlist1 objectAtIndex:6];
        self.bottomBar.hidden = NO;
    }
    
    //[self.markers replaceObjectAtIndex:0 withObject:value1];
    
    value2 = [NSString stringWithFormat:@"%f",num2];
    NSLog(@"%@", value2);
    [self.markers replaceObjectAtIndex:1 withObject:value2];
    
    [pieChartView reloadData];
    
}

- (IBAction)MuscleSliderAction:(id)sender {
    
    
    num3 = [self.muscleSlider value];
    NSLog(@"%f",num2);
    
    if(num3 ==0)
    {
        
        self.musclePic.image = [UIImage imageNamed:@""];
        
    }
    
    if(num3 >0.1 && num3 <=1 )
    {
        self.musclePic.image = [UIImage imageNamed:@"ico_smiley01"];
        
        metaSubCode3 = [self.sorelist1 objectAtIndex:0];
        
        self.bottomBar.hidden = NO;
        
        
    }
    if(num3 >1.1 && num3 <= 2)
    {
        self.musclePic.image = [UIImage imageNamed:@"ico_smiley02"];
        
        metaSubCode3 = [self.sorelist1 objectAtIndex:1];
        self.bottomBar.hidden = NO;
    }
    
    if(num3 >2.1 && num3 <= 3)
    {
        self.musclePic.image = [UIImage imageNamed:@"ico_smiley03"];
        
        metaSubCode3 = [self.sorelist1 objectAtIndex:2];
        self.bottomBar.hidden = NO;
    }
    
    if(num3 > 3.1 && num3 <= 4 )
    {
        
        self.musclePic.image = [UIImage imageNamed:@"ico_smiley04"];
        metaSubCode3 = [self.sorelist1 objectAtIndex:3];
        self.bottomBar.hidden = NO;
    }
    
    if(num3 >4.1 && num3 <= 5 )
    {
        self.musclePic.image = [UIImage imageNamed:@"ico_smiley05"];
        metaSubCode3 = [self.sorelist1 objectAtIndex:4];
        self.bottomBar.hidden = NO;
    }
    if(num3 >5.1 && num3 <= 6)
    {
        self.musclePic.image = [UIImage imageNamed:@"ico_smiley06"];
        metaSubCode3 = [self.sorelist1 objectAtIndex:5];
        self.bottomBar.hidden = NO;
    }
    if(num3 >6.1 && num3 <= 7)
    {
        self.musclePic.image = [UIImage imageNamed:@"ico_smiley07"];
        metaSubCode3 = [self.sorelist1 objectAtIndex:6];
        self.bottomBar.hidden = NO;
    }
    
    //[self.markers replaceObjectAtIndex:0 withObject:value1];
    
    value3 = [NSString stringWithFormat:@"%f",num3];
    NSLog(@"%@", value3);
    [self.markers replaceObjectAtIndex:2 withObject:value3];
    
    [pieChartView reloadData];
    
    
}
- (IBAction)StressSliderAction:(id)sender {

    num4 = [self.stressSlider value];
    NSLog(@"%f",num4);
    
    if(num4 ==0)
    {
        
        self.stressPic.image = [UIImage imageNamed:@""];
        
    }
    
    if(num4 >0.1 && num4 <=1 )
    {
        self.stressPic.image = [UIImage imageNamed:@"ico_smiley01"];
        
        metaSubCode4 = [self.stresslist1 objectAtIndex:0];
        
        self.bottomBar.hidden = NO;
        
        
    }
    if(num4 >1.1 && num4 <= 2)
    {
        self.stressPic.image = [UIImage imageNamed:@"ico_smiley02"];
        
        metaSubCode4 = [self.stresslist1 objectAtIndex:1];
        self.bottomBar.hidden = NO;
    }
    
    if(num4 >2.1 && num4 <= 3)
    {
        self.stressPic.image = [UIImage imageNamed:@"ico_smiley03"];
        
        metaSubCode4 = [self.stresslist1 objectAtIndex:2];
        self.bottomBar.hidden = NO;
    }
    
    if(num4 > 3.1 && num4 <= 4 )
    {
        
        self.stressPic.image = [UIImage imageNamed:@"ico_smiley04"];
        metaSubCode4 = [self.stresslist1 objectAtIndex:3];
        self.bottomBar.hidden = NO;
    }
    
    if(num4 >4.1 && num4 <= 5 )
    {
        self.stressPic.image = [UIImage imageNamed:@"ico_smiley05"];
        metaSubCode4 = [self.stresslist1 objectAtIndex:4];
        self.bottomBar.hidden = NO;
    }
    if(num4 >5.1 && num4 <= 6)
    {
        self.stressPic.image = [UIImage imageNamed:@"ico_smiley06"];
        metaSubCode4 = [self.stresslist1 objectAtIndex:5];
        self.bottomBar.hidden = NO;
    }
    if(num4 >6.1 && num4 <= 7)
    {
        self.stressPic.image = [UIImage imageNamed:@"ico_smiley07"];
        metaSubCode4 = [self.stresslist1 objectAtIndex:6];
        self.bottomBar.hidden = NO;
    }
    
    //[self.markers replaceObjectAtIndex:0 withObject:value1];
    
    value4 = [NSString stringWithFormat:@"%f",num4];
    NSLog(@"%@", value4);
    [self.markers replaceObjectAtIndex:3 withObject:value4];

    [pieChartView reloadData];

    
}


#pragma mark - XYPieChart Data Source

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    return  self.markers.count;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    return [[ self.markers objectAtIndex:index] intValue];
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    
    return 0;  //[self.sliceColors objectAtIndex:(index % self.sliceColors.count)];
}

#pragma mark - XYPieChart Delegate
- (void)pieChart:(XYPieChart *)pieChart willSelectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"will select slice at index %d",index);
}
- (void)pieChart:(XYPieChart *)pieChart willDeselectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"will deselect slice at index %d",index);
}
- (void)pieChart:(XYPieChart *)pieChart didDeselectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"did deselect slice at index %d",index);
}
- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"did select slice at index %d",index);
    
}
- (IBAction)updateAction:(id)sender {
    
    [self updateWebservice];
}

- (IBAction)submitAction:(id)sender {
    
    if([self.teamlbl.text isEqualToString:@""])
    {
        [self ShowAlterMsg:@"Please Select Team"];
    }
    else if([self.playerlbl.text isEqualToString:@""])
    {
        [self ShowAlterMsg:@"Please Select Player"];
    }
    else if([self.datelbl.text isEqualToString:@""])
    {
        [self ShowAlterMsg:@"Please Select Date"];
    }
    else if(self.sleepSlider.value ==0)
    {
        [self ShowAlterMsg:@"Please Select Sleep"];
    }
    else if(self.fatiqueSlider.value ==0)
    {
        [self ShowAlterMsg:@"Please Select Fatique"];
    }
    else if(self.muscleSlider.value ==0)
    {
        [self ShowAlterMsg:@"Please Select MuscleSoreness"];
    }
    else if(self.stressSlider.value ==0)
    {
        [self ShowAlterMsg:@"Please Select Stress"];
    }
    else
    {
        [self submitWebservice];
        
        self.sleepSlider.value =0;
        self.fatiqueSlider.value =0;
        self.muscleSlider.value =0;
        self.stressSlider.value =0;
        
        [self SleepSliderAction:0];
        [self FatiqueSliderAction:0];
        [self MuscleSliderAction:0];
        [self StressSliderAction:0];
        
        self.datelbl.text = @"";

    }
    self.bottomBar.hidden = YES;
    
}
- (IBAction)removeAction:(id)sender {
    
    [self removeWebservice];
}

-(void)submitWebservice
{
    [COMMON loadingIcon:self.view];
    NSString *cliendcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    NSString *usercode = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
    NSString *date = actualDate;
    //NSString *playercode = self.selectPlayercode;
    
    
    NSString *playercde;
    NSString *rolecode = [[NSUserDefaults standardUserDefaults]stringForKey:@"RoleCode"];
    
    if( [rolecode isEqualToString:@"ROL0000002"] )
    {
        playercde =self.selectPlayercode;
    }
    else
        
    {
        playercde = teamplyCode;
    }

    
    [objWebservice submit :recordInsert :cliendcode :usercode:date:playercde:metaSubCode1:metaSubCode2:metaSubCode3:metaSubCode4 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject=%@",responseObject);
        if(responseObject >0)
        {
            BOOL Status = [responseObject valueForKey:@"Status"];
            if(Status == YES)
            {
                NSLog(@"success");
                [self ShowAlterMsg:@"Wellness Rating Inserted Successfully"];
                
                // [self.pieChartRight reloadData];
            }
            
        }
        
        [COMMON RemoveLoadingIcon];
        [self.view setUserInteractionEnabled:YES];

        
    }
        failure:^(AFHTTPRequestOperation *operation, id error) {
        NSLog(@"failed");
        [COMMON webServiceFailureError];
    }];
    
}
-(void)ShowAlterMsg:(NSString*) MsgStr
{
    UIAlertView *objAlter =[[UIAlertView alloc]initWithTitle:@"" message:MsgStr delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [objAlter show];
    
}

-(void)updateWebservice
{
   
    [COMMON loadingIcon:self.view];
    // NSString *cliendcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    
    NSString *usercode = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
    
    
    NSString *date = actualDate;
    NSString *playercde;
    
    NSString *rolecode = [[NSUserDefaults standardUserDefaults]stringForKey:@"RoleCode"];
    
    if( [rolecode isEqualToString:@"ROL0000002"] )
    {
        playercde =self.selectPlayercode;
    }
    else
        
    {
        playercde = teamplyCode;
    }

    //NSString *playercode = self.selectPlayercode;
    
    
    
    [objWebservice getupdate :updateRecord :usercode:workload :date:playercde: metaSubCode1 :metaSubCode2:metaSubCode3:metaSubCode4 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject=%@",responseObject);
        if(responseObject >0)
        {
            BOOL Status = [responseObject valueForKey:@"Status"];
            if(Status == YES)
            {
                
                
                NSLog(@"success");
                [self ShowAlterMsg:@"Wellness Rating Updated Successfully"];
                
                self.sleepSlider.value =0;
                self.fatiqueSlider.value =0;
                self.muscleSlider.value =0;
                self.stressSlider.value =0;
                
                [self SleepSliderAction:0];
                [self FatiqueSliderAction:0];
                [self MuscleSliderAction:0];
                [self StressSliderAction:0];
                
                self.datelbl.text = @"";
                self.bottomBar.hidden = YES;
                self.UPDATE.hidden = YES;
                self.REMOVE.hidden = YES;
                self.SUBMIT.hidden = NO;
                
                // [self.pieChartRight reloadData];
            }
            
        }
        
        [COMMON RemoveLoadingIcon];
        [self.view setUserInteractionEnabled:YES];

        
    } failure:^(AFHTTPRequestOperation *operation, id error) {
        NSLog(@"failed");
        [COMMON webServiceFailureError];
    }];
    
}
-(void)removeWebservice
{
    
    [COMMON loadingIcon:self.view];
    // NSString *cliendcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    
    NSString *usercode = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
    
    [objWebservice getremove:removeRecord :usercode:workload  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject=%@",responseObject);
        if(responseObject >0)
        {
            BOOL Status = [responseObject valueForKey:@"Status"];
            if(Status == YES)
            {
                
                
                NSLog(@"success");
                [self ShowAlterMsg:@"Wellness Rating Removed Successfully"];
                
                self.sleepSlider.value =0;
                self.fatiqueSlider.value =0;
                self.muscleSlider.value =0;
                self.stressSlider.value =0;
                
                [self SleepSliderAction:0];
                [self FatiqueSliderAction:0];
                [self MuscleSliderAction:0];
                [self StressSliderAction:0];
                
                self.datelbl.text = @"";
                self.bottomBar.hidden = YES;
                self.UPDATE.hidden = YES;
                self.REMOVE.hidden = YES;
                self.SUBMIT.hidden = NO;
                
                //[self.pieChartRight reloadData];
            }
            
        }
        
        
        [COMMON RemoveLoadingIcon];
        [self.view setUserInteractionEnabled:YES];

        
    } failure:^(AFHTTPRequestOperation *operation, id error) {
        NSLog(@"failed");
        [COMMON webServiceFailureError];
    }];
    
}

-(IBAction)MenuBtnAction:(id)sender
{
    [COMMON ShowsideMenuView];
}
-(IBAction)btn_back:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(IBAction)HomeBtnAction:(id)sender
{
    HomeVC  * objTabVC=[[HomeVC alloc]init];
    objTabVC = (HomeVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
    [self.navigationController pushViewController:objTabVC animated:YES];
    
    
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
