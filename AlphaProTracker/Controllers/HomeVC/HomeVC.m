//
//  HomeVC.m
//  AlphaProTracker
//
//  Created by Lexicon on 23/08/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "HomeVC.h"
#import "CustomNavigation.h"
#import "Config.h"
#import "HomeVCCell.h"
#import "DashBoardVC.h"
#import "AppCommon.h"
#import "PlannerVC.h"
#import "FoodDairyVC.h"
#import "WorkLoadVC.h"
#import "ProfileVC.h"
#import "PlayerVC.h"

#import "FFEvent.h"
#import "FFCalendar.h"



@interface HomeVC ()
{
    NSArray *imageArray;
    NSArray *titleArray;
    
    NSString *usercode;
    NSString *SelectUserCode;
    NSString *Playercode;
    NSString *playername;
    NSString *playerimage;
    
    NSString *CoachModuleCode;
    NSString *PhysioModuleCode;
    NSString *SandCModuleCode;
    
    
    NSString *ScreenPhysio;
    NSString *ScreenSandC;
    NSString *ScreenCoach;
    
}


@end


@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view_border.layer.borderWidth = 1;
    //self.view_border.layer.borderColor = [UIColor colorWithRed:(0/255.0f) green:(0/255.0f) blue:(0/255.0f) alpha:0.9f].CGColor;
    //
    usercode = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
    SelectUserCode = @"USM0000002";
    Playercode = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
    playername = [[NSUserDefaults standardUserDefaults]stringForKey:@"Username"];
    playerimage = [[NSUserDefaults standardUserDefaults]stringForKey:@"PhotoPath"];
    
    
    CoachModuleCode = @"MSC084";
    PhysioModuleCode = @"MSC085";
    SandCModuleCode = @"MSC086";
    
    ScreenCoach =@"Coach";
    ScreenPhysio =@"Physio";
    ScreenSandC =@"S and C";
    
    NSString *rolecode = [[NSUserDefaults standardUserDefaults]stringForKey:@"RoleCode"];

    NSString *plyRolecode = @"ROL0000002";

    if(![rolecode isEqualToString: plyRolecode])
    {
    imageArray =[NSArray arrayWithObjects:@"ico_user_large",@"icon_planner",@"ico_food_diary",@"icon_workload",@"icon_physio",@"icon_s&m",@"icon_coaching", nil];
    
    titleArray =[[NSArray alloc]init];
    titleArray = @[@"Profile",@"Planner",@"Food Diary",@"WLM",@"Physio",@"S and C",@"Coach"];
    }
    else
    {
        imageArray =[NSArray arrayWithObjects:@"ico_user_large",@"icon_planner",@"ico_food_diary",@"icon_workload", nil];
        
        titleArray =[[NSArray alloc]init];
        titleArray = @[@"Profile",@"Planner",@"Food Diary",@"WLM"];
    }

   
    [self customnavigationmethod];
}
-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    

        objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"Home";
    objCustomNavigation.btn_back.hidden =YES;
    objCustomNavigation.menu_btn.hidden = NO;
    [objCustomNavigation.menu_btn addTarget:self action:@selector(MenuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [COMMON AddMenuView:self.view];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return imageArray.count;
}
#pragma mar - UICollectionViewFlowDelegateLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(IS_IPHONE_DEVICE)
    {
        if(!IS_IPHONE5)
        {
          return CGSizeMake(110, 110);
        }
        else
        {
            return CGSizeMake(90, 100);
        }
    }
    else
    {
        return CGSizeMake(160, 140);
    }
}
#pragma mark collection view cell paddings
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if(!IS_IPHONE_DEVICE)
    {
    return UIEdgeInsetsMake(20, 20, 30, 20); // top, left, bottom, right
      }
    else{
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if(!IS_IPHONE_DEVICE)
    {
    return 20.0;
    }
    else{
        return 5.0;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if(!IS_IPHONE_DEVICE)
    {
        return 23.0;
    }
    else{
        return 10.0;
    }
}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(10, 10, 10, 10);
//}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    HomeVCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    
    
   cell.photos.image =[UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];
    
    
    cell.photos_title_lbl.text = titleArray[indexPath.row];
    
    cell.backgroundColor= [UIColor colorWithRed:(0/255.0f) green:(0/255.0f) blue:(0/255.0f) alpha:0.27f];
    
    //cell.cellinView.backgroundColor = [UIColor colorWithRed:(0/255.0f) green:(0/255.0f) blue:(0/255.0f) alpha:0.27f];
    
    cell.layer.borderWidth=0.5f;
    cell.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
        return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //HomeVCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    
    //cell.backgroundColor=[UIColor whiteColor];   //[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1.0f];
    
    //cell.backgroundColor = [UIColor yellowColor];
    NSString *rolecode = [[NSUserDefaults standardUserDefaults]stringForKey:@"RoleCode"];
    
    NSString *plyRolecode = @"ROL0000002";
    
    if(![rolecode isEqualToString: plyRolecode])
    {
    
    if(indexPath.row == 0)
    {
        ProfileVC  * objProfile=[[ProfileVC alloc]init];
        objProfile = (ProfileVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileVC"];
        objProfile.check = @"main";
        [self.navigationController pushViewController:objProfile animated:YES];
    }
    if(indexPath.row == 1)
    {
        PlannerVC  * objPlanner=[[PlannerVC alloc]init];
        objPlanner = (PlannerVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"Planner"];
         objPlanner.check = @"main";
        [self.navigationController pushViewController:objPlanner animated:YES];

        
    }
    if(indexPath.row == 2)
    {
        FoodDairyVC  * objTabVC=[[FoodDairyVC alloc]init];
        objTabVC = (FoodDairyVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"FoodDairyVC"];
        objTabVC.check = @"main";
        [self.navigationController pushViewController:objTabVC animated:YES];
    }
    if(indexPath.row == 3)
    {
        WorkLoadVC  * objTabVC=[[WorkLoadVC alloc]init];
        objTabVC = (WorkLoadVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"WorkLoadVC"];
        objTabVC.check = @"main";
        [self.navigationController pushViewController:objTabVC animated:YES];
    }
    if(indexPath.row == 4)
    {
            
            DashBoardVC  * objTabVC=[[DashBoardVC alloc]init];
            objTabVC = (DashBoardVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"DashBoardVC"];
            objTabVC.selectedModule = PhysioModuleCode;
            objTabVC.ScreenName = ScreenPhysio;
            [self.navigationController pushViewController:objTabVC animated:YES];
    }
    if(indexPath.row == 5)
    {
            DashBoardVC  * objTabVC=[[DashBoardVC alloc]init];
            objTabVC = (DashBoardVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"DashBoardVC"];
            objTabVC.selectedModule = SandCModuleCode;
            objTabVC.ScreenName = ScreenSandC;
            [self.navigationController pushViewController:objTabVC animated:YES];
    }
    if(indexPath.row == 6)
    {
            DashBoardVC  * objTabVC=[[DashBoardVC alloc]init];
            objTabVC = (DashBoardVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"DashBoardVC"];
            objTabVC.selectedModule = CoachModuleCode;
            objTabVC.ScreenName = ScreenCoach;
            [self.navigationController pushViewController:objTabVC animated:YES];
     }
    }
    else
    {
        if(indexPath.row == 0)
        {
            PlayerVC  * objPlayer=[[PlayerVC alloc]init];
            objPlayer = (PlayerVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"PlayerVC"];
            [self.navigationController pushViewController:objPlayer animated:YES];
            objPlayer.selectPlayercode = Playercode;
            objPlayer.selectPlayer = playername;
            objPlayer.selectPlayerimg = playerimage;
            
        }
        if(indexPath.row == 1)
        {
            PlannerVC  * objPlanner=[[PlannerVC alloc]init];
            objPlanner = (PlannerVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"Planner"];
            [objPlanner setArrayWithEvents:[self arrayWithEvents]];
            [self.navigationController pushViewController:objPlanner animated:YES];
            
            
        }
        if(indexPath.row == 2)
        {
            FoodDairyVC  * objTabVC=[[FoodDairyVC alloc]init];
            objTabVC = (FoodDairyVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"FoodDairyVC"];
            [self.navigationController pushViewController:objTabVC animated:YES];
        }
        if(indexPath.row == 3)
        {
            WorkLoadVC  * objTabVC=[[WorkLoadVC alloc]init];
            objTabVC = (WorkLoadVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"WorkLoadVC"];
            objTabVC.Playcode = Playercode;
            [self.navigationController pushViewController:objTabVC animated:YES];        }

    }
    
    
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeVCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    //cell.backgroundColor = [UIColor whiteColor];
    
    if (cell.selected)
    {
        cell.backgroundColor = [UIColor redColor]; // highlight selection
    }
    else
    {
        cell.backgroundColor = [UIColor grayColor]; // Default color
    }

    
}

-(IBAction)MenuBtnAction:(id)sender
{
   [COMMON ShowsideMenuView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSMutableArray *)arrayWithEvents {
    
    FFEvent *event1 = [FFEvent new];
    [event1 setStringCustomerName: @"Customer A"];
    [event1 setNumCustomerID:@1];
    [event1 setDateDay:[NSDate dateWithYear:[NSDate componentsOfCurrentDate].year month:[NSDate componentsOfCurrentDate].month day:[NSDate componentsOfCurrentDate].day]];
    [event1 setDateTimeBegin:[NSDate dateWithHour:10 min:00]];
    [event1 setDateTimeEnd:[NSDate dateWithHour:15 min:13]];
    [event1 setArrayWithGuests:[NSMutableArray arrayWithArray:@[@[@111, @"Guest 2", @"email2@email.com"], @[@111, @"Guest 4", @"email4@email.com"], @[@111, @"Guest 5", @"email5@email.com"], @[@111, @"Guest 7", @"email7@email.com"]]]];
    
    FFEvent *event2 = [FFEvent new];
    [event2 setStringCustomerName: @"Customer B"];
    [event2 setNumCustomerID:@2];
    [event2 setDateDay:[NSDate dateWithYear:[NSDate componentsOfCurrentDate].year month:[NSDate componentsOfCurrentDate].month day:[NSDate componentsOfCurrentDate].day]];
    [event2 setDateTimeBegin:[NSDate dateWithHour:9 min:15]];
    [event2 setDateTimeEnd:[NSDate dateWithHour:12 min:138]];
    [event2 setArrayWithGuests:[NSMutableArray arrayWithArray:@[@[@111, @"Guest 2", @"email2@email.com"], @[@111, @"Guest 4", @"email4@email.com"], @[@111, @"Guest 5", @"email5@email.com"], @[@111, @"Guest 7", @"email7@email.com"]]]];
    
    FFEvent *event3 = [FFEvent new];
    [event3 setStringCustomerName: @"Customer C"];
    [event3 setNumCustomerID:@3];
    [event3 setDateDay:[NSDate dateWithYear:[NSDate componentsOfCurrentDate].year month:[NSDate componentsOfCurrentDate].month day:[NSDate componentsOfCurrentDate].day]];
    [event3 setDateTimeBegin:[NSDate dateWithHour:16 min:00]];
    [event3 setDateTimeEnd:[NSDate dateWithHour:17 min:13]];
    [event3 setArrayWithGuests:[NSMutableArray arrayWithArray:@[@[@111, @"Guest 2", @"email2@email.com"], @[@111, @"Guest 4", @"email4@email.com"], @[@111, @"Guest 5", @"email5@email.com"], @[@111, @"Guest 7", @"email7@email.com"]]]];
    
    FFEvent *event4 = [FFEvent new];
    [event4 setStringCustomerName: @"Customer D"];
    [event4 setNumCustomerID:@4];
    [event4 setDateDay:[NSDate dateWithYear:[NSDate componentsOfCurrentDate].year month:[NSDate componentsOfCurrentDate].month day:[NSDate componentsOfCurrentDate].day]];
    [event4 setDateTimeBegin:[NSDate dateWithHour:18 min:00]];
    [event4 setDateTimeEnd:[NSDate dateWithHour:19 min:13]];
    [event4 setArrayWithGuests:[NSMutableArray arrayWithArray:@[@[@111, @"Guest 2", @"email2@email.com"], @[@111, @"Guest 4", @"email4@email.com"], @[@111, @"Guest 5", @"email5@email.com"], @[@111, @"Guest 7", @"email7@email.com"]]]];
    
    FFEvent *event5 = [FFEvent new];
    [event5 setStringCustomerName: @"Customer E"];
    [event5 setNumCustomerID:@5];
    [event5 setDateDay:[NSDate dateWithYear:[NSDate componentsOfCurrentDate].year month:[NSDate componentsOfCurrentDate].month day:[NSDate componentsOfCurrentDate].day]];
    [event5 setDateTimeBegin:[NSDate dateWithHour:20 min:00]];
    [event5 setDateTimeEnd:[NSDate dateWithHour:21 min:13]];
    [event5 setArrayWithGuests:[NSMutableArray arrayWithArray:@[@[@111, @"Guest 2", @"email2@email.com"], @[@111, @"Guest 4", @"email4@email.com"], @[@111, @"Guest 5", @"email5@email.com"], @[@111, @"Guest 7", @"email7@email.com"]]]];
    
    FFEvent *event6 = [FFEvent new];
    [event6 setStringCustomerName: @"Customer F"];
    [event6 setNumCustomerID:@6];
    [event6 setDateDay:[NSDate dateWithYear:[NSDate componentsOfCurrentDate].year month:[NSDate componentsOfCurrentDate].month day:25]];
    [event6 setDateTimeBegin:[NSDate dateWithHour:20 min:00]];
    [event6 setDateTimeEnd:[NSDate dateWithHour:21 min:13]];
    [event6 setArrayWithGuests:[NSMutableArray arrayWithArray:@[@[@111, @"Guest 2", @"email2@email.com"], @[@111, @"Guest 4", @"email4@email.com"], @[@111, @"Guest 5", @"email5@email.com"], @[@111, @"Guest 7", @"email7@email.com"]]]];
    
    FFEvent *event7 = [FFEvent new];
    [event7 setStringCustomerName: @"Customer G"];
    [event7 setNumCustomerID:@7];
    [event7 setDateDay:[NSDate dateWithYear:[NSDate componentsOfCurrentDate].year month:[NSDate componentsOfCurrentDate].month day:1]];
    [event7 setDateTimeBegin:[NSDate dateWithHour:20 min:00]];
    [event7 setDateTimeEnd:[NSDate dateWithHour:21 min:13]];
    [event7 setArrayWithGuests:[NSMutableArray arrayWithArray:@[@[@111, @"Guest 2", @"email2@email.com"], @[@111, @"Guest 4", @"email4@email.com"], @[@111, @"Guest 5", @"email5@email.com"], @[@111, @"Guest 7", @"email7@email.com"]]]];
    
    FFEvent *event8 = [FFEvent new];
    [event8 setStringCustomerName: @"Customer H"];
    [event8 setNumCustomerID:@8];
    [event8 setDateDay:[NSDate dateWithYear:[NSDate componentsOfCurrentDate].year month:[NSDate componentsOfCurrentDate].month day:27]];
    [event8 setDateTimeBegin:[NSDate dateWithHour:20 min:00]];
    [event8 setDateTimeEnd:[NSDate dateWithHour:21 min:13]];
    [event8 setArrayWithGuests:[NSMutableArray arrayWithArray:@[@[@111, @"Guest 2", @"email2@email.com"], @[@111, @"Guest 4", @"email4@email.com"], @[@111, @"Guest 5", @"email5@email.com"], @[@111, @"Guest 7", @"email7@email.com"]]]];
    
    return [NSMutableArray arrayWithArray:@[event1, event2, event3, event4, event5, event6, event7, event8]];
}




@end
