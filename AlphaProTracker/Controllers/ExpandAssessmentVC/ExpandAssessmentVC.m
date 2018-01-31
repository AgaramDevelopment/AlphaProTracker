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
#import "TestAssessmentEntryVC.h"



@interface ExpandAssessmentVC ()<SKSTableViewDelegate>
{
    NSString * usercode;
    NSString *clientCode;
    BOOL isEdit;
}

@property (nonatomic,strong) NSMutableArray * objContenArray;
@property (nonatomic,strong) NSString * SelectTestCodeStr;
@property (nonatomic,strong) NSString * SelectTestNameStr;
@property (nonatomic,strong) NSString * SelectScreenId;;


@property (nonatomic,strong) DBAConnection *objDBconnection;

@end

@implementation ExpandAssessmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableview.SKSTableViewDelegate = self;
    
    [self customnavigationmethod];
    usercode = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
    clientCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    
    
    [self tableValuesMethod];
}

-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    
    
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    [self.view addSubview:objCustomNavigation.view];
    NSString * selectTilteStr = [NSString stringWithFormat:@"%@ - %@ \n %@",[self.SelectDetailDic valueForKey:@"Module"],[self.SelectDetailDic valueForKey:@"AssessmentTitle"],[self.SelectDetailDic valueForKey:@"Team"]];
    objCustomNavigation.tittle_lbl.text= selectTilteStr;
    objCustomNavigation.btn_back.hidden =NO;
    objCustomNavigation.menu_btn.hidden = YES;
    [objCustomNavigation.btn_back addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [COMMON AddMenuView:self.view];
}
-(IBAction)MenuBtnAction:(id)sender
{
   // [COMMON ShowsideMenuView];
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)HomeBtnAction:(id)sender
{
    HomeVC  * objTabVC=[[HomeVC alloc]init];
    objTabVC = (HomeVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
    [self.navigationController pushViewController:objTabVC animated:YES];
    
    
}

-(void)tableValuesMethod
{
    
    self.objDBconnection = [[DBAConnection alloc]init];
    self.objContenArray =[[NSMutableArray alloc]init];
    NSMutableArray * ComArray = [[NSMutableArray alloc]init];
    
    NSMutableArray * TestAsseementArray =  [self.objDBconnection TestByAssessment:clientCode :self.assessmentCodeStr :self.ModuleCodeStr ];
    
    NSLog(@"%@", TestAsseementArray);
    
    NSMutableArray * AssessmentTypeTest;
    NSMutableArray * AssessmentNameArray;
    
    for (int i = 0; i <TestAsseementArray.count; i++)
    {
        
        
        AssessmentNameArray =[[NSMutableArray alloc]init];
        NSMutableDictionary * objDic = [[NSMutableDictionary alloc]init];
        [objDic setValue:[[TestAsseementArray valueForKey:@"TestCode"] objectAtIndex:i] forKey:@"TestTypeCode"];
        [objDic setValue:[[TestAsseementArray valueForKey:@"TestName"] objectAtIndex:i] forKey:@"TestTypeName"];
        
        NSString *assessmentTestCode = [[TestAsseementArray valueForKey:@"TestCode"] objectAtIndex:i];
        NSString * Screenid =  [self.objDBconnection ScreenId:self.assessmentCodeStr :assessmentTestCode ];
        NSLog(@"%@", Screenid);
        [objDic setValue:Screenid forKey:@"ScreenID"];
        
        
        [AssessmentNameArray addObject:objDic];
        
        NSString * Screencount =  [self.objDBconnection ScreenCount :self.assessmentCodeStr :assessmentTestCode];
        
        
        int count = [Screencount intValue];
        
        AssessmentTypeTest = [[NSMutableArray alloc]init];
        if(count>0)
        {

            AssessmentTypeTest = [self.objDBconnection AssementForm :Screenid :clientCode:self.ModuleCodeStr:self.assessmentCodeStr :assessmentTestCode ];
        }

        for(int j=0;j<AssessmentTypeTest.count;j++)
        {

            [AssessmentNameArray addObject:[AssessmentTypeTest objectAtIndex:j]];

        }
       [ComArray addObject: AssessmentNameArray];

    }
    [self.objContenArray addObject:ComArray];
    [self.tableview reloadData];
    
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
    
    if (!cell)
        cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    NSDictionary * objDic = self.objContenArray[indexPath.section][indexPath.row][0];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [objDic valueForKey:@"TestTypeName"]];
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
    
    NSDictionary * objStr = self.objContenArray [indexPath.section][indexPath.row][indexPath.subRow];
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[objStr valueForKey:@"TestTypeName"]] ;//[NSString stringWithFormat:@"%@", self.objContenArray [indexPath.section][indexPath.row][indexPath.subRow]];
    cell.backgroundColor =[UIColor clearColor];
    cell.textLabel.textColor =[UIColor blackColor];
    [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size: (IS_IPAD ? 15 : 14)]];
    return cell;
}

- (CGFloat)tableView:(SKSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRow");
    NSDictionary * objDic = self.objContenArray[indexPath.section][indexPath.row][0];
    self.SelectTestCodeStr = [objDic valueForKey:@"TestTypeCode"];
    self.SelectTestNameStr = [objDic valueForKey:@"TestTypeName"];
    self.SelectScreenId    =[objDic valueForKey:@"ScreenID"];


}

- (void)tableView:(SKSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectSubRow");
    NSDictionary * objDic  = self.objContenArray[indexPath.section][indexPath.row][indexPath.subRow];
    NSString * TestTypeCode =[objDic valueForKey:@"TestTypeCode"];
    NSMutableArray * objArray = [self.objDBconnection getAssessmentEnrtyByDateTestType:[self.SelectDetailDic valueForKey:@"AssessmentCode"] :usercode :self.ModuleCodeStr :[self.SelectDetailDic valueForKey:@"SelectDate"] :clientCode :TestTypeCode : self.SelectTestCodeStr];
    isEdit = NO;
    if(objArray.count>0)
    {
        isEdit= YES;
    }
    
    TestAssessmentEntryVC * objAssessmentVC =[[TestAssessmentEntryVC alloc]init];
    objAssessmentVC = (TestAssessmentEntryVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"TestAssessmentEntryVC"];
    objAssessmentVC.selectAllValueDic =self.SelectDetailDic;
    objAssessmentVC.SectionTestCodeStr = self.SelectTestCodeStr;
    objAssessmentVC.SelectTestStr = [objDic valueForKey:@"TestTypeName"];
    objAssessmentVC.ModuleStr = self.ModuleCodeStr;
    objAssessmentVC.IsEdit    =isEdit;
    objAssessmentVC.SelectTestTypecode = TestTypeCode;
    objAssessmentVC.SelectScreenId =self.SelectScreenId;
    [self.navigationController pushViewController:objAssessmentVC animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

