//
//  WorkLoadVC.m
//  AlphaProTracker
//
//  Created by Lexicon on 31/08/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "WorkLoadVC.h"
#import "CustomNavigation.h"
#import "HomeVC.h"
#import "AppCommon.h"
#import "WLReportFilterVC.h"
#import "WellnessRatingVC.h"
#import "TrainingLoadVC.h"




@interface WorkLoadVC ()

@end

@implementation WorkLoadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customnavigationmethod];
    // Do any additional setup after loading the view.
}

-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    
    
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"Work Load Management";
    
    
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

    
    
//    objCustomNavigation.btn_back.hidden =NO;
//    objCustomNavigation.menu_btn.hidden = YES;
//    [objCustomNavigation.menu_btn addTarget:self action:@selector(MenuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [objCustomNavigation.btn_back addTarget:self action:@selector(btn_back:) forControlEvents:UIControlEventTouchUpInside];

    
}
-(IBAction)didClickBackBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)didClickViewGraphsBtn:(id)sender
{
    WLReportFilterVC  * objTabVC=[[WLReportFilterVC alloc]init];
    objTabVC = (WLReportFilterVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"WLReportFilterVC"];
    [self.navigationController pushViewController:objTabVC animated:YES];
    
}
-(IBAction)didClickRecordWellnessBtn:(id)sender
{
    
    WellnessRatingVC  * objTabVC=[[WellnessRatingVC alloc]init];
    objTabVC = (WellnessRatingVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"WellnessRatingVC"];
    objTabVC.selectPlayercode = self.Playcode;
    
    [self.navigationController pushViewController:objTabVC animated:YES];
}
-(IBAction)didClickRecordTrainingLoadBtn:(id)sender
{
    TrainingLoadVC  * objTabVC=[[TrainingLoadVC alloc]init];
    objTabVC = (TrainingLoadVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"TrainingLoadVC"];
    [self.navigationController pushViewController:objTabVC animated:YES];
    
}
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
-(IBAction)btn_back:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
