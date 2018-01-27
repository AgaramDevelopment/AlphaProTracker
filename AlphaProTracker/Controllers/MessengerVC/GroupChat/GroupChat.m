//
//  GroupChat.m
//  AlphaProTracker
//
//  Created by Apple on 26/01/18.
//  Copyright © 2018 agaraminfotech. All rights reserved.
//

#import "GroupChat.h"
#import "Config.h"
#import "AppCommon.h"
#import "WebService.h"
#import "CRTableViewCell.h"
#import "MessangerSelectorVC.h"

@interface GroupChat ()

@property (strong, nonatomic)  NSMutableArray *selectedMarks;

@end

@implementation GroupChat

- (void)viewDidLoad {
    [super viewDidLoad];
    self.multiSelectViewView.hidden = YES;
    
   // [self groupchatWebservice];
    self.selectedMarks = [[NSMutableArray alloc]init];
    
    
}

 
-(void)groupchatWebservice
{
    // [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@", GroupChatKey]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.requestSerializer = requestSerializer;
        
        
        NSString *UserCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
        NSString *Clientcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
        NSString *groupname = self.GroupnameTxt.text ;
        NSMutableArray *receivercodes = self.selectedMarks;
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(UserCode)   [dic    setObject:UserCode     forKey:@"UserCode"];
        if(Clientcode)   [dic    setObject:Clientcode     forKey:@"Clientcode"];
        if(groupname)   [dic    setObject:groupname     forKey:@"groupname"];
        if(receivercodes)   [dic    setObject:receivercodes     forKey:@"receivercodes"];
        
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
               
                MessangerSelectorVC * objMess = [[MessangerSelectorVC alloc] initWithNibName:@"MessangerSelectorVC" bundle:nil];
                objMess.referenceKey = @"yes";
                [appDel.navigationController pushViewController:objMess animated:YES];
//                objMess.referenceKey = @"yes";
//                objMess.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
//                [self.view addSubview:objMess.view];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.playerListArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

        static NSString *CRTableViewCellIdentifier = @"cellIdentifier";
        
        // init the CRTableViewCell
        CRTableViewCell *cell = (CRTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CRTableViewCellIdentifier];
        
        if (cell == nil) {
            cell = [[CRTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CRTableViewCellIdentifier];
        }
    
   
     NSString *   Excode = [[self.playerListArray valueForKey:@"receivercode"] objectAtIndex:indexPath.row];
        
        // Check if the cell is currently selected (marked)
        NSString *text = [[self.playerListArray valueForKey:@"receivername"] objectAtIndex:[indexPath row]];
        cell.isSelected = [self.selectedMarks containsObject:Excode] ? YES : NO;
        cell.textLabel.text = text;
        return cell;
 
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *   Excode = [[self.playerListArray valueForKey:@"receivercode"] objectAtIndex:indexPath.row];
    //Excode = [self.playerListArray objectAtIndex:indexPath.row];
    if ([self.selectedMarks containsObject:Excode])// Is selected?
        [self.selectedMarks removeObject:Excode];
    else
        [self.selectedMarks addObject:Excode];
    
    static NSString *CRTableViewCellIdentifier = @"cellIdentifier";
    
    CRTableViewCell *cell = (CRTableViewCell *)[self.PlayerListTbl dequeueReusableCellWithIdentifier:CRTableViewCellIdentifier];
    cell.isSelected = [self.selectedMarks containsObject:Excode] ? YES : NO;
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    int a = self.selectedMarks.count;
    if(a == 0)
    {
        //NSString *b = [NSString stringWithFormat:@"%d", a];
        self.selectedPlayerlbl.text = @"";
    }
    if(a == 1)
    {
        //NSString *b = [NSString stringWithFormat:@"%d", a];
        self.selectedPlayerlbl.text = [NSString stringWithFormat:@"%d Player selected", a];
    }
    else
    {
        self.selectedPlayerlbl.text = [NSString stringWithFormat:@"%d Players selected", a];
    }
    
    
}

- (IBAction)onClickBtn:(id)sender {
    NSLog(@"HI");
    //objGroup.multiSelectViewView.hidden = false;
    self.multiSelectViewView.hidden = NO;
    self.selectedMarks = [[NSMutableArray alloc]init];

}

-(IBAction)groupmemeberAction:(id)sender
{
    self.multiSelectViewView.hidden = NO;
}
-(IBAction)submitAction:(id)sender
{
    self.multiSelectViewView.hidden = YES;
    NSLog(@"%@", self.selectedMarks);
    
}
-(IBAction)cancelAction:(id)sender
{
    self.multiSelectViewView.hidden = YES;
}

-(IBAction)createAction:(id)sender
{
    [self groupchatWebservice];
}
-(IBAction)closeAction:(id)sender
{
    MessangerSelectorVC * objMess = [[MessangerSelectorVC alloc] initWithNibName:@"MessangerSelectorVC" bundle:nil];
    objMess.referenceKey = @"yes";
    [appDel.navigationController pushViewController:objMess animated:YES];
}



@end
