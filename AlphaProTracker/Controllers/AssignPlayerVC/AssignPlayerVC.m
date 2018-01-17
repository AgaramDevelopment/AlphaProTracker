//
//  AssignPlayerVC.m
//  AlphaProTracker
//
//  Created by Mac on 07/10/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "AssignPlayerVC.h"
#import "CustomNavigation.h"
#import "HomeVC.h"
#import "AppCommon.h"
#import "CRTableViewCell.h"
#import "WebService.h"
#import "Config.h"



@interface AssignPlayerVC ()
{
    BOOL isPoplist;
    BOOL isMulti;
    NSString *prgCode;
    NSString *plyCode;
    
    WebService *objWebservice;
}

@property (strong, nonatomic)  NSMutableArray *respList;

@property (strong, nonatomic)  NSMutableArray *selectedMarks;

@property (strong, nonatomic)  NSMutableArray *ProgramsList;

@property (strong, nonatomic)  NSMutableArray *ProgramCodeList;

@property (strong, nonatomic)  NSMutableArray *playersList;

@property (strong, nonatomic)  NSMutableArray *playersCode;

@property (strong, nonatomic)  NSMutableArray *ArrayEX;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableWidth;

@end

@implementation AssignPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    objWebservice = [[WebService alloc]init];
    //[COMMON AddMenuView:self.view];
    
    self.selectedMarks = [[NSMutableArray alloc]init];
    
    self.ProgramView.layer.borderWidth=0.5f;
    self.ProgramView.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.PlayersView.layer.borderWidth=0.5f;
    self.PlayersView.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.commonView.hidden = YES;
    self.popList.hidden = YES;
    
    self.Save.hidden = NO;
    self.Update.hidden = YES;
    self.Delete.hidden = YES;
    
    if([self.Scrname isEqualToString:@"Physio"])
    {
        self.ModuleCode = @"MSC084";
    }
    else if([self.Scrname isEqualToString:@"S and C"])
    {
        self.ModuleCode = @"MSC085";
    }
    else if([self.Scrname isEqualToString:@"Coach"])
    {
        self.ModuleCode = @"MSC086";
    }
    
    NSLog(@"%@", self.ModuleCode);
    
    [self ProgramWebservice];

    [self customnavigationmethod];
}
-(void)viewWillAppear:(BOOL)animated
{
    [COMMON AddMenuView:self.view];
}
-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    
    
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=[NSString stringWithFormat:@"%@ Assign Player",self.Scrname];
    if([self.check isEqualToString:@"main"])
    {
        
        objCustomNavigation.btn_back.hidden =NO;
        objCustomNavigation.menu_btn.hidden = YES;
        [objCustomNavigation.menu_btn addTarget:self action:@selector(MenuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [objCustomNavigation.btn_back addTarget:self action:@selector(btn_back:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        objCustomNavigation.btn_back.hidden =YES;
        objCustomNavigation.menu_btn.hidden = NO;
        [objCustomNavigation.menu_btn addTarget:self action:@selector(MenuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [objCustomNavigation.btn_back addTarget:self action:@selector(btn_back:) forControlEvents:UIControlEventTouchUpInside];
    }

    
    
    
}

-(void)ProgramWebservice
{
    // [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",programAssignKey]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        
        NSString *createdby = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
        NSString *clientcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(createdby)   [dic    setObject:createdby     forKey:@"CreatedBy"];
        if(clientcode)   [dic    setObject:clientcode     forKey:@"ClientCode"];
        if(self.ModuleCode) [dic    setObject:self.ModuleCode     forKey:@"Modulecode"];
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                self.respList =[[NSMutableArray alloc]init];
                self.ProgramsList =[[NSMutableArray alloc]init];
                self.ProgramCodeList =[[NSMutableArray alloc]init];
                
                self.respList=[responseObject valueForKey:@"Programs"];
                if(![self.respList isEqual:[NSNull null]])
                {
                self.ProgramsList = [self.respList valueForKey:@"ProgramName"];
                self.ProgramCodeList = [self.respList valueForKey:@"ProgramCode"];
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
-(void)PlayerWebservice
{
    
    NSString *clientcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    
    
    [objWebservice GetPlayers :playerAssignKey :clientcode  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject=%@",responseObject);
        if(responseObject >0)
        {
            self.respList = [[NSMutableArray alloc]init];
            self.playersList = [[NSMutableArray alloc]init];
            self.playersCode = [[NSMutableArray alloc]init];
            
            self.respList = [responseObject valueForKey:@"fetchAthlete"];
            self.playersList = [self.respList valueForKey:@"athleteName"];
            self.playersCode = [self.respList valueForKey:@"athleteCode"];
            [self.multiTbl reloadData];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, id error) {
        NSLog(@"failed");
        [COMMON webServiceFailureError];
    }];
    
}
-(void)SaveWebservice
{
    // [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",programAssignSaveKey]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        
        NSString *createdby = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
        NSString *clientcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(self.selectedMarks)   [dic    setObject:self.selectedMarks     forKey:@"PlayerCodes"];
        if(createdby)   [dic    setObject:createdby     forKey:@"CreatedBy"];
        if(clientcode)   [dic    setObject:clientcode     forKey:@"ClientCode"];
        if(self.ModuleCode) [dic    setObject:self.ModuleCode     forKey:@"Modulecode"];
        if(prgCode) [dic    setObject:prgCode     forKey:@"ProgramCode"];
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                [self ShowAlterMsg:@"Assign Player Inserted Successfully"];
                self.Prgmlbl.text = @"";
                self.Plylbl.text = @"";
                
                self.Save.hidden = NO;
                self.Update.hidden =YES;
                self.Delete.hidden = YES;
                [self.selectedMarks removeAllObjects];
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

-(void)UpdateWebservice
{
    // [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",UpdateAssignKey]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        
        NSString *createdby = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
        NSString *clientcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(self.selectedMarks)   [dic    setObject:self.selectedMarks     forKey:@"PlayerCodes"];
        if(createdby)   [dic    setObject:createdby     forKey:@"CreatedBy"];
        if(clientcode)   [dic    setObject:clientcode     forKey:@"ClientCode"];
        if(self.ModuleCode) [dic    setObject:self.ModuleCode     forKey:@"Modulecode"];
        if(prgCode) [dic    setObject:prgCode     forKey:@"ProgramCode"];
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                BOOL status =[responseObject valueForKey:@"Status"];
            
                if(status == YES)
                {
                    [self ShowAlterMsg:@"Player Update Successfully"];
                    self.Prgmlbl.text = @"";
                    self.Plylbl.text = @"";
                
                    self.Save.hidden = NO;
                    self.Update.hidden =YES;
                    self.Delete.hidden = YES;
                    [self.selectedMarks removeAllObjects];
                
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
-(void)DeleteWebservice
{
    // [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",DeleteAssignKey]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        
        NSString *clientcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(clientcode)   [dic    setObject:clientcode     forKey:@"ClientCode"];
        if(self.ModuleCode) [dic    setObject:self.ModuleCode     forKey:@"Modulecode"];
        if(prgCode) [dic    setObject:prgCode     forKey:@"ProgramCode"];
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                BOOL status =[responseObject valueForKey:@"Status"];
                
                if(status == YES)
                {
                    [self ShowAlterMsg:@"Player Deleted Successfully"];
                    self.Prgmlbl.text = @"";
                    self.Plylbl.text = @"";
                    
                    self.Save.hidden = NO;
                    self.Update.hidden =YES;
                    self.Delete.hidden = YES;
                    
                    [self.selectedMarks removeAllObjects];
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


-(void)EditWebservice
{
    // [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",EditAssignKey]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        
        NSString *createdby = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
        NSString *clientcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(createdby)   [dic    setObject:createdby     forKey:@"CreatedBy"];
        if(clientcode)   [dic    setObject:clientcode     forKey:@"ClientCode"];
        if(self.ModuleCode) [dic    setObject:self.ModuleCode     forKey:@"Modulecode"];
        if(prgCode) [dic    setObject:prgCode     forKey:@"ProgramCode"];
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                
                NSMutableArray *check = [[NSMutableArray alloc]init];
                check=responseObject;
                if(check.count == 0)
                {
                   
                    self.Save.hidden = NO;
                    self.Update.hidden =YES;
                    self.Delete.hidden = YES;
                }
                else
                {
                    self.Save.hidden = YES;
                    self.Update.hidden =NO;
                    self.Delete.hidden = NO;
                    
                    self.selectedMarks = [[NSMutableArray alloc]init];
                    self.ArrayEX = [[NSMutableArray alloc]init];
                    
                    NSMutableArray *res = [responseObject objectAtIndex:0];
                    self.ArrayEX = [res valueForKey:@"PlayerCodes"];
                    
                    for( int i=0;i<self.ArrayEX.count;i++)
                    {
                        plyCode = [self.ArrayEX objectAtIndex:i];
                        
                        
                        if ([self.selectedMarks containsObject:plyCode])// Is selected?
                            [self.selectedMarks removeObject:plyCode];
                        else
                            [self.selectedMarks addObject:plyCode];
                    }
                    
                    
                    static NSString *CRTableViewCellIdentifier = @"cellIdentifier";
                    CRTableViewCell *cell = (CRTableViewCell *)[self.popList dequeueReusableCellWithIdentifier:CRTableViewCellIdentifier];
                    cell.isSelected = [self.selectedMarks containsObject:plyCode] ? YES : NO;
                    
                    int a = self.selectedMarks.count;
                    if(a == 0)
                    {
                        //NSString *b = [NSString stringWithFormat:@"%d", a];
                        self.Plylbl.text = @"";
                    }
                    if(a == 1)
                    {
                        //NSString *b = [NSString stringWithFormat:@"%d", a];
                        self.Plylbl.text = [NSString stringWithFormat:@"%d item selected", a];
                    }
                    else
                    {
                        self.Plylbl.text = [NSString stringWithFormat:@"%d items selected", a];
                    }

                    
                    [self.multiTbl reloadData];
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

-(void)ShowAlterMsg1:(NSString*) MsgStr
{
    UIAlertView *objAlter =[[UIAlertView alloc]initWithTitle:@"" message:MsgStr delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"Ok", nil];
    [objAlter show];
    
   // [self DeleteWebservice];
    
}

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == [alertView cancelButtonIndex])
    {
        alertView.hidden=YES;
    }
    else
    {
        [self DeleteWebservice];
    }
}

-(void)ShowAlterMsg:(NSString*) MsgStr
{
    UIAlertView *objAlter =[[UIAlertView alloc]initWithTitle:@"" message:MsgStr delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [objAlter show];
    
}


-(IBAction)SaveAction:(id)sender
{
    
    [self SaveWebservice];
}
-(IBAction)UpdateAction:(id)sender
{
    
    [self UpdateWebservice];
}

-(IBAction)DeleteAction:(id)sender
{
    [self ShowAlterMsg1:@"Do you Want to delete Program?"];
}


-(IBAction)ProgramAction:(id)sender
{

    if(isPoplist == NO)
    {
    
    isPoplist = YES;
    isMulti = NO;
    self.tableWidth.constant = self.ProgramView.frame.size.width;
    self.popList.hidden = NO;
    [self.popList reloadData];
    }
    else
    {
        self.popList.hidden = YES;
        [self.popList reloadData];
    }
}

-(IBAction)PlayerAction:(id)sender
{
    isPoplist = NO;
    isMulti = YES;
    [self PlayerWebservice];
    self.commonView.hidden = NO;
    [self.multiTbl reloadData];
}

-(IBAction)SubmitAction:(id)sender
{
    isPoplist = NO;
    isMulti = YES;
    self.commonView.hidden = YES;
    [self.multiTbl reloadData];
}
-(IBAction)CancelAction:(id)sender
{
    isPoplist = NO;
    isMulti = YES;
    self.commonView.hidden = YES;
    [self.multiTbl reloadData];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(isPoplist)
    {
        return self.ProgramsList.count;
    }
    if(isMulti)
    {
        return self.playersList.count;
    }
  return nil;
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(isPoplist)
    {
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:nil];
    }

    cell.textLabel.text = self.ProgramsList[indexPath.row];
    return cell;
    }
    if(isMulti)
    {
        
        static NSString *CRTableViewCellIdentifier = @"cellIdentifier";
        CRTableViewCell *cell = (CRTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CRTableViewCellIdentifier];
        
        if (cell == nil) {
            cell = [[CRTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CRTableViewCellIdentifier];
        }
    
        plyCode = [self.playersCode objectAtIndex:indexPath.row];
        NSString *text = [self.playersList objectAtIndex:[indexPath row]];
        cell.isSelected = [self.selectedMarks containsObject:plyCode] ? YES : NO;
        cell.textLabel.text = text;
        return cell;
    }

    
    
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(isPoplist)
    {
        
     prgCode=self.ProgramCodeList[indexPath.row];
     [self EditWebservice];
     self.popList.hidden = YES;
     self.Prgmlbl.text = self.ProgramsList[indexPath.row];
     
        
    }
    if(isMulti)
    {
        
        plyCode = [self.playersCode objectAtIndex:indexPath.row];
        if ([self.selectedMarks containsObject:plyCode])// Is selected?
            [self.selectedMarks removeObject:plyCode];
        else
            [self.selectedMarks addObject:plyCode];
        
        static NSString *CRTableViewCellIdentifier = @"cellIdentifier";
        
        CRTableViewCell *cell = (CRTableViewCell *)[self.popList dequeueReusableCellWithIdentifier:CRTableViewCellIdentifier];
        cell.isSelected = [self.selectedMarks containsObject:plyCode] ? YES : NO;
        
        
        
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        int a = self.selectedMarks.count;
        if(a == 0)
        {
            //NSString *b = [NSString stringWithFormat:@"%d", a];
            self.Plylbl.text = @"";
        }
        if(a == 1)
        {
            //NSString *b = [NSString stringWithFormat:@"%d", a];
            self.Plylbl.text = [NSString stringWithFormat:@"%d item selected", a];
        }
        else
        {
            self.Plylbl.text = [NSString stringWithFormat:@"%d items selected", a];
        }

    }
    
    
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
