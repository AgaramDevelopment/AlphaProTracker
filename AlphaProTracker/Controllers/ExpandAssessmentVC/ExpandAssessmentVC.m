//
//  ExpandAssessmentVC.m
//  AlphaProTracker
//
//  Created by Lexicon on 01/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "ExpandAssessmentVC.h"
#import "AppCommon.h"
#import "HomeVC.h"
#import "CustomNavigation.h"
#import "Config.h"
#import "DBAConnection.h"
#import "INTUGroupedArrayImports.h"
#import "INTUFruitCategory.h"
#import "INTUFruit.h"

@interface ExpandAssessmentVC ()

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

@end

@implementation ExpandAssessmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //[COMMON AddMenuView:self.view];
    [self customnavigationmethod];
    // Do any additional setup after loading the view.
//    self.objContenArray = [[NSMutableArray alloc]init];
//    self.objContenArray = @[
//
//                  @[
//                      @[@"HOME"],
//                      @[@"PLANNER"],
//                      @[@"PHYSIO", @"Assessment", @"Questionnaire", @"SinglePlayerReport", @"MultiPlayerReport", @"program",@"Assign Player"],
//                      @[@"STRENGTH & CONDITIONS",@"Assessment",@"Questionnaire",@"SinglePlayerReport",@"MultiPlayerReport",@"Program",@"Assign player"],
//                      @[@"COACH",@"Assessment",@"Questionnaire",@"SinglePlayerReport",@"MultiPlayerReport",@"Program",@"Assign player"],
//                      @[@"WORK LOAD MANAGEMENT"],
//                      @[@"FOOD DIARY"],
//                      @[@"PROFILE"],
//                      @[@"SYNC DATA"],
//                      @[@"ILLNESS"],
//                      @[@"INJURY"],
//                      @[@"LOGOUT"]]
//                  ];
    
    [self tableValuesMethod];
}
-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    
    
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"";
    objCustomNavigation.btn_back.hidden =YES;
    objCustomNavigation.menu_btn.hidden = NO;
    [objCustomNavigation.menu_btn addTarget:self action:@selector(MenuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    //[COMMON AddMenuView:self.view];
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


#pragma mark - UITableViewDataSource

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return [self.objContenArray count];
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return [self.objContenArray[section] count];
//}
//
//- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
//{
//    return [self.objContenArray[indexPath.section][indexPath.row] count] - 1;
//}
//
//- (BOOL)tableView:(SKSTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section == 1 && indexPath.row == 0)
//    {
//        return YES;
//    }
//
//    return NO;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"SKSTableViewCell";
//
//    SKSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//
////    if(isPlayer==YES)
////    {
//        if (!cell)
//            cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//
//        cell.textLabel.text = self.objContenArray[indexPath.section][indexPath.row][0];
//        cell.textLabel.textColor =[UIColor whiteColor];
//        cell.textLabel.font = (IS_IPAD)? [UIFont fontWithName:@"Helvetica" size:15]:[UIFont fontWithName:@"Helvetica" size:13];
//
//    NSInteger row = indexPath.row;
//
//    if (indexPath.section == 0 && (indexPath.row == row))
//        cell.expandable = YES;
//        else
//        cell.expandable = NO;
//        cell.backgroundColor =[UIColor colorWithRed:(17/255.0f) green:(24/255.0f) blue:(67/255.0f) alpha:0.9];
//
//    return cell;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"UITableViewCell";
//
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//
//    if (!cell)
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//
//    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.objContenArray[indexPath.section][indexPath.row][indexPath.subRow]];
//    cell.backgroundColor =[UIColor colorWithRed:(17/255.0f) green:(24/255.0f) blue:(67/255.0f) alpha:1.0];
//    cell.textLabel.textColor =[UIColor whiteColor];
//    [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size: (IS_IPAD ? 15 : 14)]];
//    return cell;
//}
//
//- (CGFloat)tableView:(SKSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 60.0f;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}
//
//- (void)tableView:(SKSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}








- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
   return [self.groupedArray countAllSections];

    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        return [self.groupedArray countObjectsInSectionAtIndex:section];
    
    
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 44.0;
//}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"Cellid";
    
   // static NSString *MyIdentifier = @"MyIdentifier";
    
   
        INTUFruit *fruit = [self.groupedArray objectAtIndexPath:indexPath];
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        cell.textLabel.text = fruit.name;
        cell.backgroundColor = [UIColor clearColor];
        cell.textColor = [UIColor blackColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.detailTextLabel.text = fruit.color;
        return cell;
        
        
   // }
//    if(isAses==YES)
//    {
//
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
//        if (cell == nil)
//        {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                          reuseIdentifier:MyIdentifier];
//        }
//
//
//        cell.textLabel.text = poplistArray[indexPath.row] ;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//        return cell;
//    }
//    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if(isgrid==YES)
//    {
//        TestAssessmentListVC  * objTabVC=[[TestAssessmentListVC alloc]init];
//        objTabVC = (TestAssessmentListVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"TestAssessmentListVC"];
//        objTabVC.AssessmentName = self.assesmntlbl.text;
//        objTabVC.DateOfASSE = self.callbl.text;
//        
//        INTUFruitCategory *fruitCategory = [self.groupedArray sectionAtIndex:indexPath.section];
//        objTabVC.Section = fruitCategory.displayName;
//        
//        INTUFruit *fruit = [self.groupedArray objectAtIndexPath:indexPath];
//        objTabVC.Testname = fruit.name;
//        [self.navigationController pushViewController:objTabVC animated:YES];
//    }
//    else
//    {
//        self.assesmntlbl.text=poplistArray[indexPath.row];
//        self.pop_view.hidden = YES;
//        self.detailsTbl.hidden=NO;
//        isgrid=YES;
//        AssessmentCode = assmntCodeArray[indexPath.row];
//        [self tableValuesMethod];
//    }
//
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if(isgrid==YES)
//    {
        return 50;
//    }
//    else{
//        return 30;
//    }
//
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if(isgrid==YES)
//    {
        return 50;
//    }
//    else{
//        return 0;
//    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
//    if(isgrid==YES)
//    {
        INTUFruitCategory *fruitCategory = [self.groupedArray sectionAtIndex:section];
        return fruitCategory.displayName;
//    }
//    return nil;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
//    if(isgrid==YES)
//    {
        UITableViewHeaderFooterView *v = (UITableViewHeaderFooterView *)view;
        v.backgroundView.backgroundColor = [UIColor colorWithRed:(28/255.0f) green:(26/255.0f) blue:(68/255.0f) alpha:1.0f];
        v.textLabel.textColor = [UIColor whiteColor];
        v.textLabel.textAlignment = UITextAlignmentCenter;
    //}
}



-(void)tableValuesMethod
{
    //NSMutableArray *NewArray = [[NSMutableArray alloc]init];
   // NSMutableArray *PendingArray = [[NSMutableArray alloc]init];
   // NSMutableArray *CompletedArray = [[NSMutableArray alloc]init];
    
//    asblist = [[NSMutableArray alloc]init];
//    asbblist = [[NSMutableArray alloc]init];
//
    
    DBAConnection *Db = [[DBAConnection alloc]init];
    NSString *clientCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    NSString *userCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
    NSString *userRef = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
    
    NSMutableArray * TestAsseementArray =  [Db TestByAssessment:clientCode :self.assessmentCodeStr :self.ModuleCodeStr ];
    
    NSLog(@"%@", TestAsseementArray);
    
    NSMutableArray * AssessmentEntry =  [Db AssessmentEntryByDate :self.assessmentCodeStr :userCode :self.ModuleCodeStr:self.selectDate:clientCode];
    
    
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
        //NSMutableArray *tempPendingArray = [[NSMutableArray alloc]init];
        //NSMutableArray *tempCompletedArray = [[NSMutableArray alloc]init];
        
        NSMutableArray *TestCodeArray = [[NSMutableArray alloc]init];
        NSMutableArray *TestnameArray = [[NSMutableArray alloc]init];
        TestCodeArray = [TestAsseementArray valueForKey:@"TestCode"];
        TestnameArray = [TestAsseementArray valueForKey:@"TestName"];
        
        NSString *assessmentTestCode = [TestCodeArray objectAtIndex:i];
        NSString *assessmentTestName = [TestnameArray objectAtIndex:i];//test names
        
        NSString * Screenid =  [Db ScreenId:self.assessmentCodeStr :assessmentTestCode ];
        NSLog(@"%@", Screenid);
        
        NSString * Screencount =  [Db ScreenCount :self.assessmentCodeStr :assessmentTestCode];
        
        
        int count = [Screencount intValue];
        
        
        if(count>0)
        {
            AssessmentTypeTest = [Db AssementForm :Screenid :clientCode:self.ModuleCodeStr:self.assessmentCodeStr :assessmentTestCode ];
            
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
               // asbblist = TestnameArray;
                
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
    
    [self.tableview reloadData];
    
    
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
