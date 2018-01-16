//
//  AssessmentFilterView.m
//  AlphaProTracker
//
//  Created by user on 03/01/18.
//  Copyright © 2018 agaraminfotech. All rights reserved.
//

#import "AssessmentFilterView.h"
#import "AppCommon.h"
#import "WebService.h"
#import "Config.h"
#import "AssessmentCell.h"
#import "SACalendar.h"
@implementation AssessmentFilterView
{
    NSMutableArray * ModuleArray;
    NSMutableArray * AssessmentTitleArray;
    NSMutableArray * TeamArray;
    NSMutableArray * playerArray;
    NSMutableArray * commonArray;
    BOOL isModule;
    BOOL isTittle;
    BOOL isTeam;
    BOOL isPoPlist;
    BOOL isplayerlist;
}

@synthesize popTblView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    self.popTblView.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:1];
    self.popTblView.layer.cornerRadius = 5;
    self.popTblView.layer.shadowOpacity = 0.8;
    self.popTblView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.popTblView.hidden = YES;
    self.playerTxt.delegate = self;
    [self allviewSetborder];
    [self moduleWebservice];
}

-(void)allviewSetborder
{
    self.moduleView.layer.borderWidth = 0.5;
    self.moduleView.layer.borderColor = [UIColor lightTextColor].CGColor;
    self.moduleView.layer.masksToBounds = YES;
    
    self.titleView.layer.borderWidth = 0.5;
    self.titleView.layer.borderColor = [UIColor lightTextColor].CGColor;
    self.titleView.layer.masksToBounds = YES;
    
    self.teamView.layer.borderWidth = 0.5;
    self.teamView.layer.borderColor = [UIColor lightTextColor].CGColor;
    self.teamView.layer.masksToBounds = YES;
    
    self.dateView.layer.borderWidth = 0.5;
    self.dateView.layer.borderColor = [UIColor lightTextColor].CGColor;
    self.dateView.layer.masksToBounds = YES;
    
    self.searchView.layer.borderWidth = 0.5;
    self.searchView.layer.borderColor = [UIColor lightTextColor].CGColor;
    self.searchView.layer.masksToBounds = YES;
    
}

-(void)moduleWebservice
{
    [COMMON loadingIcon:self];
    if([COMMON isInternetReachable])
    {
        NSString *URLString = @"http://192.168.1.84:8044/AGAPTService.svc/FETCHASSESSMENTENTRY"; //[URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",FetchModuleKey]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if([COMMON GetUsercode])   [dic    setObject:@"USM0000002"     forKey:@"Createdby"];
        if([COMMON GetClientCode])   [dic    setObject:@"CLI0000001"     forKey:@"Clientcode"];
        if([COMMON GetUsercode])   [dic    setObject:@"USM0000002"     forKey:@"Modifiedby"];
        if([COMMON GetuserReference])   [dic    setObject:@"AMR0000001"    forKey:@"Userreferencecode"];
        
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                NSLog(@"%@",responseObject);
                ModuleArray = [[NSMutableArray alloc]init];
                AssessmentTitleArray = [[NSMutableArray alloc]init];
                TeamArray = [[NSMutableArray alloc]init];
                playerArray = [[NSMutableArray alloc]init];
                
                
                //FetchModule
                NSMutableArray * objmoduleArray= [responseObject valueForKey:@"lstAssessmentEntryModule"];
                NSMutableDictionary * moduleDict = [[NSMutableDictionary alloc]init];
                [moduleDict setObject:@"" forKey:@"Module"];
                [moduleDict setObject:@"All Module" forKey:@"ModuleName"];
                [ModuleArray addObject:moduleDict];
                
                //FetchTeamArray
                NSMutableArray * objTeamArray= [responseObject valueForKey:@"lstAssessmentEntryTeam"];
                NSMutableDictionary * teamDict = [[NSMutableDictionary alloc]init];
                [teamDict setObject:@"" forKey:@"Teamcode"];
                [teamDict setObject:@"All Team" forKey:@"Teamname"];
                [TeamArray addObject:teamDict];
                
                //FetchAssessment
                
                NSMutableArray * objAssessmentArray= [responseObject valueForKey:@"lstAssessmentEntryAssessment"];
                NSMutableDictionary * AssessmentDict = [[NSMutableDictionary alloc]init];
                [AssessmentDict setObject:@"" forKey:@"Assessment"];
                [AssessmentDict setObject:@"All Assessment" forKey:@"AssessmentName"];
                [AssessmentTitleArray addObject:AssessmentDict];
                
                //FetchPlayer
                
                NSMutableArray * objPlayerArray= [responseObject valueForKey:@"lstAssessmentEntryPlayer"];
                
                for(int i=0; objmoduleArray.count>i;i++)
                {
                    NSMutableDictionary * objDic = [[NSMutableDictionary alloc]init]; //[objAlleventArray objectAtIndex:i];
                    
                    NSString * moduleCodeStr = [self checkNull:[[objmoduleArray valueForKey:@"Module"] objectAtIndex:i]];
                    NSString * modulenameStr = [self checkNull:[[objmoduleArray valueForKey:@"ModuleName"] objectAtIndex:i]];
                    [objDic setObject:moduleCodeStr forKey:@"Module"];
                    [objDic setObject:modulenameStr forKey:@"ModuleName"];
                    
                    [ModuleArray addObject:objDic];
                }
                
                for(int i=0; objTeamArray.count>i;i++)
                {
                    NSMutableDictionary * objDic = [[NSMutableDictionary alloc]init];
                    NSString * teamCodeStr = [self checkNull:[[objTeamArray valueForKey:@"Teamcode"] objectAtIndex:i]];
                    NSString * teamnameStr = [self checkNull:[[objTeamArray valueForKey:@"Teamname"] objectAtIndex:i]];
                    [objDic setObject:teamCodeStr forKey:@"Teamcode"];
                    [objDic setObject:teamnameStr forKey:@"Teamname"];
                    
                    [TeamArray addObject:objDic];
                }
                
                for(int i=0; objAssessmentArray.count>i;i++)
                {
                    NSMutableDictionary * objDic = [[NSMutableDictionary alloc]init];
                    NSString * teamCodeStr = [self checkNull:[[objAssessmentArray valueForKey:@"Assessment"] objectAtIndex:i]];
                    NSString * teamnameStr = [self checkNull:[[objAssessmentArray valueForKey:@"AssessmentName"] objectAtIndex:i]];
                    [objDic setObject:teamCodeStr forKey:@"Assessment"];
                    [objDic setObject:teamnameStr forKey:@"AssessmentName"];
                    
                    [AssessmentTitleArray addObject:objDic];
                }
                
                for(int i=0; objPlayerArray.count>i;i++)
                {
                    NSMutableDictionary * objDic = [[NSMutableDictionary alloc]init];
                    NSString * teamCodeStr = [self checkNull:[[objPlayerArray valueForKey:@"Player"] objectAtIndex:i]];
                    NSString * teamnameStr = [self checkNull:[[objPlayerArray valueForKey:@"PlayerName"] objectAtIndex:i]];
                    NSString * recoverystatus = [self checkNull:[[objPlayerArray valueForKey:@"RecoveryStatus"] objectAtIndex:i]];
                    NSString * playerphoto = [self checkNull:[[objPlayerArray valueForKey:@"playerPhoto"] objectAtIndex:i]];
                    NSString * colorcode   = [self checkNull:[[objPlayerArray valueForKey:@"StatusColor"] objectAtIndex:i]];
                    [objDic setObject:teamCodeStr forKey:@"Player"];
                    [objDic setObject:teamnameStr forKey:@"PlayerName"];
                    [objDic setObject:recoverystatus forKey:@"RecoveryStatus"];
                    [objDic setObject:playerphoto forKey:@"playerPhoto"];
                    [objDic setObject:colorcode forKey:@"StatusColor"];
                    
                    [playerArray addObject:objDic];
                }
            }
            
            [COMMON RemoveLoadingIcon];
            [self SearchViewMethod];
            [self setUserInteractionEnabled:YES];
            isplayerlist=YES;
            [self.playerTbl reloadData];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed");
            [COMMON webServiceFailureError];
            [self setUserInteractionEnabled:YES];
            
        }];
    }
}

#pragma uibuttonAction
-(IBAction)didClickModuleAction:(id)sender
{
    isplayerlist = NO;
    isPoPlist = YES;
    self.popviewyposition.constant = self.moduleView.frame.origin.y;
    if(isModule == NO)
    {
        commonArray = [[NSMutableArray alloc]init];
        commonArray = ModuleArray;
        self.popTblView.hidden =NO;
        isModule =YES;
        [self showAnimate];
        [self.popTblView reloadData];
    } else {
        self.popTblView.hidden = YES;
        isModule = NO;
        [self removeAnimate];
    }
    isTittle = NO;
    isTeam =NO;
}

-(IBAction)didClickTittle:(id)sender
{
    isplayerlist = NO;
    isPoPlist = YES;
    self.popviewyposition.constant = self.titleView.frame.origin.y;
    if(isTittle == NO)
    {
        commonArray = [[NSMutableArray alloc]init];
        commonArray = AssessmentTitleArray;
        self.popTblView.hidden = NO;
        isTittle =YES;
        [self showAnimate];
        [self.popTblView reloadData];
    } else {
        self.popTblView.hidden = YES;
        isTittle = NO;
        [self removeAnimate];
    }
    isModule = NO;
    isTeam =NO;
}

-(IBAction)didClickTeamAction:(id)sender
{
    isplayerlist = NO;
    isPoPlist = YES;
    self.popviewyposition.constant = self.teamView.frame.origin.y;
    if(isTeam == NO)
    {
        commonArray = [[NSMutableArray alloc]init];
        commonArray = TeamArray;
        self.popTblView.hidden =NO;
        isTeam =YES;
        [self showAnimate];
        [self.popTblView reloadData];
    } else {
        self.popTblView.hidden = YES;
        isTeam =NO;
        [self removeAnimate];
    }
    isTittle = NO;
    isModule =NO;
}

-(IBAction)didClickDate:(id)sender
{
    SACalendar *calendar = [[SACalendar alloc]initWithFrame:CGRectMake(self.frame.size.width/3,self.dateView.frame.origin.y+self.dateView.frame.size.height+5,self.dateView.frame.size.width+100,self.dateView.frame.size.height+200) scrollDirection:ScrollDirectionVertical pagingEnabled:NO];
    
    calendar.delegate = self;
    calendar.layer.cornerRadius = 5;
    calendar.layer.shadowOpacity = 0.8;
    calendar.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    [self addSubview:calendar];
}

-(void) SACalendar:(SACalendar*)calendar didSelectDate:(int)day month:(int)month year:(int)year
{
    NSString * selectdate =[NSString stringWithFormat:@"%d-%02d-%02d",year,month,day];
    
    self.datelbl.text = selectdate;
    //actualdate = selectdate;
    calendar.hidden = YES;
}

- (void)showAnimate
{
    self.popTblView.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.popTblView.alpha = 0;
    [UIView animateWithDuration:.25 animations:^{
        self.popTblView.alpha = 1;
        self.popTblView.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)removeAnimate
{
    [UIView animateWithDuration:.25 animations:^{
        self.popTblView.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.popTblView.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            // [self.popTblView removeFromSuperview];
            self.popTblView.hidden = YES;
        }
    }];
}

- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image);
                               } else{
                                   completionBlock(NO,nil);
                               }
                           }];
}

#pragma  mark Table DataSource Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(isPoPlist)
    {
        return  commonArray.count;
    }
    if(isplayerlist)
    {
        return _searchResult.count;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(isplayerlist)
    {
        return 55;
    } else {
        return 44;
    }
}

#pragma mark Table Delegate Methods
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(isplayerlist)
    {
        // cell.textLabel.text = [self.ExerciseTitle objectAtIndex:indexPath.row];
        static NSString * AssessmentCellIdentifier = @"AssessmentcellIdentifier";
        
        // init the CRTableViewCell
        AssessmentCell * cell = (AssessmentCell *)[tableView dequeueReusableCellWithIdentifier:AssessmentCellIdentifier];
        
        if (cell == nil) {
            cell = [[AssessmentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AssessmentCellIdentifier];
        }
        
        //self.selectedMarks = [[NSMutableArray alloc]init];
        cell.playername_lbl.text = [[_searchResult valueForKey:@"PlayerName"] objectAtIndex:indexPath.row];
        cell.title_lbl.text = [[_searchResult valueForKey:@"RecoveryStatus"] objectAtIndex:indexPath.row];
        NSLog(@"RecoveryStatus:%@", cell.title_lbl.text);
        NSString * imgStr1 = ([[_searchResult objectAtIndex:indexPath.row] valueForKey:@"playerPhoto"]==[NSNull null])?@"":[[_searchResult objectAtIndex:indexPath.row] valueForKey:@"playerPhoto"];
        
        
        [self downloadImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",URL_FOR_AssessmentPlayer,imgStr1]] completionBlock:^(BOOL succeeded, UIImage *image) {
            if (succeeded) {
                // change the image in the cell
                cell.player_Img.image = image;
                
                // cache the image for use later (when scrolling up)
                cell.player_Img.image = image;
            }
        }];
        
        return cell;
    }
    
    else
    {
        static NSString *CellIdentifier = @"CellIdentity";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(cell == nil){
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = [UIFont fontWithName:@"ArialMT" size:12];
            cell.textLabel.textColor=[UIColor blackColor];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            // [cell setBackgroundColor:[UIColor clearColor]];
        }
        
        //cell.imageView.image = [UIImage imageNamed:[thumbnails objectAtIndex:indexPath.row]];
        NSString * displayStr;
        if(isModule)
        {
            displayStr = [[commonArray valueForKey:@"ModuleName"] objectAtIndex:indexPath.row];
        }
        else if (isTeam)
        {
            displayStr = [[commonArray valueForKey:@"Teamname"] objectAtIndex:indexPath.row];
        }
        else if (isTittle)
        {
            displayStr = [[commonArray valueForKey:@"AssessmentName"] objectAtIndex:indexPath.row];
        }
        else
        {
            displayStr = [[commonArray valueForKey:@"PlayerName"] objectAtIndex:indexPath.row];
        }
        cell.textLabel.text=displayStr;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(isplayerlist)
    {
        //player tbl selection
        self.playerTxt.text = [[_searchResult valueForKey:@"PlayerName"] objectAtIndex:indexPath.row];
        [self.playerTxt resignFirstResponder];
        self.playerTbl.hidden = YES;
    } else {
        self.popTblView.hidden = YES;
        [self removeAnimate];
        if (isModule)
        {
            self.moduleLbl.text = [[commonArray valueForKey:@"ModuleName"] objectAtIndex:indexPath.row];
            //isModule =NO;
        }
        else if (isTittle) {
            
            self.titleLbl.text = [[commonArray valueForKey:@"AssessmentName"] objectAtIndex:indexPath.row];
            //isTittle =NO;
        }
        else if (isTeam)
        {
            self.teamLbl.text = [[commonArray valueForKey:@"Teamname"] objectAtIndex:indexPath.row];
            //isTittle =NO;
            
        }
    }
}

#pragma mark To Check Null Value
- (NSString *)checkNull:(NSString *)_value {
    if ([_value isEqual:[NSNull null]] || _value == nil) {
        _value = @"";
    }
    return _value;
}

-(void)SearchViewMethod
{
    self.searchResult = playerArray;
    dispatch_async(dispatch_get_main_queue(), ^{
        // Update the UI
        self.playerTbl.hidden = NO;
        [self.playerTbl reloadData];
    });
}

#pragma mark - Search delegate methods

- (void)filterContentForSearchText:(NSString*)searchText
{
    
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"PlayerName CONTAINS[c] %@", searchText];
    _searchResult = [playerArray filteredArrayUsingPredicate:resultPredicate];
    
    NSLog(@"searchResult:%@", _searchResult);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // Update the UI
        if (_searchResult.count == 0) {
            
        } else {
            isPoPlist = NO;
            isplayerlist = YES;
            isTeam = NO;
            isTittle = NO;
            isModule = NO;
            self.playerTbl.hidden = NO;
            [self.playerTbl reloadData];
        }
    });
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.playerTbl.hidden = NO;
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    self.playerTbl.hidden = NO;
    NSString *searchString = [NSString stringWithFormat:@"%@%@",textField.text, string];
    [self filterContentForSearchText:searchString];
    dispatch_async(dispatch_get_main_queue(), ^{
        // Update the UI
        [self.playerTbl reloadData];
    });
    return YES;
}

-(void)textFieldDidChange :(UITextField *) textField
{
    if (textField.text.length == 0) {
        _searchEnabled = NO;
        //        [textField resignFirstResponder];
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI
            self.playerTbl.hidden = NO;
            [self.playerTbl reloadData];
        });
    }
    else {
        _searchEnabled = YES;
        self.playerTbl.hidden = NO;
        [self filterContentForSearchText:textField.text];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //    [textField resignFirstResponder];
    _searchEnabled = YES;
    self.playerTbl.hidden = NO;
    [self filterContentForSearchText:textField.text];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    //    [textField setText:@""];
    _searchEnabled = NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        // Update the UI
        self.playerTbl.hidden = NO;
        [self.playerTbl reloadData];
    });
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    self.playerTbl.hidden = NO;
    [self.playerTbl reloadData];
    [textField resignFirstResponder];
}

@end

