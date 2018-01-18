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
#import "CRTableViewCell.h"


@interface MultiInjuryVC ()
{
    BOOL isMulti;
    BOOL isList;
    
   // UITapGestureRecognizer *letterTapRecognizer;
}

@property (strong, nonatomic)  NSMutableArray *selectedMarks;
//@property (strong, nonatomic)IBOutlet  UITapGestureRecognizer *outerTapRecognizer;

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
    self.selectedMarks = [[NSMutableArray alloc]init];
    
    UITapGestureRecognizer *outerTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(highlightLetter:)];
    [self.tapView addGestureRecognizer:outerTapRecognizer];
    
}

- (void)highlightLetter:(UITapGestureRecognizer*)sender {
//    UIView *view = sender.view;
//    NSLog(@"%d", view.tag);//By tag, you can find out where you had tapped.
    
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
    if(tableView == self.injuryTbl)
    {
    static NSString *MyIdentifier = @"custid";
    
    MultiInjurylistCell *cell = [self.injuryTbl dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"MultiInjurylistCell" owner:self options:nil];
        cell = self.objCell;
    }
    
    
    cell.sidelbl.text = @"Text";
    cell.sitelbl.text = @"Text";
    cell.causelbl.text = @"Text";
    cell.locationlbl.text = @"Text";
    cell.typelbl.text = @"Text";
    //cell.deleteBtn.imageView.image = [UIImage imageNamed:@"ico_delete"];
    [cell.deleteBtn setImage:[UIImage imageNamed:@"ico_delete"]  forState:UIControlStateNormal];
    cell.backgroundColor =[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    }
    if(tableView == self.multiSelectTbl)
    {
        static NSString *CRTableViewCellIdentifier = @"cellIdentifier";
        CRTableViewCell *cell = (CRTableViewCell *)[self.multiSelectTbl dequeueReusableCellWithIdentifier:CRTableViewCellIdentifier];
        
        if (cell == nil) {
            cell = [[CRTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CRTableViewCellIdentifier];
        }
        
        //self.selectedMarks = [[NSMutableArray alloc]init];
        
        //
        
        // Check if the cell is currently selected (marked)
        NSString *text = @"text";
        cell.isSelected = [self.selectedMarks containsObject:text] ? YES : NO;
        cell.textLabel.text = text;
        return cell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(tableView == self.multiSelectTbl)
    {
        NSString *text = @"text";
        if ([self.selectedMarks containsObject:text])// Is selected?
            [self.selectedMarks removeObject:text];
        else
            [self.selectedMarks addObject:text];
        
        static NSString *CRTableViewCellIdentifier = @"cellIdentifier";
        
        CRTableViewCell *cell = (CRTableViewCell *)[self.multiSelectTbl dequeueReusableCellWithIdentifier:CRTableViewCellIdentifier];
        cell.isSelected = [self.selectedMarks containsObject:text] ? YES : NO;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


-(IBAction)btn_back:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:NO];
}
@end
