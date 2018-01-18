//
//  WLReportFilterVC.m
//  AlphaProTracker
//
//  Created by Lexicon on 01/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "WLReportFilterVC.h"
#import "CustomNavigation.h"
#import "HomeVC.h"
#import "AppCommon.h"
#import "WebService.h"
#import "Config.h"
#import "GraphsVC.h"
#import "SACalendar.h"




@interface WLReportFilterVC ()
{
    WebService *objWebservice;
    
    
    BOOL isrange;
    BOOL ismonth;
    BOOL isyear;
    BOOL ismeta1;
    BOOL ismeta2;
    BOOL isgame;
    BOOL isteam;
    BOOL isplayer;
    
    BOOL isStart;
    BOOL isEnd;
    
    NSString *metasubCode1;
    NSString *metasubCode2;
    NSString *playercode;
    NSString *monthNo;
    NSString * actualDate1;
    NSString * actualDate2;
}

@property (strong, nonatomic) IBOutlet NSMutableArray *mainArray;

@property (strong, nonatomic) IBOutlet NSMutableArray *rangeArr;
@property (strong, nonatomic) IBOutlet NSMutableArray *monthArr;
@property (strong, nonatomic) IBOutlet NSMutableArray *monthnum;
@property (strong, nonatomic) IBOutlet NSMutableArray *yearArr;
@property (strong, nonatomic) IBOutlet NSMutableArray *metalist;
@property (strong, nonatomic) IBOutlet NSMutableArray *gameArr;
@property (strong, nonatomic) IBOutlet NSMutableArray *teamArr;
@property (strong, nonatomic) IBOutlet NSMutableArray *playerArr;

@property (strong, nonatomic) IBOutlet NSMutableArray *rangeArr1;
@property (strong, nonatomic) IBOutlet NSMutableArray *monthArr1;
@property (strong, nonatomic) IBOutlet NSMutableArray *yearArr1;
@property (strong, nonatomic) IBOutlet NSMutableArray *metalist1;
@property (strong, nonatomic) IBOutlet NSMutableArray *metacodelist;
@property (strong, nonatomic) IBOutlet NSMutableArray *gameArr1;
@property (strong, nonatomic) IBOutlet NSMutableArray *teamArr1;
@property (strong, nonatomic) IBOutlet NSMutableArray *playerArr1;

@property (strong, nonatomic) IBOutlet NSMutableArray *playecodeList;


@property (strong, nonatomic) IBOutlet NSLayoutConstraint * Tblx_position;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint * Tbly_position;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint * TblWidth;

@end

@implementation WLReportFilterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    objWebservice = [[WebService alloc]init];
    //[COMMON AddMenuView:self.view];
    self.mainArray = [[NSMutableArray alloc]init];
    self.rangeArr = [[NSMutableArray alloc]init];
    self.monthArr = [[NSMutableArray alloc]init];
    self.yearArr = [[NSMutableArray alloc]init];
    self.metalist = [[NSMutableArray alloc]init];
    self.metacodelist = [[NSMutableArray alloc]init];
    
    self.gameArr = [[NSMutableArray alloc]init];
    self.teamArr = [[NSMutableArray alloc]init];
    self.playerArr = [[NSMutableArray alloc]init];
    
    self.rangeArr1 = [[NSMutableArray alloc]init];
    self.monthArr1 = [[NSMutableArray alloc]init];
    self.yearArr1 = [[NSMutableArray alloc]init];
    self.metalist1 = [[NSMutableArray alloc]init];
    self.gameArr1 = [[NSMutableArray alloc]init];
    self.teamArr1 = [[NSMutableArray alloc]init];
    self.playerArr1 = [[NSMutableArray alloc]init];
    self.playecodeList = [[NSMutableArray alloc]init];
    
    self.rangeview.layer.borderWidth=0.5f;
    self.rangeview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.monthview.layer.borderWidth=0.5f;
    self.monthview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.yearview.layer.borderWidth=0.5f;
    self.yearview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.gameview.layer.borderWidth=0.5f;
    self.gameview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.playersview.layer.borderWidth=0.5f;
    self.playersview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.teamview.layer.borderWidth=0.5f;
    self.teamview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.axis1view.layer.borderWidth=0.5f;
    self.axis1view.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.axis2view.layer.borderWidth=0.5f;
    self.axis2view.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.strdView.layer.borderWidth=0.5f;
    self.strdView.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.endView.layer.borderWidth=0.5f;
    self.endView.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;

    
    self.startitle.hidden=YES;
    self.endtitle.hidden=YES;
    self.strdView.hidden=YES;
    self.endView.hidden=YES;
    
    NSString *rolecode = [[NSUserDefaults standardUserDefaults]stringForKey:@"RoleCode"];
    
    
    if( [rolecode isEqualToString:@"ROL0000002"] )
    {
        
        self.gameview.hidden = YES;
        self.teamview.hidden = YES;
        self.playersview.hidden = YES;
        self.teamTxt.hidden = YES;
        self.gameTxt.hidden = YES;
        self.playerTxt.hidden = YES;
        
        self.axis1position.constant = -140;
        self.axis1viewposition.constant = -140;
        
    }
    

    
    // self.listTbl.hidden=YES;
    
    [self FilterWebservice];
    [self Filter2Webservice];
    [self customnavigationmethod];
    // Do any additional setup after loading the view.
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
-(void)FilterWebservice
{
    
    NSString *clientcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    NSString *value1 = @"null";
    NSString *value2 = @"null";
    
    
    
    [objWebservice FilterReport :FilterKey :value1 :clientcode :value2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject=%@",responseObject);
        if(responseObject >0)
        {
            
            self.rangeArr = [responseObject valueForKey:@"RangeWise"];
            self.monthArr = [responseObject valueForKey:@"MonthRangeName"];
            
            self.yearArr =  [responseObject valueForKey:@"YearlyRange"];
            self.metalist = [responseObject valueForKey:@"metaDataList"];
            
            self.rangeArr1 = [self.rangeArr valueForKey:@"RangeWise"];
            self.monthArr1 = [self.monthArr valueForKey:@"monthName"];
            self.yearArr1 =  [self.yearArr valueForKey:@"years"];
            self.metalist1 = [self.metalist valueForKey:@"metaSubCodeDescription"];
            self.metacodelist = [self.metalist valueForKey:@"metaSubCode"];
            self.monthnum = [self.monthArr valueForKey:@"monthNo"];
            
        }
        
        [self.listTbl reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, id error) {
        NSLog(@"failed");
        [COMMON webServiceFailureError];
    }];
    
}
-(void)Filter2Webservice
{
    
    NSString *clientcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    
    
    
    
    [objWebservice SecFilterReport :FilterKey2 :clientcode  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject=%@",responseObject);
        if(responseObject >0)
        {
            
            self.gameArr = [responseObject valueForKey:@"fetchGame"];
            self.teamArr = [responseObject valueForKey:@"fetchTeam"];
            self.playerArr =  [responseObject valueForKey:@"fetchAthlete"];
            
            self.gameArr1 = [self.gameArr valueForKey:@"gameName"];
            self.teamArr1 = [self.teamArr valueForKey:@"teamName"];
            self.playerArr1 =  [self.playerArr valueForKey:@"athleteName"];
            
            self.playecodeList =  [self.playerArr valueForKey:@"athleteCode"];
            
            
            
        }
        
        [self.listTbl reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, id error) {
        NSLog(@"failed");
        [COMMON webServiceFailureError];
    }];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.mainArray.count;
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
        
    }
    
    if(isrange)
    {
        cell.textLabel.text = [self.mainArray objectAtIndex:indexPath.row];
        
    }
    if(ismonth)
    {
        cell.textLabel.text = [self.mainArray objectAtIndex:indexPath.row];
    }
    if(isyear)
    {
        cell.textLabel.text = [self.mainArray objectAtIndex:indexPath.row];
    }
    if(ismeta1)
    {
        cell.textLabel.text = [self.mainArray objectAtIndex:indexPath.row];
    }
    if(ismeta2)
    {
        cell.textLabel.text = [self.mainArray objectAtIndex:indexPath.row];
    }
    if(isgame)
    {
        cell.textLabel.text = [self.mainArray objectAtIndex:indexPath.row];
    }
    if(isteam)
    {
        cell.textLabel.text = [self.mainArray objectAtIndex:indexPath.row];
    }
    if(isplayer)
    {
        cell.textLabel.text = [self.mainArray objectAtIndex:indexPath.row];
        
    }
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(isrange)
    {
        self.rangelbl.text = [self.mainArray objectAtIndex:indexPath.row];
        
        if(indexPath.row ==0)
        {
            self.rangelbl.text = [self.mainArray objectAtIndex:indexPath.row];
            self.startitle.hidden=YES;
            self.endtitle.hidden=YES;
            self.strdView.hidden=YES;
            self.endView.hidden=YES;
            
            self.monthtitle.hidden=NO;
            self.yeartitle.hidden=NO;
            self.monthview.hidden=NO;
            self.yearview.hidden=NO;
        }
        if(indexPath.row ==1)
        {
            self.rangelbl.text = [self.mainArray objectAtIndex:indexPath.row];
            self.startitle.hidden=NO;
            self.endtitle.hidden=NO;
            self.strdView.hidden=NO;
            self.endView.hidden=NO;
            
            self.monthtitle.hidden=YES;
            self.yeartitle.hidden=YES;
            self.monthview.hidden=YES;
            self.yearview.hidden=YES;
        }
    }
    if(ismonth)
    {
        self.monthlbl.text = [self.mainArray objectAtIndex:indexPath.row];
        monthNo = [self.monthnum objectAtIndex:indexPath.row];
    }
    if(isyear)
    {
        self.yearlbl.text = [self.mainArray objectAtIndex:indexPath.row];
    }
    if(ismeta1)
    {
        self.axis1lbl.text = [self.mainArray objectAtIndex:indexPath.row];
        metasubCode1 = [self.metacodelist objectAtIndex:indexPath.row];
    }
    if(ismeta2)
    {
        self.axis2lbl.text = [self.mainArray objectAtIndex:indexPath.row];
        metasubCode2 = [self.metacodelist objectAtIndex:indexPath.row];
    }
    
    if(isgame)
    {
        self.gamelbl.text = [self.mainArray objectAtIndex:indexPath.row];
    }
    if(isteam)
    {
        self.teamlbl.text = [self.mainArray objectAtIndex:indexPath.row];
    }
    if(isplayer)
    {
        self.playerslbl.text = [self.mainArray objectAtIndex:indexPath.row];
        playercode = [self.playecodeList objectAtIndex:indexPath.row];
    }
    
    self.listTbl.hidden = YES;
    
}



-(IBAction)rangeAction:(id)sender
{
    isrange = YES;
    ismonth = NO;
    isyear = NO;
    ismeta1 = NO;
    ismeta2 = NO;
    isgame = NO;
    isteam = NO;
    isplayer = NO;
    
    self.Tblx_position.constant = self.rangeview.frame.origin.x-16;
    self.Tbly_position.constant = self.rangeview.frame.origin.y+self.rangeview.frame.size.height+68;
    self.TblWidth.constant =self.rangeview.frame.size.width;
    self.listTbl.hidden = NO;
    self.mainArray = self.rangeArr1;
    [self.listTbl reloadData];
}
-(IBAction)monthAction:(id)sender
{
    
    isrange = NO;
    ismonth = YES;
    isyear = NO;
    ismeta1 = NO;
    ismeta2 = NO;
    isgame = NO;
    isteam = NO;
    isplayer = NO;
    
    self.Tblx_position.constant = self.monthview.frame.origin.x-16;
    self.Tbly_position.constant = self.monthview.frame.origin.y+self.monthview.frame.size.height+68;
    self.TblWidth.constant =self.monthview.frame.size.width;
    self.listTbl.hidden = NO;
    self.mainArray = self.monthArr1;
    [self.listTbl reloadData];
    
}
-(IBAction)yearAction:(id)sender
{
    isrange = NO;
    ismonth = NO;
    isyear = YES;
    ismeta1 = NO;
    ismeta2 = NO;
    isgame = NO;
    isteam = NO;
    isplayer = NO;
    
    self.Tblx_position.constant = self.yearview.frame.origin.x-16;
    self.Tbly_position.constant = self.yearview.frame.origin.y+self.yearview.frame.size.height+68;
    self.TblWidth.constant =self.yearview.frame.size.width;

    self.listTbl.hidden = NO;
    self.mainArray = self.yearArr1;
    [self.listTbl reloadData];
    
}
-(IBAction)axis1Action:(id)sender
{
    isrange = NO;
    ismonth = NO;
    isyear = NO;
    ismeta1 = YES;
    ismeta2 = NO;
    isgame = NO;
    isteam = NO;
    isplayer = NO;
    
    self.Tblx_position.constant = self.axis1view.frame.origin.x-16;
    self.Tbly_position.constant = self.axis1view.frame.origin.y+self.axis1view.frame.size.height+68;
    self.TblWidth.constant =self.axis1view.frame.size.width;

    self.listTbl.hidden = NO;
    self.mainArray = self.metalist1;
    [self.listTbl reloadData];
    
    
}
-(IBAction)axis2Action:(id)sender
{
    isrange = NO;
    ismonth = NO;
    isyear = NO;
    ismeta1 = NO;
    ismeta2 = YES;
    isgame = NO;
    isteam = NO;
    isplayer = NO;
    
    self.Tblx_position.constant = self.axis2view.frame.origin.x-16;
    self.Tbly_position.constant = self.axis2view.frame.origin.y+self.axis2view.frame.size.height+68;
    self.TblWidth.constant =self.axis2view.frame.size.width;

    self.listTbl.hidden = NO;
    self.mainArray = self.metalist1;
    [self.listTbl reloadData];
    
}
-(IBAction)gameAction:(id)sender
{
    
    isrange = NO;
    ismonth = NO;
    isyear = NO;
    ismeta1 = NO;
    ismeta2 = NO;
    isgame = YES;
    isteam = NO;
    isplayer = NO;
    
    self.Tblx_position.constant = self.gameview.frame.origin.x-16;
    self.Tbly_position.constant = self.gameview.frame.origin.y+self.gameview.frame.size.height+68;
    self.TblWidth.constant =self.gameview.frame.size.width;

    self.listTbl.hidden = NO;
    self.mainArray = self.gameArr1;
    [self.listTbl reloadData];
    
}

-(IBAction)teamAction:(id)sender
{
    
    isrange = NO;
    ismonth = NO;
    isyear = NO;
    ismeta1 = NO;
    ismeta2 = NO;
    isgame = NO;
    isteam = YES;
    isplayer = NO;
    
    self.Tblx_position.constant = self.teamview.frame.origin.x-16;
    self.Tbly_position.constant = self.teamview.frame.origin.y+self.teamview.frame.size.height+68;
    self.TblWidth.constant =self.teamview.frame.size.width;

    self.listTbl.hidden = NO;
    self.mainArray = self.teamArr1;
    [self.listTbl reloadData];
    
}

-(IBAction)playerAction:(id)sender
{
    
    isrange = NO;
    ismonth = NO;
    isyear = NO;
    ismeta1 = NO;
    ismeta2 = NO;
    isgame = NO;
    isteam = NO;
    isplayer = YES;
    
    self.Tblx_position.constant = self.playersview.frame.origin.x-16;
    self.Tbly_position.constant = self.playersview.frame.origin.y+self.playersview.frame.size.height+68;
    self.TblWidth.constant =self.playersview.frame.size.width;

    self.listTbl.hidden = NO;
    self.mainArray = self.playerArr1;
    [self.listTbl reloadData];
    
}
-(IBAction)startDateAction:(id)sender
{
    isStart=YES;
    isEnd=NO;
    SACalendar *calendar = [[SACalendar alloc]initWithFrame:CGRectMake(self.strdView.frame.origin.x-135,self.strdView.frame.origin.y+self.strdView.frame.size.height+40,self.view.frame.size.width,self.view.frame.size.height-340) scrollDirection:ScrollDirectionVertical pagingEnabled:NO];
    
    calendar.delegate = self;
    
    [self.view addSubview:calendar];
    
}
-(IBAction)endDateAction:(id)sender
{
    isStart=NO;
    isEnd=YES;
    SACalendar *calendar = [[SACalendar alloc]initWithFrame:CGRectMake(self.endView.frame.origin.x-135,self.endView.frame.origin.y+self.endView.frame.size.height+40,self.view.frame.size.width,self.view.frame.size.height-340) scrollDirection:ScrollDirectionVertical pagingEnabled:NO];
    
    calendar.delegate = self;
    
    [self.view addSubview:calendar];
   
}

-(void) SACalendar:(SACalendar*)calendar didSelectDate:(int)day month:(int)month year:(int)year
{
    NSString * selectdate =[NSString stringWithFormat:@"%d-%02d-%02d",day,month,year];
    NSString * selectdate1 =[NSString stringWithFormat:@"%d-%02d-%02d",year,month,day];
    
    if(isStart)
    {
        self.startLbl.text = selectdate;
        actualDate1=selectdate1;
    }
    
    if(isEnd)
    {
    self.endlbl.text = selectdate;
    actualDate2=selectdate1;
    }
    
    
    
    
    
    calendar.hidden = YES;
    
    
    
}



-(IBAction)viewReportAction:(id)sender
{
    
    
    
    if([self.rangelbl.text isEqualToString:@""])
    {
        [self ShowAlterMsg:@"Please Select Range"];
    }
    else if( [self.monthlbl.text isEqualToString:@""] )
    {
        [self ShowAlterMsg:@"Please Select Month"];
    }
    else if( [self.yearlbl.text isEqualToString:@""])
    {
        [self ShowAlterMsg:@"Please Select Year"];
    }
    else if( [self.gamelbl.text isEqualToString:@""] )
    {
        [self ShowAlterMsg:@"Please Select Game"];
    }
    else if( [self.teamlbl.text isEqualToString:@""])
    {
        [self ShowAlterMsg:@"Please Select Team"];
    }
    else if( [self.playerslbl.text isEqualToString:@""] )
    {
        [self ShowAlterMsg:@"Please Select Player"];
    }
    else if( [self.axis1lbl.text isEqualToString:@""])
    {
        [self ShowAlterMsg:@"Please Select Axis1"];
    }
    else if( [self.axis2lbl.text isEqualToString:@""] )
    {
        [self ShowAlterMsg:@"Please Select Axis2"];
    }
    else
    {
        GraphsVC  * objTabVC=[[GraphsVC alloc]init];
        objTabVC = (GraphsVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"GraphsVC"];
        
        objTabVC.range = self.rangelbl.text;
        objTabVC.month = monthNo;
        objTabVC.year = self.yearlbl.text;
        
        NSString *rolecode = [[NSUserDefaults standardUserDefaults]stringForKey:@"RoleCode"];
        
        if( [rolecode isEqualToString:@"ROL0000002"] )
        {
            NSString *plycode = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
            objTabVC.playerCode = plycode;
        }
        else
        {
            objTabVC.playerCode = playercode;
        }
        
        objTabVC.axis1 = metasubCode1;
        objTabVC.axis2 = metasubCode2;
        objTabVC.axis1name = self.axis1lbl.text;
        objTabVC.axis2name = self.axis2lbl.text;
        
        objTabVC.Sdate = actualDate1;
        objTabVC.Edate = actualDate2;
        
        [self.navigationController pushViewController:objTabVC animated:YES];
    }
}

-(void)ShowAlterMsg:(NSString*) MsgStr
{
    UIAlertView *objAlter =[[UIAlertView alloc]initWithTitle:@"" message:MsgStr delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [objAlter show];
    
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
