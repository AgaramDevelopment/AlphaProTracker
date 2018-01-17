//
//  PlannerVC.m
//  AlphaProTracker
//
//  Created by Mac on 28/08/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "PlannerVC.h"
#import "CustomNavigation.h"
#import "SACalendar.h"
#import "DateUtil.h"
#import "PlannerAddEvent.h"
#import "AppCommon.h"
#import "Config.h"
#import "WebService.h"
#import "PlannerListVC.h"
#import "HomeVC.h"

#import "FFCalendarViewController.h"
#import "FFCalendar.h"

#import "EventRecord.h"
#import "FFBlueButton.h"



typedef enum : NSUInteger
{
    CalendarViewWeekType  = 0,
    CalendarViewMonthType = 2,
    //CalendarViewYearType = 2,
    CalendarViewDayType = 1
} CalendarViewType;


@interface PlannerVC ()<SACalendarDelegate,FFButtonAddEventWithPopoverProtocol, FFYearCalendarViewProtocol, FFMonthCalendarViewProtocol, FFWeekCalendarViewProtocol, FFDayCalendarViewProtocol>

{
    BOOL isEvent;
    SACalendar *saCalendar;
    NSString *usercode;
    NSString *cliendcode;
    NSString *userref;
    NSDate *date1;
    NSDate *dateFromString;
    
    NSString *EventBgcolor;
}




@property (nonatomic) BOOL boolDidLoad;
@property (nonatomic) BOOL boolYearViewIsShowing;
@property (nonatomic, strong) NSMutableDictionary *dictEvents;
@property (nonatomic, strong) UILabel *labelWithMonthAndYear;
@property (nonatomic, strong) NSArray *arrayButtons;
@property (nonatomic, strong) NSArray *arrayCalendars;
@property (nonatomic, strong) FFEditEventPopoverController *popoverControllerEditar;
@property (nonatomic, strong) FFYearCalendarView *viewCalendarYear;
@property (nonatomic, strong) FFMonthCalendarView *viewCalendarMonth;
@property (nonatomic, strong) FFWeekCalendarView *viewCalendarWeek;
@property (nonatomic, strong) FFDayCalendarView *viewCalendarDay;








@property (nonatomic,strong) WebService * objWebservice;

@property (nonatomic,strong) IBOutlet UIView * titleview;
@property (nonatomic,strong) IBOutlet UIView * eventview;

@property (nonatomic,strong) IBOutlet UITableView * eventTbl;

@property (nonatomic,strong) IBOutlet UILabel * eventLbl;
@property (nonatomic,strong) NSMutableArray * AllEventListArray;
@property (nonatomic,strong) NSMutableArray * AllEventDetailListArray;
@property (nonatomic,strong) NSMutableArray * ParticipantsTypeArray;
@property (nonatomic,strong) NSMutableArray * PlayerTeamArray;
@property (nonatomic,strong) NSMutableArray * EventStatusArray;
@property (nonatomic,strong) NSMutableArray * EventTypeArray;

@property (nonatomic,strong) NSMutableArray * eventArray;

@property (nonatomic,strong) IBOutlet UIButton * selectTitleBtn;

@property (nonatomic,strong) IBOutlet UILabel * Tabbar;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * TabbarPosition;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * TabbarWidth;

@end

@implementation PlannerVC
@synthesize boolDidLoad;
@synthesize boolYearViewIsShowing;
@synthesize protocol;
@synthesize arrayWithEvents;
@synthesize dictEvents;
@synthesize labelWithMonthAndYear;
@synthesize arrayButtons;
@synthesize arrayCalendars;
@synthesize popoverControllerEditar;
@synthesize viewCalendarYear;
@synthesize viewCalendarMonth;
@synthesize viewCalendarWeek;
@synthesize viewCalendarDay;


#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.TabbarPosition.constant = self.MONTH.frame.origin.x;
        self.TabbarWidth.constant = self.MONTH.frame.size.width;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[COMMON AddMenuView:self.view];
    self.nameOfMonth.text = @"";
    [self customnavigationmethod];
    
    self.eventTbl.hidden =YES;
    
    self.objWebservice =[[WebService alloc]init];
    
    usercode = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
    
    cliendcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    
    userref = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
    
    self.Tabbar.hidden = YES;
    
    [self EventTypeWebservice :usercode:cliendcode:userref];
    
    self.TabbarPosition.constant = self.MONTH.frame.origin.x;
    self.TabbarWidth.constant = self.MONTH.frame.size.width;
    
    
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dateChanged:) name:DATE_MANAGER_DATE_CHANGED object:nil];
//    
//    [self customNavigationBarLayout];
//    
//    [self addCalendars];
//    //[self displayFFCalendar];
//    
//    [self buttonYearMonthWeekDayAction:[arrayButtons objectAtIndex:0]];
    
//    saCalendar = [[SACalendar alloc]initWithFrame:CGRectMake(self.titleview.frame.origin.x,self.titleview.frame.origin.y+self.titleview.frame.size.height+27,self.view.frame.size.width,self.view.frame.size.height-340) scrollDirection:ScrollDirectionVertical pagingEnabled:NO];
//
    self.Tabbar.hidden = NO;
    self.TabbarPosition.constant = self.MONTH.frame.origin.x;
    self.TabbarWidth.constant = self.MONTH.frame.size.width;
//    saCalendar.delegate = self;
//    [self.view addSubview:saCalendar];


}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!boolDidLoad) {
        boolDidLoad = YES;
        [self buttonTodayAction:nil];
    }

//    [self EventTypeWebservice :usercode:cliendcode:userref];
    self.TabbarPosition.constant = self.MONTH.frame.origin.x;
    self.TabbarWidth.constant = self.MONTH.frame.size.width;
    
        [COMMON AddMenuView:self.view];

    
}

-(IBAction)MonthAction:(id)sender
{
    
    self.Tabbar.hidden = NO;
    self.nameOfMonth.text = @"";
    
    
    usercode = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
    
    cliendcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    
    userref = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
//    [self EventTypeWebservice :usercode:cliendcode:userref];
    [self addMonthCalendar];
    [self setArrayWithEvents:[self arrayWithEvents]];

    self.TabbarPosition.constant = self.MONTH.frame.origin.x;
    self.TabbarWidth.constant = self.MONTH.frame.size.width;
    
}

-(IBAction)WeekAction:(id)sender
{
    
    self.Tabbar.hidden = NO;
    
      self.TabbarPosition.constant = self.WEEK.frame.origin.x;
      self.TabbarWidth.constant = self.WEEK.frame.size.width;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dateChanged:) name:DATE_MANAGER_DATE_CHANGED object:nil];
        [self customNavigationBarLayout];
        [self addCalendarWeek];
        //[self displayFFCalendar];
//     PlannerVC *calendarVc = [PlannerVC new];
//     [calendarVc setProtocol:self];
     //[self setArrayWithEvents:[self arrayWithEvents]];
     [self setArrayWithEvents:[self arrayWithEvents]];
    [self buttonYearMonthWeekDayAction:[arrayButtons objectAtIndex:0]];
    
}

-(IBAction)DayAction:(id)sender
{
    self.Tabbar.hidden = NO;
    self.TabbarPosition.constant = self.DAY.frame.origin.x;
    self.TabbarWidth.constant = self.DAY.frame.size.width;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dateChanged:) name:DATE_MANAGER_DATE_CHANGED object:nil];
    [self customNavigationBarLayout];
    [self addCalendarDay];
    //[self displayFFCalendar];
    [self buttonYearMonthWeekDayAction:[arrayButtons objectAtIndex:0]];
    
}



-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    
    
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"";
    
    if([self.check isEqualToString:@"main"])
    {
        objCustomNavigation.btn_back.hidden =NO;
        objCustomNavigation.menu_btn.hidden =YES;
        [objCustomNavigation.btn_back addTarget:self action:@selector(didClickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
        [objCustomNavigation.menu_btn addTarget:self action:@selector(MenuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        objCustomNavigation.btn_back.hidden =YES;
        objCustomNavigation.menu_btn.hidden =NO;
        [objCustomNavigation.btn_back addTarget:self action:@selector(didClickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
        [objCustomNavigation.menu_btn addTarget:self action:@selector(MenuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}
/**
 *  Delegate method : get called when a date is selected
 */
-(void) SACalendar:(SACalendar*)calendar didSelectDate:(int)day month:(int)month year:(int)year
{
   // NSString * selectdate =[NSString stringWithFormat:@"%d-%02d-%02d",year,month,day];
    NSString * selectdate =[NSString stringWithFormat:@"%02d/%02d/%d",day,month,year];

    //NSString *finalDate = @"2017-10-15";
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    //NSDate *datess = [dateFormatter dateFromString:selectdate];
    
    NSString * selectdate1 =[NSString stringWithFormat:@"%02d/%02d/%d",day+1,month,year];
    NSDate *datess = [dateFormatter dateFromString:selectdate1];
    NSDate *today = [NSDate date]; // it will give you current date
    
    NSMutableArray * ojAddPlannerArray =[[NSMutableArray alloc]init];
    for(int i=0; self.AllEventDetailListArray.count>i;i++)
    {
        NSDictionary * objDic =[self.AllEventDetailListArray objectAtIndex:i];
        NSString * startdate =[objDic valueForKey:@"startdatetime"];
        NSDateFormatter *dateFormatters = [[NSDateFormatter alloc] init];
        [dateFormatters setDateFormat:@"dd/MM/yyyy hh:mm a"];
        NSDate *dates = [dateFormatters dateFromString:startdate];
        
        NSDateFormatter* dfs = [[NSDateFormatter alloc]init];
        [dfs setDateFormat:@"dd/MM/yyyy"];
        NSString * endDateStr = [dfs stringFromDate:dates];
        
        if([endDateStr isEqualToString:selectdate])
        {
            [ojAddPlannerArray addObject:objDic];
        }
    }

    
    
    NSComparisonResult result;
    //has three possible values: NSOrderedSame,NSOrderedDescending, NSOrderedAscending
    
    result = [today compare:datess]; // comparing two dates
    
    if(result==NSOrderedAscending)
    {
        NSLog(@"today is less");
        
        if(ojAddPlannerArray.count>0)
        {
            PlannerListVC  * objPlannerlist=[[PlannerListVC alloc]init];
            objPlannerlist = (PlannerListVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"PlannerList"];
            objPlannerlist.objPlannerArray =ojAddPlannerArray;
            [self.navigationController pushViewController:objPlannerlist animated:YES];
        }
        
        else
        {
        PlannerAddEvent  * objaddEvent=[[PlannerAddEvent alloc]init];
        objaddEvent = (PlannerAddEvent *)[self.storyboard instantiateViewControllerWithIdentifier:@"AddEvent"];
        objaddEvent.selectDateStr =selectdate;
            objaddEvent.isEdit =NO;
        objaddEvent.ListeventTypeArray = self.EventTypeArray;
        objaddEvent.ListeventStatusArray =self.EventStatusArray;
        objaddEvent.ListparticipantTypeArray =self.ParticipantsTypeArray;
        
        [self.navigationController pushViewController:objaddEvent animated:YES];
        }
    }
    
    else if(result==NSOrderedDescending)
    {
        if(ojAddPlannerArray.count>0)
        {
            PlannerListVC  * objPlannerlist=[[PlannerListVC alloc]init];
            objPlannerlist = (PlannerListVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"PlannerList"];
            objPlannerlist.objPlannerArray =ojAddPlannerArray;
            [self.navigationController pushViewController:objPlannerlist animated:YES];
        }
        else{
        NSLog(@"newDate is less");
        UIAlertView * objAlt =[[UIAlertView alloc]initWithTitle:@"Planner" message:@"Past date not allowed!!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [objAlt show];
        }
    }
    else
        NSLog(@"Both dates are same");
    
    
}

/**
 *  Delegate method : get called user has scroll to a new month
 */
//-(void) SACalendar:(SACalendar *)calendar didDisplayCalendarForMonth:(int)month year:(int)year{
//
//    NSLog(@"Displaying : %@ %04i",[DateUtil getMonthString:month],year);
//}

-(IBAction)didClickevent:(id)sender
{
    if(isEvent==NO)
    {
        self.eventTbl.hidden =NO;
        isEvent=YES;

       // [self EventTypeWebservice :usercode:cliendcode:userref];
    }
    else{
        self.eventTbl.hidden =YES;
        isEvent =NO;
    }
}
-(void)EventTypeWebservice:(NSString *) usercode :(NSString*) cliendcode:(NSString *)userreference
{
    [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",PlannerEventKey]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(usercode)   [dic    setObject:usercode     forKey:@"CreatedBy"];
        if(cliendcode)   [dic    setObject:cliendcode     forKey:@"ClientCode"];
        if(userreference)   [dic    setObject:userreference     forKey:@"Userreferencecode"];
        
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                NSLog(@"%@",responseObject);
                self.AllEventListArray = [[NSMutableArray alloc]init];
                
                NSMutableArray * objAlleventArray= [responseObject valueForKey:@"ListEventTypeDetails"];
                
                
                NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc]init];
                [mutableDict setObject:@"" forKey:@"EventTypeColor"];
                [mutableDict setObject:@"" forKey:@"EventTypeCode"];
                [mutableDict setObject:@"All EVENT" forKey:@"EventTypename"];
                
                [self.AllEventListArray insertObject:mutableDict atIndex:0];
                [self.AllEventListArray addObjectsFromArray:objAlleventArray];
                
//                [self.AllEventListArray addObject:mutableDict];
//                for(int i=0; objAlleventArray.count>i;i++)
//                {
//                    NSMutableDictionary * objDic =[objAlleventArray objectAtIndex:i];
//                    [self.AllEventListArray addObject:objDic];
//                }
                
                self.ParticipantsTypeArray =[[NSMutableArray alloc]init];
                self.ParticipantsTypeArray=[responseObject valueForKey:@"ListParticipantsTypeDetails"];
                
                self.PlayerTeamArray =[[NSMutableArray alloc]init];
                self.PlayerTeamArray =[responseObject valueForKey:@"ListPlayerTeamDetails"];
                
                self.EventTypeArray  =[[NSMutableArray alloc]init];
                self.EventTypeArray =[responseObject valueForKey:@"ListEventTypeDetails"];
                
                self.EventStatusArray =[[NSMutableArray alloc]init];
                self.EventStatusArray =[responseObject valueForKey:@"ListEventStatusDetails"];
                
                
            }
            
            [COMMON RemoveLoadingIcon];
            [self.view setUserInteractionEnabled:YES];
            [self.eventTbl reloadData];
            
            NSDate *now = [NSDate date];
            NSDate *startDate = [now dateByAddingTimeInterval:-30*24*60*60];
            NSDateFormatter* df = [[NSDateFormatter alloc]init];
            [df setDateFormat:@"MM-dd-YYYY hh:mm:ss a"];
            NSString *startDateStr = [df stringFromDate:startDate];
            
            
            NSDate *enddate = [now dateByAddingTimeInterval:30*24*60*60];
            NSDateFormatter* dfs = [[NSDateFormatter alloc]init];
            [dfs setDateFormat:@"MM-dd-YYYY hh:mm:ss a"];
            NSString * endDateStr = [dfs stringFromDate:enddate];
            
            NSString *usercode = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
            
            NSString *cliendcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
            
            [self EventDateFetchMethod :startDateStr:endDateStr:cliendcode:usercode];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed");
            [COMMON webServiceFailureError];
            [self.view setUserInteractionEnabled:YES];
            
        }];
    }
    
}

-(void)EventDateFetchMethod :(NSString *)startDate :(NSString *) endDate :(NSString *)cliendCode :(NSString *)createdby
{
    [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",EventDateFetch]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(startDate)   [dic    setObject:startDate     forKey:@"start"];
        if(endDate)   [dic    setObject:endDate     forKey:@"end"];
        if(cliendCode)   [dic    setObject:cliendCode     forKey:@"Clientcode"];
        if(createdby)   [dic    setObject:createdby     forKey:@"CreatedBy"];
        
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                NSLog(@"%@",responseObject);
                self.AllEventDetailListArray = [[NSMutableArray alloc]init];
            
//                self.eventArray =[[NSMutableArray alloc]init];
//                self.eventArray=[responseObject valueForKey:@"lstEventDetailsEntity"];
//                self.AllEventDetailListArray = self.eventArray;
                [self.AllEventDetailListArray addObjectsFromArray:[responseObject valueForKey:@"lstEventDetailsEntity"]];
                
//                saCalendar = [[SACalendar alloc]initWithFrame:CGRectMake(self.titleview.frame.origin.x,self.titleview.frame.origin.y+self.titleview.frame.size.height+27,self.view.frame.size.width,self.view.frame.size.height-340) scrollDirection:ScrollDirectionVertical pagingEnabled:NO];
//
//                self.Tabbar.hidden = NO;
//                self.TabbarPosition.constant = self.MONTH.frame.origin.x;
//                self.TabbarWidth.constant = self.MONTH.frame.size.width;
////
////
//               saCalendar.delegate = self;
//
//                [self.view addSubview:saCalendar];
                
//                if(![self.AllEventDetailListArray isEqual: [NSNull null]])
//                {
//                    [saCalendar SetEventTitle:self.AllEventDetailListArray];
//                }
//
//                [self setArrayWithEvents:[self arrayWithEvents]];
                [self MonthAction:nil];
                
                
            }
            
            
            [COMMON RemoveLoadingIcon];
            [self.view setUserInteractionEnabled:YES];
            // [self.eventTbl reloadData];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed");
            [COMMON webServiceFailureError];
            [self.view setUserInteractionEnabled:YES];
            
        }];
    }
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.AllEventListArray count];    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier];
    }
    
    if(indexPath.row ==0)
    {
        cell.backgroundColor=[UIColor colorWithRed:(37/255.0f) green:(187/255.0f) blue:(151/255.0f) alpha:1.0f];
        self.eventview.backgroundColor =[UIColor colorWithRed:(37/255.0f) green:(187/255.0f) blue:(151/255.0f) alpha:1.0f];
    }
    else if(indexPath.row ==1)
    {
        cell.backgroundColor=[UIColor colorWithRed:(42/255.0f) green:(151/255.0f) blue:(243/255.0f) alpha:1.0f];
        //self.eventview.backgroundColor = [UIColor colorWithRed:(42/255.0f) green:(151/255.0f) blue:(243/255.0f) alpha:1.0f];
    }
    else if(indexPath.row ==2)
    {
        cell.backgroundColor=[UIColor colorWithRed:(247/255.0f) green:(116/255.0f) blue:(159/255.0f) alpha:1.0f];
        
    }
    else if(indexPath.row ==3)
    {
        cell.backgroundColor=[UIColor colorWithRed:(215/255.0f) green:(163/255.0f) blue:(69/255.0f) alpha:1.0f];
        
    }
    else if(indexPath.row ==4)
    {
        cell.backgroundColor=[UIColor colorWithRed:(162/255.0f) green:(99/255.0f) blue:(28/255.0f) alpha:1.0f];
        
    }
    else if(indexPath.row ==5)
    {
        cell.backgroundColor=[UIColor colorWithRed:(90/255.0f) green:(181/255.0f) blue:(96/255.0f) alpha:1.0f];
        
    }
    else if(indexPath.row ==6)
    {
        cell.backgroundColor=[UIColor colorWithRed:(60/255.0f) green:(172/255.0f) blue:(206/255.0f) alpha:1.0f];
        
    }
    else if(indexPath.row ==7)
    {
        cell.backgroundColor=[UIColor colorWithRed:(207/255.0f) green:(134/255.0f) blue:(46/255.0f) alpha:1.0f];
        
    }
    else if (indexPath.row ==8)
    {
        cell.backgroundColor=[UIColor colorWithRed:(71/255.0f) green:(30/255.0f) blue:(102/255.0f) alpha:1.0f];
        
    }
    else if (indexPath.row ==9)
    {
        cell.backgroundColor=[UIColor colorWithRed:(193/255.0f) green:(73/255.0f) blue:(74/255.0f) alpha:1.0f];
        
    }
    else
    {
        cell.backgroundColor=[UIColor colorWithRed:(97/255.0f) green:(50/255.0f) blue:(139/255.0f) alpha:1.0f];
        
    }
    
    
    cell.textLabel.text = [[self.AllEventListArray valueForKey:@"EventTypename"] objectAtIndex:indexPath.row];
    cell.textLabel.textColor =[UIColor whiteColor];
    self.eventLbl.text = [[self.AllEventListArray valueForKey:@"EventTypename"] objectAtIndex:0];
    
    //cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * selectStr = [[self.AllEventListArray valueForKey:@"EventTypename"] objectAtIndex:indexPath.row];
    NSString * eventTypeCode =[[self.AllEventListArray valueForKey:@"EventTypeCode"] objectAtIndex:indexPath.row];
    self.eventLbl.text = selectStr;
    self.eventTbl.hidden =YES;
    isEvent =NO;

    self.AllEventDetailListArray = [[NSMutableArray alloc]init];
    for(int i=0;self.eventArray.count>i;i++)
    {
        NSDictionary * objDic =[self.eventArray objectAtIndex:i];
        NSString * eventType = [objDic valueForKey:@"eventtype"];
        if([eventTypeCode isEqualToString:eventType])
        {
            [self.AllEventDetailListArray addObject:objDic];
        }
    }
    
    saCalendar = [[SACalendar alloc]initWithFrame:CGRectMake(self.titleview.frame.origin.x,self.titleview.frame.origin.y+self.titleview.frame.size.height+5,self.view.frame.size.width,self.view.frame.size.height-340) scrollDirection:ScrollDirectionVertical pagingEnabled:NO];
//    
//    
//    
    saCalendar.delegate = self;
//    
   [self.view addSubview:saCalendar];
    
    if(![self.AllEventDetailListArray isEqual: [NSNull null]])
    {
        [saCalendar SetEventTitle:self.AllEventDetailListArray];
    }

    
    if(![self.AllEventDetailListArray isEqual: [NSNull null]])
    {
        [saCalendar SetEventTitle:self.AllEventDetailListArray];
    }
    
    if(indexPath.row ==0)
    {
        self.eventview.backgroundColor=[UIColor colorWithRed:(37/255.0f) green:(187/255.0f) blue:(151/255.0f) alpha:1.0f];
        
    }
    else if(indexPath.row ==1)
    {
        self.eventview.backgroundColor=[UIColor colorWithRed:(42/255.0f) green:(151/255.0f) blue:(243/255.0f) alpha:1.0f];
    }
    else if(indexPath.row ==2)
    {
       self.eventview.backgroundColor=[UIColor colorWithRed:(247/255.0f) green:(116/255.0f) blue:(159/255.0f) alpha:1.0f];
        
    }
    else if(indexPath.row ==3)
    {
        self.eventview.backgroundColor=[UIColor colorWithRed:(215/255.0f) green:(163/255.0f) blue:(69/255.0f) alpha:1.0f];
        
    }
    else if(indexPath.row ==4)
    {
        self.eventview.backgroundColor=[UIColor colorWithRed:(162/255.0f) green:(99/255.0f) blue:(28/255.0f) alpha:1.0f];
        
    }
    else if(indexPath.row ==5)
    {
        self.eventview.backgroundColor=[UIColor colorWithRed:(90/255.0f) green:(181/255.0f) blue:(96/255.0f) alpha:1.0f];
        
    }
    else if(indexPath.row ==6)
    {
        self.eventview.backgroundColor=[UIColor colorWithRed:(60/255.0f) green:(172/255.0f) blue:(206/255.0f) alpha:1.0f];
        
    }
    else if(indexPath.row ==7)
    {
        self.eventview.backgroundColor=[UIColor colorWithRed:(207/255.0f) green:(134/255.0f) blue:(46/255.0f) alpha:1.0f];
        
    }
    else if (indexPath.row ==8)
    {
        self.eventview.backgroundColor=[UIColor colorWithRed:(71/255.0f) green:(30/255.0f) blue:(102/255.0f) alpha:1.0f];
        
    }
    else if (indexPath.row ==9)
    {
        self.eventview.backgroundColor=[UIColor colorWithRed:(193/255.0f) green:(73/255.0f) blue:(74/255.0f) alpha:1.0f];
        
    }
    else
    {
        self.eventview.backgroundColor=[UIColor colorWithRed:(97/255.0f) green:(50/255.0f) blue:(139/255.0f) alpha:1.0f];
        
    }
    
    

}

-(IBAction)didClickBackBtn:(id)sender
{
    //[self.navigationController popViewControllerAnimated:YES];
    HomeVC  * objTabVC=[[HomeVC alloc]init];
    objTabVC = (HomeVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
    [self.navigationController pushViewController:objTabVC animated:YES];
}
-(IBAction)HomeBtnAction:(id)sender
{
    HomeVC  * objTabVC=[[HomeVC alloc]init];
    objTabVC = (HomeVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
    [self.navigationController pushViewController:objTabVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




#pragma mark - FFDateManager Notification

- (void)dateChanged:(NSNotification *)notification {
    
    [self updateLabelWithMonthAndYear];
}

- (void)updateLabelWithMonthAndYear {
    
    NSDateComponents *comp = [NSDate componentsOfDate:[[FFDateManager sharedManager] currentDate]];
    NSString *string = boolYearViewIsShowing ? [NSString stringWithFormat:@"%li", (long)comp.year] : [NSString stringWithFormat:@"%@ %li", [arrayMonthName objectAtIndex:comp.month-1], (long)comp.year];
    //[self.nameOfMonth setText:string];
    
    self.nameOfMonth.text = [NSString stringWithFormat:@"%@ %ld",[arrayMonthName objectAtIndex:comp.month-1],(long)comp.year];
    [labelWithMonthAndYear setText:string];
}

#pragma mark - Init dictEvents

- (void)setArrayWithEvents:(NSMutableArray *)_arrayWithEvents {
    
    arrayWithEvents = _arrayWithEvents;
    
    dictEvents = [NSMutableDictionary new];
    
    for (EventRecord *event in _arrayWithEvents) {
        NSDateComponents *comp = [NSDate componentsOfDate:event.dateDay];
        NSDate *newDate = [NSDate dateWithYear:comp.year month:comp.month day:comp.day];
        NSMutableArray *array = [dictEvents objectForKey:newDate];
        if (!array) {
            array = [NSMutableArray new];
            [dictEvents setObject:array forKey:newDate];
        }
        [array addObject:event];
    }
}

#pragma mark - Custom NavigationBar

- (void)customNavigationBarLayout {
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor lighterGrayCustom]];
    
    [self addRightBarButtonItems];
    [self addLeftBarButtonItems];
}

- (void)addRightBarButtonItems {
    
    UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedItem.width = 20.;
    
    //FFRedAndWhiteButton *buttonYear = [self calendarButtonWithTitle:@"year"];
    //FFRedAndWhiteButton *buttonMonth = [self calendarButtonWithTitle:@"month"];
    FFRedAndWhiteButton *buttonWeek = [self calendarButtonWithTitle:@"week"];
    FFRedAndWhiteButton *buttonDay = [self calendarButtonWithTitle:@"day"];
    
    //UIBarButtonItem *barButtonYear = [[UIBarButtonItem alloc] initWithCustomView:buttonYear];
    //UIBarButtonItem *barButtonMonth = [[UIBarButtonItem alloc] initWithCustomView:buttonMonth];
    UIBarButtonItem *barButtonWeek = [[UIBarButtonItem alloc] initWithCustomView:buttonWeek];
    UIBarButtonItem *barButtonDay = [[UIBarButtonItem alloc] initWithCustomView:buttonDay];
    
    FFButtonAddEventWithPopover *buttonAdd = [[FFButtonAddEventWithPopover alloc] initWithFrame:CGRectMake(0., 0., 30,30)];
    [buttonAdd setProtocol:self];
    //UIBarButtonItem *barButtonAdd = [[UIBarButtonItem alloc] initWithCustomView:buttonAdd];
    
    arrayButtons = @[buttonWeek, buttonDay];
    [self.navigationItem setRightBarButtonItems:@[barButtonWeek, barButtonDay]];
}

- (void)addLeftBarButtonItems {
    
    UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedItem.width = 30.;
    
    FFRedAndWhiteButton *buttonToday = [[FFRedAndWhiteButton alloc] initWithFrame:CGRectMake(0., 0., 50., 30)];
    [buttonToday addTarget:self action:@selector(buttonTodayAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonToday setTitle:@"today" forState:UIControlStateNormal];
    UIBarButtonItem *barButtonToday = [[UIBarButtonItem alloc] initWithCustomView:buttonToday];
    
    labelWithMonthAndYear = [[UILabel alloc] initWithFrame:CGRectMake(100., 100., 100., 100)];
    [labelWithMonthAndYear setTextColor:[UIColor redColor]];
    [labelWithMonthAndYear setFont:buttonToday.titleLabel.font];
    UIBarButtonItem *barButtonLabel = [[UIBarButtonItem alloc] initWithCustomView:labelWithMonthAndYear];
    
    [self.navigationItem setLeftBarButtonItems:@[barButtonLabel, fixedItem, barButtonToday]];
}

- (FFRedAndWhiteButton *)calendarButtonWithTitle:(NSString *)title {
    
    FFRedAndWhiteButton *button = [[FFRedAndWhiteButton alloc] initWithFrame:CGRectMake(0., 0., 50., 30.)];
    [button addTarget:self action:@selector(buttonYearMonthWeekDayAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

#pragma mark - Add Calendars

-(void)addMonthCalendar
{
    FFMonthCalendarView* monthly = [[FFMonthCalendarView alloc] initWithFrame:CGRectMake(self.titleview.frame.origin.x,self.titleview.frame.origin.y+self.titleview.frame.size.height+27,self.view.frame.size.width,self.view.frame.size.height-340)];
    [monthly setProtocol:self];
    [monthly setDictEvents:dictEvents];
    [self.view addSubview:monthly];
    

    
}

- (void)addCalendarWeek {
    
    //CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    CGRect frame = CGRectMake(self.titleview.frame.origin.x,self.titleview.frame.origin.y+self.titleview.frame.size.height+27,self.view.frame.size.width,self.view.frame.size.height-340);
    
    
    
    //saCalendar = [[SACalendar alloc]initWithFrame:CGRectMake(self.titleview.frame.origin.x,self.titleview.frame.origin.y+self.titleview.frame.size.height+5,self.view.frame.size.width,self.view.frame.size.height-340) scrollDirection:ScrollDirectionVertical pagingEnabled:NO];
    
    //viewCalendarYear = [[FFYearCalendarView alloc] initWithFrame:frame];
    //[viewCalendarYear setProtocol:self];
    //[self.view addSubview:viewCalendarYear];
    
//    viewCalendarMonth = [[FFMonthCalendarView alloc] initWithFrame:frame];
//    [viewCalendarMonth setProtocol:self];
//    [viewCalendarMonth setDictEvents:dictEvents];
//    [self.view addSubview:viewCalendarMonth];
    
    viewCalendarWeek = [[FFWeekCalendarView alloc] initWithFrame:frame];
    
    [viewCalendarWeek setProtocol:self];
    [viewCalendarWeek setDictEvents:dictEvents];
    [self.view addSubview:viewCalendarWeek];
    
//    viewCalendarDay = [[FFDayCalendarView alloc] initWithFrame:frame];
//    [viewCalendarDay setProtocol:self];
//    [viewCalendarDay setDictEvents:dictEvents];
//    [self.view addSubview:viewCalendarDay];
    
    arrayCalendars = @[viewCalendarWeek];
}

- (void)addCalendarDay {
    
    CGRect frame = CGRectMake(self.titleview.frame.origin.x,self.titleview.frame.origin.y+self.titleview.frame.size.height+27,self.view.frame.size.width,self.view.frame.size.height-340);
    
    //viewCalendarYear = [[FFYearCalendarView alloc] initWithFrame:frame];
    //[viewCalendarYear setProtocol:self];
    //[self.view addSubview:viewCalendarYear];
    
    //    viewCalendarMonth = [[FFMonthCalendarView alloc] initWithFrame:frame];
    //    [viewCalendarMonth setProtocol:self];
    //    [viewCalendarMonth setDictEvents:dictEvents];
    //    [self.view addSubview:viewCalendarMonth];
    
//    viewCalendarWeek = [[FFWeekCalendarView alloc] initWithFrame:frame];
//    [viewCalendarWeek setProtocol:self];
//    [viewCalendarWeek setDictEvents:dictEvents];
//    [self.view addSubview:viewCalendarWeek];
    
    viewCalendarDay = [[FFDayCalendarView alloc] initWithFrame:frame];
    [viewCalendarDay setProtocol:self];
    [viewCalendarDay setDictEvents:dictEvents];
    [self.view addSubview:viewCalendarDay];
    
    arrayCalendars = @[viewCalendarDay];
}


#pragma mark - Button Action

- (IBAction)buttonYearMonthWeekDayAction:(id)sender {
    
    long index = [arrayButtons indexOfObject:sender];
    
    //[self.view bringSubviewToFront:[arrayCalendars objectAtIndex:index]];
    
    for (UIButton *button in arrayButtons) {
        button.selected = (button == sender);
    }
    
    boolYearViewIsShowing = (index == 0);
    [self updateLabelWithMonthAndYear];
}

- (IBAction)buttonTodayAction:(id)sender {
    
    [[FFDateManager sharedManager] setCurrentDate:[NSDate dateWithYear:[NSDate componentsOfCurrentDate].year
                                                                 month:[NSDate componentsOfCurrentDate].month
                                                                   day:[NSDate componentsOfCurrentDate].day]];
}

#pragma mark - Interface Rotation

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    [viewCalendarYear invalidateLayout];
    [viewCalendarMonth invalidateLayout];
    [viewCalendarWeek invalidateLayout];
    [viewCalendarDay invalidateLayout];
}

#pragma mark - FFButtonAddEventWithPopover Protocol

- (void)addNewEvent:(EventRecord *)eventNew {
    
    NSMutableArray *arrayNew = [dictEvents objectForKey:eventNew.dateDay];
    if (!arrayNew) {
        arrayNew = [NSMutableArray new];
        [dictEvents setObject:arrayNew forKey:eventNew.dateDay];
    }
    [arrayNew addObject:eventNew];
    
    [self setNewDictionary:dictEvents];
}

#pragma mark - FFMonthCalendarView, FFWeekCalendarView and FFDayCalendarView Protocols

- (void)setNewDictionary:(NSDictionary *)dict {
    
    dictEvents = (NSMutableDictionary *)dict;
    
    [viewCalendarMonth setDictEvents:dictEvents];
    [viewCalendarWeek setDictEvents:dictEvents];
    [viewCalendarDay setDictEvents:dictEvents];
    
    [self arrayUpdatedWithAllEvents];
}

#pragma mark - FFYearCalendarView Protocol

- (void)showMonthCalendar {
    [self MonthAction:nil];
//    [self buttonYearMonthWeekDayAction:[arrayButtons objectAtIndex:1]];
}

#pragma mark - Sending Updated Array to FFCalendarViewController Protocol

- (void)arrayUpdatedWithAllEvents {
    
    NSMutableArray *arrayNew = [NSMutableArray new];
    
    NSArray *arrayKeys = dictEvents.allKeys;
    for (NSDate *date in arrayKeys) {
        NSArray *arrayOfDate = [dictEvents objectForKey:date];
        for (EventRecord *event in arrayOfDate) {
            [arrayNew addObject:event];
        }
    }
    
    if (protocol != nil && [protocol respondsToSelector:@selector(arrayUpdatedWithAllEvents:)]) {
        [protocol arrayUpdatedWithAllEvents:arrayNew];
    }
}
- (void)displayFFCalendar {
    
    FFCalendarViewController *calendarVc = [FFCalendarViewController new];
    [calendarVc setProtocol:self];
    [calendarVc setArrayWithEvents:[self arrayWithEvents]];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:calendarVc];
    navigationController.view.frame = CGRectMake(0., 0., self.view.frame.size.width, self.view.frame.size.height);
    
    [self addChildViewController:navigationController];
    [self.view addSubview:navigationController.view];
    [navigationController didMoveToParentViewController:self];
}

//- (NSMutableArray *)arrayWithEvents {
//    
//    FFEvent *event1 = [FFEvent new];
//    [event1 setStringCustomerName: @"Customer A"];
//    [event1 setNumCustomerID:@1];
//    [event1 setDateDay:[NSDate dateWithYear:[NSDate componentsOfCurrentDate].year month:[NSDate componentsOfCurrentDate].month day:[NSDate componentsOfCurrentDate].day]];
//    [event1 setDateTimeBegin:[NSDate dateWithHour:10 min:00]];
//    [event1 setDateTimeEnd:[NSDate dateWithHour:15 min:13]];
//    [event1 setArrayWithGuests:[NSMutableArray arrayWithArray:@[@[@111, @"Guest 2", @"email2@email.com"], @[@111, @"Guest 4", @"email4@email.com"], @[@111, @"Guest 5", @"email5@email.com"], @[@111, @"Guest 7", @"email7@email.com"]]]];
//    
//    return [NSMutableArray arrayWithArray:@[event1]];
//}


- (NSMutableArray *)arrayWithEvents {
    
    
    NSMutableArray *EventsList =[[NSMutableArray alloc]init];
    
    EventsList = self.AllEventDetailListArray;
    
    NSLog(@"%@", EventsList);
    
    NSMutableArray *title =[[NSMutableArray alloc]init];
    NSMutableArray *strtDatetime =[[NSMutableArray alloc]init];
    NSMutableArray *endDatetime =[[NSMutableArray alloc]init];
    NSMutableArray *EventDate =[[NSMutableArray alloc]init];
    NSMutableArray *Bgcolors =[[NSMutableArray alloc]init];
    
    title = [EventsList valueForKey:@"title"];
    strtDatetime = [EventsList valueForKey:@"startdatetime"];
    endDatetime = [EventsList valueForKey:@"enddatetime"];
    EventDate = [EventsList valueForKey:@"title"];
    
    Bgcolors = [EventsList valueForKey:@"backgroundColor"];
    
    NSMutableArray *allCompetitionArray = [[NSMutableArray alloc]init];

    for(int i=0;i<strtDatetime.count;i++)
    {
        
        
    ///STARTDATETIME  START
        NSString *dateString = [strtDatetime objectAtIndex:i];
        NSString *res= [self changeformate_string24hr:dateString];
        
        NSArray *components = [res componentsSeparatedByString:@" "];
        NSString *datee = components[0];
        NSString *timee = components[1];
        
        NSArray *componentsSTART = [timee componentsSeparatedByString:@":"];
        NSString *STARThrs = componentsSTART[0];
        NSString *STARTmnts = componentsSTART[1];
        
        //date
        NSString *dddd=@"7-11-2017";
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        [arr addObject:dddd];
        [arr replaceObjectAtIndex:0 withObject:datee];
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat:@"dd-MM-yyyy"];
        NSDate *dateFromString1 = [dateFormatter1 dateFromString:[arr objectAtIndex:0]];
        self.reqDate = [dateFromString1 copy];
        

        //time
        
        NSString *tH=@"15";
        NSMutableArray *arr1 = [[NSMutableArray alloc]init];
        [arr1 addObject:tH];
        [arr1 replaceObjectAtIndex:0 withObject:STARThrs];
        int startH = [[arr1 objectAtIndex:0] intValue];
    
        NSString *tM=@"15";
        NSMutableArray *arr2 = [[NSMutableArray alloc]init];
        [arr2 addObject:tM];
        [arr2 replaceObjectAtIndex:0 withObject:STARTmnts];
        int startM = [[arr2 objectAtIndex:0] intValue];
  ///STARTDATETIME  END
        
        
        
  ///ENDDATETIME  START
        
        NSString *dateString1 = [endDatetime objectAtIndex:i];
        NSString *res1= [self changeformate_string24hr:dateString1];
        
        NSArray *components1 = [res1 componentsSeparatedByString:@" "];
        NSString *datee1 = components1[0];
        NSString *timee1 = components1[1];
        
        NSArray *componentsEND = [timee1 componentsSeparatedByString:@":"];
        NSString *ENDhrs = componentsEND[0];
        NSString *ENDmnts = componentsEND[1];

        //time
        
        NSString *tH1=@"15";
        NSMutableArray *ar = [[NSMutableArray alloc]init];
        [ar addObject:tH1];
        [ar replaceObjectAtIndex:0 withObject:ENDhrs];
        int endH = [[ar objectAtIndex:0] intValue];
        
        NSString *tM1=@"15";
        NSMutableArray *ar1 = [[NSMutableArray alloc]init];
        [ar1 addObject:tM1];
        [ar1 replaceObjectAtIndex:0 withObject:ENDmnts];
        int endM = [[ar1 objectAtIndex:0] intValue];
  ///ENDDATETIME  END
        
        
        //Event Add
        
        EventRecord * objRecord    = [[EventRecord alloc]init];
        objRecord.numCustomerID    = @1;
        objRecord.stringCustomerName  = [title objectAtIndex:i];
        objRecord.dateDay          = self.reqDate;
        objRecord.dateTimeBegin  = [NSDate dateWithHour:startH min:startM];
        objRecord.dateTimeEnd         = [NSDate dateWithHour:endH min:endM];
        objRecord.color         = [Bgcolors objectAtIndex:i];
        
//        FFBlueButton *bb = [[FFBlueButton alloc]init];
//        [bb setBackgroundColor:<#(UIColor * _Nullable)#>]
        
        [allCompetitionArray addObject:objRecord];
        
    }

    
    //return [NSMutableArray arrayWithArray:@[event2]];
    
    return allCompetitionArray;
}

-(NSString *)changeformate_string24hr:(NSString *)date
{
    
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    
    [df setTimeZone:[NSTimeZone systemTimeZone]];
    
    [df setDateFormat:@"dd/MM/yyyy hh:mm a"];
    
    NSDate* wakeTime = [df dateFromString:date];
    
    [df setDateFormat:@"dd/MM/yyyy HH:mm"];
    
    
    return [df stringFromDate:wakeTime];
    
}

-(NSString *)Bcolors : (NSString *)ReqColor
{
    NSString * cc = EventBgcolor;
    return cc;
}




-(UIColor*)colorWithHexString:(NSString*)hex
{
    //-----------------------------------------
    // Convert hex string to an integer
    //-----------------------------------------
    unsigned int hexint = 0;
    
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hex];
    
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet
                                       characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt:&hexint];
    
    //-----------------------------------------
    // Create color object, specifying alpha
    //-----------------------------------------
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:1.0f];
    
    return color;
}
-(IBAction)MenuBtnAction:(id)sender
{
   [COMMON ShowsideMenuView];
}




@end
