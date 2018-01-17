//
//  PlayerVC.m
//  AlphaProTracker
//
//  Created by Lexicon on 06/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "PlayerVC.h"
#import "AppCommon.h"
#import "HomeVC.h"
#import "CustomNavigation.h"
#import "Config.h"
#import "WebService.h"
#import "ViewProfile.h"
#import "WellnessRating.h"
#import "TrainingLoad.h"
#import "RecentFitness.h"
#import "SummaryOfInjuries.h"
#import "CtlVsAtl.h"
#import "RecentPerformance.h"
#import "SessionDetails.h"
#import "BowlingLoad.h"

@interface PlayerVC ()
{
    
    NSString *plycde;
    NSString *tmecde;
    
    ViewProfile *viewpf;
    WellnessRating *WellRt;
    TrainingLoad *TrainingLd;
    RecentFitness *RcntFit;
    SummaryOfInjuries *sumInj;
    CtlVsAtl *ctlatl;
    RecentPerformance *RcntPer;
    SessionDetails *sessDetails;
    BowlingLoad *bwlLoad;
    
    NSString * SelectClientCode;
    NSString * Selectteamcode;
    NSString * Selectplayercode;
    
    
    //UILabel *sep_lbl;
    
}
@property (nonatomic,strong) IBOutlet  NSArray * titleArray;
@property (nonatomic,strong) IBOutlet  UILabel * sep_lbl;

@property (nonatomic,strong) IBOutlet  NSLayoutConstraint * Xposition;

@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@property (nonatomic,strong) IBOutlet NSMutableArray *detailslist;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint *imgHeight;

@end

@implementation PlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // [COMMON AddMenuView:self.view];
    [self customnavigationmethod];
    
    if([self.check isEqualToString:@"main"])
    {
        plycde = self.selectPlayercode;
        tmecde = self.selectTeamcode;
        
        self.titleArray =[[NSArray alloc]init];
        self.titleArray = @[@"PROFILE",@"WELLNESS RATING",@"TRAINING LOAD",@"RECENT FITNESS ",@"SUMMARY OF INJURIES",@"CTL VS ATL",@"RECENT PERFORMANCE ",@"SESSION DETAILS",@"BOWLING LOAD"];
        
        
        
        self.playername.text = self.selectPlayer;
        [self downloadImageWithURL:[NSURL URLWithString:self.selectPlayerimg] completionBlock:^(BOOL succeeded, UIImage *image) {
            if (succeeded) {
                // change the image in the cell
                self.playerpic.image = image;
                
                // cache the image for use later (when scrolling up)
                self.playerpic.image = image;
            }
        }];

    }
    else
    {
        
       NSString * pplycde = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
        NSString *pplayername = [[NSUserDefaults standardUserDefaults]stringForKey:@"Username"];
        NSString *pplayerimage = [[NSUserDefaults standardUserDefaults]stringForKey:@"PhotoPath"];
        
        plycde = pplycde;
        tmecde = self.selectTeamcode;
        
        self.titleArray =[[NSArray alloc]init];
        self.titleArray = @[@"PROFILE",@"WELLNESS RATING",@"TRAINING LOAD",@"RECENT FITNESS ",@"SUMMARY OF INJURIES",@"CTL VS ATL",@"RECENT PERFORMANCE ",@"SESSION DETAILS",@"BOWLING LOAD"];
        
        
        
        self.playername.text = pplayername;
        [self downloadImageWithURL:[NSURL URLWithString:pplayerimage] completionBlock:^(BOOL succeeded, UIImage *image) {
            if (succeeded) {
                // change the image in the cell
                self.playerpic.image = image;
                
                // cache the image for use later (when scrolling up)
                self.playerpic.image = image;
            }
        }];

        
    }
    
    
    
    self.playerpic.layer.masksToBounds = true;
    self.playerpic.clipsToBounds = true;
    self.playerpic.layer.cornerRadius = self.playerpic.frame.size.width/2;
    
    
    self.sep_lbl =[[UILabel alloc]initWithFrame:CGRectMake(15,75,140, 3)];
    [self.sep_lbl setBackgroundColor:[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1.0f]];
    [self.title_collection_view addSubview:self.sep_lbl];
    
    [self profileWebservice:SelectClientCode :Selectteamcode:Selectplayercode];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [COMMON AddMenuView:self.view];
}
-(void)viewDidAppear:(BOOL)animated
{
    NSIndexPath *indexPathForFirstRow = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.title_collection_view selectItemAtIndexPath:indexPathForFirstRow animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    [self collectionView:self.title_collection_view didSelectItemAtIndexPath:indexPathForFirstRow];
}
-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    
    
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"";
    
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


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    DashBoardVCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    
    
    cell.seprator_lbl.hidden = YES;
    
    cell.photos_title_lbl.text = self.titleArray[indexPath.row];
    
    
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    // [cell setBackgroundColor:[UIColor clearColor]];
    
    
    
    //    if(indexPath.row == 0)
    //    {
    //
    ////        [self setClearView];
    ////        viewpf = [[ViewProfile alloc] initWithNibName:@"ViewProfile" bundle:nil];
    ////
    ////        viewpf.Teamcode = tmecde;
    ////        viewpf.Playercode = plycde;
    ////        viewpf.UserCode = self.Playerusercde;
    ////        viewpf.view.frame = CGRectMake(0, 290, self.view.bounds.size.width, self.view.bounds.size.height);
    ////        [self.view addSubview:viewpf.view];
    ////
    ////        self.Xposition.constant = cell.frame.origin.x;
    //
    //
    //
    //    }
    //
    
    
    
    //cell.selectedBackgroundView.backgroundColor =[UIColor whiteColor];
    
    
    
    cell.photos_title_lbl.highlightedTextColor = [UIColor whiteColor];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    
    //DashBoardVCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    
    
    
    if(indexPath.row == 0)
    {
        
        
        
        [self setClearView];
        viewpf = [[ViewProfile alloc] initWithNibName:@"ViewProfile" bundle:nil];
        
        viewpf.Teamcode = tmecde;
        viewpf.Playercode = plycde;
        viewpf.UserCode = self.Playerusercde;
        
        viewpf.view.frame = CGRectMake(0, 340, self.view.bounds.size.width, self.view.bounds.size.height);
        [self.view addSubview:viewpf.view];
        
        self.Xposition.constant = cell.frame.origin.x;
        
        
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
    }
    
    
    
    if(indexPath.row == 1)
    {
        
        [self setClearView];
        WellRt = [[WellnessRating alloc] initWithNibName:@"WellnessRating" bundle:nil];
        
        WellRt.selecteddetailslist = self.detailslist;
        WellRt.selectedUsercode = self.Playerusercde;
        //WellRt.Teamcode = tmecde;
        //WellRt.Playercode = plycde;
        WellRt.view.frame = CGRectMake(0, 340, self.view.bounds.size.width, self.view.bounds.size.height);
        [self.view addSubview:WellRt.view];
        
        self.Xposition.constant = cell.frame.origin.x;
        
        
        
    }
    
    
    
    
    
    if(indexPath.row == 2)
    {
        
        
        [self setClearView];
        TrainingLd = [[TrainingLoad alloc] initWithNibName:@"TrainingLoad" bundle:nil];
        
        //TrainingLoad.Teamcode = tmecde;
        TrainingLd.Playercode = plycde;
        TrainingLd.UserCode = self.Playerusercde;
        TrainingLd.view.frame = CGRectMake(0, 340, self.view.bounds.size.width, self.view.bounds.size.height);
        [self.view addSubview:TrainingLd.view];
        
        self.Xposition.constant = cell.frame.origin.x;
        
        
        
    }
    
    
    if(indexPath.row == 3)
    {
        [self setClearView];
        RcntFit = [[RecentFitness alloc] initWithNibName:@"RecentFitness" bundle:nil];
        
        //RcntFit.Teamcode = tmecde;
        //RcntFit.Playercode = plycde;
        
        RcntFit.UserCode = self.Playerusercde;
        RcntFit.view.frame = CGRectMake(0, 340, self.view.bounds.size.width, self.view.bounds.size.height);
        [self.view addSubview:RcntFit.view];
        
        self.Xposition.constant = cell.frame.origin.x;
        
        
    }
    if(indexPath.row == 4)
    {
        
        [self setClearView];
        sumInj = [[SummaryOfInjuries alloc] initWithNibName:@"SummaryOfInjuries" bundle:nil];
        
        //sumInj.Teamcode = tmecde;
        sumInj.Playercode = plycde;
        sumInj.UserCode = self.Playerusercde;
        sumInj.view.frame = CGRectMake(0, 340, self.view.bounds.size.width, self.view.bounds.size.height);
        [self.view addSubview:sumInj.view];
        
        self.Xposition.constant = cell.frame.origin.x;
        
    }
    if(indexPath.row == 5)
    {
        
        
        [self setClearView];
        ctlatl = [[CtlVsAtl alloc] initWithNibName:@"CtlVsAtl" bundle:nil];
        
        //ctlatl.Teamcode = tmecde;
        //ctlatl.Playercode = plycde;
        
        ctlatl.view.frame = CGRectMake(0, 340, self.view.bounds.size.width, self.view.bounds.size.height);
        [self.view addSubview:ctlatl.view];
        
        // cell.photos_title_lbl.textColor = [UIColor whiteColor];
        
        self.Xposition.constant = cell.frame.origin.x;
        
    }
    if(indexPath.row == 6)
    {
        [self setClearView];
        RcntPer = [[RecentPerformance alloc] initWithNibName:@"RecentPerformance" bundle:nil];
        
        //RcntPer.Teamcode = tmecde;
        //RcntPer.Playercode = plycde;
        RcntPer.view.frame = CGRectMake(0, 340, self.view.bounds.size.width, self.view.bounds.size.height);
        [self.view addSubview:RcntPer.view];
        
        self.Xposition.constant = cell.frame.origin.x;
        
    }
    if(indexPath.row == 7)
    {
        [self setClearView];
        sessDetails = [[SessionDetails alloc] initWithNibName:@"SessionDetails" bundle:nil];
        
        //sessDetails.Teamcode = tmecde;
        //sessDetails.Playercode = plycde;
        
        sessDetails.UserCode = self.Playerusercde;
        sessDetails.view.frame = CGRectMake(0, 340, self.view.bounds.size.width, self.view.bounds.size.height);
        [self.view addSubview:sessDetails.view];
        
        self.Xposition.constant = cell.frame.origin.x;
        
        
        
    }
    if(indexPath.row == 8)
    {
        
        [self setClearView];
        bwlLoad = [[BowlingLoad alloc] initWithNibName:@"BowlingLoad" bundle:nil];
        
        //bwlLoad.Teamcode = tmecde;
        //bwlLoad.Playercode = plycde;
        bwlLoad.UserCode = self.Playerusercde;
        bwlLoad.view.frame = CGRectMake(0, 340, self.view.bounds.size.width, self.view.bounds.size.height);
        [self.view addSubview:bwlLoad.view];
        
        self.Xposition.constant = cell.frame.origin.x;
        
        
    }
    
    
    self.sep_lbl =[[UILabel alloc]initWithFrame:CGRectMake(cell.frame.origin.x,75,140, 3)];
    [self.sep_lbl setBackgroundColor:[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1.0f]];
    [self.title_collection_view addSubview:self.sep_lbl];
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    
}


//- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
//    cell.contentView.backgroundColor = [UIColor clearColor];
//}



- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor clearColor];
}




-(void)setClearView
{
    //if(self.sep_lbl != nil)
    //{
    
    //   [self.sep_lbl removeFromSuperview];
    //}
    if(viewpf != nil)
    {
        
        [viewpf.view removeFromSuperview];
    }
    
    if(WellRt != nil)
    {
        
        [WellRt.view removeFromSuperview];
    }
    if(TrainingLd != nil)
    {
        
        [TrainingLd.view removeFromSuperview];
    }
    if(RcntFit != nil)
    {
        
        [RcntFit.view removeFromSuperview];
    }
    if(sumInj != nil)
    {
        
        [sumInj.view removeFromSuperview];
    }
    if(ctlatl != nil)
    {
        
        [ctlatl.view removeFromSuperview];
    }
    if(RcntPer != nil)
    {
        
        [RcntPer.view removeFromSuperview];
    }
    if(sessDetails != nil)
    {
        
        [sessDetails.view removeFromSuperview];
    }
    if(bwlLoad != nil)
    {
        
        [bwlLoad.view removeFromSuperview];
    }
    
}




-(IBAction)MenuBtnAction:(id)sender
{
   [COMMON ShowsideMenuView];
    
}
-(IBAction)btn_back:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:NO];
}


-(IBAction)HomeBtnAction:(id)sender
{
    HomeVC  * objTabVC=[[HomeVC alloc]init];
    objTabVC = (HomeVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
    [self.navigationController pushViewController:objTabVC animated:YES];
    
    
}

-(void)profileWebservice :(NSString *) cliendcode :(NSString *) PlyCode :(NSString *) usercde
{
    //[COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",playerDetailsKey]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        
        NSString *cliendcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
        NSString * PlyCode = self.selectPlayercode;
        //NSString * usercde = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
        NSString *rolecode = [[NSUserDefaults standardUserDefaults]stringForKey:@"RoleCode"];
        
        NSString *usercode1 = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
        
        NSString *usercde;
        if( [rolecode isEqualToString:@"ROL0000002"] )
        {
            usercde = usercode1;
        }
        else
        {
            usercde = self.Playerusercde;
        }
        
        
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(cliendcode)   [dic    setObject:cliendcode     forKey:@"Clientcode"];
        if(PlyCode)   [dic    setObject:PlyCode     forKey:@"PlayerCode"];
        if(usercde)   [dic    setObject:usercde     forKey:@"Usercode"];
        
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            if(responseObject >0)
            {
                
                
                self.detailslist = [[NSMutableArray alloc]init];
                self.detailslist = [responseObject valueForKey:@"lstPlayerDashBoardWR"];
                
                
            }
            
            
            
            // self.datelist =[[NSMutableArray alloc]init];
            // self.datelist =[self.detailslist valueForKey:@"wellnessdate"];
            
            
            // self.ratinglist =[[NSMutableArray alloc]init];
            // self.ratinglist =[self.detailslist valueForKey:@"wellnessrating"];
            
            NSLog(@"%@", self.detailslist);
            
            
            
            //[COMMON RemoveLoadingIcon];
            [self.view setUserInteractionEnabled:YES];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed");
            [COMMON webServiceFailureError];
            [self.view setUserInteractionEnabled:YES];
            
        }];
    }
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
