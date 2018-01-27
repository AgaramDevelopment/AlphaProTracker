//
//  MessangerSelectorVC.m
//  AlphaProTracker
//
//  Created by apple on 25/01/18.
//  Copyright © 2018 agaraminfotech. All rights reserved.
//

#import "MessangerSelectorVC.h"
#import "AppCommon.h"
#import "WebService.h"
#import "InboxTableViewCell.h"
#import "GroupChat.h"
#import "CustomNavigation.h"

@interface MessangerSelectorVC ()
{
    CustomNavigation * objCustomNavigation;
    GroupChat *objGroup;
}

@end

@implementation MessangerSelectorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customnavigationmethod];
    commonArray = [[NSMutableArray alloc] init];
    self.messangerTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self fetchMessagesPageLoadWebservice];
    
//    [self.inboxBtn setBackgroundColor:[UIColor whiteColor]];
}

-(void)customnavigationmethod
{
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    [self.naviView addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"Messages";
    objCustomNavigation.btn_back.hidden =YES;
    objCustomNavigation.home_btn.hidden =NO;
    objCustomNavigation.menu_btn.hidden = NO;
     [objCustomNavigation.home_btn setImage:[UIImage imageNamed:@"ico_addWhite"]  forState:UIControlStateNormal];
    
    [objCustomNavigation.menu_btn addTarget:self action:@selector(MenuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
     [objCustomNavigation.home_btn addTarget:self action:@selector(NewGroptAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(IBAction)MenuBtnAction:(id)sender
{
    [COMMON ShowsideMenuView];
    
}

- (void)fetchMessagesPageLoadWebservice {
    
    //    [COMMON loadingIcon:self.view];
    [AppCommon showLoading];
    if([COMMON isInternetReachable])
    {
        NSString *URLString =  @"http://192.168.1.84:8029/AGAPTSERVICE.svc/FETCHMESSAGESPAGELOAD";
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        
        NSString *cliendcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
        NSString *userref = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
        //NSString * usercde = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
        NSString *rolecode = [[NSUserDefaults standardUserDefaults]stringForKey:@"RoleCode"];
        
        //        NSString *usercode1 = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
        //
        //        NSString *usercde;
        //        if( [rolecode isEqualToString:@"ROL0000002"] )
        //        {
        //            usercde = usercode1;
        //        }
        //        else
        //        {
        //            usercde = self.Playerusercde;
        //        }
        
        NSString *usercde = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(cliendcode)   [dic    setObject:cliendcode     forKey:@"Clientcode"];
        if(usercde)   [dic    setObject:usercde     forKey:@"UserCode"];
        if(userref)   [dic    setObject:userref     forKey:@"Userreferencecode"];
        if(rolecode)   [dic    setObject:userref     forKey:@"RoleCode"];
        
        //                   [dic    setObject:cliendcode     forKey:@"Clientcode"];
        //                 [dic    setObject:usercde     forKey:@"UserCode"];
        //                 [dic    setObject:userref     forKey:@"Userreferencecode"];
        //                  [dic    setObject:userref     forKey:@"RoleCode"];
        
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            if(responseObject >0)
            {
                inboxArray = [NSMutableArray new]; //lstunreadDetails
                contactsArray = [NSMutableArray new]; //lstcontactsDetails
                groupsArray = [NSMutableArray new]; //lstcontactsDetails
                //For PopView --> lstrecipients
                
                NSMutableArray *lstunreadDetails = [responseObject valueForKey:@"lstunreadDetails"];
                if(lstunreadDetails.count>0)
                {
                for (id key in lstunreadDetails) {
                    NSMutableDictionary *unreadDetailsDict = [NSMutableDictionary new];
                    [unreadDetailsDict setObject:[key valueForKey:@"message"] forKey:@"message"];
                    [unreadDetailsDict setObject:[key valueForKey:@"messageId"] forKey:@"messageId"];
                    [unreadDetailsDict setObject:[key valueForKey:@"receivefromcode"] forKey:@"receivefromcode"];
                    [unreadDetailsDict setObject:[key valueForKey:@"receivefromname"] forKey:@"receivefromname"];
                    
                    [unreadDetailsDict setObject:[key valueForKey:@"msgDateTime"] forKey:@"msgDateTime"];
                    [unreadDetailsDict setObject:[key valueForKey:@"commId"] forKey:@"commId"];
                    [unreadDetailsDict setObject:[key valueForKey:@"msgCount"] forKey:@"msgCount"];
                    
                    [inboxArray addObject:unreadDetailsDict];
                    NSLog(@"inboxArray:%@", inboxArray);
                }
                NSLog(@"inboxArray:%@", inboxArray);
                }
                NSMutableArray *lstcontactsDetails = [responseObject valueForKey:@"lstcontactsDetails"];
                if(lstcontactsDetails.count>0)
                {
                for (id key in lstcontactsDetails) {
                    
                    NSMutableDictionary *contactsDetailsDict = [NSMutableDictionary new];
                    if ([[key valueForKey:@"commId"] hasPrefix:@"GRP"]) {
                        
                        [contactsDetailsDict setObject:[key valueForKey:@"receivercode"] forKey:@"receivercode"];
                        [contactsDetailsDict setObject:[key valueForKey:@"receivername"] forKey:@"receivername"];
                        [contactsDetailsDict setObject:[key valueForKey:@"commId"] forKey:@"commId"];
                        [groupsArray addObject:contactsDetailsDict];
                        NSLog(@"groupsArray:%@", groupsArray);
                    } else if ([[key valueForKey:@"commId"] hasPrefix:@"COM"]) {
                        
                        [contactsDetailsDict setObject:[key valueForKey:@"receivercode"] forKey:@"receivercode"];
                        [contactsDetailsDict setObject:[key valueForKey:@"receivername"] forKey:@"receivername"];
                        [contactsDetailsDict setObject:[key valueForKey:@"commId"] forKey:@"commId"];
                        [contactsArray addObject:contactsDetailsDict];
                        NSLog(@"contactsArray:%@", contactsArray);
                    }
                }
                }
                
                recipientsArray = [[NSMutableArray alloc] init];
                NSMutableArray *recipArray = [responseObject valueForKey:@"lstrecipients"];
                if(recipArray.count>0)
                {
                for (id key in recipArray) {
                    
                    NSMutableDictionary *recipientsDict = [NSMutableDictionary new];
                    
                        [recipientsDict setObject:[key valueForKey:@"receivercode"] forKey:@"receivercode"];
                        [recipientsDict setObject:[key valueForKey:@"receivername"] forKey:@"receivername"];
                    [recipientsArray addObject:recipientsDict];
                }
                }
                
            }
            
            if([self.referenceKey isEqualToString:@"yes"])
            {
                [self.groupsBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
            }
            else
            {
                [self.inboxBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
            }
            
//            commonArray = inboxArray;
            [AppCommon hideLoading];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed");
            [AppCommon hideLoading];
            [COMMON webServiceFailureError];
        }];
    }
}

- (IBAction)inboxAction:(id)sender {

    objCustomNavigation.home_btn.hidden = YES;
    
    [self resetButtonStatus];
    if (!isInbox) {
        isInbox = YES;
        [self setInningsBySelection:@"1"];
        
        
        
//        [commonArray removeAllObjects];
        commonArray = [[NSMutableArray alloc] init];
        commonArray = inboxArray;
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI
            [self.messangerTableView reloadData];
        });
    }
}
- (IBAction)contactsAction:(id)sender {
    
    
    NSString *rolecode = [[NSUserDefaults standardUserDefaults]stringForKey:@"RoleCode"];
    
    if([rolecode isEqualToString:@"ROL0000002"])
    {
        objCustomNavigation.home_btn.hidden = YES;
    } else {
        objCustomNavigation.home_btn.hidden = NO;
    }
    [self resetButtonStatus];
    if (!isContacts) {
        isContacts = YES;
        [self setInningsBySelection:@"2"];
        
//        [commonArray removeAllObjects];
        commonArray = [[NSMutableArray alloc] init];
        commonArray = contactsArray;
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI
            [self.messangerTableView reloadData];
        });
    }
}

- (IBAction)groupsAction:(id)sender {
    
    NSString *rolecode = [[NSUserDefaults standardUserDefaults]stringForKey:@"RoleCode"];
    
    if([rolecode isEqualToString:@"ROL0000002"])
    {
        objCustomNavigation.home_btn.hidden = YES;
    } else {
        objCustomNavigation.home_btn.hidden = NO;
    }
    
    [self resetButtonStatus];
    if (!isGroups) {
        isGroups = YES;
        [self setInningsBySelection:@"3"];
        
//        [commonArray removeAllObjects];
        commonArray = [[NSMutableArray alloc] init];
        commonArray = groupsArray;
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI
            [self.messangerTableView reloadData];
        });
    }
}


#pragma mark - UITableViewDataSource
// number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return commonArray.count;
}
// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (isInbox) {
        
        static NSString *inboxCell = @"inboxCell";
        InboxTableViewCell * objCell = [tableView dequeueReusableCellWithIdentifier:@"inboxCell"];
        NSArray* arr = [[NSBundle mainBundle] loadNibNamed:@"InboxTableViewCell" owner:self options:nil];
         objCell = arr[0];
        
        if (objCell == nil) {
            objCell = [[InboxTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:inboxCell];
        }
        
        objCell.backgroundColor = [UIColor clearColor];
//        UIView *bgColorView = [[UIView alloc] init];
//        bgColorView.backgroundColor = [UIColor colorWithRed:(8/255.0f) green:(26/255.0f) blue:(77/255.0f) alpha:1.0f];
//        objCell.selectedBackgroundView = bgColorView;
        objCell.textLabel.textColor = [UIColor blackColor];
        
        
//        objCell.unreadMssgLbl.text = @"1 Unread message(s) from Veeresh";
//        objCell.messageLbl.text = @"Last Message: Hii";
//        objCell.dateTimeLbl.text = @"msgDateTime: Jan 26 2018 Fri 8:31 PM";
        objCell.unreadMssgLbl.text = [NSString stringWithFormat:@"%@ Unread message(s) from %@",[[commonArray objectAtIndex:indexPath.row] valueForKey:@"msgCount"], [[commonArray objectAtIndex:indexPath.row] valueForKey:@"receivefromname"]];
        objCell.messageLbl.text = [NSString stringWithFormat:@"Last Message: %@",[[commonArray objectAtIndex:indexPath.row] valueForKey:@"message"]];
        objCell.dateTimeLbl.text = [NSString stringWithFormat:@"%@",[[commonArray objectAtIndex:indexPath.row] valueForKey:@"msgDateTime"]];
        
        return objCell;
        
    }
    
    static NSString *cellIdentifier = @"messangerSelectorCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    
//    UIView *bgColorView = [[UIView alloc] init];
//    bgColorView.backgroundColor = [UIColor colorWithRed:(8/255.0f) green:(26/255.0f) blue:(77/255.0f) alpha:1.0f];
//    cell.selectedBackgroundView = bgColorView;
    cell.textLabel.textColor = [UIColor blackColor];
    
    if (isContacts) {
        cell.textLabel.text = [[commonArray objectAtIndex:indexPath.row] valueForKey:@"receivername"];
    } else if(isGroups) {
        cell.textLabel.text = [[commonArray objectAtIndex:indexPath.row] valueForKey:@"receivername"];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
// when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self resetButtonStatus];
}


-(void) setInningsBySelection: (NSString*) innsNo{
    
    [self setInningsButtonUnselect:self.inboxBtn];
    [self setInningsButtonUnselect:self.contactsBtn];
    [self setInningsButtonUnselect:self.groupsBtn];
    
    if([innsNo isEqualToString:@"1"]){
        
        [self setInningsButtonSelect:self.inboxBtn];
        
    }else if([innsNo isEqualToString:@"2"]){
        
        [self setInningsButtonSelect:self.contactsBtn];
    }
    else if([innsNo isEqualToString:@"3"]){
        
        [self setInningsButtonSelect:self.groupsBtn];
    }
    
}

-(UIColor*)colorWithHexString:(NSString*)hex
{
    //-----------------------------------------
    // Convert hex string to an integer
    //-----------------------------------------
    unsigned int hexint = 0;
    
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hex];
    
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet
                                       characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt:&hexint];
    
    //-----------------------------------------
    // Create color object, specifying alpha
    //-----------------------------------------
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:1.0f];
    
    return color;
}

-(void) setInningsButtonSelect : (UIButton*) innsBtn{
    // innsBtn.layer.cornerRadius = 25;
    UIColor *extrasBrushBG = [self colorWithHexString : @"#FFFFFF"];
    innsBtn.layer.backgroundColor = extrasBrushBG.CGColor;
    [innsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

-(void) setInningsButtonUnselect : (UIButton*) innsBtn{
    //  innsBtn.layer.cornerRadius = 25;
    UIColor *extrasBrushBG = [self colorWithHexString : @"#333333"];
    
    innsBtn.layer.backgroundColor = extrasBrushBG.CGColor;
    [innsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}

- (void)resetButtonStatus {
    isInbox = NO;
    isContacts = NO;
    isGroups = NO;
}
- (IBAction)NewGroptAction:(id)sender {
   
     objGroup = [[GroupChat alloc] initWithNibName:@"GroupChat" bundle:nil];
    //RcntPer.Teamcode = tmecde;
    //RcntPer.Playercode = plycde;
    objGroup.view.frame = CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height);
    objGroup.playerListArray =   recipientsArray;
    
   // [objGroup.multiSelectBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:objGroup.view];
    
}

//- (void)buttonPressed:(id)sender
//{
//    objGroup.multiSelectViewView.hidden = false;
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
