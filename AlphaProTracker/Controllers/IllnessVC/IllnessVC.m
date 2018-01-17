//
//  IllnessVC.m
//  AlphaProTracker
//
//  Created by Mac on 26/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "IllnessVC.h"
#import "WebService.h"
#import "CustomNavigation.h"
#import "AppCommon.h"
#import "Config.h"
#import "HomeVC.h"
#import "IllnessCell.h"
#import "AddIllnessVC.h"


@interface IllnessVC ()
{
    WebService * objWebservice;
    NSString * cliendCode;
}

@property (nonatomic,strong) IBOutlet UITableView * illnessTbl;

@property (nonatomic,strong)IBOutlet UIButton * addBtn;
@property (nonatomic,strong)NSMutableArray  * IllnessListArray;


@end

@implementation IllnessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customnavigationmethod];
    objWebservice =[[WebService alloc]init];
    cliendCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    self.addBtn.layer.cornerRadius=20;
    self.addBtn.layer.masksToBounds=YES;

}
-(void)viewWillAppear:(BOOL)animated
{
    [self FetchInjuryListWebService];
}
-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    
    
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"Illness";
    objCustomNavigation.btn_back.hidden =YES;
    objCustomNavigation.menu_btn.hidden = NO;
    [objCustomNavigation.menu_btn addTarget:self action:@selector(MenuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma Button action
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
-(void)FetchInjuryListWebService
{
    [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        [objWebservice getFetchinjuryList:fetchillness :cliendCode success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                self.IllnessListArray =[[NSMutableArray alloc] init];
                self.IllnessListArray =[responseObject valueForKey:@"IllnessDetails"];
                [self.illnessTbl reloadData];
                
            }
            [COMMON RemoveLoadingIcon];
            [self.view setUserInteractionEnabled:YES];
        } failure:^(AFHTTPRequestOperation *operation, id error) {
            [COMMON webServiceFailureError];
            [self.view setUserInteractionEnabled:YES];
        }];
        
    }
}
#pragma Tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.IllnessListArray count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!IS_IPHONE_DEVICE)
    {
        return 60;
    }
    else
    {
       return 40;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Injury";
    
    IllnessCell * objCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (objCell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"IllnessCell" owner:self options:nil];
        objCell = self.illnesscell;
    }
    
    
    NSString * ondate =[[self.IllnessListArray valueForKey:@"dateOnSet"] objectAtIndex:indexPath.row];
    NSDateFormatter *dateFormatters = [[NSDateFormatter alloc] init];
    [dateFormatters setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
    NSDate *dates = [dateFormatters dateFromString:ondate];
    
    NSDateFormatter* dfs = [[NSDateFormatter alloc]init];
    [dfs setDateFormat:@"dd-MMMM-yyyy"];
    NSString * ondateStr = [dfs stringFromDate:dates];
    
    
    NSString * recorydate =[[self.IllnessListArray valueForKey:@"expertedDateofRecovery"] objectAtIndex:indexPath.row];;
    NSDateFormatter *dateFormatterss = [[NSDateFormatter alloc] init];
    [dateFormatterss setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
    NSDate *date = [dateFormatters dateFromString:recorydate];
    
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"dd-MMMM-yyyy"];
    NSString * recorydateStr = [df stringFromDate:date];
    
    
    
    objCell.dateofOnsetlbl.text =ondateStr;
    objCell.illnessNamelbl.text =[[self.IllnessListArray valueForKey:@"illnessName"] objectAtIndex:indexPath.row];
    objCell.recoverylbl.text=recorydateStr;
    objCell.backgroundColor=[UIColor clearColor];
    objCell.selectionStyle=UITableViewCellSelectionStyleNone;
    return objCell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddIllnessVC  * objaddIllness=[[AddIllnessVC alloc]init];
    objaddIllness = (AddIllnessVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"addIllness"];
    objaddIllness.isUpdate =YES;
    objaddIllness.objSelectobjIllnessArray =[self.IllnessListArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:objaddIllness animated:YES];
}

-(IBAction)didclickAddBtn:(id)sender
{
    AddIllnessVC  * objaddIllness=[[AddIllnessVC alloc]init];
    objaddIllness = (AddIllnessVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"addIllness"];
    objaddIllness.isUpdate =NO;
    [self.navigationController pushViewController:objaddIllness animated:YES];
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
