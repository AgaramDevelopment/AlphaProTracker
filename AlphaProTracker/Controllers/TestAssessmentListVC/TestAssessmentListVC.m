//
//  SubAssessmentVC.m
//  AlphaProTracker
//
//  Created by Lexicon on 30/08/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "TestAssessmentListVC.h"
#import "CustomNavigation.h"
#import "AppCommon.h"
#import "AppCommon.h"
#import "Config.h"
#import "AFNetworking.h"
#import "WebService.h"
#import "HomeVC.h"
#import "TestAssessmentEntryVC.h"

@interface TestAssessmentListVC ()
{
    NSString * SelectClientCode;
    NSString * SelectModuleCode;
    NSString * SelectCreatedby;
    NSString * SelectUserref;
    
}
@property (nonatomic,strong)  NSArray *players;
@property (nonatomic,strong)  NSMutableArray *playerslist;
@property (nonatomic,strong)  NSMutableArray *playername;



@end

@implementation TestAssessmentListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //[COMMON AddMenuView:self.view];
    
    self.AssessmentNamelbl.text = self.AssessmentName;
    self.DateOfASSElbl.text = self.DateOfASSE;
    self.Sectionlbl.text = self.Section;
    self.Testnamelbl.text = self.Testname;
    
    self.players =[[NSArray alloc]init];
    self.players = @[@"Player1",@"Player2",@"Player3",@"Player4",@"Player5",@"Player6",@"Player7",@"Player8",@"Player9",@"Player10"];
    [self customnavigationmethod];
    [self PlayerWebservice:SelectCreatedby :SelectClientCode :SelectUserref :SelectModuleCode];
    
    // Do any additional setup after loading the view.
}
-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    
    
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"";
    objCustomNavigation.btn_back.hidden =NO;
    objCustomNavigation.menu_btn.hidden = YES;
    [objCustomNavigation.menu_btn addTarget:self action:@selector(MenuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [objCustomNavigation.btn_back addTarget:self action:@selector(BackBtn:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [COMMON AddMenuView:self.view];
}
-(void)PlayerWebservice :(NSString *) createdby :(NSString *) cliendcode :(NSString *)userref:(NSString*)module
{
    [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",playerListKey]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        
        NSString *cliendcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
        NSString *userref = @"AMR0000001";
        
        NSString *module = @"msc085";
        NSString *createdby=@"USM0000002";

        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(createdby)   [dic    setObject:createdby     forKey:@"Createdby"];
        if(cliendcode)   [dic    setObject:cliendcode     forKey:@"Clientcode"];
        if(userref)   [dic    setObject:userref     forKey:@"Userreferencecode"];
        if(module)   [dic    setObject:module     forKey:@"Module"];
        
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            if(responseObject >0)
            {
                self.playerslist = [[NSMutableArray alloc]init];
                self.playerslist = [responseObject valueForKey:@"lstAssessmentEntryPlayer"];
                
                self.playername = [[NSMutableArray alloc]init];
                self.playername = [self.playerslist valueForKey:@"PlayerName"];
                
                
            }

            [self.playersTbl reloadData];
                        
            [COMMON RemoveLoadingIcon];
            [self.view setUserInteractionEnabled:YES];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed");
            [COMMON webServiceFailureError];
            [self.view setUserInteractionEnabled:YES];
            
        }];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.playername.count;
    
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

        //cell = self.objsubcell;
        
       cell.textLabel.text = self.playername[indexPath.row];
    
       cell.textColor = [UIColor whiteColor];
    
        return cell;
        
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
           TestAssessmentEntryVC  * objTabVC=[[TestAssessmentEntryVC alloc]init];
        objTabVC = (TestAssessmentEntryVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"TestAssessmentEntryVC"];
        [self.navigationController pushViewController:objTabVC animated:YES];
    
    
}

-(IBAction)BackBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
