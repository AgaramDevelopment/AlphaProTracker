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
//#import "INTUGroupedArrayImports.h"
//#import "INTUFruitCategory.h"
//#import "INTUFruit.h"

@interface ExpandAssessmentVC ()<SKSTableViewDelegate>

@property (nonatomic,strong) NSMutableArray * objContenArray;
//#if __has_feature(objc_generics)
//@property (nonatomic, strong) INTUMutableGroupedArray<INTUFruitCategory *, INTUFruit *> *groupedArray;
//#else
//@property (nonatomic, strong) INTUMutableGroupedArray *groupedArray;
//#endif
//
//#if __has_feature(objc_generics)
//@property (nonatomic, strong) INTUMutableGroupedArray<INTUFruitCategory *, INTUFruit *> *AddedArray;
//#else
//@property (nonatomic, strong) INTUMutableGroupedArray *AddedArray;
//#endif

@end

@implementation ExpandAssessmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableview.SKSTableViewDelegate = self;

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
    objCustomNavigation.tittle_lbl.text=self.TitleStr;
    objCustomNavigation.btn_back.hidden =YES;
    objCustomNavigation.menu_btn.hidden = NO;
    [objCustomNavigation.menu_btn addTarget:self action:@selector(MenuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [COMMON AddMenuView:self.view];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.objContenArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.objContenArray[section] count];
}

- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.objContenArray[indexPath.section][indexPath.row] count] - 1;
}

- (BOOL)tableView:(SKSTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0)
    {
        return YES;
    }

    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SKSTableViewCell";

    SKSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

//    if(isPlayer==YES)
//    {
        if (!cell)
            cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

        cell.textLabel.text = self.objContenArray[indexPath.section][indexPath.row][0];
        cell.textLabel.textColor =[UIColor whiteColor];
        cell.textLabel.font = (IS_IPAD)? [UIFont fontWithName:@"Helvetica" size:15]:[UIFont fontWithName:@"Helvetica" size:13];

    NSInteger row = indexPath.row;

    if (indexPath.section == 0 && (indexPath.row == row))
        cell.expandable = YES;
        else
        cell.expandable = NO;
        cell.backgroundColor =[UIColor colorWithRed:(17/255.0f) green:(24/255.0f) blue:(67/255.0f) alpha:0.9];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UITableViewCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.objContenArray[indexPath.section][indexPath.row][indexPath.subRow]];
   //cell.backgroundColor =[UIColor colorWithRed:(17/255.0f) green:(24/255.0f) blue:(67/255.0f) alpha:1.0];
    cell.backgroundColor =[UIColor clearColor];
    cell.textLabel.textColor =[UIColor blackColor];
    [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size: (IS_IPAD ? 15 : 14)]];
    return cell;
}

- (CGFloat)tableView:(SKSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (void)tableView:(SKSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath
{

}








//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//   return [self.groupedArray countAllSections];
//}
//
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//        return [self.groupedArray countObjectsInSectionAtIndex:section];
//}

//- (UITableViewCell *)tableView:(UITableView *)tableView
//         cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *cellid=@"Cellid";
//
//        //INTUFruit *fruit = [self.groupedArray objectAtIndexPath:indexPath];
//        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
//        cell.textLabel.text = fruit.name;
//        cell.backgroundColor = [UIColor clearColor];
//        cell.textColor = [UIColor whiteColor];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

        return 50;

}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//
//        INTUFruitCategory *fruitCategory = [self.groupedArray sectionAtIndex:section];
//        return fruitCategory.displayName;
//
//}
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
//{
//
//        UITableViewHeaderFooterView *v = (UITableViewHeaderFooterView *)view;
//        v.backgroundView.backgroundColor = [UIColor colorWithRed:(28/255.0f) green:(26/255.0f) blue:(68/255.0f) alpha:1.0f];
//        v.textLabel.textColor = [UIColor whiteColor];
//        v.textLabel.textAlignment = UITextAlignmentCenter;
//
//}



-(void)tableValuesMethod
{
   
    DBAConnection *Db = [[DBAConnection alloc]init];
    self.objContenArray =[[NSMutableArray alloc]init];
    NSMutableArray * ComArray = [[NSMutableArray alloc]init];
    NSString *clientCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
   // NSString *userCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
   // NSString *userRef = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
    
    NSMutableArray * TestAsseementArray =  [Db TestByAssessment:clientCode :self.assessmentCodeStr :self.ModuleCodeStr ];
    
    NSLog(@"%@", TestAsseementArray);
    
   // NSMutableArray * AssessmentEntry =  [Db AssessmentEntryByDate :self.assessmentCodeStr :userCode :self.ModuleCodeStr:self.selectDate:clientCode];
    
    
//    NSMutableArray * playersArray2 =  [Db PlayersByCoach:clientCode :userRef];
//    NSLog(@"%@", playersArray2);
//
    
    NSMutableArray * AssessmentTypeTest;
    NSMutableArray * AssessmentNameArray;
//#if __has_feature(objc_generics)
//    INTUMutableGroupedArray<INTUFruitCategory *, INTUFruit *> *groupedArray = [INTUMutableGroupedArray new];
//#else
//    INTUMutableGroupedArray *groupedArray = [INTUMutableGroupedArray new];
//#endif
    for (int i = 0; i <TestAsseementArray.count; i++)
    {
        AssessmentNameArray =[[NSMutableArray alloc]init];
        NSString *assessmentTestCode = [[TestAsseementArray valueForKey:@"TestCode"] objectAtIndex:i];
        NSString *assessmentTestName = [[TestAsseementArray valueForKey:@"TestName"] objectAtIndex:i];//test names
        
        [AssessmentNameArray addObject:assessmentTestName];
        NSString * Screenid =  [Db ScreenId:self.assessmentCodeStr :assessmentTestCode ];
        NSLog(@"%@", Screenid);
        
        NSString * Screencount =  [Db ScreenCount :self.assessmentCodeStr :assessmentTestCode];
        
        
        int count = [Screencount intValue];
        
        
        if(count>0)
        {
            AssessmentTypeTest = [Db AssementForm :Screenid :clientCode:self.ModuleCodeStr:self.assessmentCodeStr :assessmentTestCode ];
        }
        
        for(int j=0;j<AssessmentTypeTest.count;j++)
        {
            [AssessmentNameArray addObject:[[AssessmentTypeTest valueForKey:@"TestTypeName"] objectAtIndex:j]];
           // [self.objContenArray addObject:[[AssessmentTypeTest valueForKey:@"TestTypeName"] objectAtIndex:j]];
        }
        [ComArray addObject: AssessmentNameArray];
    
    }
    [self.objContenArray addObject:ComArray];
    [self.tableview reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
