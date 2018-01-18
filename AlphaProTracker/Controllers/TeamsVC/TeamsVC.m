//
//  TeamsVC.m
//  AlphaProTracker
//
//  Created by Lexicon on 05/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "TeamsVC.h"
#import "AppCommon.h"
#import "HomeVC.h"
#import "CustomNavigation.h"
#import "Config.h"
#import "WebService.h"
#import "PlayerVC.h"
#import "ParallaxHeaderView.h"



@interface TeamsVC ()
{
    NSString * SelectClientCode;
    NSString * SelectUsercode;
    NSString * teamcode;
    
    NSString*  player;
    NSString*  playerimage;
    NSString*  playercode;
    NSString * plyusercode;
    
    NSString*  ply;
    NSString*  plyimage;
    NSString*  plycode;
    NSString*  plyuscode;
    
    
    
}
@property (nonatomic,strong) IBOutlet NSMutableArray *teamslist;
@property (nonatomic,strong) IBOutlet NSMutableArray *subteamslist;
@property (nonatomic,strong) IBOutlet NSMutableArray *playerlist;
@property (nonatomic,strong) IBOutlet NSMutableArray *imagelist;
@property (nonatomic,strong) IBOutlet NSMutableArray *Usercodelist;
@property (nonatomic,strong) IBOutlet NSMutableArray *playercodelist;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint *imgHeight;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint *nameYView;


@end

@implementation TeamsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[COMMON AddMenuView:self.view];
    [self profileWebservice:SelectClientCode :SelectUsercode];
    [self customnavigationmethod];
    
    
    self.Teamname.text = self.selectTeamname;
    //teamcode = self.selectteamcode;
    
    NSLog(@"%@", self.selectteamcode);
    
    // Do any additional setup after loading the view.
    
    ParallaxHeaderView *headerView = [ParallaxHeaderView parallaxHeaderViewWithImage:[UIImage imageNamed:@"banner"] forSize:CGSizeMake(self.playersTbl.frame.size.width, 300)];
    headerView.headerTitleLabel.text = self.selectTeamname;
    [self.playersTbl setTableHeaderView:headerView];

}
//-(void)viewDidLayoutSubviews
//{
//    [self.playersTbl setContentInset:UIEdgeInsetsMake(self.containerUIView.bounds.size.height, 0.f, 0.f, 0.f)];
//    [self.playersTbl scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
//
//    float headerImageYOffset = 88+self.containerUIView.bounds.size.height - self.view.bounds.size.height;
//    CGRect headerImageFrame = _containerUIView.frame;
//    headerImageFrame.origin.y = headerImageYOffset;
//}
-(void)viewWillAppear:(BOOL)animated
{
    //[COMMON AddMenuView:self.view];
}
- (void)viewDidAppear:(BOOL)animated
{
    [(ParallaxHeaderView *)self.playersTbl.tableHeaderView refreshBlurViewForNewImage];
    [super viewDidAppear:animated];
}

-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    
    
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"";
    objCustomNavigation.btn_back.hidden =NO;
    objCustomNavigation.menu_btn.hidden = YES;
    objCustomNavigation.home_btn.hidden =YES;
    [objCustomNavigation.btn_back addTarget:self action:@selector(didClickbackBtn:) forControlEvents:UIControlEventTouchUpInside];
    //[objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
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
        
        NSString *usercode = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
        //@"USM0000002";
        
        
        
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
                
                
                self.subteamslist = [[NSMutableArray alloc]init];
                self.subteamslist = [responseObject valueForKey:@"lstCoachPlayerAvailability"];
                
                
                self.playerlist = [[NSMutableArray alloc]init];
                self.imagelist = [[NSMutableArray alloc]init];
                self.playercodelist = [[NSMutableArray alloc]init];
                self.Usercodelist = [[NSMutableArray alloc]init];
                if(self.subteamslist.count>0)
                {
                    for(int i=0; self.subteamslist.count>i;i++)
                    {
                        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
                        dictionary=[self.subteamslist objectAtIndex:i];
                        NSString*  strckercode;
                        strckercode =([dictionary valueForKey:@"TeamCode"]);
                        
                        //NSString * strckercode =[dictionary valueForKey:@"STRIKERCODE"];
                        if([self.selectteamcode isEqualToString:strckercode])
                        {
                            
                            
                            player = [dictionary valueForKey:@"Player"];
                            playerimage = [dictionary valueForKey:@"CoachImage"];
                            playercode = [dictionary valueForKey:@"PlayerCode"];
                            plyusercode = [dictionary valueForKey:@"Usercode"];
                            
                            
                            [self.playerlist addObject:player];
                            [self.imagelist addObject:playerimage];
                            [self.playercodelist addObject:playercode];
                            [self.Usercodelist addObject:plyusercode];
                            
                            
                        }
                    }
                    
                }
                
                
                NSLog(@"%@", self.playerlist);
                
                
                
                
                
                
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
    return self.playerlist.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *MyIdentifier = @"MyIdentifier";
    ProfileVCCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"ProfileVCCell" owner:self options:nil];
        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefaultreuseIdentifier:MyIdentifier];
    }
    
    cell=self.objProfilecell;
    
    cell.backgroundColor = [UIColor clearColor];
    cell.Teamsname.text = self.playerlist[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString * imgStr1 = [self.imagelist objectAtIndex:indexPath.row] ;
    
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
    PlayerVC  * objTabVC=[[PlayerVC alloc]init];
    objTabVC = (PlayerVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"PlayerVC"];
    [self.navigationController pushViewController:objTabVC animated:YES];
    
    plycode = [self.playercodelist objectAtIndex:indexPath.row];
    ply = [self.playerlist objectAtIndex:indexPath.row];
    plyimage = [self.imagelist objectAtIndex:indexPath.row];
    plyuscode = [self.Usercodelist objectAtIndex:indexPath.row];
    
    
    objTabVC.selectTeamcode = self.selectteamcode;
    objTabVC.selectPlayercode = plycode;
    objTabVC.selectPlayer = ply;
    objTabVC.selectPlayerimg = plyimage;
    objTabVC.Playerusercde = plyuscode;
    objTabVC.check = @"main";
    
    
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
//#pragma  mark - Parallax Scrolling Animation
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//
//    CGFloat scrollOffset = -scrollView.contentOffset.y;
//    CGFloat yPos = scrollOffset -_containerUIView.bounds.size.height+25;
//    _containerUIView.frame = CGRectMake(0, yPos, _containerUIView.frame.size.width, _containerUIView.frame.size.height);
//    float alpha=1.0-(-yPos/ _containerUIView.frame.size.height);
//    self.teamImg.alpha=alpha;
//    float fontSize=24-(-yPos/20);
//    self.Teamname.font=[UIFont systemFontOfSize:fontSize];
//
//}
#pragma mark -
#pragma mark UISCrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.playersTbl)
    {
        // pass the current offset of the UITableView so that the ParallaxHeaderView layouts the subViews.
        [(ParallaxHeaderView *)self.playersTbl.tableHeaderView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
    }
}

-(IBAction)didClickbackBtn:(id)sender
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
