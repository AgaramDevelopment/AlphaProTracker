//
//  TrainingLoadVC.m
//  AlphaProTracker
//
//  Created by Lexicon on 02/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "TrainingLoadVC.h"
#import "AppCommon.h"
#import "HomeVC.h"
#import "CustomNavigation.h"
#import "WebService.h"
#import "Config.h"
#import "TrainingLoadVCCell.h"
#import "SACalendar.h"
#import "CRTableViewCell.h"


@interface TrainingLoadVC ()
{
    UIDatePicker *datePicker;
    NSString *actualDate;
    
    WebService *objWebservice;
    
    NSString *teamcode;
    NSString *player;
    NSString *metaSubcode1;
    NSString *metaSubcode2;
    
    NSString *activityDescription;
    NSString *rpeDescription;
    NSString *WorkloadCode;
    NSString *ActCode;
    
    
    NSString *actCode1;
    NSString *actCode2;
    NSString *actCode3;
    NSString *actCode4;
    NSString *actCode5;
    NSString *actCode6;
    NSString *actCode7;
    
    
    BOOL isTeam;
    BOOL isPlayer;
    BOOL isAct;
    BOOL isRpe;
    
    BOOL isborderview;
    BOOL isborderview1;
    BOOL isborderview2;
    BOOL isborderview3;
    BOOL isborderview4;
    BOOL isborderview5;
    BOOL isborderview6;
    BOOL isborderview7;
    BOOL isborderview8;
    
    BOOL isView;
}
@property (strong, nonatomic) IBOutlet NSMutableArray *teamlist;
@property (strong, nonatomic) IBOutlet NSMutableArray *playerlist;
@property (strong, nonatomic) IBOutlet NSMutableArray *updatedplayerlist;
@property (strong, nonatomic) IBOutlet NSMutableArray *updatedplayercode;

@property (strong, nonatomic) IBOutlet NSMutableArray *Viewslist;
@property (strong, nonatomic) IBOutlet NSMutableArray *Viewslist1;

@property (strong, nonatomic) IBOutlet NSMutableArray *dateActivityCode;



@property (strong, nonatomic) IBOutlet NSMutableArray *Responselist;

@property (strong, nonatomic) IBOutlet NSMutableArray *workingloadlist;

@property (strong, nonatomic) IBOutlet NSMutableArray *Getdesclist;
@property (strong, nonatomic) IBOutlet NSMutableArray *GetrpeDesclist;

@property (strong, nonatomic) IBOutlet NSMutableArray *activitylist;
@property (strong, nonatomic) IBOutlet NSMutableArray *rpelist;
@property (strong, nonatomic) IBOutlet NSMutableArray *activityCodelist;
@property (strong, nonatomic) IBOutlet NSMutableArray *rpeCodelist;
@property (strong, nonatomic) IBOutlet NSMutableArray *PlayerCodelist;

@property (strong, nonatomic) IBOutlet NSMutableArray *activityDesc;
@property (strong, nonatomic) IBOutlet NSMutableArray *rpeDesc;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint * Tblx_position;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint * Tbly_position;


@property (nonatomic, strong) NSMutableArray *contents;
@property (nonatomic, strong) NSMutableArray *selectedIndexPaths;

@property (strong, nonatomic) IBOutlet NSString *PlayerCode;

@property (strong, nonatomic)  NSMutableArray *selectedMarks;

@end

@implementation TrainingLoadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    objWebservice = [[WebService alloc]init];
    [self customnavigationmethod];
    
    self.selectedMarks = [[NSMutableArray alloc]init];
    
    self.Viewslist = [[NSMutableArray alloc]init];
    self.Viewslist1 = [[NSMutableArray alloc]init];
    
    self.dateActivityCode = [[NSMutableArray alloc]init];
    
    [self setSelectedIndexPaths:[NSMutableArray array]];
    
    self.listTbl.hidden = YES;
    self.view_datepicker.hidden = YES;
    [self trainingLoadWebservice];
    self.borderview.layer.borderWidth=1.0f;
    self.borderview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1.0f].CGColor;
    
    self.teamview.layer.borderWidth=0.5f;
    self.teamview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.playerview.layer.borderWidth=0.5f;
    self.playerview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.dateview.layer.borderWidth=0.5f;
    self.dateview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.actview.layer.borderWidth=0.5f;
    self.actview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.rpeview.layer.borderWidth=0.5f;
    self.rpeview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.timeview.layer.borderWidth=0.5f;
    self.timeview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.ballslblview.layer.borderWidth=0.5f;
    self.ballslblview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    
    
    
    
    self.borderview1.layer.borderWidth=1.0f;
    self.borderview1.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1.0f].CGColor;
    
    self.teamview1.layer.borderWidth=0.5f;
    self.teamview1.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.playerview1.layer.borderWidth=0.5f;
    self.playerview1.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.dateview1.layer.borderWidth=0.5f;
    self.dateview1.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.actview1.layer.borderWidth=0.5f;
    self.actview1.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.rpeview1.layer.borderWidth=0.5f;
    self.rpeview1.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.timeview1.layer.borderWidth=0.5f;
    self.timeview1.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.ballslblview1.layer.borderWidth=0.5f;
    self.ballslblview1.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    
    
    self.borderview2.layer.borderWidth=1.0f;
    self.borderview2.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1.0f].CGColor;
    
    self.teamview2.layer.borderWidth=0.5f;
    self.teamview2.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.playerview2.layer.borderWidth=0.5f;
    self.playerview2.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.dateview2.layer.borderWidth=0.5f;
    self.dateview2.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.actview2.layer.borderWidth=0.5f;
    self.actview2.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.rpeview2.layer.borderWidth=0.5f;
    self.rpeview2.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.timeview2.layer.borderWidth=0.5f;
    self.timeview2.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.ballslblview2.layer.borderWidth=0.5f;
    self.ballslblview2.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    
    
    
    self.borderview3.layer.borderWidth=1.0f;
    self.borderview3.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1.0f].CGColor;
    
    self.teamview3.layer.borderWidth=0.5f;
    self.teamview3.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.playerview3.layer.borderWidth=0.5f;
    self.playerview3.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.dateview3.layer.borderWidth=0.5f;
    self.dateview3.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.actview3.layer.borderWidth=0.5f;
    self.actview3.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.rpeview3.layer.borderWidth=0.5f;
    self.rpeview3.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.timeview3.layer.borderWidth=0.5f;
    self.timeview3.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.ballslblview3.layer.borderWidth=0.5f;
    self.ballslblview3.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    
    
    
    self.borderview4.layer.borderWidth=1.0f;
    self.borderview4.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1.0f].CGColor;
    
    self.teamview4.layer.borderWidth=0.5f;
    self.teamview4.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.playerview4.layer.borderWidth=0.5f;
    self.playerview4.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.dateview4.layer.borderWidth=0.5f;
    self.dateview4.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.actview4.layer.borderWidth=0.5f;
    self.actview4.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.rpeview4.layer.borderWidth=0.5f;
    self.rpeview4.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.timeview4.layer.borderWidth=0.5f;
    self.timeview4.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.ballslblview4.layer.borderWidth=0.5f;
    self.ballslblview4.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    
    
    self.borderview5.layer.borderWidth=1.0f;
    self.borderview5.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1.0f].CGColor;
    
    self.teamview5.layer.borderWidth=0.5f;
    self.teamview5.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.playerview5.layer.borderWidth=0.5f;
    self.playerview5.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.dateview5.layer.borderWidth=0.5f;
    self.dateview5.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.actview5.layer.borderWidth=0.5f;
    self.actview5.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.rpeview5.layer.borderWidth=0.5f;
    self.rpeview5.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.timeview5.layer.borderWidth=0.5f;
    self.timeview5.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.ballslblview5.layer.borderWidth=0.5f;
    self.ballslblview5.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    
    
    
    self.borderview6.layer.borderWidth=1.0f;
    self.borderview6.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1.0f].CGColor;
    
    self.teamview6.layer.borderWidth=0.5f;
    self.teamview6.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.playerview6.layer.borderWidth=0.5f;
    self.playerview6.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.dateview6.layer.borderWidth=0.5f;
    self.dateview6.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.actview6.layer.borderWidth=0.5f;
    self.actview6.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.rpeview6.layer.borderWidth=0.5f;
    self.rpeview6.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.timeview6.layer.borderWidth=0.5f;
    self.timeview6.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.ballslblview6.layer.borderWidth=0.5f;
    self.ballslblview6.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    
    
    
    
    self.borderview7.layer.borderWidth=1.0f;
    self.borderview7.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1.0f].CGColor;
    
    self.teamview7.layer.borderWidth=0.5f;
    self.teamview7.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.playerview7.layer.borderWidth=0.5f;
    self.playerview7.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.dateview7.layer.borderWidth=0.5f;
    self.dateview7.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.actview7.layer.borderWidth=0.5f;
    self.actview7.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.rpeview7.layer.borderWidth=0.5f;
    self.rpeview7.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.timeview7.layer.borderWidth=0.5f;
    self.timeview7.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.ballslblview7.layer.borderWidth=0.5f;
    self.ballslblview7.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    
    
    
    
    
    
    
    
    
    self.borderview1.hidden=YES;
    self.borderview2.hidden=YES;
    self.borderview3.hidden=YES;
    self.borderview4.hidden=YES;
    self.borderview5.hidden=YES;
    self.borderview6.hidden=YES;
    self.borderview7.hidden=YES;
    
    self.RemoveView1.hidden=YES;
    self.RemoveView2.hidden=YES;
    self.RemoveView3.hidden=YES;
    self.RemoveView4.hidden=YES;
    self.RemoveView5.hidden=YES;
    self.RemoveView6.hidden=YES;
    self.RemoveView7.hidden=YES;
    
    
    
    self.count1view.layer.borderWidth=1.0f;
    self.count1view.layer.borderColor=[UIColor whiteColor].CGColor;
    
    self.ballsview.hidden=YES;
    
    self.Update.hidden = YES;
    
    self.commonView.hidden = YES;
    self.countview.layer.masksToBounds = true;
    self.countview.clipsToBounds = true;
    self.countview.layer.cornerRadius = self.countview.frame.size.width/2;
    self.countview.layer.borderWidth = 1;
    self.countview.layer.borderColor =[UIColor whiteColor].CGColor;
    
    NSString *rolecode = [[NSUserDefaults standardUserDefaults]stringForKey:@"RoleCode"];
    
    if( [rolecode isEqualToString:@"ROL0000002"] )
    {
        self.teamTotalView.hidden = YES;
        self.playerTotalview.hidden = YES;
        
        self.dateYposition.constant = -70;
    }

    
    
    self.listTbl.allowsSelectionDuringEditing = YES;
    
    //    self.countview.layer.cornerRadius =40;
    //    self.countview.layer.masksToBounds =YES;
    //    self.countview.layer.borderColor =[UIColor whiteColor].CGColor;
    //    self.countview.layer.borderWidth =2;
    // Do any additional setup after loading the view.
    
    //    UIToolbar *toobar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 430, 250, 48)];
    //    toobar.barStyle = UIBarStyleBlack;
    //    [self.listTbl addSubview:toobar];
}
- (void)populateCell:(UITableViewCell *)cell
         atIndexPath:(NSIndexPath *)indexPath
{
    
    
    if ([[self selectedIndexPaths] containsObject:indexPath])
    {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    else
    {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
}


-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    
    
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"Training Load";
    objCustomNavigation.btn_back.hidden =NO;
    objCustomNavigation.menu_btn.hidden = YES;
    [objCustomNavigation.menu_btn addTarget:self action:@selector(MenuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [objCustomNavigation.btn_back addTarget:self action:@selector(btn_back:) forControlEvents:UIControlEventTouchUpInside];
    
}


//-(void)DisplaydatePicker
//{
//    if(datePicker!= nil)
//    {
//        [datePicker removeFromSuperview];
//
//    }
//    self.view_datepicker.hidden=NO;
//    //isStartDate =YES;
//
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    //   2016-06-25 12:00:00
//    [dateFormat setDateFormat:@"dd-MM-yyyy"];
//
//    datePicker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,self.view_datepicker.frame.origin.y-180,self.view.frame.size.width,100)];
//
//    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
//    [datePicker setLocale:locale];
//
//    // [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
//    datePicker.datePickerMode = UIDatePickerModeDate;
//
//    [datePicker reloadInputViews];
//    [self.view_datepicker addSubview:datePicker];
//
//}
//-(IBAction)showSelecteddate:(id)sender{
//
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    NSDate *matchdate = [NSDate date];
//    [dateFormat setDateFormat:@"dd-MM-yyyy"];
//    // for minimum date
//    [datePicker setMinimumDate:matchdate];
//
//    // for maximumDate
//    int daysToAdd = 1;
//    NSDate *newDate1 = [matchdate dateByAddingTimeInterval:60*60*24*daysToAdd];
//
//    [datePicker setMaximumDate:newDate1];
//
//
//    self.datelbl.text=[dateFormat stringFromDate:datePicker.date];
//
//    [dateFormat setDateFormat:@"yyyy-MM-dd"];
//
//    actualDate = [dateFormat stringFromDate:datePicker.date];
//
//
//
//    NSLog(@"%@", actualDate);
//
//    [self.view_datepicker setHidden:YES];
//
//
//
//}
-(IBAction)TeamsAction:(id)sender
{
    isTeam = YES;
    isPlayer =NO;
    isAct=NO;
    isRpe=NO;
    isView = NO;
    //self.listTbl.hidden = NO;
    self.commonView.hidden = NO;
    
    //    self.Tblx_position.constant = self.teamview.frame.origin.x;
    //    self.Tbly_position.constant = self.teamview.frame.origin.y+self.teamview.frame.size.height;
    [self.MultiTbl reloadData];
}
-(IBAction)PlayerAction:(id)sender
{
    isTeam = NO;
    isPlayer =YES;
    isAct=NO;
    isRpe=NO;
    
    isView = NO;
    
    self.updatedplayerlist = [[NSMutableArray alloc]init];
    
     self.updatedplayercode = [[NSMutableArray alloc]init];
    
//    for(int i=0; self.playerlist.count>i;i++)
//    {
//        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
//        dictionary=[self.playerlist objectAtIndex:i];
//        NSString*  strckercode;
//        strckercode =([dictionary valueForKey:@"TeamCode"]);
//        
//        //NSString * strckercode =[dictionary valueForKey:@"STRIKERCODE"];
//        if([teamcode isEqualToString:strckercode])
//        {
//            
//            
//            player = [dictionary valueForKey:@"PlayerName"];
//            
//            
//            [self.updatedplayerlist addObject:player];
//            
//            
//        }
//    }
    
    for(int i=0; self.selectedMarks.count>i;i++)
    {
        
        teamcode = [self.selectedMarks objectAtIndex:i] ;
        
        for(int j=0; self.playerlist.count>j;j++)
        {
            
            NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
            dictionary=[self.playerlist objectAtIndex:j];
            NSString*  strckercode;
            strckercode =([dictionary valueForKey:@"TeamCode"]);
            
            if([teamcode isEqualToString:strckercode])
            {
                
                player = [dictionary valueForKey:@"PlayerName"];
                
               NSString *plycde = [dictionary valueForKey:@"PlayerCode"];
                
                [self.updatedplayerlist addObject:player];
                
                [self.updatedplayercode addObject:plycde];
                
                
            }
            
        }
        
    }

    
    self.listTbl.hidden = NO;
    
    self.Tblx_position.constant = self.playerview.frame.origin.x;
    self.Tbly_position.constant = self.playerview.frame.origin.y+self.playerview.frame.size.height+10;
    [self.listTbl reloadData];
}

-(IBAction)ActivityTypeAction:(id)sender
{
    isTeam = NO;
    isPlayer =NO;
    isAct=YES;
    isRpe=NO;
    
    isView = NO;
    
    self.listTbl.hidden = NO;
    
    
    self.Tblx_position.constant = self.actview.frame.origin.x+5;
    self.Tbly_position.constant = self.actview.frame.origin.y+self.actview.frame.size.height+115;
    [self.listTbl reloadData];
}
-(IBAction)RPEAction:(id)sender
{
    
    isTeam = NO;
    isPlayer =NO;
    isAct=NO;
    isRpe=YES;
    
    isView = NO;
    
    isborderview=YES;
    isborderview1=NO;
    isborderview2=NO;
    isborderview3=NO;
    isborderview4=NO;
    isborderview5=NO;
    isborderview6=NO;
    isborderview7=NO;
    
    self.listTbl.hidden = NO;
    self.Tblx_position.constant = self.rpeview.frame.origin.x+5;
    self.Tbly_position.constant = self.rpeview.frame.origin.y+self.rpeview.frame.size.height+165;
    [self.listTbl reloadData];
}
-(IBAction)RPEAction1:(id)sender
{
    
    isTeam = NO;
    isPlayer =NO;
    isAct=NO;
    isRpe=YES;
    
    isView = NO;
    
    
    isborderview=NO;
    isborderview1=YES;
    isborderview2=NO;
    isborderview3=NO;
    isborderview4=NO;
    isborderview5=NO;
    isborderview6=NO;
    isborderview7=NO;
    
    self.listTbl.hidden = NO;
    self.Tblx_position.constant = self.rpeview1.frame.origin.x+5;
    self.Tbly_position.constant = self.rpeview1.frame.origin.y+self.rpeview1.frame.size.height+470;
    [self.listTbl reloadData];
}
-(IBAction)RPEAction2:(id)sender
{
    
    isTeam = NO;
    isPlayer =NO;
    isAct=NO;
    isRpe=YES;
    
    isView = NO;
    
    
    isborderview=NO;
    isborderview1=NO;
    isborderview2=YES;
    isborderview3=NO;
    isborderview4=NO;
    isborderview5=NO;
    isborderview6=NO;
    isborderview7=NO;
    
    self.listTbl.hidden = NO;
    self.Tblx_position.constant = self.rpeview2.frame.origin.x+5;
    self.Tbly_position.constant = self.rpeview2.frame.origin.y+self.rpeview2.frame.size.height+780;
    [self.listTbl reloadData];
}

-(IBAction)RPEAction3:(id)sender
{
    
    isTeam = NO;
    isPlayer =NO;
    isAct=NO;
    isRpe=YES;
    
    isView = NO;
    
    
    isborderview=NO;
    isborderview1=NO;
    isborderview2=NO;
    isborderview3=YES;
    isborderview4=NO;
    isborderview5=NO;
    isborderview6=NO;
    isborderview7=NO;
    
    self.listTbl.hidden = NO;
    self.Tblx_position.constant = self.rpeview3.frame.origin.x+5;
    self.Tbly_position.constant = self.rpeview3.frame.origin.y+self.rpeview3.frame.size.height+1090;
    [self.listTbl reloadData];
}

-(IBAction)RPEAction4:(id)sender
{
    
    isTeam = NO;
    isPlayer =NO;
    isAct=NO;
    isRpe=YES;
    
    isView = NO;
    
    
    isborderview=NO;
    isborderview1=NO;
    isborderview2=NO;
    isborderview3=NO;
    isborderview4=YES;
    isborderview5=NO;
    isborderview6=NO;
    isborderview7=NO;
    
    self.listTbl.hidden = NO;
    self.Tblx_position.constant = self.rpeview4.frame.origin.x+5;
    self.Tbly_position.constant = self.rpeview4.frame.origin.y+self.rpeview4.frame.size.height+1400;
    [self.listTbl reloadData];
}

-(IBAction)RPEAction5:(id)sender
{
    
    isTeam = NO;
    isPlayer =NO;
    isAct=NO;
    isRpe=YES;
    
    isView = NO;
    
    
    isborderview=NO;
    isborderview1=NO;
    isborderview2=NO;
    isborderview3=NO;
    isborderview4=NO;
    isborderview5=YES;
    isborderview6=NO;
    isborderview7=NO;
    
    self.listTbl.hidden = NO;
    self.Tblx_position.constant = self.rpeview5.frame.origin.x+5;
    self.Tbly_position.constant = self.rpeview5.frame.origin.y+self.rpeview5.frame.size.height+1710;
    [self.listTbl reloadData];
}

-(IBAction)RPEAction6:(id)sender
{
    
    isTeam = NO;
    isPlayer =NO;
    isAct=NO;
    isRpe=YES;
    
    isView = NO;
    
    
    isborderview=NO;
    isborderview1=NO;
    isborderview2=NO;
    isborderview3=NO;
    isborderview4=NO;
    isborderview5=NO;
    isborderview6=YES;
    isborderview7=NO;
    
    
    self.listTbl.hidden = NO;
    self.Tblx_position.constant = self.rpeview6.frame.origin.x+5;
    self.Tbly_position.constant = self.rpeview6.frame.origin.y+self.rpeview6.frame.size.height+2020;
    [self.listTbl reloadData];
}

-(IBAction)RPEAction7:(id)sender
{
    
    isTeam = NO;
    isPlayer =NO;
    isAct=NO;
    isRpe=YES;
    
    isView = NO;
    
    
    isborderview=NO;
    isborderview1=NO;
    isborderview2=NO;
    isborderview3=NO;
    isborderview4=NO;
    isborderview5=NO;
    isborderview6=NO;
    isborderview7=YES;
    
    self.listTbl.hidden = NO;
    self.Tblx_position.constant = self.rpeview7.frame.origin.x+5;
    self.Tbly_position.constant = self.rpeview7.frame.origin.y+self.rpeview7.frame.size.height+2330;
    [self.listTbl reloadData];
}


-(IBAction)dateAction:(id)sender
{
    
    // [self DisplaydatePicker];
    SACalendar *calendar = [[SACalendar alloc]initWithFrame:CGRectMake(self.dateview.frame.origin.x-135,self.dateview.frame.origin.y+self.dateview.frame.size.height+40,self.view.frame.size.width,self.view.frame.size.height-340) scrollDirection:ScrollDirectionVertical pagingEnabled:NO];
    
    calendar.delegate = self;
    //    NSString * currentDate =[NSString stringWithFormat:@"%d-%02d-%02d",year,month,day];
    //    self.callbl.text = currentDate;
    
    [self.view addSubview:calendar];
    //self.view_datepicker.hidden=NO;
}
-(void) SACalendar:(SACalendar*)calendar didSelectDate:(int)day month:(int)month year:(int)year
{
    NSString * selectdate =[NSString stringWithFormat:@"%d-%02d-%02d",day,month,year];
    
    self.datelbl.text = selectdate;
    
    NSString * selectdate1 =[NSString stringWithFormat:@"%d-%02d-%02d",year,month,day];
    
    actualDate=selectdate1;
    
    calendar.hidden = YES;
    
    [self dateWebservice];
    
    
}
-(void)dateWebservice
{
    
    
    NSString *rolecode = [[NSUserDefaults standardUserDefaults]stringForKey:@"RoleCode"];
    
    NSString *plycode;
    if( [rolecode isEqualToString:@"ROL0000002"] )
    {
        plycode = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
    }
    else
    {
        plycode = self.PlayerCode;
    }

    
    [objWebservice dateTrl : dateTrLKey :actualDate:plycode success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject=%@",responseObject);
        
        [self setClear];
        
        if(responseObject >0)
        {
            self.Responselist = [[NSMutableArray alloc]init];
            self.Responselist = responseObject;
            
            
            if( self.Responselist.count == 0)
            {
                self.BottomCountViewYPosition.constant = self.borderview1.frame.origin.y+100;
            }
            if( self.Responselist.count == 1)
            {
                self.BottomCountViewYPosition.constant = self.borderview2.frame.origin.y+100;
            }
            if( self.Responselist.count == 2)
            {
                self.BottomCountViewYPosition.constant = self.borderview3.frame.origin.y+100;
            }
            if( self.Responselist.count == 3)
            {
                self.BottomCountViewYPosition.constant = self.borderview4.frame.origin.y+100;
            }
            
            if( self.Responselist.count == 4)
            {
                self.BottomCountViewYPosition.constant = self.borderview5.frame.origin.y+100;
            }
            if( self.Responselist.count == 5)
            {
                self.BottomCountViewYPosition.constant = self.borderview6.frame.origin.y+100;
            }
            if( self.Responselist.count == 6)
            {
                self.BottomCountViewYPosition.constant = self.borderview7.frame.origin.y+100;
            }


            
            
            for(int i=0;self.Responselist.count>i;i++)
            {
                
                self.Viewslist = [self.Responselist objectAtIndex:i];
                
                NSString *ACTIVITYTYPECODE;
                NSString *RATEPERCEIVEDEXERTION;
                NSString *DURATION;
                NSString *BALL;
                
                ACTIVITYTYPECODE = [self.Viewslist valueForKey:@"ACTIVITYTYPECODE"];
                RATEPERCEIVEDEXERTION = [self.Viewslist valueForKey:@"RATEPERCEIVEDEXERTION"];
                DURATION = [self.Viewslist valueForKey:@"DURATION"];
                BALL = [self.Viewslist valueForKey:@"BALL"];
                WorkloadCode = [self.Viewslist valueForKey:@"WORKLOADCODE"];
                
                
                [self.dateActivityCode addObject:ACTIVITYTYPECODE];
                
                
                
                if([ACTIVITYTYPECODE isEqualToString:@"MSC053"])
                {
                    activityDescription = [self.activityDesc objectAtIndex:0];
                    actCode1=ACTIVITYTYPECODE;
                }
                else if([ACTIVITYTYPECODE isEqualToString:@"MSC054"])
                {
                    activityDescription = [self.activityDesc objectAtIndex:1];
                    actCode2=ACTIVITYTYPECODE;
                }
                else if([ACTIVITYTYPECODE isEqualToString:@"MSC055"])
                {
                    activityDescription = [self.activityDesc objectAtIndex:2];
                    actCode3=ACTIVITYTYPECODE;
                    
                }else if([ACTIVITYTYPECODE isEqualToString:@"MSC056"])
                {
                    activityDescription = [self.activityDesc objectAtIndex:3];
                    actCode4=ACTIVITYTYPECODE;
                    
                }else if([ACTIVITYTYPECODE isEqualToString:@"MSC057"])
                {
                    activityDescription = [self.activityDesc objectAtIndex:4];
                    actCode5=ACTIVITYTYPECODE;
                    
                }else if([ACTIVITYTYPECODE isEqualToString:@"MSC058"])
                {
                    activityDescription = [self.activityDesc objectAtIndex:5];
                    actCode6=ACTIVITYTYPECODE;
                    
                }
                else if([ACTIVITYTYPECODE isEqualToString:@"MSC059"])
                {
                    activityDescription = [self.activityDesc objectAtIndex:6];
                    actCode7=ACTIVITYTYPECODE;
                    
                }
                
                
                
                if([RATEPERCEIVEDEXERTION isEqualToString:@"MSC060"])
                {
                    rpeDescription = [self.rpeDesc objectAtIndex:0];
                }
                else if([RATEPERCEIVEDEXERTION isEqualToString:@"MSC061"])
                {
                    rpeDescription = [self.rpeDesc objectAtIndex:1];
                }
                else if([RATEPERCEIVEDEXERTION isEqualToString:@"MSC062"])
                {
                    rpeDescription = [self.rpeDesc objectAtIndex:2];
                }else if([RATEPERCEIVEDEXERTION isEqualToString:@"MSC063"])
                {
                    rpeDescription = [self.rpeDesc objectAtIndex:3];
                }else if([RATEPERCEIVEDEXERTION isEqualToString:@"MSC064"])
                {
                    rpeDescription = [self.rpeDesc objectAtIndex:4];
                }else if([RATEPERCEIVEDEXERTION isEqualToString:@"MSC065"])
                {
                    rpeDescription = [self.rpeDesc objectAtIndex:5];
                }
                else if([RATEPERCEIVEDEXERTION isEqualToString:@"MSC066"])
                {
                    rpeDescription = [self.rpeDesc objectAtIndex:6];
                }
                else if([RATEPERCEIVEDEXERTION isEqualToString:@"MSC067"])
                {
                    rpeDescription = [self.rpeDesc objectAtIndex:7];
                }
                else if([RATEPERCEIVEDEXERTION isEqualToString:@"MSC068"])
                {
                    rpeDescription = [self.rpeDesc objectAtIndex:8];
                }
                else if([RATEPERCEIVEDEXERTION isEqualToString:@"MSC069"])
                {
                    rpeDescription = [self.rpeDesc objectAtIndex:9];
                }
                
                else if([RATEPERCEIVEDEXERTION isEqualToString:@"MSC070"])
                {
                    rpeDescription = [self.rpeDesc objectAtIndex:10];
                }
                
                else if([RATEPERCEIVEDEXERTION isEqualToString:@"MSC071"])
                {
                    rpeDescription = [self.rpeDesc objectAtIndex:11];
                }
                
                
                
                if(i==0)
                {
                    self.activitylbl1.text = activityDescription;
                    self.rpelbl1.text = rpeDescription;
                    self.timecount1.text = DURATION;
                    self.ballscount1.text = BALL;
                    
                    self.borderview1.hidden=NO;
                    self.RemoveView1.hidden = NO;
                }
                
                if(i==1)
                {
                    self.activitylbl2.text = activityDescription;
                    self.rpelbl2.text = rpeDescription;
                    self.timecount2.text = DURATION;
                    self.ballscount2.text = BALL;
                    
                    self.borderview2.hidden=NO;
                    self.RemoveView2.hidden = NO;
                }
                
                
                if(i==2)
                {
                    self.activitylbl3.text = activityDescription;
                    self.rpelbl3.text = rpeDescription;
                    self.timecount3.text = DURATION;
                    self.ballscount3.text = BALL;
                    
                    self.borderview3.hidden=NO;
                    self.RemoveView3.hidden = NO;
                }
                
                
                if(i==3)
                {
                    self.activitylbl4.text = activityDescription;
                    self.rpelbl4.text = rpeDescription;
                    self.timecount4.text = DURATION;
                    self.ballscount4.text = BALL;
                    
                    self.borderview4.hidden=NO;
                    self.RemoveView4.hidden = NO;
                }
                
                if(i==4)
                {
                    self.activitylbl5.text = activityDescription;
                    self.rpelbl5.text = rpeDescription;
                    self.timecount5.text = DURATION;
                    self.ballscount5.text = BALL;
                    
                    self.borderview5.hidden=NO;
                    self.RemoveView5.hidden = NO;
                }
                
                
                if(i==5)
                {
                    self.activitylbl6.text = activityDescription;
                    self.rpelbl6.text = rpeDescription;
                    self.timecount6.text = DURATION;
                    self.ballscount6.text = BALL;
                    
                    self.borderview6.hidden=NO;
                    self.RemoveView6.hidden = NO;
                }
                
                
                if(i==6)
                {
                    self.activitylbl7.text = activityDescription;
                    self.rpelbl7.text = rpeDescription;
                    self.timecount7.text = DURATION;
                    self.ballscount7.text = BALL;
                    
                    self.borderview7.hidden=NO;
                    self.RemoveView7.hidden = NO;
                }
                
                
            }
            
        }
        self.Update.hidden = NO;
        
        [self loadingcount];
        //[self.ViewsTbl reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, id error) {
        NSLog(@"failed");
        [COMMON webServiceFailureError];
    }];
    
}

-(void)setClear
{
    self.borderview1.hidden=YES;
    self.borderview2.hidden=YES;
    self.borderview3.hidden=YES;
    self.borderview4.hidden=YES;
    self.borderview5.hidden=YES;
    self.borderview6.hidden=YES;
    self.borderview7.hidden=YES;
    
    self.RemoveView1.hidden=YES;
    self.RemoveView2.hidden=YES;
    self.RemoveView3.hidden=YES;
    self.RemoveView4.hidden=YES;
    self.RemoveView5.hidden=YES;
    self.RemoveView6.hidden=YES;
    self.RemoveView7.hidden=YES;
}

-(void)trainingLoadWebservice
{
    
    NSString *clientcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    
    
    [objWebservice getTRLDetails :TRDetailsKey :clientcode success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject=%@",responseObject);
        if(responseObject >0)
        {
            
            self.teamlist = [[NSMutableArray alloc]init];
            self.playerlist = [[NSMutableArray alloc]init];
            self.activitylist = [[NSMutableArray alloc]init];
            self.rpelist = [[NSMutableArray alloc]init];
            self.activityCodelist = [[NSMutableArray alloc]init];
            self.rpeCodelist = [[NSMutableArray alloc]init];
            
            self.activityDesc = [[NSMutableArray alloc]init];
            self.rpeDesc = [[NSMutableArray alloc]init];
            
            self.PlayerCodelist = [[NSMutableArray alloc]init];
            
            
            
            self.teamlist = [responseObject valueForKey:@"Teams"];
            self.playerlist = [responseObject valueForKey:@"Players"];
            self.activitylist = [responseObject valueForKey:@"ActivityTypes"];
            self.rpelist = [responseObject valueForKey:@"Rpes"];
            
            
            self.activityDesc = [self.activitylist valueForKey:@"MetaSubcodeDescription"];
            self.rpeDesc = [self.rpelist valueForKey:@"MetaSubcodeDescription"];
            
            self.activityCodelist = [self.activitylist valueForKey:@"MetaSubCode"];
            self.rpeCodelist = [self.rpelist valueForKey:@"MetaSubCode"];
            self.PlayerCodelist = [self.playerlist valueForKey:@"PlayerCode"];
            
            
            
            
            self.Getdesclist = [[NSMutableArray alloc]init];
            self.GetrpeDesclist = [[NSMutableArray alloc]init];
            
            //            for(int i=0;self.activitylist.count>i;i++)
            //            {
            //                if([metaSubcode1 isEqualToString:ACTIVITYTYPECODE])
            //                {
            //                    [self.Getdesclist addObject:[self.activitylist objectAtIndex:i]];
            //                }
            //
            //            }
            //            self.activitylbl1.text = [self.Getdesclist valueForKey:@"MetaSubcodeDescription"];
            //            for(int i=0;self.rpelist.count>i;i++)
            //            {
            //                if([metaSubcode2 isEqualToString:RATEPERCEIVEDEXERTION])
            //                {
            //                    [self.GetrpeDesclist addObject:[self.rpelist objectAtIndex:i]];
            //                }
            //
            //            }
            //            self.rpelbl1.text = [self.Getdesclist valueForKey:@"MetaSubcodeDescription"];
            
            
            //          self.timecount1.text = DURATION;
            //          self.ballscount1.text = BALL;
            
            
            
            
            
        }
        //isgrid=NO;
        [self.listTbl reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, id error) {
        NSLog(@"failed");
        [COMMON webServiceFailureError];
    }];
    
}
-(void)activityAddWebservice
{
    
    NSString *usercode = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
    
    
    
    NSString *rolecode = [[NSUserDefaults standardUserDefaults]stringForKey:@"RoleCode"];
    
    NSString *plycode;
    
    if( [rolecode isEqualToString:@"ROL0000003"] )
    {
        plycode = self.PlayerCode;
    }
    else
        
    {
        plycode =  [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
    }
    
    NSString *balls;
    if([self.ballscount.text isEqual:[NSNull null]] || [self.ballscount.text isEqualToString: @""])
    {
        balls = @"0";
    }
    else
    {
        balls = self.ballscount.text;
    }
    
    
    [objWebservice AddActivityDetails :addActivityKey :usercode :actualDate :plycode:metaSubcode1 :metaSubcode2 :self.timecount.text :balls success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject=%@",responseObject);
        if(responseObject >0)
        {
            //NSString * key = @"false";
            NSString * message = [responseObject valueForKey:@"Message"];
            if([message isEqualToString:@"Success"])
            {
                self.workingloadlist = [[NSMutableArray alloc]init];
                
                self.workingloadlist =  [responseObject valueForKey:@"WorkloadTraingDetails"];
                // self.Viewslist1 = [[NSMutableArray alloc]init];
                
                
                self.Viewslist1 = [self.workingloadlist objectAtIndex:[self.workingloadlist count]-1];
                
                NSString *ACTIVITYTYPECODE;
                NSString *RATEPERCEIVEDEXERTION;
                NSString *DURATION;
                NSString *BALL;
                
                
                
                ACTIVITYTYPECODE = [self.Viewslist1 valueForKey:@"ACTIVITYTYPECODE"];
                RATEPERCEIVEDEXERTION = [self.Viewslist1 valueForKey:@"RATEPERCEIVEDEXERTION"];
                DURATION = [self.Viewslist1 valueForKey:@"DURATION"];
                BALL = [self.Viewslist1 valueForKey:@"BALL"];
                
                
                
                
                
                if([ACTIVITYTYPECODE isEqualToString:@"MSC053"])
                {
                    activityDescription = [self.activityDesc objectAtIndex:0];
                    actCode1 = ACTIVITYTYPECODE;
                }
                else if([ACTIVITYTYPECODE isEqualToString:@"MSC054"])
                {
                    activityDescription = [self.activityDesc objectAtIndex:1];
                    actCode2 = ACTIVITYTYPECODE;
                }
                else if([ACTIVITYTYPECODE isEqualToString:@"MSC055"])
                {
                    activityDescription = [self.activityDesc objectAtIndex:2];
                    actCode3 = ACTIVITYTYPECODE;
                }else if([ACTIVITYTYPECODE isEqualToString:@"MSC056"])
                {
                    activityDescription = [self.activityDesc objectAtIndex:3];
                    actCode4 = ACTIVITYTYPECODE;
                }else if([ACTIVITYTYPECODE isEqualToString:@"MSC057"])
                {
                    activityDescription = [self.activityDesc objectAtIndex:4];
                    actCode5 = ACTIVITYTYPECODE;
                }else if([ACTIVITYTYPECODE isEqualToString:@"MSC058"])
                {
                    activityDescription = [self.activityDesc objectAtIndex:5];
                    actCode6 = ACTIVITYTYPECODE;
                }
                else if([ACTIVITYTYPECODE isEqualToString:@"MSC059"])
                {
                    activityDescription = [self.activityDesc objectAtIndex:6];
                    actCode7 = ACTIVITYTYPECODE;
                }
                
                
                
                if([RATEPERCEIVEDEXERTION isEqualToString:@"MSC060"])
                {
                    rpeDescription = [self.rpeDesc objectAtIndex:0];
                }
                else if([RATEPERCEIVEDEXERTION isEqualToString:@"MSC061"])
                {
                    rpeDescription = [self.rpeDesc objectAtIndex:1];
                }
                else if([RATEPERCEIVEDEXERTION isEqualToString:@"MSC062"])
                {
                    rpeDescription = [self.rpeDesc objectAtIndex:2];
                }else if([RATEPERCEIVEDEXERTION isEqualToString:@"MSC063"])
                {
                    rpeDescription = [self.rpeDesc objectAtIndex:3];
                }else if([RATEPERCEIVEDEXERTION isEqualToString:@"MSC064"])
                {
                    rpeDescription = [self.rpeDesc objectAtIndex:4];
                }else if([RATEPERCEIVEDEXERTION isEqualToString:@"MSC065"])
                {
                    rpeDescription = [self.rpeDesc objectAtIndex:5];
                }
                else if([RATEPERCEIVEDEXERTION isEqualToString:@"MSC066"])
                {
                    rpeDescription = [self.rpeDesc objectAtIndex:6];
                }
                else if([RATEPERCEIVEDEXERTION isEqualToString:@"MSC067"])
                {
                    rpeDescription = [self.rpeDesc objectAtIndex:7];
                }
                else if([RATEPERCEIVEDEXERTION isEqualToString:@"MSC068"])
                {
                    rpeDescription = [self.rpeDesc objectAtIndex:8];
                }
                else if([RATEPERCEIVEDEXERTION isEqualToString:@"MSC069"])
                {
                    rpeDescription = [self.rpeDesc objectAtIndex:9];
                }
                
                else if([RATEPERCEIVEDEXERTION isEqualToString:@"MSC070"])
                {
                    rpeDescription = [self.rpeDesc objectAtIndex:10];
                }
                
                else if([RATEPERCEIVEDEXERTION isEqualToString:@"MSC071"])
                {
                    rpeDescription = [self.rpeDesc objectAtIndex:11];
                }
                
                if(self.workingloadlist.count-1 == 0)
                {
                    self.activitylbl1.text = activityDescription;
                    self.rpelbl1.text = rpeDescription;
                    self.timecount1.text = DURATION;
                    self.ballscount1.text = BALL;
                    
                    self.borderview1.hidden=NO;
                    self.RemoveView1.hidden = NO;
                }
                
                if(self.workingloadlist.count-1 == 1)
                {
                    self.activitylbl2.text = activityDescription;
                    self.rpelbl2.text = rpeDescription;
                    self.timecount2.text = DURATION;
                    self.ballscount2.text = BALL;
                    
                    self.borderview2.hidden=NO;
                    self.RemoveView2.hidden = NO;
                }
                if(self.workingloadlist.count-1 == 2)
                {
                    self.activitylbl3.text = activityDescription;
                    self.rpelbl3.text = rpeDescription;
                    self.timecount3.text = DURATION;
                    self.ballscount3.text = BALL;
                    
                    self.borderview3.hidden=NO;
                    self.RemoveView3.hidden = NO;
                }
                
                if(self.workingloadlist.count-1 == 3)
                {
                    self.activitylbl4.text = activityDescription;
                    self.rpelbl4.text = rpeDescription;
                    self.timecount4.text = DURATION;
                    self.ballscount4.text = BALL;
                    
                    self.borderview4.hidden=NO;
                    self.RemoveView4.hidden = NO;
                }
                if(self.workingloadlist.count-1 == 4)
                {
                    self.activitylbl5.text = activityDescription;
                    self.rpelbl5.text = rpeDescription;
                    self.timecount5.text = DURATION;
                    self.ballscount5.text = BALL;
                    
                    self.borderview5.hidden=NO;
                    self.RemoveView5.hidden = NO;
                }
                if(self.workingloadlist.count-1 == 5)
                {
                    self.activitylbl6.text = activityDescription;
                    self.rpelbl6.text = rpeDescription;
                    self.timecount6.text = DURATION;
                    self.ballscount6.text = BALL;
                    
                    self.borderview6.hidden=NO;
                    self.RemoveView6.hidden = NO;
                }
                if(self.workingloadlist.count-1 == 6)
                {
                    self.activitylbl7.text = activityDescription;
                    self.rpelbl7.text = rpeDescription;
                    self.timecount7.text = DURATION;
                    self.ballscount7.text = BALL;
                    
                    self.borderview7.hidden=NO;
                    self.RemoveView7.hidden = NO;
                }
                
                [self ShowAlterMsg:@"Activity Inserted Successfully "];
                
                self.activitylbl.text = @"";
                self.rpelbl.text = @"";
                self.timecount.text = @"";
                self.ballscount.text = @"";
                
                self.Update.hidden = NO;
                
            }
            else
            {
                
                [self ShowAlterMsg:@"Activity Already exists "];
                
            }
            
            
            
            
        }
        
        [self dateWebservice];
        
        [self loadingcount];
        
    } failure:^(AFHTTPRequestOperation *operation, id error) {
        NSLog(@"failed");
        [COMMON webServiceFailureError];
    }];
    
}

-(void)RemoveWebservice
{
    
    NSString *usercode = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
    NSString *rolecode = [[NSUserDefaults standardUserDefaults]stringForKey:@"RoleCode"];
    
    NSString *plycode;
    
    if( [rolecode isEqualToString:@"ROL0000003"] )
    {
        plycode = self.PlayerCode;
    }
    else
        
    {
        plycode =  [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
    }
    
    
    
    [objWebservice RemoveDtls :RemoveKey :usercode :plycode :WorkloadCode :actualDate :ActCode success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject=%@",responseObject);
        if(responseObject >0)
        {
            
            [self ShowAlterMsg:@"Activity Record Removed Successfully "];
            
        }
        //isgrid=NO;
        [self.listTbl reloadData];
        [self dateWebservice];
        
        
    } failure:^(AFHTTPRequestOperation *operation, id error) {
        NSLog(@"failed");
        [COMMON webServiceFailureError];
    }];
    
}
-(void)UpdateWebservice
{
    [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",UpdateRecord]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        NSString * usercode = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
        NSMutableArray * objArray =[[NSMutableArray alloc]init];
        for (int i=0; i<self.workingloadlist.count;i++)
        {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            
            if([[self.workingloadlist valueForKey:@"ACTIVITYTYPECODE"]objectAtIndex:i])   [dic    setObject:[[self.workingloadlist valueForKey:@"ACTIVITYTYPECODE"]objectAtIndex:i]     forKey:@"ACTIVITYTYPECODE"];
            
            if([[self.workingloadlist valueForKey:@"RATEPERCEIVEDEXERTION"]objectAtIndex:i])   [dic    setObject:[[self.workingloadlist valueForKey:@"RATEPERCEIVEDEXERTION"]objectAtIndex:i]     forKey:@"RATEPERCEIVEDEXERTION"];
            
            if([[self.workingloadlist valueForKey:@"BALL"]objectAtIndex:i])   [dic    setObject:[[self.workingloadlist valueForKey:@"BALL"]objectAtIndex:i]     forKey:@"BALL"];
            
            if([[self.workingloadlist valueForKey:@"WORKLOADCODE"]objectAtIndex:i])   [dic    setObject:[[self.workingloadlist valueForKey:@"WORKLOADCODE"]objectAtIndex:i]     forKey:@"WORKLOADCODE"];
            
            if(usercode) [dic setObject:usercode forKey:@"USERCODE"];
            
            if([[self.workingloadlist valueForKey:@"WORKLOADDATE"]objectAtIndex:i])   [dic    setObject:[[self.workingloadlist valueForKey:@"WORKLOADDATE"]objectAtIndex:i]     forKey:@"WORKLOADDATE"];
            
            if([[self.workingloadlist valueForKey:@"DURATION"]objectAtIndex:i])   [dic    setObject:[[self.workingloadlist valueForKey:@"DURATION"]objectAtIndex:i]     forKey:@"DURATION"];
            
            
            if([[self.workingloadlist valueForKey:@"PLAYERCODE"]objectAtIndex:i])   [dic    setObject:[[self.workingloadlist valueForKey:@"PLAYERCODE"]objectAtIndex:i]     forKey:@"PLAYERCODE"];
            
            [objArray addObject:dic];
        }
        
        //        [rootObj setObject:cliendcode forKey:@"ClientCode"];
        //        [rootObj setObject:[self.objSelectEditDic valueForKey:@"id"] forKey:@"EventCode"];
        //        [rootObj setObject:self.eventnameTxt.text forKey:@"EventName"];
        //        [rootObj setObject:self.startdateLbl.text forKey:@"StartDate"];
        //        [rootObj setObject:self.enddateLbl.text forKey:@"EndDate"];
        //        [rootObj setObject:self.startTimeLbl.text forKey:@"StartTime"];
        //        [rootObj setObject:self.endTimeLbl.text forKey:@"EndTime"];
        //        [rootObj setObject:selectEventTypeCode forKey:@"EventTypeCode"];
        //        [rootObj setObject:selectEventStatusCode forKey:@"EventStatusCode"];
        //        [rootObj setObject:self.commentTxt.text forKey:@"Comments"];
        //        [rootObj setObject:usercode forKey:@"CreatedBy"];
        //        [rootObj setObject:objArray forKey:@"lstEventTemplateParticipants"];
        
        
        //NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:objArray success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                NSLog(@"%@",responseObject);
                BOOL status=[responseObject valueForKey:@"result"];
                if(status == YES)
                {
                    
                    
                }
                else{
                    
                }
            }
            
            [COMMON RemoveLoadingIcon];
            [self.view setUserInteractionEnabled:YES];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed");
            [COMMON webServiceFailureError];
            [self.view setUserInteractionEnabled:YES];
            
        }];
    }
    
}


-(void)ShowAlterMsg:(NSString*) MsgStr
{
    UIAlertView *objAlter =[[UIAlertView alloc]initWithTitle:@"" message:MsgStr delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [objAlter show];
    
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
    else if(isAct)
    {
        return self.activitylist.count;
    }
    else if(isRpe)
    {
        return self.rpelist.count;
    }
    
    return nil;
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(isTeam)
    {
        
        
        //cell.textLabel.text = [self.teamlist[indexPath.row] valueForKey:@"TeamName"];
        //[self populateCell:cell atIndexPath:indexPath];
        
        static NSString *CRTableViewCellIdentifier = @"cellIdentifier";
        
        
        CRTableViewCell *cell = (CRTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CRTableViewCellIdentifier];
        
        if (cell == nil) {
            cell = [[CRTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CRTableViewCellIdentifier];
        }
        
        
        teamcode = [self.teamlist[indexPath.row] valueForKey:@"TeamCode"];
        
        NSString *text = [self.teamlist[indexPath.row] valueForKey:@"TeamName"];
        cell.isSelected = [self.selectedMarks containsObject:teamcode] ? YES : NO;
        cell.textLabel.text = text;
        return cell;

    }
    
    if(isPlayer)
    {
        static NSString *MyIdentifier = @"MyIdentifier";
        
        //static NSString *Identifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:nil];
            //cell.backgroundColor = [UIColor whiteColor];
            cell.textColor = [UIColor blackColor];
        }

        cell.textLabel.text = self.updatedplayerlist[indexPath.row] ;
        return cell;
    }
    if(isAct)
    {
        static NSString *MyIdentifier = @"MyIdentifier";
        
        //static NSString *Identifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:nil];
            //cell.backgroundColor = [UIColor whiteColor];
            cell.textColor = [UIColor blackColor];
        }

        cell.textLabel.text = [self.activitylist[indexPath.row] valueForKey:@"MetaSubcodeDescription"];
        metaSubcode1 = self.activityCodelist[indexPath.row];
        return cell;
    }
    if(isRpe)
    {
        static NSString *MyIdentifier = @"MyIdentifier";
        
        //static NSString *Identifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:nil];
            //cell.backgroundColor = [UIColor whiteColor];
            cell.textColor = [UIColor blackColor];
        }

        cell.textLabel.text = [self.rpelist[indexPath.row] valueForKey:@"MetaSubcodeDescription"];
        metaSubcode2 = self.rpeCodelist[indexPath.row];
        return cell;
        
    }
    
    //[self.listTbl setEditing:YES animated:YES];
    return nil;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if(isTeam)
    {
        
//        self.listTbl.hidden = YES;
//        self.teamlbl.text = [self.teamlist[indexPath.row] valueForKey:@"TeamName"];
//        teamcode = [self.teamlist[indexPath.row] valueForKey:@"TeamCode"];
        
        teamcode = [[self.teamlist objectAtIndex:indexPath.row] valueForKey:@"TeamCode"];
        if ([self.selectedMarks containsObject:teamcode])// Is selected?
            [self.selectedMarks removeObject:teamcode];
        else
            [self.selectedMarks addObject:teamcode];
        
        static NSString *CRTableViewCellIdentifier = @"cellIdentifier";
        
        CRTableViewCell *cell = (CRTableViewCell *)[self.MultiTbl dequeueReusableCellWithIdentifier:CRTableViewCellIdentifier];
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
        self.PlayerCode = self.updatedplayercode[indexPath.row];
    }
    if(isAct)
    {
        self.listTbl.hidden = YES;
        self.activitylbl.text = [self.activitylist[indexPath.row] valueForKey:@"MetaSubcodeDescription"];
        self.ballsview.hidden=YES;
        metaSubcode1 = self.activityCodelist[indexPath.row];
        
        if(indexPath.row==6)
        {
            self.ballsview.hidden=NO;
        }
    }
    if(isRpe)
    {
        if(isborderview)
        {
            
            self.listTbl.hidden = YES;
            self.rpelbl.text = [self.rpelist[indexPath.row] valueForKey:@"MetaSubcodeDescription"];
            metaSubcode2 = self.rpeCodelist[indexPath.row];
        }
        if(isborderview1)
        {
            
            self.listTbl.hidden = YES;
            self.rpelbl1.text = [self.rpelist[indexPath.row] valueForKey:@"MetaSubcodeDescription"];
        }
        if(isborderview2)
        {
            
            self.listTbl.hidden = YES;
            self.rpelbl2.text = [self.rpelist[indexPath.row] valueForKey:@"MetaSubcodeDescription"];
        }
        if(isborderview3)
        {
            
            self.listTbl.hidden = YES;
            self.rpelbl3.text = [self.rpelist[indexPath.row] valueForKey:@"MetaSubcodeDescription"];
        }
        if(isborderview4)
        {
            
            self.listTbl.hidden = YES;
            self.rpelbl4.text = [self.rpelist[indexPath.row] valueForKey:@"MetaSubcodeDescription"];
        }
        if(isborderview5)
        {
            
            self.listTbl.hidden = YES;
            self.rpelbl5.text = [self.rpelist[indexPath.row] valueForKey:@"MetaSubcodeDescription"];
        }
        if(isborderview6)
        {
            
            self.listTbl.hidden = YES;
            self.rpelbl6.text = [self.rpelist[indexPath.row] valueForKey:@"MetaSubcodeDescription"];
        }
        if(isborderview7)
        {
            
            self.listTbl.hidden = YES;
            self.rpelbl7.text = [self.rpelist[indexPath.row] valueForKey:@"MetaSubcodeDescription"];
        }
        
        
        
        
        [self loadingcount];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if(isView)
    {
        return 250;
    }
    else
    {
        return 30;
    }
    
}
-(IBAction)SubmitAction:(id)sender
{
    
    self.commonView.hidden = YES;
    
}
-(IBAction)CancelAction:(id)sender
{
    
    self.commonView.hidden = YES;
    
}



- (IBAction)timecountAction:(id)sender
{
    [self loadingcount];
}

-(void)loadingcount
{
    
    int a = ([self.timecount.text intValue]);
    double b = [self.rpelbl.text doubleValue];
    int result;
    
    
    int c = ([self.timecount1.text intValue]);
    double d = [self.rpelbl1.text doubleValue];
    
    int e = ([self.timecount2.text intValue]);
    double f = [self.rpelbl2.text doubleValue];
    
    int g = ([self.timecount3.text intValue]);
    double h = [self.rpelbl3.text doubleValue];
    
    int i = ([self.timecount4.text intValue]);
    double j = [self.rpelbl4.text doubleValue];
    
    int k = ([self.timecount5.text intValue]);
    double l = [self.rpelbl5.text doubleValue];
    
    int m = ([self.timecount6.text intValue]);
    double n = [self.rpelbl6.text doubleValue];
    
    int o = ([self.timecount7.text intValue]);
    double p = [self.rpelbl7.text doubleValue];
    
    result = (a*b)+(c*d)+(e*f)+(g*h)+(i*j)+(k*l)+(m*n)+(o*p);
    
    
    
    
    
    self.countlbl.text = [NSString stringWithFormat:@"%d", result];
    
    NSLog(@"%d", result);
    
    
}



-(IBAction)RemoveAction1:(id)sender
{
    if([self.activitylbl1.text isEqualToString: @"Match"] )
    {
        ActCode = actCode1;
    }
    if([self.activitylbl1.text isEqualToString: @"Strengthening"] )
    {
        ActCode = actCode2;
    }
    if([self.activitylbl1.text isEqualToString: @"Conditioning"] )
    {
        ActCode = actCode3;
    }
    if([self.activitylbl1.text isEqualToString: @"Cardio"] )
    {
        ActCode = actCode4;
    }
    if([self.activitylbl1.text isEqualToString: @"Net Session"] )
    {
        ActCode = actCode5;
    }
    if([self.activitylbl1.text isEqualToString: @"Recovery"] )
    {
        ActCode = actCode6;
    }
    if([self.activitylbl1.text isEqualToString: @"Bowling"] )
    {
        ActCode = actCode7;
    }
    
    [self RemoveWebservice];
    self.borderview1.hidden = YES;
    self.RemoveView1.hidden = YES;
    
}
-(IBAction)RemoveAction2:(id)sender
{
    if([self.activitylbl2.text isEqualToString: @"Match"] )
    {
        ActCode = actCode1;
    }
    if([self.activitylbl2.text isEqualToString: @"Strengthening"] )
    {
        ActCode = actCode2;
    }
    if([self.activitylbl2.text isEqualToString: @"Conditioning"] )
    {
        ActCode = actCode3;
    }
    if([self.activitylbl2.text isEqualToString: @"Cardio"] )
    {
        ActCode = actCode4;
    }
    if([self.activitylbl2.text isEqualToString: @"Net Session"] )
    {
        ActCode = actCode5;
    }
    if([self.activitylbl2.text isEqualToString: @"Recovery"] )
    {
        ActCode = actCode6;
    }
    if([self.activitylbl2.text isEqualToString: @"Bowling"] )
    {
        ActCode = actCode7;
    }
    
    
    
    [self RemoveWebservice];
    self.borderview2.hidden = YES;
    self.RemoveView2.hidden = YES;
    
}
-(IBAction)RemoveAction3:(id)sender
{
    if([self.activitylbl3.text isEqualToString: @"Match"] )
    {
        ActCode = actCode1;
    }
    if([self.activitylbl3.text isEqualToString: @"Strengthening"] )
    {
        ActCode = actCode2;
    }
    if([self.activitylbl3.text isEqualToString: @"Conditioning"] )
    {
        ActCode = actCode3;
    }
    if([self.activitylbl3.text isEqualToString: @"Cardio"] )
    {
        ActCode = actCode4;
    }
    if([self.activitylbl3.text isEqualToString: @"Net Session"] )
    {
        ActCode = actCode5;
    }
    if([self.activitylbl3.text isEqualToString: @"Recovery"] )
    {
        ActCode = actCode6;
    }
    if([self.activitylbl3.text isEqualToString: @"Bowling"] )
    {
        ActCode = actCode7;
    }
    
    
    [self RemoveWebservice];
    self.borderview3.hidden = YES;
    self.RemoveView3.hidden = YES;
    
}
-(IBAction)RemoveAction4:(id)sender
{
    if([self.activitylbl4.text isEqualToString: @"Match"] )
    {
        ActCode = actCode1;
    }
    if([self.activitylbl4.text isEqualToString: @"Strengthening"] )
    {
        ActCode = actCode2;
    }
    if([self.activitylbl4.text isEqualToString: @"Conditioning"] )
    {
        ActCode = actCode3;
    }
    if([self.activitylbl4.text isEqualToString: @"Cardio"] )
    {
        ActCode = actCode4;
    }
    if([self.activitylbl4.text isEqualToString: @"Net Session"] )
    {
        ActCode = actCode5;
    }
    if([self.activitylbl4.text isEqualToString: @"Recovery"] )
    {
        ActCode = actCode6;
    }
    if([self.activitylbl4.text isEqualToString: @"Bowling"] )
    {
        ActCode = actCode7;
    }
    
    
    [self RemoveWebservice];
    self.borderview4.hidden = YES;
    self.RemoveView4.hidden = YES;
    
}
-(IBAction)RemoveAction5:(id)sender
{
    
    if([self.activitylbl5.text isEqualToString: @"Match"] )
    {
        ActCode = actCode1;
    }
    if([self.activitylbl5.text isEqualToString: @"Strengthening"] )
    {
        ActCode = actCode2;
    }
    if([self.activitylbl5.text isEqualToString: @"Conditioning"] )
    {
        ActCode = actCode3;
    }
    if([self.activitylbl5.text isEqualToString: @"Cardio"] )
    {
        ActCode = actCode4;
    }
    if([self.activitylbl5.text isEqualToString: @"Net Session"] )
    {
        ActCode = actCode5;
    }
    if([self.activitylbl5.text isEqualToString: @"Recovery"] )
    {
        ActCode = actCode6;
    }
    if([self.activitylbl5.text isEqualToString: @"Bowling"] )
    {
        ActCode = actCode7;
    }
    
    [self RemoveWebservice];
    self.borderview5.hidden = YES;
    self.RemoveView5.hidden = YES;
    
}

-(IBAction)RemoveAction6:(id)sender
{
    if([self.activitylbl6.text isEqualToString: @"Match"] )
    {
        ActCode = actCode1;
    }
    if([self.activitylbl6.text isEqualToString: @"Strengthening"] )
    {
        ActCode = actCode2;
    }
    if([self.activitylbl6.text isEqualToString: @"Conditioning"] )
    {
        ActCode = actCode3;
    }
    if([self.activitylbl6.text isEqualToString: @"Cardio"] )
    {
        ActCode = actCode4;
    }
    if([self.activitylbl6.text isEqualToString: @"Net Session"] )
    {
        ActCode = actCode5;
    }
    if([self.activitylbl6.text isEqualToString: @"Recovery"] )
    {
        ActCode = actCode6;
    }
    if([self.activitylbl6.text isEqualToString: @"Bowling"] )
    {
        ActCode = actCode7;
    }
    
    
    [self RemoveWebservice];
    self.borderview6.hidden = YES;
    self.RemoveView6.hidden = YES;
    
}
-(IBAction)RemoveAction7:(id)sender
{
    if([self.activitylbl7.text isEqualToString: @"Match"] )
    {
        ActCode = actCode1;
    }
    if([self.activitylbl7.text isEqualToString: @"Strengthening"] )
    {
        ActCode = actCode2;
    }
    if([self.activitylbl7.text isEqualToString: @"Conditioning"] )
    {
        ActCode = actCode3;
    }
    if([self.activitylbl7.text isEqualToString: @"Cardio"] )
    {
        ActCode = actCode4;
    }
    if([self.activitylbl7.text isEqualToString: @"Net Session"] )
    {
        ActCode = actCode5;
    }
    if([self.activitylbl7.text isEqualToString: @"Recovery"] )
    {
        ActCode = actCode6;
    }
    if([self.activitylbl7.text isEqualToString: @"Bowling"] )
    {
        ActCode = actCode7;
    }
    
    
    [self RemoveWebservice];
    self.borderview7.hidden = YES;
    self.RemoveView7.hidden = YES;
    
}
-(IBAction)UpadateAction:(id)sender
{
    
    [self UpdateWebservice];
    
}



-(IBAction)AddActivityAction:(id)sender
{
    isTeam = NO;
    isPlayer =NO;
    isAct=NO;
    isRpe=NO;
    isView = YES;
    
    
    [self activityAddWebservice];
    
}

-(IBAction)MenuBtnAction:(id)sender
{
    [COMMON AddMenuView:self.view];
    
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
