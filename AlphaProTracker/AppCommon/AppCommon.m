	//
//  AppCommon.m
//  AlphaProTracker
//
//  Created by Mac on 21/08/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "AppCommon.h"
#import "Reachability.h"
#import "LoginVC.h"
#import "WebService.h"
#import "Config.h"
#import "DBMANAGERSYNC.h"
#import "QuestionaryVC.h"
#import "ProgramVC.h"
#import "AssignPlayerVC.h"
#import <sqlite3.h>
#import "ExcersizeViewController.h"

@implementation AppCommon
AppCommon *sharedCommon = nil;

+ (AppCommon *)common {
    
    if (!sharedCommon) {
        
        sharedCommon = [[self alloc] init];
    }
    return sharedCommon;
}

- (id)init {
    
    return self;
}

-(void)loadingIcon:(UIView *)view
{
    loadingView = [[UIView alloc] initWithFrame:CGRectMake((view.frame.size.width)/2, (view.frame.size.height)/2, 37, 37)];
    
    [loadingView.layer setCornerRadius:5.0];
    
    [loadingView setBackgroundColor:[UIColor blackColor]];
    
    //Enable maskstobound so that corner radius would work.
    
    [loadingView.layer setMasksToBounds:YES];
    
    //Set the corner radius
    
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    [activityView setFrame:CGRectMake(0,0, 37, 37)];
    
    [activityView setHidesWhenStopped:YES];
    
    [activityView startAnimating];
    
    [loadingView addSubview:activityView];
    [view addSubview:loadingView];
    [view setUserInteractionEnabled:NO];
    
}

-(void)RemoveLoadingIcon
{
    [loadingView removeFromSuperview];
    
}
#pragma mark Reachable

-(BOOL) isInternetReachable
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus != NotReachable) {
        NSLog(@"Data Connected");
        return YES;
    }
    else {
        [self reachabilityNotReachableAlert];
        return NO;
    }
}

-(void)reachabilityNotReachableAlert{
    
    [self RemoveLoadingIcon];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"] message:@"It appears that you have lost network connectivity. Please check your network settings!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [alert show];
    
}

-(void)webServiceFailureError
{
    [self RemoveLoadingIcon];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"] message:@"Server Error" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [alert show];
}

#pragma mark - get usercode,clientcode,usereferencecode

-(NSString *)GetUsercode
{
    NSString * usercode = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
    return usercode;
}
-(NSString *) GetClientCode
{
    NSString * clientcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    return clientcode;
}
-(NSString *) GetuserReference
{
    NSString * userreference =  [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
    return userreference;
}

#pragma mark - Get Height of Control

- (CGSize)getControlHeight:(NSString *)string withFontName:(NSString *)fontName ofSize:(NSInteger)size withSize:(CGSize)LabelWidth {
    CGSize maxSize = LabelWidth;
    CGSize dataHeight;
    
    UIFont *font = [UIFont fontWithName:fontName size:size];
    //    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //    paragraphStyle.paragraphSpacing = 50 * font.lineHeight;
    NSString *version = [[UIDevice currentDevice] systemVersion];
    
    if ([version floatValue]>=7.0) {
        CGRect textRect = [string boundingRectWithSize:maxSize
                                               options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading
                                            attributes:@{NSFontAttributeName:font}
                                               context:nil];
        
        
        dataHeight = CGSizeMake(textRect.size.width , textRect.size.height+20);
        
    }
    
    return CGSizeMake(dataHeight.width, dataHeight.height);
}
-(void)AddMenuView:(UIView *)view
{
    //Rightswipe
    
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandlerRight)];
    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [view addGestureRecognizer:gestureRecognizer];
    
    //LeftSwipe
    UISwipeGestureRecognizer * LeftgestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandlerLeft)];
    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [view addGestureRecognizer:LeftgestureRecognizer];
    
    //MenuView * menuView;
    
    menuview =[[UIView alloc]init];
    menuview.frame =CGRectMake(view.frame.origin.x,view.frame.origin.y,view.frame.size.width,view.frame.size.height);
    [view addSubview:menuview];
    
    backgroundTransview =[[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
    [view addSubview:backgroundTransview];

    [backgroundTransview setBackgroundColor:[UIColor blackColor]];
    backgroundTransview.alpha=0.25;
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [backgroundTransview addGestureRecognizer:singleFingerTap];
    
    commonview = (IS_IPAD)?[[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height)] : [[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width/1.4,[UIScreen mainScreen].bounds.size.height)];
    [view addSubview:commonview];
    commonview.backgroundColor = [UIColor greenColor];
    
    UIView * profileView = (IS_IPAD)?[[UIView alloc]initWithFrame:CGRectMake(0,0,menuview.frame.size.width/2,150)]:[[UIView alloc]initWithFrame:CGRectMake(0,0,menuview.frame.size.width/1.4,150)];
    [commonview addSubview:profileView];
    
    UIImageView * bgImg =[[UIImageView alloc]initWithFrame:CGRectMake(profileView.frame.origin.x,profileView.frame.origin.y,profileView.frame.size.width,profileView.frame.size.height)];
    [bgImg setImage:[UIImage imageNamed:@"MenuBgImg"]];
    [profileView addSubview:bgImg];
    
    UIImageView * profileImg =[[UIImageView alloc]initWithFrame:CGRectMake(10,30,40,40)];
    [profileImg setImage:[UIImage imageNamed:@"profileImg"]];
    [profileView addSubview:profileImg];
    
    NSString *username = [[NSUserDefaults standardUserDefaults]stringForKey:@"Username"];
    NSString *userRolename = [[NSUserDefaults standardUserDefaults]stringForKey:@"RoleName"];
    
    UILabel * userNamelbl =[[UILabel alloc]initWithFrame:CGRectMake(10,profileImg.frame.origin.y+profileImg.frame.size.height,menuview.frame.size.width-10,30)];
    userNamelbl.text=username;
    userNamelbl.textColor = [UIColor whiteColor];
    userNamelbl.font = (IS_IPAD)? [UIFont fontWithName:@"Helvetica" size:15]:[UIFont fontWithName:@"Helvetica" size:13];
   

    [profileView addSubview:userNamelbl];
    
    UIView * popView =[[UIView alloc]initWithFrame:CGRectMake(10,userNamelbl.frame.origin.y+userNamelbl.frame.size.height,profileView.frame.size.width-20,40)];

    UILabel * selectTypelbl =[[UILabel alloc]initWithFrame:CGRectMake(0,0,popView.frame.size.width-30,popView.frame.size.height)];
    selectTypelbl.text =userRolename;
    selectTypelbl.textColor = [UIColor whiteColor];
    selectTypelbl.font = (IS_IPAD)? [UIFont fontWithName:@"Helvetica" size:15]:[UIFont fontWithName:@"Helvetica" size:13];

    [popView addSubview:selectTypelbl];
    
    UIImageView * dropdownImg =[[UIImageView alloc]initWithFrame:CGRectMake(popView.frame.size.width-20,selectTypelbl.frame.origin.y+10,20,20)];
    [dropdownImg setImage:[UIImage imageNamed:@"ico_cmb"]];
    [popView addSubview:dropdownImg];
    
    [profileView addSubview:popView];
    
    UIView * tblBackgroundview =(IS_IPAD)?[[UIView alloc]initWithFrame:CGRectMake(0,profileView.frame.origin.y+profileView.frame.size.height,menuview.frame.size.width/2,[UIScreen mainScreen].bounds.size.height-profileView.frame.size.height)] : [[UIView alloc]initWithFrame:CGRectMake(0,profileView.frame.origin.y+profileView.frame.size.height,menuview.frame.size.width/1.4,[UIScreen mainScreen].bounds.size.height-profileView.frame.size.height)];
    
    tblBackgroundview.backgroundColor =[UIColor colorWithRed:(28/255.0f) green:(26/255.0f) blue:(65/255.0f) alpha:1.0f];
    [commonview addSubview:tblBackgroundview];
    
    tableview =[[SKSTableView alloc]initWithFrame:CGRectMake(0,0,tblBackgroundview.frame.size.width,tblBackgroundview.frame.size.height)];
    tableview.SKSTableViewDelegate = self;
    tableview.separatorColor=[UIColor clearColor];
    tableview.backgroundColor =[UIColor clearColor];
    
    [tblBackgroundview addSubview:tableview];
    
    NSString *rolecode = [[NSUserDefaults standardUserDefaults]stringForKey:@"RoleCode"];
    
    if([rolecode isEqualToString:@"ROL0000002"])
    {
            _contents = @[
                          
                          @[
                              @[@"HOME"],
                              @[@"PLANNER"],
                              @[@"WORK LOAD MANAGEMENT"],
                              @[@"ILLNESS"],
                              @[@"INJURY"],
                              @[@"FOOD DIARY"],
                              @[@"PROFILE"],
                              @[@"LOGOUT"]]
                          ];
            isPlayer=YES;
    }
    else
    {
        
            _contents = @[
                          
                          @[
                              @[@"HOME"],
                              @[@"PLANNER"],
                              @[@"PHYSIO", @"Assessment", @"Questionnaire", @"SinglePlayerReport", @"MultiPlayerReport", @"program",@"Assign Player"],
                              @[@"STRENGTH & CONDITIONS",@"Assessment",@"Questionnaire",@"SinglePlayerReport",@"MultiPlayerReport",@"Program",@"Assign player"],
                              @[@"COACH",@"Assessment",@"Questionnaire",@"SinglePlayerReport",@"MultiPlayerReport",@"Program",@"Assign player"],
                              @[@"WORK LOAD MANAGEMENT"],
                              @[@"FOOD DIARY"],
                              @[@"PROFILE"],
                              @[@"SYNC DATA"],
                              @[@"ILLNESS"],
                              @[@"INJURY"],
                              @[@"LOGOUT"]]
                          ];
            isPlayer=NO;
    }
    commonview.hidden=YES;
    [self swipeHandlerRight];
   

    }

-(void)ShowsideMenuView
{
    [self swipeHandlerLeft];

}


-(void)swipeHandlerRight
{
    //Your ViewController
    NSLog(@"RightSwipe");
    [UIView animateWithDuration:0.5
                     animations:^{
                         // animations go here
                         backgroundTransview.hidden = YES;

                         commonview.frame = (IS_IPAD)? CGRectMake(-menuview.frame.size.width,menuview.frame.origin.y, menuview.frame.size.width/2, menuview.frame.size.height): CGRectMake(-menuview.frame.size.width,menuview.frame.origin.y, menuview.frame.size.width/1.4, menuview.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         menuview.frame = CGRectMake(-menuview.frame.size.width,menuview.frame.origin.y, menuview.frame.size.width, menuview.frame.size.height);

                     }];
}
-(void)swipeHandlerLeft
{
    NSLog(@"LeftSwipe");
    //Your ViewController
    [UIView animateWithDuration:0.5
                     animations:^{
                         // animations go here
                         commonview.hidden=NO;

                         commonview.frame =(IS_IPAD)? CGRectMake(0,menuview.frame.origin.y, menuview.frame.size.width/2, menuview.frame.size.height): CGRectMake(0,menuview.frame.origin.y, menuview.frame.size.width/1.4, menuview.frame.size.height);
                        
                     }
                     completion:^(BOOL finished) {
                         backgroundTransview.hidden = NO;

                          menuview.frame = CGRectMake(menuview.frame.size.width,menuview.frame.origin.y, menuview.frame.size.width, menuview.frame.size.height);
                         // block fires when animation has finished
                     }];
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.contents count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contents[section] count];
}

- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.contents[indexPath.section][indexPath.row] count] - 1;
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

    if(isPlayer==YES)
    {
        if (!cell)
            cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        cell.textLabel.text = self.contents[indexPath.section][indexPath.row][0];
        cell.textLabel.textColor =[UIColor whiteColor];
        cell.textLabel.font = (IS_IPAD)? [UIFont fontWithName:@"Helvetica" size:15]:[UIFont fontWithName:@"Helvetica" size:13];

//        if ((indexPath.section == 0 && (indexPath.row == 2)) || (indexPath.section == 0 && (indexPath.row == 3)) || (indexPath.section == 0 && (indexPath.row == 4)))
//            cell.expandable = YES;
//        else
            cell.expandable = NO;
        cell.backgroundColor =[UIColor colorWithRed:(17/255.0f) green:(24/255.0f) blue:(67/255.0f) alpha:0.9];
    }
    else
    {
        
    if (!cell)
        cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    cell.textLabel.text = self.contents[indexPath.section][indexPath.row][0];
    cell.textLabel.textColor =[UIColor whiteColor];
    //[cell.textLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
    cell.textLabel.font = (IS_IPAD)? [UIFont fontWithName:@"Helvetica" size:15]:[UIFont fontWithName:@"Helvetica" size:13];
    
    if ((indexPath.section == 0 && (indexPath.row == 2)) || (indexPath.section == 0 && (indexPath.row == 3)) || (indexPath.section == 0 && (indexPath.row == 4)))
        cell.expandable = YES;
    else
        cell.expandable = NO;
    cell.backgroundColor =[UIColor colorWithRed:(17/255.0f) green:(24/255.0f) blue:(67/255.0f) alpha:0.9];
    
    }
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.contents[indexPath.section][indexPath.row][indexPath.subRow]];
    cell.backgroundColor =[UIColor colorWithRed:(17/255.0f) green:(24/255.0f) blue:(67/255.0f) alpha:1.0];
    cell.textLabel.textColor =[UIColor whiteColor];
    //[cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:14]];
    cell.textLabel.font = (IS_IPAD)? [UIFont fontWithName:@"Helvetica" size:15]:[UIFont fontWithName:@"Helvetica" size:13];
    return cell;
}

- (CGFloat)tableView:(SKSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    commonview.hidden=NO;
    menuview.hidden=NO;
    if(isPlayer==YES)
    {
//        [@"HomeVC",@"Planner",@"WorkLoadVC",@"Illness",@"injury",@"FoodDairyVC",@"PlayerVC"]
        
        if(indexPath.row==0)
        {
            
            [self redirectSelectview:@"HomeVC"];
            
        }
        
        else if(indexPath.row ==1)
        {
            [self redirectSelectview:@"Planner"];
            
        }
        
        else if(indexPath.row ==2)
        {
            [self redirectSelectview:@"WorkLoadVC"];
            
        }
        else if (indexPath.row == 3)
        {
            [self redirectSelectview:@"Illness"];
        }
        else if (indexPath.row == 4)
        {
            [self redirectSelectview:@"injury"];
        }
        else if (indexPath.row == 5)
        {
            [self redirectSelectview:@"FoodDairyVC"];
        }
        else if (indexPath.row == 6)
        {
            [self redirectSelectview:@"PlayerVC"];
        }
        else if (indexPath.row ==7)
        {
            UIAlertView *objAlter =[[UIAlertView alloc]initWithTitle:@"" message:@"Do you want to Logout?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [objAlter show];

            
        }
        
    }
    else
    {
        
    if(indexPath.row==0)
    {
        
        [self redirectSelectview:@"HomeVC"];

    }
    
    else if(indexPath.row ==1)
    {
        [self redirectSelectview:@"Planner"];

    }
    
   else if(indexPath.row ==2)
   {
      // [self redirectSelectview:@"DashBoardVC"];

   }
    else if (indexPath.row == 3)
    {
        //[self redirectSelectview:@"DashBoardVC"];
    }
    else if (indexPath.row == 4)
    {
        //[self redirectSelectview:@"DashBoardVC"];
    }
    else if (indexPath.row == 5)
    {
        [self redirectSelectview:@"WorkLoadVC"];
    }
    else if (indexPath.row == 6)
    {
        [self redirectSelectview:@"FoodDairyVC"];
    }
    else if (indexPath.row ==7)
    {
        [self redirectSelectview:@"ProfileVC"];

    }
    else if (indexPath.row ==8)
    {
        [self synDataMethod];
    }
    else if (indexPath.row ==9)
    {
        [self redirectSelectview:@"Illness"];
    }
    else if (indexPath.row ==10)
    {
        [self redirectSelectview:@"injury"];
    }
    
    else if(indexPath.row ==11)
    {
        
        UIAlertView *objAlter =[[UIAlertView alloc]initWithTitle:@"" message:@"Do you want to Logout?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [objAlter show];
        
        

    }
    }
   
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == [alertView cancelButtonIndex])
    {
        alertView.hidden=YES;
    }
    else
    {
    
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserCode"];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ClientCode"];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Userreferencecode"];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Username"];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"PhotoPath"];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RoleCode"];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RoleName"];
        
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self redirectSelectview:@"LoginVC"];
    }
}


- (void)tableView:(SKSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    commonview.hidden=NO;
    menuview.hidden=NO;
    if(indexPath.row==2 )
    {
        if( indexPath.subRow==1)
        {
            NSLog(@"Assessment");
            [self redirectSelectview:@"TestAssessmentViewVC"];
        }
        else if(indexPath.subRow==2)
        {
            NSLog(@"questionaire");
            [self redirectSelectview:@"QuestionaryVC"];
        }
        else if(indexPath.subRow==3)
        {
            NSLog(@"singleplayer");
            [self redirectSelectview:@"AssessmentSinglePlayerReportVC"];
        }
        else if(indexPath.subRow==4)
        {
            NSLog(@"multiplayer");
            [self redirectSelectview:@"AssessmentSinglePlayerReportVC"];
        }
        else if( indexPath.subRow==5)
        {
            NSLog(@"Physio ProgramVC");
//            [self redirectSelectview:@"ProgramVC"];
            ExcersizeViewController* VC = [ExcersizeViewController new];
            [appDel.navigationController pushViewController:VC animated:YES];
            
        }
        else if( indexPath.subRow==6)
        {
            NSLog(@"Assignplayer");
            [self redirectSelectview:@"AssignPlayerVC"];
        }

    }
    else if(indexPath.row==3)
    {
        if( indexPath.subRow==1)
        {
            NSLog(@"Assessment");
            [self redirectSelectview:@"TestAssessmentViewVC"];
        }
        else if(indexPath.subRow==2)
        {
            NSLog(@"questionaire");
            [self redirectSelectview:@"QuestionaryVC"];
        }
        else if(indexPath.subRow==3)
        {
            NSLog(@"singleplayer");
            [self redirectSelectview:@"AssessmentSinglePlayerReportVC"];
        }
        else if(indexPath.subRow==4)
        {
            NSLog(@"multiplayer");
            [self redirectSelectview:@"AssessmentSinglePlayerReportVC"];
        }
        else if( indexPath.subRow==5)
        {
            NSLog(@"Strength and Condition ProgramVC");
            [self redirectSelectview:@"ProgramVC"];
        }
        else if( indexPath.subRow==6)
        {
            NSLog(@"Assignplayer");
            [self redirectSelectview:@"AssignPlayerVC"];
        }

    }
    
   else if(indexPath.row==4)
    {
        if( indexPath.subRow==1)
        {
            NSLog(@"Assessment");
            [self redirectSelectview:@"TestAssessmentViewVC"];
        }
        else if(indexPath.subRow==2)
        {
            NSLog(@"questionaire");
            [self redirectSelectview:@"QuestionaryVC"];
        }
        else if(indexPath.subRow==3)
        {
            NSLog(@"singleplayer");
            [self redirectSelectview:@"AssessmentSinglePlayerReportVC"];
        }
        else if(indexPath.subRow==4)
        {
            NSLog(@"multiplayer");
            [self redirectSelectview:@"AssessmentSinglePlayerReportVC"];
        }
        else if( indexPath.subRow==5)
        {
            NSLog(@"Coach ProgramVC");
            [self redirectSelectview:@"ProgramVC"];
        }
        else if( indexPath.subRow==6)
        {
            NSLog(@"Assignplayer");
            [self redirectSelectview:@"AssignPlayerVC"];
        }

    }
    
    
}

-(void)redirectSelectview:(NSString *)selectViewcontroller
{
    if ([selectViewcontroller isEqualToString:@"LoginVC"]) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLogin"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    UIViewController *initViewController = [appDel.storyBoard instantiateViewControllerWithIdentifier:selectViewcontroller];
    [appDel.navigationController pushViewController:initViewController animated:YES];
    
}

#pragma mark - Actions

- (void)collapseSubrows
{
    [tableview collapseCurrentlyExpandedIndexPaths];
}


- (void)undoData
{
    [self reloadTableViewWithData:nil];
    
    //[self setDataManipulationButton:UIBarButtonSystemItemRefresh];
}

- (void)reloadTableViewWithData:(NSArray *)array
{
    self.contents = array;
    
    
    
    [tableview refreshDataWithScrollingToIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    //commonview.hidden=YES;
    //menuview.hidden=YES;
    [self swipeHandlerRight];
    
}
-(void)synDataMethod
{
    [self loadingIcon:loadingView];
    if([COMMON isInternetReachable])
    {
        
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",synData]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        NSString * cliendcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];

        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(cliendcode)   [dic    setObject:cliendcode     forKey:@"Clientcode"];
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                NSLog(@"%@",responseObject);
                
                NSMutableArray * lstAssessment =[[NSMutableArray alloc]init];
                NSMutableArray *  lstSession  =[[NSMutableArray alloc]init];
                NSMutableArray *  lstROM =[[NSMutableArray alloc]init];
                NSMutableArray * lstSpecial =[[NSMutableArray alloc]init];
                NSMutableArray * lstmmt     =[[NSMutableArray alloc]init];
                NSMutableArray * lstGaint  =[[NSMutableArray alloc]init];
                NSMutableArray * lstPosture =[[NSMutableArray alloc]init];
                NSMutableArray * lstsandc   =[[NSMutableArray alloc]init];
                NSMutableArray * lstCoaching =[[NSMutableArray alloc]init];
                NSMutableArray * lstMetaData  =[[NSMutableArray alloc]init];
                NSMutableArray * lstAtheletInfo =[[NSMutableArray alloc]init];
                NSMutableArray * lstAssessmentreg =[[NSMutableArray alloc]init];
                NSMutableArray * lstAtheletememberReg =[[NSMutableArray alloc]init];
                NSMutableArray * lstAtheleteinfoteam =[[NSMutableArray alloc]init];
                NSMutableArray * lstSupportStaffteam =[[NSMutableArray alloc]init];
                NSMutableArray * lstRoledetail =[[NSMutableArray alloc]init];
                NSMutableArray * AssessmentEntry =[[NSMutableArray alloc]init];
                NSMutableArray * lstatheleteinfodetaul =[[NSMutableArray alloc]init];
                NSMutableArray * lstgameattributemetadata =[[NSMutableArray alloc]init];
                NSMutableArray * lstTestcGoal =[[NSMutableArray alloc]init];
                NSMutableArray * LstUserrolemap =[[NSMutableArray alloc]init];
                NSMutableArray * LstUserdetail =[[NSMutableArray alloc]init];
                NSMutableArray * lstTeamListArray = [[NSMutableArray alloc]init];
                NSMutableArray * lstSupportStaff = [[NSMutableArray alloc]init];

                lstAssessment =[responseObject valueForKey:@"LstAssessment"];
                lstSession =[responseObject valueForKey:@"LstSession"];
                lstROM =[responseObject valueForKey:@"LstROM"];
                lstSpecial =[responseObject valueForKey:@"Lstspecial"];
                lstmmt =[responseObject valueForKey:@"LstMmt"];
                lstGaint =[responseObject valueForKey:@"LstGaint"];
                lstPosture =[responseObject valueForKey:@"LstPosture"];
                lstsandc =[responseObject valueForKey:@"LstSandC"];
                lstCoaching =[responseObject valueForKey:@"LstCoaching"];
                lstMetaData =[responseObject valueForKey:@"LstMetadata"];
                lstAtheletInfo =[responseObject valueForKey:@"LstAtheleteinfo"];
                lstAssessmentreg =[responseObject valueForKey:@"LstAssessmentreg"];
                lstAtheletememberReg =[responseObject valueForKey:@"LstAtheletememberrag"];
                lstAtheleteinfoteam =[responseObject valueForKey:@"LstAtheleteinfoteam"];
                lstSupportStaffteam =[responseObject valueForKey:@"LstSupportstaffteams"];
                lstRoledetail =[responseObject valueForKey:@"LstRoledetails"];
                LstUserdetail =[responseObject valueForKey:@"LstUserdetails"];

                LstUserrolemap =[responseObject valueForKey:@"LstUserrolemap"];

                AssessmentEntry =[responseObject valueForKey:@"LstAssessmententry"];
                lstatheleteinfodetaul =[responseObject valueForKey:@"LstAthleteinfodetails"];
                lstgameattributemetadata =[responseObject valueForKey:@"LstGameattributemetadata"];
                lstTestcGoal =[responseObject valueForKey:@"LstTestscgoal"];
                lstTeamListArray = [responseObject valueForKey:@"LstTeam"];
                lstSupportStaff = [responseObject valueForKey:@"LstSupportStaff"];

                
                //NSMutableArray * listAssesmnt =[[NSMutableArray alloc]init];
                
                
                for(int i= 0;i<lstAssessment.count;i++)
                {
                    
                    NSMutableArray *arr1 = [[NSMutableArray alloc]init];
                    arr1 = [lstAssessment objectAtIndex:i];
                    
                    NSString * Clientcode =[arr1 valueForKey:@"Clientcode"];
                    NSString * Modulecode =[arr1 valueForKey:@"Modulecode"];
                    NSString * Assessmentcode =[arr1 valueForKey:@"Assessmentcode"];
                    NSString * Assessmentname =[arr1 valueForKey:@"Assessmentname"];
                    NSString * Recordstatus =[arr1 valueForKey:@"Recordstatus"];
                    NSString * Createdby =[arr1 valueForKey:@"Createdby"];
                    NSString * Createddate =[arr1 valueForKey:@"Createddate"];
                    NSString * Modifiedby =[arr1 valueForKey:@"Modifiedby"];
                    NSString * Modifieddate =[arr1 valueForKey:@"Modifieddate"];
                    
                    
                    NSMutableArray *AssemntValues = [[NSMutableArray alloc] initWithObjects:Clientcode,Modulecode,Assessmentcode,Assessmentname,Recordstatus,Createdby,Createddate,Modifiedby,Modifieddate, nil];
                    
                    
                    DBMANAGERSYNC *Dbm = [[DBMANAGERSYNC alloc]init];
                    
                    Dbm.Assmnt = AssemntValues;
                    [Dbm SELECTASSESSMENT:Assessmentcode];
                }
                
                
                for(int i= 0;i<lstSession.count;i++)
                {
                    
                    NSMutableArray *arr1 = [[NSMutableArray alloc]init];
                    arr1 = [lstSession objectAtIndex:i];
                    
                    NSString * Clientcode =[arr1 valueForKey:@"Clientcode"];
                    NSString * Modulecode =[arr1 valueForKey:@"Modulecode"];
                    NSString * Assessmentcode =[arr1 valueForKey:@"Assessmentcode"];
                    NSString * Testcode =[arr1 valueForKey:@"Testcode"];
                    NSString * Testname =[arr1 valueForKey:@"Testname"];
                    NSString * Recordstatus =[arr1 valueForKey:@"Recordstatus"];
                    NSString * Createdby =[arr1 valueForKey:@"Createdby"];
                    NSString * Createddate =[arr1 valueForKey:@"Createddate"];
                    NSString * Modifiedby =[arr1 valueForKey:@"Modifiedby"];
                    NSString * Modifieddate =[arr1 valueForKey:@"Modifieddate"];
                    
                    
                    NSMutableArray *Values = [[NSMutableArray alloc] initWithObjects:Clientcode,Modulecode,Assessmentcode,Testcode,Testname,Recordstatus,Createdby,Createddate,Modifiedby,Modifieddate, nil];
                    
                    
                    DBMANAGERSYNC *Dbm = [[DBMANAGERSYNC alloc]init];
                    Dbm.AssmntTestMaster = Values;
                    [Dbm SELECTASSESSMENTTESTMASTER:Testcode];
                    
                }
                
                for(int i= 0;i<lstROM.count;i++)
                {
                    
                    NSMutableArray *arr1 = [[NSMutableArray alloc]init];
                    arr1 = [lstROM objectAtIndex:i];
                    
                    NSString * Clientcode =[arr1 valueForKey:@"Clientcode"];
                    NSString * Testcode =[arr1 valueForKey:@"Testcode"];
                    NSString * Joint =[arr1 valueForKey:@"Joint"];
                    NSString * Movement =[arr1 valueForKey:@"Movement"];
                    NSString * Side =[arr1 valueForKey:@"Side"];
                    NSString * Minimumrange =[arr1 valueForKey:@"Minimumrange"];
                    NSString * Maximumrange =[arr1 valueForKey:@"Maximumrange"];
                    NSString * Unit =[arr1 valueForKey:@"Unit"];
                    NSString * Inputtype =[arr1 valueForKey:@"Inputtype"];
                    NSString * Recordstatus =[arr1 valueForKey:@"Recordstatus"];
                    NSString * Createdby =[arr1 valueForKey:@"Createdby"];
                    NSString * Createddate =[arr1 valueForKey:@"Createddate"];
                    NSString * Modifiedby =[arr1 valueForKey:@"Modifiedby"];
                    NSString * Modifieddate =[arr1 valueForKey:@"Modifieddate"];
                    
                    
                    
                    
                    NSMutableArray *Values = [[NSMutableArray alloc] initWithObjects:Clientcode,Testcode,Joint,Movement,Side,Minimumrange,Maximumrange,Unit,Inputtype,Recordstatus,Createdby,Createddate,Modifiedby,Modifieddate, nil];
                    
                    DBMANAGERSYNC *Dbm = [[DBMANAGERSYNC alloc]init];
                    Dbm.RangeOfMotion = Values;
                    [Dbm SELECTRANGEOFMOTION:Testcode];
                    
                }
                
                
                for(int i= 0;i<lstSpecial.count;i++)
                {
                    
                    NSMutableArray *arr1 = [[NSMutableArray alloc]init];
                    arr1 = [lstSpecial objectAtIndex:i];
                    
                    NSString * Clientcode =[arr1 valueForKey:@"Clientcode"];
                    NSString * Testcode =[arr1 valueForKey:@"Testcode"];
                    NSString * Region =[arr1 valueForKey:@"Region"];
                    NSString * Testname =[arr1 valueForKey:@"Testname"];
                    NSString * Side =[arr1 valueForKey:@"Side"];
                    NSString * Result =[arr1 valueForKey:@"Result"];
                    NSString * Recordstatus =[arr1 valueForKey:@"Recordstatus"];
                    NSString * Createdby =[arr1 valueForKey:@"Createdby"];
                    NSString * Createddate =[arr1 valueForKey:@"Createddate"];
                    NSString * Modifiedby =[arr1 valueForKey:@"Modifiedby"];
                    NSString * Modifieddate =[arr1 valueForKey:@"Modifieddate"];
        
                    
                    
                    
                    NSMutableArray *Values = [[NSMutableArray alloc] initWithObjects:Clientcode,Testcode,Region,Testname,Side,Result,Recordstatus,Createdby,Createddate,Modifiedby,Modifieddate, nil];
                    
                    DBMANAGERSYNC *Dbm = [[DBMANAGERSYNC alloc]init];
                    Dbm.TestSplArray = Values;
                    [Dbm TESTSPECIAL:Testcode];
                    
                }
                
                for(int i= 0;i<lstmmt.count;i++)
                {
                    
                    NSMutableArray *arr1 = [[NSMutableArray alloc]init];
                    arr1 = [lstmmt objectAtIndex:i];
                    
                    NSString * Clientcode =[arr1 valueForKey:@"Clientcode"];
                    NSString * Testcode =[arr1 valueForKey:@"Testcode"];
                    NSString * Joint =[arr1 valueForKey:@"Joint"];
                    NSString * Motion =[arr1 valueForKey:@"Motion"];
                    NSString * Muscle =[arr1 valueForKey:@"Muscle"];
                    NSString * Side =[arr1 valueForKey:@"Side"];
                    NSString * Result =[arr1 valueForKey:@"Result"];
                    NSString * Recordstatus =[arr1 valueForKey:@"Recordstatus"];
                    NSString * Createdby =[arr1 valueForKey:@"Createdby"];
                    NSString * Createddate =[arr1 valueForKey:@"Createddate"];
                    NSString * Modifiedby =[arr1 valueForKey:@"Modifiedby"];
                    NSString * Modifieddate =[arr1 valueForKey:@"Modifieddate"];
                    
                    
                    
                    
                    
                    
                    NSMutableArray *Values = [[NSMutableArray alloc] initWithObjects:Clientcode,Testcode,Joint,Motion,Muscle,Side,Result,Recordstatus,Createdby,Createddate,Modifiedby,Modifieddate, nil];
                    
                    DBMANAGERSYNC *Dbm = [[DBMANAGERSYNC alloc]init];
                    Dbm.Testmmt = Values;
                    [Dbm TESTmmt:Testcode];
                    
                }
                
                for(int i= 0;i<lstGaint.count;i++)
                {
                    
                    NSMutableArray *arr1 = [[NSMutableArray alloc]init];
                    arr1 = [lstGaint objectAtIndex:i];
                    
                    NSString * Clientcode =[arr1 valueForKey:@"Clientcode"];
                    NSString * Testcode =[arr1 valueForKey:@"Testcode"];
                    NSString * Plane =[arr1 valueForKey:@"Plane"];
                    NSString * Testname =[arr1 valueForKey:@"Testname"];
                    NSString * Side =[arr1 valueForKey:@"Side"];
                    NSString * Units =[arr1 valueForKey:@"Units"];
                    NSString * Result =[arr1 valueForKey:@"Result"];
                    NSString * Recordstatus =[arr1 valueForKey:@"Recordstatus"];
                    NSString * Createdby =[arr1 valueForKey:@"Createdby"];
                    NSString * Createddate =[arr1 valueForKey:@"Createddate"];
                    NSString * Modifiedby =[arr1 valueForKey:@"Modifiedby"];
                    NSString * Modifieddate =[arr1 valueForKey:@"Modifieddate"];
                    
                    
                    
                    
                    NSMutableArray *Values = [[NSMutableArray alloc] initWithObjects:Clientcode,Testcode,Plane,Testname,Side,Units,Result,Recordstatus,Createdby,Createddate,Modifiedby,Modifieddate, nil];
                    
                    DBMANAGERSYNC *Dbm = [[DBMANAGERSYNC alloc]init];
                    Dbm.TestgaintArray = Values;
                    [Dbm SELECTTESTGAINT:Testcode];
                    
                }
                
                
                for(int i= 0;i<lstPosture.count;i++)
                {
                    
                    NSMutableArray *arr1 = [[NSMutableArray alloc]init];
                    arr1 = [lstPosture objectAtIndex:i];
                    
                    NSString * Clientcode =[arr1 valueForKey:@"Clientcode"];
                    NSString * Testcode =[arr1 valueForKey:@"Testcode"];
                    NSString * View =[arr1 valueForKey:@"View"];
                    NSString * Region =[arr1 valueForKey:@"Region"];
                    NSString * Side =[arr1 valueForKey:@"Side"];
                    NSString * Units =[arr1 valueForKey:@"Units"];
                    NSString * Result =[arr1 valueForKey:@"Result"];
                    NSString * Recordstatus =[arr1 valueForKey:@"Recordstatus"];
                    NSString * Createdby =[arr1 valueForKey:@"Createdby"];
                    NSString * Createddate =[arr1 valueForKey:@"Createddate"];
                    NSString * Modifiedby =[arr1 valueForKey:@"Modifiedby"];
                    NSString * Modifieddate =[arr1 valueForKey:@"Modifieddate"];
       
                    
                    NSMutableArray *Values = [[NSMutableArray alloc] initWithObjects:Clientcode,Testcode,View,Region,Side,Units,Result,Recordstatus,Createdby,Createddate,Modifiedby,Modifieddate, nil];
                    
                    DBMANAGERSYNC *Dbm = [[DBMANAGERSYNC alloc]init];
                    Dbm.TestpostureArray = Values;
                    [Dbm SELECTTESTPosture:Testcode];
                    
                }
                
                for(int i= 0;i<lstsandc.count;i++)
                {
                    
                    NSMutableArray *arr1 = [[NSMutableArray alloc]init];
                    arr1 = [lstsandc objectAtIndex:i];
                    
                    NSString * Clientcode =[arr1 valueForKey:@"Clientcode"];
                    NSString * Testcode =[arr1 valueForKey:@"Testcode"];
                    NSString * Component =[arr1 valueForKey:@"Component"];
                    NSString * Testname =[arr1 valueForKey:@"Testname"];
                    NSString * Side =[arr1 valueForKey:@"Side"];
                    NSString * Nooftrials =[arr1 valueForKey:@"Nooftrials"];
                    NSString * Units =[arr1 valueForKey:@"Units"];
                    NSString * Scoreevaluation =[arr1 valueForKey:@"Scoreevaluation"];
                    NSString * Recordstatus =[arr1 valueForKey:@"Recordstatus"];
                    NSString * Createdby =[arr1 valueForKey:@"Createdby"];
                    NSString * Createddate =[arr1 valueForKey:@"Createddate"];
                    NSString * Modifiedby =[arr1 valueForKey:@"Modifiedby"];
                    NSString * Modifieddate =[arr1 valueForKey:@"Modifieddate"];
                    
                    
                    
                    NSMutableArray *Values = [[NSMutableArray alloc] initWithObjects:Clientcode,Testcode,Component,Testname,Side,Nooftrials,Units,Scoreevaluation,Recordstatus,Createdby,Createddate,Modifiedby,Modifieddate, nil];
                    
                    DBMANAGERSYNC *Dbm = [[DBMANAGERSYNC alloc]init];
                    Dbm.TestSCArray = Values;
                    [Dbm SELECTTESTSC:Testcode];
                    
                }

                
                
                for(int i= 0;i<lstCoaching.count;i++)
                {
                    
                    NSMutableArray *arr1 = [[NSMutableArray alloc]init];
                    arr1 = [lstCoaching objectAtIndex:i];
                    
                    NSString * Clientcode =[arr1 valueForKey:@"Clientcode"];
                    NSString * Testcode =[arr1 valueForKey:@"Testcode"];
                    NSString * Kpi =[arr1 valueForKey:@"Kpi"];
                    NSString * Description =[arr1 valueForKey:@"Description"];
                    NSString * Recordstatus =[arr1 valueForKey:@"Recordstatus"];
                    NSString * Createdby =[arr1 valueForKey:@"Createdby"];
                    NSString * Createddate =[arr1 valueForKey:@"Createddate"];
                    NSString * Modifiedby =[arr1 valueForKey:@"Modifiedby"];
                    NSString * Modifieddate =[arr1 valueForKey:@"Modifieddate"];
                    
    
                    NSMutableArray *Values = [[NSMutableArray alloc] initWithObjects:Clientcode,Testcode,Kpi,Description,Recordstatus,Createdby,Createddate,Modifiedby,Modifieddate, nil];
                    
                    DBMANAGERSYNC *Dbm = [[DBMANAGERSYNC alloc]init];
                    Dbm.TestCoachArray = Values;
                    [Dbm SELECTTESTCoaching:Testcode];
                    
                }
                
                
                for(int i= 0;i<lstMetaData.count;i++)
                {
                    
                    NSMutableArray *arr1 = [[NSMutableArray alloc]init];
                    arr1 = [lstMetaData objectAtIndex:i];
                    
                    NSString * Metasubcode =[arr1 valueForKey:@"Metasubcode"];
                    NSString * Metadatatypecode =[arr1 valueForKey:@"Metadatatypecode"];
                    NSString * Metadatatypedescription =[arr1 valueForKey:@"Metadatatypedescription"];
                    NSString * Metasubcodedescription =[arr1 valueForKey:@"Metasubcodedescription"];
                    NSString * Metasubcodevalue =[arr1 valueForKey:@"Metasubcodevalue"];
                   
                    
                    NSMutableArray *Values = [[NSMutableArray alloc] initWithObjects:Metasubcode,Metadatatypecode,Metadatatypedescription,Metasubcodedescription,Metasubcodevalue, nil];
                    
                    DBMANAGERSYNC *Dbm = [[DBMANAGERSYNC alloc]init];
                    Dbm.metadataArray = Values;
                    [Dbm SELECTmetadata:Metasubcode];
                    
                }
                
                for(int i= 0;i<lstAtheletInfo.count;i++)
                {
                    
                    NSMutableArray *arr1 = [[NSMutableArray alloc]init];
                    arr1 = [lstAtheletInfo objectAtIndex:i];
                    
                    NSString * Clientcode =[arr1 valueForKey:@"Clientcode"];
                    NSString * Athletecode =[arr1 valueForKey:@"Athletecode"];
                    NSString * Height =[arr1 valueForKey:@"Height"];
                    NSString * Weight =[arr1 valueForKey:@"Weight"];
                    NSString * Allergies =[arr1 valueForKey:@"Allergies"];
                    NSString * Orthotics =[arr1 valueForKey:@"Orthotics"];
                    NSString * Recordstatus =[arr1 valueForKey:@"Recordstatus"];
                    NSString * Createdby =[arr1 valueForKey:@"Createdby"];
                    NSString * Createddate =[arr1 valueForKey:@"Createddate"];
                    NSString * Modifiedby =[arr1 valueForKey:@"Modifiedby"];
                    NSString * Modifieddate =[arr1 valueForKey:@"Modifieddate"];
                    
                
                    
                    NSMutableArray *Values = [[NSMutableArray alloc] initWithObjects:Clientcode,Athletecode,Height,Weight,Allergies,Orthotics,Recordstatus,Createdby,Createddate,Modifiedby,Modifieddate, nil];
                    
                    DBMANAGERSYNC *Dbm = [[DBMANAGERSYNC alloc]init];
                    Dbm.SportsInfoArray = Values;
                    [Dbm SELECTSportsInfo:Athletecode];
                    
                }
                
                for(int i= 0;i<lstAssessmentreg.count;i++)
                {
                    
                    NSMutableArray *arr1 = [[NSMutableArray alloc]init];
                    arr1 = [lstAssessmentreg objectAtIndex:i];
                    
                    NSString * Clientcode =[arr1 valueForKey:@"Clientcode"];
                    NSString * Assessmentregistercode =[arr1 valueForKey:@"Assessmentregistercode"];
                    NSString * Modulecode =[arr1 valueForKey:@"Modulecode"];
                    NSString * Assessmentcode =[arr1 valueForKey:@"Assessmentcode"];
                    NSString * Assessmenttesttypescreencode =[arr1 valueForKey:@"Assessmenttesttypescreencode"];
                    NSString * Assessmenttestcode =[arr1 valueForKey:@"Assessmenttestcode"];
                    NSString * Assessmenttesttypecode =[arr1 valueForKey:@"Assessmenttesttypecode"];
                    NSString * Version =[arr1 valueForKey:@"Version"];
                    NSString * Recordstatus =[arr1 valueForKey:@"Recordstatus"];
                    NSString * Createdby =[arr1 valueForKey:@"Createdby"];
                    NSString * Createddate =[arr1 valueForKey:@"Createddate"];
                    NSString * Modifiedby =[arr1 valueForKey:@"Modifiedby"];
                    NSString * Modifieddate =[arr1 valueForKey:@"Modifieddate"];
                    
                    
                    
                    
                     NSMutableArray *Values = [[NSMutableArray alloc] initWithObjects:Clientcode,Assessmentregistercode,Modulecode,Assessmentcode,Assessmenttesttypescreencode,Assessmenttestcode,Assessmenttesttypecode,Version,Recordstatus,Createdby,Createddate,Modifiedby,Modifieddate, nil];
                    
                    DBMANAGERSYNC *Dbm = [[DBMANAGERSYNC alloc]init];
                    Dbm.AssessmentRegisterArray = Values;
                    [Dbm SELECTAssementRegister:Assessmentregistercode];
                    
                }
                
                
                for(int i= 0;i<lstAtheletememberReg.count;i++)
                {
                    
                    NSMutableArray *arr1 = [[NSMutableArray alloc]init];
                    arr1 = [lstAtheletememberReg objectAtIndex:i];
                    
        
                    NSString * Associationmemberid =[arr1 valueForKey:@"Associationmemberid"];
                    
                    //NSMutableArray *Values = [[NSMutableArray alloc] initWithObjects:Clientcode,Assessmentregistercode,Modulecode,Assessmentcode,Assessmenttesttypescreencode,Assessmenttestcode,Assessmenttesttypecode,Version,Recordstatus,Createdby,Createddate,Modifiedby,Modifieddate, nil];
                    
                    DBMANAGERSYNC *Dbm = [[DBMANAGERSYNC alloc]init];
                    Dbm.AtheleteMemRegArray = arr1;
                    [Dbm SELECTAtheleteMemReg:Associationmemberid];
                    
                }



                for(int i= 0;i<lstAtheleteinfoteam.count;i++)
                {
                    
                    NSMutableArray *arr1 = [[NSMutableArray alloc]init];
                    arr1 = [lstAtheleteinfoteam objectAtIndex:i];
                    
                    NSString * Clientcode =[arr1 valueForKey:@"Clientcode"];
                    NSString * Athletecode =[arr1 valueForKey:@"Athletecode"];
                    NSString * Teamcode =[arr1 valueForKey:@"Teamcode"];
                    NSString * Recordstatus =[arr1 valueForKey:@"Recordstatus"];
                    NSString * Createdby =[arr1 valueForKey:@"Createdby"];
                    NSString * Createddate =[arr1 valueForKey:@"Createddate"];
                    NSString * Modifiedby =[arr1 valueForKey:@"Modifiedby"];
                    NSString * Modifieddate =[arr1 valueForKey:@"Modifieddate"];
                    
                    
                    
                    
                    
                    NSMutableArray *Values = [[NSMutableArray alloc] initWithObjects:Clientcode,Athletecode,Teamcode,Recordstatus,Createdby,Createddate,Modifiedby,Modifieddate, nil];
                    
                    DBMANAGERSYNC *Dbm = [[DBMANAGERSYNC alloc]init];
                    Dbm.AtheleteInfoTeamArray = Values;
                    [Dbm SELECTAtheleteInfoTeam:Athletecode];
                    
                }
                
                
                for(int i= 0;i<lstSupportStaffteam.count;i++)
                {
                    
                    NSMutableArray *arr1 = [[NSMutableArray alloc]init];
                    arr1 = [lstSupportStaffteam objectAtIndex:i];
                    
                    NSString * Clientcode =[arr1 valueForKey:@"Clientcode"];
                    NSString * Code =[arr1 valueForKey:@"Code"];
                    NSString * Teamcode =[arr1 valueForKey:@"Teamcode"];
                    NSString * Recordstatus =[arr1 valueForKey:@"Recordstatus"];
                    NSString * Createdby =[arr1 valueForKey:@"Createdby"];
                    NSString * Createddate =[arr1 valueForKey:@"Createddate"];
                    NSString * Modifiedby =[arr1 valueForKey:@"Modifiedby"];
                    NSString * Modifieddate =[arr1 valueForKey:@"Modifieddate"];
                    
                    
                    
                    
                    NSMutableArray *Values = [[NSMutableArray alloc] initWithObjects:Clientcode,Code,Teamcode,Recordstatus,Createdby,Createddate,Modifiedby,Modifieddate, nil];
                    DBMANAGERSYNC *Dbm = [[DBMANAGERSYNC alloc]init];
                    Dbm.SupportStaffInfoArray = Values;
                    [Dbm SELECTSupportStaffInfo:Code:Teamcode];
                    
                }
                
                for(int i= 0;i<lstRoledetail.count;i++)
                {
                    
                    NSMutableArray *arr1 = [[NSMutableArray alloc]init];
                    arr1 = [lstRoledetail objectAtIndex:i];
                    
                    NSString * Clientcode =[arr1 valueForKey:@"Clientcode"];
                    NSString * Rolecode =[arr1 valueForKey:@"Rolecode"];
                    NSString * Role =[arr1 valueForKey:@"Role"];
                    NSString * Ischecked =[arr1 valueForKey:@"Ischecked"];
                    NSString * Recordstatus =[arr1 valueForKey:@"Recordstatus"];
                    NSString * Createdby =[arr1 valueForKey:@"Createdby"];
                    NSString * Createddate =[arr1 valueForKey:@"Createddate"];
                    NSString * Modifiedby =[arr1 valueForKey:@"Modifiedby"];
                    NSString * Modifieddate =[arr1 valueForKey:@"Modifieddate"];
                    
                    
    
                    
                    
                    NSMutableArray *Values = [[NSMutableArray alloc] initWithObjects:Clientcode,Rolecode,Role,Ischecked,Recordstatus,Createdby,Createddate,Modifiedby,Modifieddate, nil];
                    DBMANAGERSYNC *Dbm = [[DBMANAGERSYNC alloc]init];
                    Dbm.RoleDetailsArray = Values;
                    [Dbm SELECTRoleDetails:Rolecode];
                    
                }
                
                
                for(int i= 0;i<LstUserdetail.count;i++)
                {
                    
                    NSMutableArray *arr1 = [[NSMutableArray alloc]init];
                    arr1 = [LstUserdetail objectAtIndex:i];
                    
                    
                    NSString * Usercode =[arr1 valueForKey:@"Usercode"];
                    
                    //NSMutableArray *Values = [[NSMutableArray alloc] initWithObjects:Clientcode,Assessmentregistercode,Modulecode,Assessmentcode,Assessmenttesttypescreencode,Assessmenttestcode,Assessmenttesttypecode,Version,Recordstatus,Createdby,Createddate,Modifiedby,Modifieddate, nil];
                    
                    DBMANAGERSYNC *Dbm = [[DBMANAGERSYNC alloc]init];
                    Dbm.UserDetailsArray = arr1;
                    [Dbm SELECTUserDetails:Usercode];
                    
                }
                
                for(int i= 0;i<LstUserrolemap.count;i++)
                {
                    
                    NSMutableArray *arr1 = [[NSMutableArray alloc]init];
                    arr1 = [LstUserrolemap objectAtIndex:i];
                    
                    NSString * Clientcode =[arr1 valueForKey:@"Clientcode"];
                    NSString * Usercode =[arr1 valueForKey:@"Usercode"];
                    NSString * Rolecode =[arr1 valueForKey:@"Rolecode"];
                    NSString * Isdefaultrole =[arr1 valueForKey:@"Isdefaultrole"];
                    NSString * Recordstatus =[arr1 valueForKey:@"Recordstatus"];
                    NSString * Createdby =[arr1 valueForKey:@"Createdby"];
                    NSString * Createddate =[arr1 valueForKey:@"Createddate"];
                    NSString * Modifiedby =[arr1 valueForKey:@"Modifiedby"];
                    NSString * Modifieddate =[arr1 valueForKey:@"Modifieddate"];
                    
                    
                    
                    
                    NSMutableArray *Values = [[NSMutableArray alloc] initWithObjects:Clientcode,Usercode,Rolecode,Isdefaultrole,Recordstatus,Createdby,Createddate,Modifiedby,Modifieddate, nil];
                    DBMANAGERSYNC *Dbm = [[DBMANAGERSYNC alloc]init];
                    Dbm.UserRolemapArray = Values;
                    [Dbm SELECTUserRoleMap:Usercode:Rolecode];
                    
                }
                
                
                DBMANAGERSYNC *Dbm = [[DBMANAGERSYNC alloc]init];
                [Dbm DleteAthleteinfodetails];
                
                for(int i= 0;i<lstatheleteinfodetaul.count;i++)
                {
                    
                    
                    
                    NSMutableArray *arr1 = [[NSMutableArray alloc]init];
                    arr1 = [lstatheleteinfodetaul objectAtIndex:i];
                    
                    NSString * Clientcode =[arr1 valueForKey:@"Clientcode"];
                    NSString * Athletecode =[arr1 valueForKey:@"Athletecode"];
                    NSString * Gamecode =[arr1 valueForKey:@"Gamecode"];
                    NSString * Teamcode =[arr1 valueForKey:@"Teamcode"];
                    NSString * Attributevaluecode =[arr1 valueForKey:@"Attributevaluecode"];
                    NSString * Attributevaluedescription =[arr1 valueForKey:@"Attributevaluedescription"];
                    NSString * Inputtype =[arr1 valueForKey:@"Inputtype"];
                    NSString * Recordstatus =[arr1 valueForKey:@"Recordstatus"];
                    NSString * Createdby =[arr1 valueForKey:@"Createdby"];
                    NSString * Createddate =[arr1 valueForKey:@"Createddate"];
                    NSString * Modifiedby =[arr1 valueForKey:@"Modifiedby"];
                    NSString * Modifieddate =[arr1 valueForKey:@"Modifieddate"];
                    
        
                    
                    
                    [Dbm InsertAthleteinfodetails: Clientcode: Athletecode: Gamecode: Teamcode: Attributevaluecode: Attributevaluedescription: Inputtype: Recordstatus: Createdby: Createddate: Modifiedby: Modifieddate];
                    
                }
                
                
                
                
                [Dbm DletegameAttribute];
                for(int i= 0;i<lstgameattributemetadata.count;i++)
                {
                    
                    NSMutableArray *arr1 = [[NSMutableArray alloc]init];
                    arr1 = [lstgameattributemetadata objectAtIndex:i];
                    
                    NSString * Attributevaluecode =[arr1 valueForKey:@"Attributevaluecode"];
                    NSString * Attributevaluedescription =[arr1 valueForKey:@"Attributevaluedescription"];
                    NSString * Gametype =[arr1 valueForKey:@"Gametype"];
                    NSString * Attributecode =[arr1 valueForKey:@"Attributecode"];
                    NSString * Attributedescription =[arr1 valueForKey:@"Attributedescription"];
                    NSString * Inputtype =[arr1 valueForKey:@"Inputtype"];
                
                    
                    
                    [Dbm InsertgameAttribute: Attributevaluecode: Attributevaluedescription: Gametype: Attributecode: Attributedescription: Inputtype];
                    
                }
                
                
                
                [Dbm DleteTestGoal];
                
                for(int i= 0;i<lstTestcGoal.count;i++)
                {
                    
                    NSMutableArray *arr1 = [[NSMutableArray alloc]init];
                    arr1 = [lstTestcGoal objectAtIndex:i];
                    
                    NSString * Clientcode =[arr1 valueForKey:@"Clientcode"];
                    NSString * Testcode =[arr1 valueForKey:@"Testcode"];
                    NSString * Min =[arr1 valueForKey:@"Min"];
                    NSString * Max =[arr1 valueForKey:@"Max"];
                    NSString * Recordstatus =[arr1 valueForKey:@"Recordstatus"];
                    NSString * Createdby =[arr1 valueForKey:@"Createdby"];
                    NSString * Createddate =[arr1 valueForKey:@"Createddate"];
                    NSString * Modifiedby =[arr1 valueForKey:@"Modifiedby"];
                    NSString * Modifieddate =[arr1 valueForKey:@"Modifieddate"];
                    
                    [Dbm InsertTestGoal: Clientcode: Testcode: Min: Max: Recordstatus: Createdby:Createddate:Modifiedby:Modifieddate];
                    
                }

                for(int i= 0;i<lstTeamListArray.count;i++)
                {
                    
                    NSMutableArray *arr1 = [[NSMutableArray alloc]init];
                    arr1 = [lstTeamListArray objectAtIndex:i];
                    
                    NSString * Clientcode =[arr1 valueForKey:@"ClientCode"];
                    NSString * Teamcode =[arr1 valueForKey:@"TeamCode"];
                    NSString * TeamName =[arr1 valueForKey:@"TeamName"];
                    NSString * TeamShortName =[arr1 valueForKey:@"TeamShortName"];
                    NSString * Game =[arr1 valueForKey:@"Game"];
                    NSString * RecordStatus =[arr1 valueForKey:@"RecordStatus"];
                    NSString * CreatedBy =[arr1 valueForKey:@"CreatedBy"];
                    NSString * CreatedDate =[arr1 valueForKey:@"CreatedDate"];
                    
                    NSMutableArray *Values = [[NSMutableArray alloc] initWithObjects:Clientcode,Teamcode,TeamName,TeamShortName,Game,RecordStatus,CreatedBy,CreatedDate, nil];
                    
                    DBMANAGERSYNC *Dbm = [[DBMANAGERSYNC alloc]init];
                    Dbm.TeamListDetailArray = Values;
                    [Dbm SELECTTEAM:Teamcode];
                    
                }

                for(int i= 0;i<lstSupportStaff.count;i++)
                {
                    
                    NSMutableArray *arr1 = [[NSMutableArray alloc]init];
                    arr1 = [lstSupportStaff objectAtIndex:i];
                    
                    NSString * Clientcode =[arr1 valueForKey:@"Clientcode"];
                    NSString * Membercode =[arr1 valueForKey:@"MemberCode"];
                    NSString * StaffType =[arr1 valueForKey:@"StaffType"];
                    NSString * level =[arr1 valueForKey:@"Levels"];
                    NSString * recordStatus =[arr1 valueForKey:@"Recordstatus"];
                    NSString * CreateBy =[arr1 valueForKey:@"Createdby"];
                    NSString * CreatedDate =[arr1 valueForKey:@"Createddate"];
                    NSString * ModifiedBy =[arr1 valueForKey:@"Modifiedby"];
                    NSString * ModifiedDate =[arr1 valueForKey:@"Modifieddate"];
                    
                    NSMutableArray *Values = [[NSMutableArray alloc] initWithObjects:Clientcode,Membercode,StaffType,level,recordStatus,CreateBy,CreatedDate,ModifiedBy,ModifiedDate, nil];
                    
                    DBMANAGERSYNC *Dbm = [[DBMANAGERSYNC alloc]init];
                    Dbm.SupportStaffArray = Values;
                    [Dbm SELECTSupportStaff:Membercode];
                    
                }

                

            }
            
            [COMMON RemoveLoadingIcon];
            [loadingView setUserInteractionEnabled:YES];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed");
            [COMMON webServiceFailureError];
            [loadingView setUserInteractionEnabled:YES];
            
        }];
    }

}



@end
