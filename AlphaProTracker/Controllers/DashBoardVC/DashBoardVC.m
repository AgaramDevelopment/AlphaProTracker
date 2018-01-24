//
//  DashBoardVC.m
//  AlphaProTracker
//
//  Created by Lexicon on 24/08/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "DashBoardVC.h"
#import "CustomNavigation.h"
#import "Config.h"
#import "HomeVCCell.h"
#import "DashBoardVC.h"
#import "DashBoardVCCell.h"
#import "AppCommon.h"
#import "QuestionaryVC.h"
#import "HomeVC.h"
#import "FoodDairyVC.h"
#import "TestAssessmentViewVC.h"
#import "AssessmentMultiPlayerReportVC.h"
#import "AssessmentSinglePlayerReportVC.h"
#import "ProgramVC.h"
#import "AssignPlayerVC.h"


@interface DashBoardVC ()
{
    NSArray *imageArray;
    NSArray *titleArray;
}


@end



@implementation DashBoardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view_border.layer.borderWidth = 1;
    //self.view_border.layer.borderColor = [UIColor colorWithRed:(0/255.0f) green:(0/255.0f) blue:(0/255.0f) alpha:0.9f].CGColor;
    
    imageArray =[NSArray arrayWithObjects:@"icon_assesment",@"icon_question",@"icon_singleplayer",@"icon_multiplayer",@"icon_program",@"icon_assignplayer", nil];
    
    titleArray =[[NSArray alloc]init];
    titleArray = @[@"Assesment",@"Questionary",@"SPR",@"MPR",@"Program",@"Assign Player"];
    
    [self customnavigationmethod];
}
-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    
    
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"DashBoard";
    objCustomNavigation.btn_back.hidden =NO;
    objCustomNavigation.menu_btn.hidden = YES;
    [objCustomNavigation.menu_btn addTarget:self action:@selector(MenuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [objCustomNavigation.btn_back addTarget:self action:@selector(btn_back:) forControlEvents:UIControlEventTouchUpInside];

    
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
          return CGSizeMake(90,100);
        }
    }
    else
    {
        return CGSizeMake(200, 150);
    }
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    DashBoardVCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    
    
    cell.photos.image =[UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];
    
    
    cell.photos_title_lbl.text = titleArray[indexPath.row];
    
    cell.backgroundColor= [UIColor colorWithRed:(0/255.0f) green:(0/255.0f) blue:(0/255.0f) alpha:0.27f];
    
    cell.layer.borderWidth=0.5f;
    cell.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        TestAssessmentViewVC  * objTabVC=[[TestAssessmentViewVC alloc]init];
        objTabVC = (TestAssessmentViewVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"TestAssessmentViewVC"];
        objTabVC.ModuleCode = self.selectedModule;
        [self.navigationController pushViewController:objTabVC animated:YES];
        
    }
    if(indexPath.row == 1)
    {
        QuestionaryVC  * objTabVC=[[QuestionaryVC alloc]init];
        objTabVC = (QuestionaryVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"QuestionaryVC"];
        objTabVC.modulecode = self.selectedModule;
        objTabVC.Scrname = self.ScreenName;
        objTabVC.check = @"main";
        [self.navigationController pushViewController:objTabVC animated:YES];
        
        
    }
    if(indexPath.row == 2)
    {
        AssessmentSinglePlayerReportVC  * objTabVC=[[AssessmentSinglePlayerReportVC alloc]init];
        objTabVC = (AssessmentSinglePlayerReportVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"AssessmentSinglePlayerReportVC"];
        [self.navigationController pushViewController:objTabVC animated:YES];

    }
    if(indexPath.row == 3)
    {
        AssessmentMultiPlayerReportVC  * objTabVC=[[AssessmentMultiPlayerReportVC alloc]init];
        objTabVC = (AssessmentMultiPlayerReportVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"AssessmentMultiPlayerReportVC"];
        [self.navigationController pushViewController:objTabVC animated:YES];

    }
    if(indexPath.row == 4)
    {
        
        ProgramVC  * objTabVC=[[ProgramVC alloc]init];
        objTabVC = (ProgramVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"ProgramVC"];
        objTabVC.ModuleCode = self.selectedModule;
        objTabVC.Screen = self.ScreenName;
        objTabVC.check = @"main";
        [self.navigationController pushViewController:objTabVC animated:YES];
        
    }
    if(indexPath.row == 5)
    {
        
        AssignPlayerVC  * objTabVC=[[AssignPlayerVC alloc]init];
        objTabVC = (AssignPlayerVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"AssignPlayerVC"];
        
        objTabVC.ModuleCode = self.selectedModule;
        objTabVC.check = @"main";
        [self.navigationController pushViewController:objTabVC animated:YES];
 
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





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
