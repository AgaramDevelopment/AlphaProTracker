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
#import "AppCommon.h"
#import "Config.h"
#import "WebService.h"



@interface MultiInjuryVC ()
{
//    BOOL isMulti;
//    BOOL isList;
    
    
    BOOL isSide;
    BOOL isSite;
    BOOL isLoc;
    BOOL isCause;
    BOOL isType;
    
    NSIndexPath *SelectedindexPath;
    
   // UITapGestureRecognizer *letterTapRecognizer;
}

@property (strong, nonatomic)  NSMutableArray *selectedMarks;

@property (strong, nonatomic)  NSMutableArray *commonArray;
@property (strong, nonatomic)  NSMutableArray *commonGridArray;


@property (strong, nonatomic)  NSMutableArray *SiteCodeArray;
@property (strong, nonatomic)  NSMutableArray *SideCodeArray;
@property (strong, nonatomic)  NSMutableArray *LocCodeArray;
@property (strong, nonatomic)  NSMutableArray *CauseCodeArray;
@property (strong, nonatomic)  NSMutableArray *TypeCodeArray;
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
    
    self.UPDATEBtn.hidden = YES;
    self.DELETEBtn.hidden = YES;
    self.CLOSEBtn.hidden = YES;
    self.injuryTbl.hidden = YES;
    
    self.injurySideArray = [NSMutableArray arrayWithObjects:@"Right",@"Left", nil];
    self.injurySiteArray = [NSMutableArray arrayWithObjects:@"Anterior",@"Posterior",@"Medical",@"Lateral", nil];
    
    self.clientcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    
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
     isSide=YES;
     isSite=NO;
     isLoc=NO;
     isCause=NO;
     isType=NO;
    
    self.multiseliectPopView.hidden = NO;
     self.selectedMarks = [[NSMutableArray alloc]init];
    self.commonArray = [[NSMutableArray alloc]init];
    self.commonArray = self.injurySideArray;
    [self.multiSelectTbl reloadData];
}
-(IBAction)SiteAction:(id)sender
{
    isSide=NO;
    isSite=YES;
    isLoc=NO;
    isCause=NO;
    isType=NO;
    self.multiseliectPopView.hidden = NO;
     self.selectedMarks = [[NSMutableArray alloc]init];
    self.commonArray = [[NSMutableArray alloc]init];
    self.commonArray = self.injurySiteArray;
    [self.multiSelectTbl reloadData];
}
-(IBAction)CauseAction:(id)sender
{
    isSide=NO;
    isSite=NO;
    isLoc=NO;
    isCause=YES;
    isType=NO;
    
    self.multiseliectPopView.hidden = NO;
    self.commonArray = [[NSMutableArray alloc]init];
     self.selectedMarks = [[NSMutableArray alloc]init];
    self.commonArray = self.injuryCauseArray;
    [self.multiSelectTbl reloadData];
}
-(IBAction)locationAction:(id)sender
{
    isSide=NO;
    isSite=NO;
    isLoc=YES;
    isCause=NO;
    isType=NO;
    self.multiseliectPopView.hidden = NO;
    self.commonArray = [[NSMutableArray alloc]init];
     self.selectedMarks = [[NSMutableArray alloc]init];
    self.commonArray = self.injuryLocationArray;
    [self.multiSelectTbl reloadData];
}
-(IBAction)TypeAction:(id)sender
{
    isSide=NO;
    isSite=NO;
    isLoc=NO;
    isCause=NO;
    isType=YES;
    self.multiseliectPopView.hidden = NO;
    self.commonArray = [[NSMutableArray alloc]init];
     self.selectedMarks = [[NSMutableArray alloc]init];
    self.commonArray = self.injuryTypeArray;
    [self.multiSelectTbl reloadData];
}

-(IBAction)AddAction:(id)sender
{
    [self tablevalueAddWebservice];
}

-(IBAction)CancelAction:(id)sender
{
    self.multiseliectPopView.hidden = YES;
}
-(IBAction)SubmitAction:(id)sender
{
    self.multiseliectPopView.hidden = YES;
    
    NSLog(@"%@",_selectedMarks);
    
    if(isSite==YES)
    {
        self.SiteCodeArray = [[NSMutableArray alloc]init];
        self.SiteCodeArray = _selectedMarks;
        self.sitelbl.text = [NSString stringWithFormat:@"%lu items selected",(unsigned long)self.SiteCodeArray.count];
        NSLog(@"%@",_SiteCodeArray);
    }
    if(isSide==YES)
    {
        self.SideCodeArray = [[NSMutableArray alloc]init];
        self.SideCodeArray = _selectedMarks;
        
        self.sidelbl.text = [NSString stringWithFormat:@"%lu items selected",(unsigned long)self.SideCodeArray.count];
        
        NSLog(@"%@",_SideCodeArray);
    }
    if(isCause==YES)
    {
        self.CauseCodeArray = [[NSMutableArray alloc]init];
        self.CauseCodeArray = _selectedMarks;
        self.causelbl.text = [NSString stringWithFormat:@"%lu items selected",(unsigned long)self.CauseCodeArray.count];
        NSLog(@"%@",_CauseCodeArray);
    }
    if(isLoc==YES)
    {
        self.LocCodeArray = [[NSMutableArray alloc]init];
        self.LocCodeArray = _selectedMarks;
        self.locationlbl.text = [NSString stringWithFormat:@"%lu items selected",(unsigned long)self.LocCodeArray.count];
        NSLog(@"%@",_LocCodeArray);
    }
    if(isType==YES)
    {
        self.TypeCodeArray = [[NSMutableArray alloc]init];
        self.TypeCodeArray = _selectedMarks;
        self.typelbl.text = [NSString stringWithFormat:@"%lu items selected",(unsigned long)self.TypeCodeArray.count];
        NSLog(@"%@",_TypeCodeArray);
    }
    
    
}



//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;    //count of section
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(tableView == self.multiSelectTbl)
    {
        return self.commonArray.count;
    }
    else{
        return self.commonGridArray.count;
    }
    return nil;
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
    
    
    cell.sidelbl.text = [[self.commonGridArray valueForKey:@"InjurySide"]objectAtIndex:indexPath.row];
    cell.sitelbl.text = [[self.commonGridArray valueForKey:@"InjurySite"]objectAtIndex:indexPath.row];
    cell.causelbl.text = [[self.commonGridArray valueForKey:@"InjuryCause"]objectAtIndex:indexPath.row];
    cell.locationlbl.text = [[self.commonGridArray valueForKey:@"InjuryLocation"]objectAtIndex:indexPath.row];
    cell.typelbl.text = [[self.commonGridArray valueForKey:@"InjuryType"]objectAtIndex:indexPath.row];
        
        [[cell deleteBtn] setTag:indexPath.row];
        [cell.deleteBtn addTarget:self action:@selector(DeleterowAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
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
        
        if(isSide==YES)
        {
            
        NSString *text = [self.commonArray objectAtIndex:indexPath.row];
            NSString *SideCode;
            
            if(indexPath.row == 0)
            {
                SideCode = @"MSC169";
            }
            if(indexPath.row == 1)
            {
                SideCode = @"MSC170";
            }
        cell.isSelected = [self.selectedMarks containsObject:SideCode] ? YES : NO;
        cell.textLabel.text = text;
        }
        
        if(isSite==YES)
        {
            NSString *text = [self.commonArray objectAtIndex:indexPath.row];
            NSString *SiteCode;
            
            if(indexPath.row == 0)
            {
                SiteCode = @"MSC165";
            }
            if(indexPath.row == 1)
            {
                SiteCode = @"MSC167";
            }
            if(indexPath.row == 2)
            {
                SiteCode = @"MSC166";
            }
            if(indexPath.row == 3)
            {
                SiteCode = @"MSC168";
            }
            cell.isSelected = [self.selectedMarks containsObject:SiteCode] ? YES : NO;
            cell.textLabel.text = text;
        }
        
        if(isLoc==YES)
        {
            NSString *locationcode = [[self.commonArray valueForKey:@"InjuryMetaSubCode"]objectAtIndex:indexPath.row];
            NSString *text = [[self.commonArray valueForKey:@"InjuryMetaDataTypeCode"]objectAtIndex:indexPath.row];
            cell.isSelected = [self.selectedMarks containsObject:locationcode] ? YES : NO;
            cell.textLabel.text = text;
        }
        
        if(isCause==YES)
        {
            
            NSString *causecode = [[self.commonArray valueForKey:@"InjuryMetaSubCode"]objectAtIndex:indexPath.row];
            NSString *text = [[self.commonArray valueForKey:@"InjuryMetaDataTypeCode"]objectAtIndex:indexPath.row];
            cell.isSelected = [self.selectedMarks containsObject:causecode] ? YES : NO;
            cell.textLabel.text = text;
        }
        if(isType==YES)
        {
            NSString *typecode = [[self.commonArray valueForKey:@"InjuryMetaSubCode"]objectAtIndex:indexPath.row];
            NSString *text = [[self.commonArray valueForKey:@"InjuryMetaDataTypeCode"]objectAtIndex:indexPath.row];
            cell.isSelected = [self.selectedMarks containsObject:typecode] ? YES : NO;
            cell.textLabel.text = text;
        }
        
        return cell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(tableView == self.multiSelectTbl)
    {
//        NSString *text = @"text";
//        if ([self.selectedMarks containsObject:text])// Is selected?
//            [self.selectedMarks removeObject:text];
//        else
//            [self.selectedMarks addObject:text];
        
        NSString *text;
        
        if(isSide==YES)
        {
           
            NSString *SideCode;
            
            if(indexPath.row == 0)
            {
                SideCode = @"MSC169";
            }
            if(indexPath.row == 1)
            {
                SideCode = @"MSC170";
            }
            
            text = [self.commonArray objectAtIndex:indexPath.row];
            if ([self.selectedMarks containsObject:SideCode])// Is selected?
                [self.selectedMarks removeObject:SideCode];
            else
                [self.selectedMarks addObject:SideCode];
            
            NSLog(@"%@",_selectedMarks);
            
            static NSString *CRTableViewCellIdentifier = @"cellIdentifier";
            
            CRTableViewCell *cell = (CRTableViewCell *)[self.multiSelectTbl dequeueReusableCellWithIdentifier:CRTableViewCellIdentifier];
            cell.isSelected = [self.selectedMarks containsObject:SideCode] ? YES : NO;
        }
        
        if(isSite==YES)
        {
            
            NSString *SiteCode;
            
            if(indexPath.row == 0)
            {
                SiteCode = @"MSC165";
            }
            if(indexPath.row == 1)
            {
                SiteCode = @"MSC167";
            }
            if(indexPath.row == 2)
            {
                SiteCode = @"MSC166";
            }
            if(indexPath.row == 3)
            {
                SiteCode = @"MSC168";
            }
            
            text = [self.commonArray objectAtIndex:indexPath.row];
            if ([self.selectedMarks containsObject:SiteCode])// Is selected?
                [self.selectedMarks removeObject:SiteCode];
            else
                [self.selectedMarks addObject:SiteCode];
            
            
            static NSString *CRTableViewCellIdentifier = @"cellIdentifier";
            
            CRTableViewCell *cell = (CRTableViewCell *)[self.multiSelectTbl dequeueReusableCellWithIdentifier:CRTableViewCellIdentifier];
            cell.isSelected = [self.selectedMarks containsObject:SiteCode] ? YES : NO;
        }
        
        if(isLoc==YES)
        {
            
            NSString *locationcode = [[self.commonArray valueForKey:@"InjuryMetaSubCode"]objectAtIndex:indexPath.row];
            text = [[self.commonArray valueForKey:@"InjuryMetaDataTypeCode"]objectAtIndex:indexPath.row];
            if ([self.selectedMarks containsObject:locationcode])// Is selected?
                [self.selectedMarks removeObject:locationcode];
            else
                [self.selectedMarks addObject:locationcode];
            
            static NSString *CRTableViewCellIdentifier = @"cellIdentifier";
            
            CRTableViewCell *cell = (CRTableViewCell *)[self.multiSelectTbl dequeueReusableCellWithIdentifier:CRTableViewCellIdentifier];
            cell.isSelected = [self.selectedMarks containsObject:locationcode] ? YES : NO;
        }
        
        if(isCause==YES)
        {
            
            NSString *causecode = [[self.commonArray valueForKey:@"InjuryMetaSubCode"]objectAtIndex:indexPath.row];
            text = [[self.commonArray valueForKey:@"InjuryMetaDataTypeCode"]objectAtIndex:indexPath.row];
            if ([self.selectedMarks containsObject:causecode])// Is selected?
                [self.selectedMarks removeObject:causecode];
            else
                [self.selectedMarks addObject:causecode];
            
            static NSString *CRTableViewCellIdentifier = @"cellIdentifier";
            
            CRTableViewCell *cell = (CRTableViewCell *)[self.multiSelectTbl dequeueReusableCellWithIdentifier:CRTableViewCellIdentifier];
            cell.isSelected = [self.selectedMarks containsObject:causecode] ? YES : NO;
        }
        if(isType==YES)
        {
            
            NSString *typecode = [[self.commonArray valueForKey:@"InjuryMetaSubCode"]objectAtIndex:indexPath.row];
            text = [[self.commonArray valueForKey:@"InjuryMetaDataTypeCode"]objectAtIndex:indexPath.row];
            if ([self.selectedMarks containsObject:typecode])// Is selected?
                [self.selectedMarks removeObject:typecode];
            else
                [self.selectedMarks addObject:typecode];
            
            static NSString *CRTableViewCellIdentifier = @"cellIdentifier";
            
            CRTableViewCell *cell = (CRTableViewCell *)[self.multiSelectTbl dequeueReusableCellWithIdentifier:CRTableViewCellIdentifier];
            cell.isSelected = [self.selectedMarks containsObject:typecode] ? YES : NO;
        }
        
        
        
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}



-(void)tablevalueAddWebservice
{
    [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",MultiInjuryAddeKey]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;

        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(self.injuryName)   [dic    setObject:self.injuryName     forKey:@"InjuryName"];
        if(self.playercode)   [dic    setObject:self.playercode     forKey:@"PlayerCode"];
        if(self.clientcode) [dic    setObject:self.clientcode     forKey:@"ClientCode"];
        if(_SideCodeArray) [dic    setObject:_SideCodeArray    forKey:@"InjurySide1"];
        if(_SiteCodeArray) [dic    setObject:_SiteCodeArray    forKey:@"InjurySite1"];
        if(self.CauseCodeArray)   [dic    setObject:self.CauseCodeArray      forKey:@"InjuryCaseCode1"];
        if(self.TypeCodeArray)   [dic    setObject:self.TypeCodeArray      forKey:@"InjuryTypeCode1"];
         if(self.LocCodeArray)   [dic    setObject:self.LocCodeArray      forKey:@"InjuryLocationSubCode1"];
        
        
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                self.commonGridArray = [[NSMutableArray alloc]init];
                self.commonGridArray = [responseObject valueForKey:@"InjuryWebs1"];
                [self.injuryTbl reloadData];
                self.UPDATEBtn.hidden = NO;
                self.DELETEBtn.hidden = NO;
                self.CLOSEBtn.hidden = NO;
                self.injuryTbl.hidden = NO;
            }
            
            [COMMON RemoveLoadingIcon];
            [self.view setUserInteractionEnabled:YES];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed");
            [COMMON webServiceFailureError];
            [self.view setUserInteractionEnabled:YES];
            
        }];
    }
    
}

-(IBAction)DeleterowAction:(id)sender
{
    
    UIButton *button = sender;
   SelectedindexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    
    [self ShowAlterMsg1:@"Do you Want to delete Injury?"];
    
}


-(void)ShowAlterMsg1:(NSString*) MsgStr
{
    UIAlertView *objAlter =[[UIAlertView alloc]initWithTitle:@"" message:MsgStr delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [objAlter show];
    
    // [self DeleteWebservice];
    
}

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == [alertView cancelButtonIndex])
    {
        alertView.hidden=YES;
    }
    else
    {
        NSString * clientcode = [[self.commonGridArray valueForKey:@"ClientCode"] objectAtIndex:SelectedindexPath.row];
        NSString * playercode = [[self.commonGridArray valueForKey:@"PlayerCode"]objectAtIndex:SelectedindexPath.row];
        NSString * injuryname = [[self.commonGridArray valueForKey:@"InjuryName"]objectAtIndex:SelectedindexPath.row];
        NSString * injurycode = [[self.commonGridArray valueForKey:@"InjuryCode"]objectAtIndex:SelectedindexPath.row];
        NSString * typecode = [[self.commonGridArray valueForKey:@"InjuryTypeCode"]objectAtIndex:SelectedindexPath.row];
        NSString * sitecode = [[self.commonGridArray valueForKey:@"InjurySiteCode"]objectAtIndex:SelectedindexPath.row];
        NSString * sidecode = [[self.commonGridArray valueForKey:@"InjurySideCode"]objectAtIndex:SelectedindexPath.row];
        NSString * causecode = [[self.commonGridArray valueForKey:@"InjuryCauseCode"]objectAtIndex:SelectedindexPath.row];
        NSString * locationcode = [[self.commonGridArray valueForKey:@"InjuryLocationSubCode"]objectAtIndex:SelectedindexPath.row];
        
        
        [self RowDeleteWebservice:clientcode:playercode :injuryname :injurycode :typecode :sitecode :sidecode :causecode:locationcode];
    }
}

-(void)RowDeleteWebservice :(NSString *)CLIENTCODE :(NSString *)PLAYERCODE:(NSString *)INJURYNAME:(NSString *)INJURYCODE :(NSString *)TYPECODE :(NSString *)SITECODE :(NSString *)SIDECODE :(NSString *)CAUSECODE :(NSString *)LOCATIONCODE
{
    [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",deleteRowKey]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(CLIENTCODE)   [dic    setObject:CLIENTCODE     forKey:@"ClientCode"];
        if(PLAYERCODE)   [dic    setObject:PLAYERCODE     forKey:@"PlayerCode"];
        if(INJURYNAME)   [dic    setObject:INJURYNAME     forKey:@"InjuryName"];
        if(INJURYCODE)   [dic    setObject:INJURYCODE     forKey:@"InjuryCode"];
        if(TYPECODE)     [dic    setObject:TYPECODE     forKey:@"InjuryTypeCode"];
        if(LOCATIONCODE) [dic    setObject:LOCATIONCODE     forKey:@"InjuryLocationSubCode"];
        if(SITECODE)   [dic    setObject:SITECODE     forKey:@"InjurySiteCode"];
        if(SIDECODE)   [dic    setObject:SIDECODE     forKey:@"InjurySideCode"];
        if(CAUSECODE)   [dic    setObject:CAUSECODE     forKey:@"InjuryCauseCode"];
        
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                self.commonGridArray = [[NSMutableArray alloc]init];
                self.commonGridArray = [responseObject valueForKey:@"InjuryWebs1"];
                [self.injuryTbl reloadData];
                self.UPDATEBtn.hidden = NO;
                self.DELETEBtn.hidden = NO;
                self.CLOSEBtn.hidden = NO;
                self.injuryTbl.hidden = NO;
                
                [self.injuryTbl reloadData];
            }
            
            [COMMON RemoveLoadingIcon];
            [self.view setUserInteractionEnabled:YES];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed");
            [COMMON webServiceFailureError];
            [self.view setUserInteractionEnabled:YES];
            
        }];
    }
    
}


-(IBAction)btn_back:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:NO];
}
@end
