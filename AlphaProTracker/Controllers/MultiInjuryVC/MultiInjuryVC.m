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
    
    self.sideView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.sideView.layer.borderWidth=0.5;
    self.sideView.layer.masksToBounds=YES;
    
    self.siteView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.siteView.layer.borderWidth=0.5;
    self.siteView.layer.masksToBounds=YES;
    
    self.causeView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.causeView.layer.borderWidth=0.5;
    self.causeView.layer.masksToBounds=YES;
    
    self.locationView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.locationView.layer.borderWidth=0.5;
    self.locationView.layer.masksToBounds=YES;
    
    self.typeView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.typeView.layer.borderWidth=0.5;
    self.typeView.layer.masksToBounds=YES;
    
    self.multiseliectPopView.hidden = YES;
}

-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    
    
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"Multi Injury Details";
    objCustomNavigation.btn_back.hidden =NO;
    objCustomNavigation.home_btn.hidden =YES;
    objCustomNavigation.menu_btn.hidden = YES;
    [objCustomNavigation.btn_back addTarget:self action:@selector(btn_back:) forControlEvents:UIControlEventTouchUpInside];
   // [objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(IBAction)HomeBtnAction:(id)sender
{
    HomeVC  * objTabVC=[[HomeVC alloc]init];
    objTabVC = (HomeVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
    [self.navigationController pushViewController:objTabVC animated:YES];
    
    
}
-(IBAction)SideAction:(id)sender
{
    self.multiseliectPopView.hidden = NO;
}
-(IBAction)SiteAction:(id)sender
{
    self.multiseliectPopView.hidden = NO;
}
-(IBAction)CauseAction:(id)sender
{
    self.multiseliectPopView.hidden = NO;
}
-(IBAction)locationAction:(id)sender
{
    self.multiseliectPopView.hidden = NO;
}
-(IBAction)TypeAction:(id)sender
{
    self.multiseliectPopView.hidden = NO;
}

-(IBAction)AddAction:(id)sender
{
    
}

-(IBAction)CancelAction:(id)sender
{
    self.multiseliectPopView.hidden = YES;
}
-(IBAction)SubmitAction:(id)sender
{
    self.multiseliectPopView.hidden = YES;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [self.injuryTbl dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier];
    }
    
    
    cell.textLabel.text = @"injuryNAME";
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


-(IBAction)btn_back:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:NO];
}
@end
