//
//  MultiInjuryVC.m
//  AlphaProTracker
//
//  Created by Mac on 16/01/18.
//  Copyright © 2018 agaraminfotech. All rights reserved.
//

#import "MultiInjuryVC.h"
#import "CustomNavigation.h"
#import "HomeVC.h"


@interface MultiInjuryVC ()

@end

@implementation MultiInjuryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customnavigationmethod];
}

-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    
    
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"Multi Injury Details";
    objCustomNavigation.btn_back.hidden =NO;
    objCustomNavigation.menu_btn.hidden = YES;
    [objCustomNavigation.btn_back addTarget:self action:@selector(btn_back:) forControlEvents:UIControlEventTouchUpInside];
    [objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
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
@end
