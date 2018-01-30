//
//  InjuryVC.m
//  AlphaProTracker
//
//  Created by Mac on 19/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "InjuryVC.h"
#import "CustomNavigation.h"
#import "HomeVC.h"
#import "AppCommon.h"
#import "Config.h"
#import "InjuryListCell.h"
#import "WebService.h"
#import "AddInjuryVC.h"

@interface InjuryVC ()
{
    WebService * objWebservice;
    NSString * cliendCode;
    NSString *userRefcode;
}

@property (nonatomic,strong)IBOutlet UIButton * addBtn;
@property (nonatomic,strong)NSMutableArray  * InjuryListArray;
@property (nonatomic,strong) IBOutlet UITableView * injuryTbl;

@end

@implementation InjuryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //[COMMON AddMenuView:self.view];
    [self customnavigationmethod];
    objWebservice =[[WebService alloc]init];
    cliendCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    userRefcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
    
    self.addBtn.layer.cornerRadius=20;
    self.addBtn.layer.masksToBounds=YES;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [COMMON AddMenuView:self.view];
    
    [self FetchInjuryListWebService];
}

-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    
    
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"Injury";
    objCustomNavigation.btn_back.hidden =YES;
    objCustomNavigation.menu_btn.hidden = NO;
    [objCustomNavigation.menu_btn addTarget:self action:@selector(MenuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [objCustomNavigation.home_btn setImage:[UIImage imageNamed:@"ico_addWhite"]  forState:UIControlStateNormal];
    [objCustomNavigation.home_btn addTarget:self action:@selector(didclickAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma Button action
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
//-(void)FetchInjuryListWebService
//{
//    [COMMON loadingIcon:self.view];
//    if([COMMON isInternetReachable])
//    {
//        [objWebservice getFetchinjuryList:FetchInjuryList :cliendCode :userRefcode success:^(AFHTTPRequestOperation *operation, id responseObject) {
//           NSLog(@"response ; %@",responseObject);
//
//           if(responseObject >0)
//           {
//               self.InjuryListArray =[[NSMutableArray alloc] init];
//               self.InjuryListArray =[responseObject valueForKey:@"InjuryDetails"];
//               [self.injuryTbl reloadData];
//
//           }
//           [COMMON RemoveLoadingIcon];
//           [self.view setUserInteractionEnabled:YES];
//       } failure:^(AFHTTPRequestOperation *operation, id error) {
//           [COMMON webServiceFailureError];
//           [self.view setUserInteractionEnabled:YES];
//       }];
//
//    }
//}

-(void)FetchInjuryListWebService
{
    [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",FetchInjuryList]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(cliendCode)   [dic    setObject:cliendCode     forKey:@"ClientCode"];
        if(userRefcode)   [dic    setObject:userRefcode     forKey:@"Userreferencecode"];
        
        
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                self.InjuryListArray =[[NSMutableArray alloc] init];
                self.InjuryListArray =[responseObject valueForKey:@"InjuryWebs"];
                if(self.InjuryListArray.count>0)
                {
                [self.injuryTbl reloadData];
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

#pragma Tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.InjuryListArray count];
    
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
    
    InjuryListCell * objCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (objCell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"InjuryListCell" owner:self options:nil];
        objCell = self.injuryCell;
    }
    
    
    
    NSString * ondate =[[self.InjuryListArray valueForKey:@"OnSetDate"] objectAtIndex:indexPath.row];
    NSDateFormatter *dateFormatters = [[NSDateFormatter alloc] init];
    [dateFormatters setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
    NSDate *dates = [dateFormatters dateFromString:ondate];
    
    NSDateFormatter* dfs = [[NSDateFormatter alloc]init];
    [dfs setDateFormat:@"dd-MMMM-yyyy"];
    NSString * ondateStr = [dfs stringFromDate:dates];
    
    
    NSString * recorydate =[[self.InjuryListArray valueForKey:@"ExpectedDateOfRecovery"] objectAtIndex:indexPath.row];;
    NSDateFormatter *dateFormatterss = [[NSDateFormatter alloc] init];
    [dateFormatterss setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
    NSDate *date = [dateFormatters dateFromString:recorydate];
    
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"dd-MMMM-yyyy"];
    NSString * recorydateStr = [df stringFromDate:date];
    
    
    
    objCell.dateofOnsetlbl.text =ondate;
    objCell.injuryNamelbl.text =[[self.InjuryListArray valueForKey:@"InjuryName"] objectAtIndex:indexPath.row];
    objCell.recoverylbl.text=recorydate;
    
    objCell.backgroundColor = [UIColor clearColor];
    
    objCell.selectionStyle=UITableViewCellSelectionStyleNone;
    return objCell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddInjuryVC  * objaddinjury=[[AddInjuryVC alloc]init];
    objaddinjury = (AddInjuryVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"addInjury"];
    objaddinjury.isUpdate =YES;
    objaddinjury.objSelectInjuryArray =[self.InjuryListArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:objaddinjury animated:YES];
    
}

-(IBAction)didclickAddBtn:(id)sender
{
    AddInjuryVC  * objaddinjury=[[AddInjuryVC alloc]init];
    objaddinjury = (AddInjuryVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"addInjury"];
    objaddinjury.isUpdate =NO;
    
    [self.navigationController pushViewController:objaddinjury animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

