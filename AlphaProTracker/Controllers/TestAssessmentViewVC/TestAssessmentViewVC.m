//
//  AssesmentVC.m
//  AlphaProTracker
//
//  Created by Lexicon on 24/08/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "TestAssessmentViewVC.h"
#import "CustomNavigation.h"
#import "AppCommon.h"
#import "Config.h"
#import "WebService.h"
#import "SACalendar.h"
#import "TestAssessmentListVC.h"
#import "HomeVC.h"
#import "DBAConnection.h"

#import "INTUGroupedArrayImports.h"
#import "INTUFruitCategory.h"
#import "INTUFruit.h"



@interface TestAssessmentViewVC ()<SACalendarDelegate>
{
    WebService *objWebService;
    NSString * SelectClientCode;
    NSString * SelectModuleCode;
    NSString * SelectCreatedby;
    NSString * AssessmentCode;
    
    NSMutableArray *list;
    NSMutableArray *aslist;
    NSMutableArray *asblist;
    NSMutableArray *asbblist;
    NSString *actualdate;
    
    NSMutableArray *TestHeader;
    
    
    NSMutableArray *poplistArray;
    NSMutableArray *assmntCodeArray;
    
    
    NSMutableArray *addedArray;
    
    BOOL isgrid;
    BOOL isAses;
    
}
#if __has_feature(objc_generics)
@property (nonatomic, strong) INTUMutableGroupedArray<INTUFruitCategory *, INTUFruit *> *groupedArray;
#else
@property (nonatomic, strong) INTUMutableGroupedArray *groupedArray;
#endif

#if __has_feature(objc_generics)
@property (nonatomic, strong) INTUMutableGroupedArray<INTUFruitCategory *, INTUFruit *> *AddedArray;
#else
@property (nonatomic, strong) INTUMutableGroupedArray *AddedArray;
#endif


@property(nonatomic,strong)  IBOutlet UIView * assessmentView;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * colorlbl_xposition;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * popview_yposition;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * popview_xposition;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * tblWidth;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * colorLblWidth;
@end


@implementation TestAssessmentViewVC
@synthesize objAssessmentSideView;
- (void)viewDidLoad {
    [super viewDidLoad];
    
     objWebService=[[WebService alloc]init];
   // aslist = [[NSMutableArray alloc]init];
    
    poplistArray = [[NSMutableArray alloc]init];
    addedArray = [[NSMutableArray alloc]init];
    [self setview];
    
    NSLog(@"%@", poplistArray);
    self.pop_view.hidden =YES;
    
    isgrid=YES;
    
    [self.detailsTbl reloadData];
    [self.pop_view reloadData];
    
   // self.detailsTbl.hidden=YES;
    self.colorlbl.hidden = YES;
    self.colorlbl_xposition.constant = self.Pending.frame.origin.x;
     self.colorLblWidth.constant = self.New.frame.size.width;
    
    self.AssesView.layer.borderWidth=1.0f;
    self.AssesView.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.calView.layer.borderWidth=0.5f;
    self.calView.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    [self customnavigationmethod];
    
    NSString *dd = [NSString stringWithFormat:@"%@",[NSDate date]];
    
    NSArray *comp = [dd componentsSeparatedByString:@" "];
    
    NSString *d=comp[0];
    
    self.callbl.text = d;
   
    objAssessmentSideView.frame=[self setFramrToMenuViewWithXposition:-190];
    objAssessmentSideView.moduleStr =  self.ModuleCode;
    //objAssessmentSideView.hidden=YES;
    self.assessmentView.hidden = YES;
}
-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    
    
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"Assesment";
    objCustomNavigation.btn_back.hidden =NO;
    objCustomNavigation.menu_btn.hidden = YES;
    [objCustomNavigation.menu_btn addTarget:self action:@selector(MenuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [objCustomNavigation.btn_back addTarget:self action:@selector(didClickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)setview
{
    
    DBAConnection *Db = [[DBAConnection alloc]init];
    NSString *clientCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    NSString *userCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
    //[Db AssessmentTestType:clientCode:userCode:self.ModuleCode];
    
    NSMutableArray * myNewDouble =  [Db AssessmentTestType:clientCode :userCode :self.ModuleCode ];
    
    NSLog(@"%@", myNewDouble);
    aslist = [[NSMutableArray alloc]init];
    
    assmntCodeArray = [[NSMutableArray alloc]init];
    
    for(int i=0;i<myNewDouble.count;i++)
    {
        NSString * name = [[myNewDouble valueForKey:@"AssessmentName"] objectAtIndex:i];
        NSString * assesmentCode = [[myNewDouble valueForKey:@"AssessmentCode"] objectAtIndex:i];
        NSLog(@"%@", name);
        [aslist addObject:name];
        [assmntCodeArray addObject:assesmentCode];
    }

    //[self.New sendActionsForControlEvents:UIControlEventTouchUpInside];
    poplistArray = aslist;
}

-(IBAction)didselectAssesment:(id)sender
{
    if(isAses == NO)
    {
        isAses=YES;
        isgrid=NO;
    //self.popview_xposition.constant = self.AssesView.frame.origin.x;
    //self.popview_yposition.constant = self.AssesView.frame.origin.y+20;
    self.pop_view.hidden =NO;
       
        self.tblWidth.constant = self.AssesView.frame.size.width;
        
        NSLog(@"%@", poplistArray);
        //poplistArray = aslist;
  [self.pop_view reloadData];
        
    }
    else
    {
        isAses=NO;
        isgrid=YES;
    }
    
}

-(IBAction)didClickcal:(id)sender
{
    
    SACalendar *calendar = [[SACalendar alloc]initWithFrame:CGRectMake(self.AssesView.frame.origin.x+20,self.calView.frame.origin.y+self.calView.frame.size.height+5,self.view.frame.size.width-50,self.view.frame.size.height-250) scrollDirection:ScrollDirectionVertical pagingEnabled:NO];
    
    calendar.delegate = self;
//    NSString * currentDate =[NSString stringWithFormat:@"%d-%02d-%02d",year,month,day];
//    self.callbl.text = currentDate;
   
    [self.view addSubview:calendar];
    
}
-(void) SACalendar:(SACalendar*)calendar didSelectDate:(int)day month:(int)month year:(int)year
{
    NSString * selectdate =[NSString stringWithFormat:@"%d-%02d-%02d",year,month,day];

    self.callbl.text = selectdate;
    actualdate = selectdate;
    calendar.hidden = YES;
}

-(void)loadingAssesmentWebservice
{
    NSString *usercode = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
    
    NSString *cliendcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    
    NSString *userref = @"USM0000002";
    
    NSString *module = @"msc085";
    
    
    
    [objWebService getAssesmentlist :AssementKey :cliendcode :module :userref success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"responseObject=%@",responseObject);
            if(responseObject >0)
            {
                list = [[NSMutableArray alloc]init];
                //aslist = [[NSMutableArray alloc]init];
                
                 list = [responseObject valueForKey:@"fetchAssessmentList"];
                
                aslist = ([[list valueForKey:@"assessmentName"] isEqual:[NSNull null]])?@"":[list valueForKey:@"assessmentName"];
                
                
                
               
            }
        isgrid=NO;
        [self.pop_view reloadData];
        
        
        } failure:^(AFHTTPRequestOperation *operation, id error) {
            NSLog(@"failed");
            [COMMON webServiceFailureError];
        }];
    
    }
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(isgrid==YES)
    {
    return [self.groupedArray countAllSections];
    }
    else
    {
        return 1;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(isgrid==YES)
    {
        return [self.groupedArray countObjectsInSectionAtIndex:section];
    }
    else if(isAses==YES)
    {
       return poplistArray.count;
    }
 return nil;
    
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 44.0;
//}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"Cellid";
    
    static NSString *MyIdentifier = @"MyIdentifier";
    
    if(isgrid==YES )
    {
        INTUFruit *fruit = [self.groupedArray objectAtIndexPath:indexPath];
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        cell.textLabel.text = fruit.name;
        cell.backgroundColor = [UIColor clearColor];
        cell.textColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.detailTextLabel.text = fruit.color;
        return cell;


    }
   if(isAses==YES)
    {

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier];
        }
        
        
        cell.textLabel.text = poplistArray[indexPath.row] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        return cell;
     }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(isgrid==YES)
    {
        TestAssessmentListVC  * objTabVC=[[TestAssessmentListVC alloc]init];
        objTabVC = (TestAssessmentListVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"TestAssessmentListVC"];
        objTabVC.AssessmentName = self.assesmntlbl.text;
        objTabVC.DateOfASSE = self.callbl.text;
        
        INTUFruitCategory *fruitCategory = [self.groupedArray sectionAtIndex:indexPath.section];
        objTabVC.Section = fruitCategory.displayName;
        
        INTUFruit *fruit = [self.groupedArray objectAtIndexPath:indexPath];
        objTabVC.Testname = fruit.name;
        [self.navigationController pushViewController:objTabVC animated:YES];
    }
    else
    {
        self.assesmntlbl.text=poplistArray[indexPath.row];
        self.pop_view.hidden = YES;
        self.detailsTbl.hidden=NO;
        isgrid=YES;
        AssessmentCode = assmntCodeArray[indexPath.row];
        [self tableValuesMethod];
    }
    
   

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(isgrid==YES)
    {
        return 50;
    }
    else{
        return 30;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(isgrid==YES)
    {
        return 50;
    }
    else{
        return 0;
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(isgrid==YES)
    {
    INTUFruitCategory *fruitCategory = [self.groupedArray sectionAtIndex:section];
    return fruitCategory.displayName;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if(isgrid==YES)
    {
    UITableViewHeaderFooterView *v = (UITableViewHeaderFooterView *)view;
    v.backgroundView.backgroundColor = [UIColor colorWithRed:(28/255.0f) green:(26/255.0f) blue:(68/255.0f) alpha:1.0f];
    v.textLabel.textColor = [UIColor whiteColor];
    v.textLabel.textAlignment = UITextAlignmentCenter;
    }
}



-(void)tableValuesMethod
{
    NSMutableArray *NewArray = [[NSMutableArray alloc]init];
    NSMutableArray *PendingArray = [[NSMutableArray alloc]init];
    NSMutableArray *CompletedArray = [[NSMutableArray alloc]init];
    
    asblist = [[NSMutableArray alloc]init];
    asbblist = [[NSMutableArray alloc]init];

    
    DBAConnection *Db = [[DBAConnection alloc]init];
    NSString *clientCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    NSString *userCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
    NSString *userRef = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
    
    NSMutableArray * TestAsseementArray =  [Db TestByAssessment:clientCode :AssessmentCode :self.ModuleCode ];
    
    NSLog(@"%@", TestAsseementArray);
    
    NSMutableArray * AssessmentEntry =  [Db AssessmentEntryByDate :AssessmentCode :userCode :self.ModuleCode:actualdate:clientCode];
    
    
    NSMutableArray * playersArray2 =  [Db PlayersByCoach:clientCode :userRef];
    NSLog(@"%@", playersArray2);
    
    
    NSMutableArray *AssessmentTypeTest;
#if __has_feature(objc_generics)
    INTUMutableGroupedArray<INTUFruitCategory *, INTUFruit *> *groupedArray = [INTUMutableGroupedArray new];
#else
    INTUMutableGroupedArray *groupedArray = [INTUMutableGroupedArray new];
#endif
    for (int i = 0; i <TestAsseementArray.count; i++)
    {
        NSMutableArray *tempNewArray = [[NSMutableArray alloc]init];
        NSMutableArray *tempPendingArray = [[NSMutableArray alloc]init];
        NSMutableArray *tempCompletedArray = [[NSMutableArray alloc]init];
        
        NSMutableArray *TestCodeArray = [[NSMutableArray alloc]init];
        NSMutableArray *TestnameArray = [[NSMutableArray alloc]init];
        TestCodeArray = [TestAsseementArray valueForKey:@"TestCode"];
        TestnameArray = [TestAsseementArray valueForKey:@"TestName"];
        
        NSString *assessmentTestCode = [TestCodeArray objectAtIndex:i];
        NSString *assessmentTestName = [TestnameArray objectAtIndex:i];//test names
        
        NSString * Screenid =  [Db ScreenId:AssessmentCode :assessmentTestCode ];
        NSLog(@"%@", Screenid);
        
        NSString * Screencount =  [Db ScreenCount :AssessmentCode :assessmentTestCode];
        
        
        int count = [Screencount intValue];
        
        
        if(count>0)
        {
            AssessmentTypeTest = [Db AssementForm :Screenid :clientCode:self.ModuleCode:AssessmentCode :assessmentTestCode ];
            
            for(int j =0 ;j<AssessmentTypeTest.count;j++)
            {
            int completed = 0;
            int remaining = 0;
                
                for(int k =0 ;k<playersArray2.count;k++)
                {
                    for(int l =0 ;l<AssessmentEntry.count;l++)
                    {
                        
                        NSMutableArray *EntryCheck1 = [AssessmentEntry valueForKey:@"TestTypeCode"];
                        NSMutableArray *EntryCheck2 = [AssessmentTypeTest valueForKey:@"TestTypeCode"];
                        
                        NSMutableArray *EntryCheck3 = [AssessmentEntry valueForKey:@"TestCode"];
                        NSMutableArray *EntryCheck4 = [TestAsseementArray valueForKey:@"TestCode"];
                        
                        NSMutableArray *EntryCheck5 = [AssessmentEntry valueForKey:@"AthleteCode"];
                        NSMutableArray *EntryCheck6 = [playersArray2 valueForKey:@"PlayerCode"];
                        
                        if([[EntryCheck1 objectAtIndex:l] isEqualToString:[EntryCheck2 objectAtIndex:j]] && [[EntryCheck3 objectAtIndex:l] isEqualToString:[EntryCheck4 objectAtIndex:i]] && [[EntryCheck5 objectAtIndex:l] isEqualToString:[EntryCheck6 objectAtIndex:k]])
                            {
                                completed++;
                            }
                    }
                }
                
                remaining = playersArray2.count - completed;
                asbblist = TestnameArray;
                
                //new
                if(playersArray2.count == 0 || (remaining == playersArray2.count && completed == 0 ))
                {
                    if(tempNewArray.count == 0)
                    {
                        
                    }
                    
                }
                
            }
            
            
        }
        
        INTUFruitCategory *smallRoundCategory = [INTUFruitCategory fruitCategoryWithDisplayName:assessmentTestName];
        for(int j=0;j<AssessmentTypeTest.count;j++)
        {
            [groupedArray addObject:[INTUFruit fruitWithName:[[AssessmentTypeTest valueForKey:@"TestTypeName"] objectAtIndex:j] color:@""] toSection:smallRoundCategory];
            
        }

        

    }
    
    

  self.groupedArray = groupedArray;
    
    [self.detailsTbl reloadData];
    
    
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
-(IBAction)didClickBackBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (IBAction)NewBtn:(id)sender
{
   
    self.colorlbl_xposition.constant = self.New.frame.origin.x;
    self.colorLblWidth.constant = self.New.frame.size.width;
     self.colorlbl.hidden = NO;
    self.detailsTbl.hidden=NO;
}

- (IBAction)PendingBtn:(id)sender
{
    self.colorlbl.hidden = NO;
    self.colorlbl_xposition.constant = self.Pending.frame.origin.x;
    self.colorLblWidth.constant = self.New.frame.size.width;
    self.detailsTbl.hidden=YES;
    
}
- (IBAction)CompletedBtn:(id)sender
{
    self.colorlbl.hidden = NO;
    self.colorlbl_xposition.constant = self.Completed.frame.origin.x;
    self.colorLblWidth.constant = self.New.frame.size.width;
    self.detailsTbl.hidden=YES;
}

-(CGRect)setFramrToMenuViewWithXposition:(NSInteger)position{
    CGRect frame;
    frame.origin.x=position;
    frame.origin.y=self.objAssessmentSideView.frame.origin.y;
    frame.size.height=self.objAssessmentSideView.frame.size.height;
    frame.size.width=self.objAssessmentSideView.frame.size.width;
    
    return frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
