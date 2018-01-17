//
//  ProfileVC.m
//  AlphaProTracker
//
//  Created by Lexicon on 04/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "ProfileVC.h"
#import "AppCommon.h"
#import "SACalendar.h"
#import "HomeVC.h"
#import "Config.h"
#import "WebService.h"
#import "CustomNavigation.h"
#import "TeamsVC.h"


@interface ProfileVC ()
{
    NSString * SelectClientCode;
    NSString * SelectUsercode;
    NSString * SelectTeamcode;
    
    TeamsVC *teams;
    
}

@property (nonatomic,strong) IBOutlet NSMutableArray *teamslist;
@property (nonatomic,strong) IBOutlet NSMutableArray *subteamslist;
@property (nonatomic,strong) IBOutlet NSMutableArray *teamcode;
@end

@implementation ProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[COMMON AddMenuView:self.view];
    self.teamslist =[[NSMutableArray alloc]init];
    self.subteamslist =[[NSMutableArray alloc]init];
    [self customnavigationmethod];
    [self profileWebservice:SelectClientCode :SelectUsercode];
    
       // Do any additional setup after loading the view.
}
-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    
    
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"Team List";
    
    if([self.check isEqualToString:@"main"])
    {
    objCustomNavigation.btn_back.hidden =NO;
    objCustomNavigation.menu_btn.hidden =YES;
    [objCustomNavigation.btn_back addTarget:self action:@selector(didClickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [objCustomNavigation.menu_btn addTarget:self action:@selector(MenuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        objCustomNavigation.btn_back.hidden =YES;
        objCustomNavigation.menu_btn.hidden =NO;
        [objCustomNavigation.btn_back addTarget:self action:@selector(didClickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
        [objCustomNavigation.menu_btn addTarget:self action:@selector(MenuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [COMMON AddMenuView:self.view];
}

-(void)profileWebservice :(NSString *) cliendcode :(NSString *) usercode
{
    [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",profileKey]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        
        NSString *cliendcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
       
        NSString *usercode = @"USM0000002";
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(cliendcode)   [dic    setObject:cliendcode     forKey:@"Clientcode"];
        if(usercode)   [dic    setObject:usercode     forKey:@"Usercode"];
        
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            if(responseObject >0)
            {
                
                
                self.teamslist = [[NSMutableArray alloc]init];
                self.teamslist = [responseObject valueForKey:@"lstTeamDetails"];
                
                self.teamcode= [[NSMutableArray alloc]init];
                self.teamcode=[self.teamslist valueForKey:@"TeamCode"];
                
                
                self.subteamslist = [[NSMutableArray alloc]init];
                self.subteamslist = [self.teamslist valueForKey:@"TeamName"];
                
                
                
                
                
            }
            
            [self.teamsTbl reloadData];
            
            [COMMON RemoveLoadingIcon];
            [self.view setUserInteractionEnabled:YES];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed");
            [COMMON webServiceFailureError];
            [self.view setUserInteractionEnabled:YES];
            
        }];
    }
    
}
- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image);
                               } else{
                                   completionBlock(NO,nil);
                               }
                           }];
}






- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.subteamslist.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(IS_IPHONE_DEVICE)
    {
        return 45;

    }
    else{
        return 45;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *MyIdentifier = @"MyIdentifier";
    ProfileVCCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (cell==nil) {
       [[NSBundle mainBundle] loadNibNamed:@"ProfileVCCell" owner:self options:nil];
      // cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefaultreuseIdentifier:MyIdentifier];
        
    }
    cell = self.objProfilecell;

    cell.Teamsname.text = self.subteamslist[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
     cell.backgroundColor = [UIColor clearColor];
    
    NSString * imgStr1 = ([[self.teamslist objectAtIndex:indexPath.row] valueForKey:@"TeamLogo"]==[NSNull null])?@"":[[self.teamslist objectAtIndex:indexPath.row] valueForKey:@"TeamLogo"];
    
    [self downloadImageWithURL:[NSURL URLWithString:imgStr1] completionBlock:^(BOOL succeeded, UIImage *image) {
        if (succeeded) {
            // change the image in the cell
            cell.teamLogo.image = image;
            
            // cache the image for use later (when scrolling up)
            cell.teamLogo.image = image;
        }
    }];

    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if(indexPath.row==0)
//    {
    TeamsVC  * objTabVC=[[TeamsVC alloc]init];
    objTabVC = (TeamsVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"TeamsVC"];
    [self.navigationController pushViewController:objTabVC animated:YES];
        
    self.teamcode1 = [self.teamcode objectAtIndex:indexPath.row];
    self.teamname = [self.subteamslist objectAtIndex:indexPath.row];
    
    objTabVC.selectteamcode = self.teamcode1;
    objTabVC.selectTeamname = self.teamname;

        
    //}
//    if(indexPath.row==1)
//    {
//        
//        TeamsVC  * objTabVC=[[TeamsVC alloc]init];
//        objTabVC = (TeamsVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"TeamsVC"];
//        [self.navigationController pushViewController:objTabVC animated:YES];
//        
//        self.teamcode1 = [self.teamcode objectAtIndex:1];
//        self.teamname = [self.subteamslist objectAtIndex:1];
//        
//        objTabVC.selectteamcode = self.teamcode1;
//        objTabVC.selectTeamname = self.teamname;
//        
//        
//    }

    
    
    
    
}
-(IBAction)MenuBtnAction:(id)sender
{
   [COMMON ShowsideMenuView];
}
-(IBAction)didClickBackBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];

}

-(IBAction)HomeBtnAction:(id)sender
{
    
    HomeVC  * objTabVC=[[HomeVC alloc]init];
    objTabVC = (HomeVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
    [self.navigationController pushViewController:objTabVC animated:YES];

    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
