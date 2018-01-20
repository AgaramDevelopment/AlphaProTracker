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
#import "PopViewCell.h"
#import "DBAConnection.h"
#import "WebService.h"
@implementation AssessmentFilterView
{
    NSMutableArray * ModuleArray;
    NSMutableArray * TeamArray;
    NSMutableArray * playerArray;
    NSMutableArray * commonArray;
    NSMutableArray * FetchAssessTitleArray;
    WebService * objWebService;
    
    BOOL isModule;
    BOOL isTittle;
    BOOL isTeam;
    BOOL isPoPlist;
    BOOL isplayerlist;
    BOOL isDatePicker;
    SACalendar *calendar;
}


@synthesize popTblView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSLog(@"Initial");
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
    [self datePickermethod];
    [self allviewSetborder];
    [self moduleWebservice];
//    objWebService=[[WebService alloc]init];
//
//    [self GetAssessmentTitleMethod];
    calendar.hidden = YES;
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
-(void)GetAssessmentTitleMethod
{
    
    DBAConnection *Db = [[DBAConnection alloc]init];
    NSString *clientCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    NSString *userCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
    
    
    _AssessmentTitleArray = [[NSMutableArray alloc]init];
    _AssessmentTitleArray =  [Db AssessmentTestType:clientCode :userCode :self.moduleStr ];
    
//    NSLog(@"%@", myNewDouble);
    
    
//
//    assmntCodeArray = [[NSMutableArray alloc]init];
//
//    for(int i=0;i<myNewDouble.count;i++)
//    {
//        NSString * name = [[myNewDouble valueForKey:@"AssessmentName"] objectAtIndex:i];
//        NSString * assesmentCode = [[myNewDouble valueForKey:@"AssessmentCode"] objectAtIndex:i];
//        NSLog(@"%@", name);
//        //NSDictionary * assessmentDic = [[NSDictionary alloc]init];
//        [aslist addObject:name];
//        [assmntCodeArray addObject:assesmentCode];
//    }
//
//    //[self.New sendActionsForControlEvents:UIControlEventTouchUpInside];
//    poplistArray = aslist;
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
        if([AppCommon GetUsercode])   [dic    setObject:@"USM0000002"     forKey:@"Createdby"];
        if([AppCommon GetClientCode])   [dic    setObject:@"CLI0000001"     forKey:@"Clientcode"];
        if([AppCommon GetUsercode])   [dic    setObject:@"USM0000002"     forKey:@"Modifiedby"];
        if([AppCommon GetuserReference])   [dic    setObject:@"AMR0000001"    forKey:@"Userreferencecode"];


        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);

            if(responseObject >0)
            {
                NSLog(@"%@",responseObject);
                ModuleArray = [[NSMutableArray alloc]init];
//                AssessmentTitleArray = [[NSMutableArray alloc]init];
//                TeamArray = [[NSMutableArray alloc]init];
//                playerArray = [[NSMutableArray alloc]init];


                //FetchModule
                NSMutableArray * objmoduleArray= [responseObject valueForKey:@"lstAssessmentEntryModule"];
                NSMutableDictionary * moduleDict = [[NSMutableDictionary alloc]init];
                [moduleDict setObject:@"" forKey:@"Module"];
                [moduleDict setObject:@"All Module" forKey:@"ModuleName"];
                [ModuleArray addObject:moduleDict];

                //FetchTeamArray
//                NSMutableArray * objTeamArray= [responseObject valueForKey:@"lstAssessmentEntryTeam"];
//                NSMutableDictionary * teamDict = [[NSMutableDictionary alloc]init];
//                [teamDict setObject:@"" forKey:@"Teamcode"];
//                [teamDict setObject:@"All Team" forKey:@"Teamname"];
//                [TeamArray addObject:teamDict];

                //FetchAssessment

//                NSMutableArray * objAssessmentArray= [responseObject valueForKey:@"lstAssessmentEntryAssessment"];
//                NSMutableDictionary * AssessmentDict = [[NSMutableDictionary alloc]init];
//                [AssessmentDict setObject:@"" forKey:@"Assessment"];
//                [AssessmentDict setObject:@"All Assessment" forKey:@"AssessmentName"];
//                [AssessmentTitleArray addObject:AssessmentDict];

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

//                for(int i=0; objTeamArray.count>i;i++)
//                {
//                    NSMutableDictionary * objDic = [[NSMutableDictionary alloc]init];
//                    NSString * teamCodeStr = [self checkNull:[[objTeamArray valueForKey:@"Teamcode"] objectAtIndex:i]];
//                    NSString * teamnameStr = [self checkNull:[[objTeamArray valueForKey:@"Teamname"] objectAtIndex:i]];
//                    [objDic setObject:teamCodeStr forKey:@"Teamcode"];
//                    [objDic setObject:teamnameStr forKey:@"Teamname"];
//
//                    [TeamArray addObject:objDic];
//                }

//                for(int i=0; objAssessmentArray.count>i;i++)
//                {
//                    NSMutableDictionary * objDic = [[NSMutableDictionary alloc]init];
//
//                    NSString * moduleCodeStr = [self checkNull:[[objAssessmentArray valueForKey:@"Module"] objectAtIndex:i]];
//
//                    NSString * modulenameStr = [self checkNull:[[objAssessmentArray valueForKey:@"ModuleName"] objectAtIndex:i]];
//
//                    NSString * teamCodeStr = [self checkNull:[[objAssessmentArray valueForKey:@"Assessment"] objectAtIndex:i]];
//                    NSString * teamnameStr = [self checkNull:[[objAssessmentArray valueForKey:@"AssessmentName"] objectAtIndex:i]];
//
//                    [objDic setObject:moduleCodeStr forKey:@"Module"];
//                    [objDic setObject:modulenameStr forKey:@"ModuleName"];
//                    [objDic setObject:teamCodeStr forKey:@"Assessment"];
//                    [objDic setObject:teamnameStr forKey:@"AssessmentName"];
//
//                    [AssessmentTitleArray addObject:objDic];
//                }

//                for(int i=0; objPlayerArray.count>i;i++)
//                {
//                    NSMutableDictionary * objDic = [[NSMutableDictionary alloc]init];
//                    NSString * teamCodeStr = [self checkNull:[[objPlayerArray valueForKey:@"Player"] objectAtIndex:i]];
//                    NSString * teamnameStr = [self checkNull:[[objPlayerArray valueForKey:@"PlayerName"] objectAtIndex:i]];
//                    NSString * recoverystatus = [self checkNull:[[objPlayerArray valueForKey:@"RecoveryStatus"] objectAtIndex:i]];
//                    NSString * playerphoto = [self checkNull:[[objPlayerArray valueForKey:@"playerPhoto"] objectAtIndex:i]];
//                    NSString * colorcode   = [self checkNull:[[objPlayerArray valueForKey:@"StatusColor"] objectAtIndex:i]];
//                    [objDic setObject:teamCodeStr forKey:@"Player"];
//                    [objDic setObject:teamnameStr forKey:@"PlayerName"];
//                    [objDic setObject:recoverystatus forKey:@"RecoveryStatus"];
//                    [objDic setObject:playerphoto forKey:@"playerPhoto"];
//                    [objDic setObject:colorcode forKey:@"StatusColor"];
//
//                    [playerArray addObject:objDic];
//                }
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
    self.popviewXposition.constant = self.moduleView.frame.origin.x;
    self.popviewWidth.constant = self.moduleView.frame.size.width;

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
    calendar.hidden=YES;
    isDatePicker=NO;
}

-(IBAction)didClickTittle:(id)sender
{
    isplayerlist = NO;
    isPoPlist = YES;
    self.popviewyposition.constant = self.titleView.frame.origin.y;
    self.popviewWidth.constant = self.titleView.frame.size.width;
    self.popviewXposition.constant = self.titleView.frame.origin.x;
    

    if(isTittle == NO)
    {
        commonArray = [[NSMutableArray alloc]init];
        commonArray = self.AssessmentTitleArray;
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
    calendar.hidden =YES;
    isDatePicker=NO;
}

-(IBAction)didClickTeamAction:(id)sender
{
    isplayerlist = NO;
    isPoPlist = YES;
    self.popviewyposition.constant = self.teamView.frame.origin.y;
    self.popviewXposition.constant = self.teamView.frame.origin.x;
    self.popviewWidth.constant =  self.teamView.frame.size.width;

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
    isDatePicker=NO;
    calendar.hidden = YES;
}
-(void)datePickermethod
{
    calendar = [[SACalendar alloc]initWithFrame:CGRectMake(self.dateView.frame.origin.x,self.dateView.frame.origin.y+self.dateView.frame.size.height+5,self.frame.size.width,self.dateView.frame.size.height+210) scrollDirection:ScrollDirectionVertical pagingEnabled:NO];
    
    calendar.delegate = self;
    calendar.layer.shadowOpacity = 0.8;
    calendar.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    calendar.layer.cornerRadius = 8;
    calendar.layer.masksToBounds = YES;
    calendar.layer.borderColor = [UIColor lightTextColor].CGColor;
    calendar.layer.borderWidth = 1;
    [self addSubview:calendar];
}

-(IBAction)didClickDate:(id)sender
{
    
    if(isDatePicker==NO)
    {
     calendar.transform = CGAffineTransformMakeScale(1.3, 1.3);
     calendar.alpha = 0;
     [UIView animateWithDuration:.25 animations:^{
        calendar.alpha = 1;
        calendar.transform = CGAffineTransformMakeScale(1, 1);
         isDatePicker=YES;
        
         calendar.hidden = NO;
    }];
    }
    else
    {
        [UIView animateWithDuration:.25 animations:^{
            calendar.transform = CGAffineTransformMakeScale(1.3, 1.3);
            calendar.alpha = 0.0;;
            
        } completion:^(BOOL finished) {
            if (finished) {
                // [self.popTblView removeFromSuperview];
                calendar.hidden = YES;
                isDatePicker=NO;
            }
        }];
    }
     isTeam = NO;
    isTittle = NO;
    isModule = NO;
    self.popTblView.hidden=YES;
}

-(void) SACalendar:(SACalendar*)calendar didSelectDate:(int)day month:(int)month year:(int)year
{
    NSString * selectdate =[NSString stringWithFormat:@"%d-%02d-%02d",year,month,day];
    
    self.datelbl.text = selectdate;
   
    [UIView animateWithDuration:.25 animations:^{
        calendar.transform = CGAffineTransformMakeScale(1.3, 1.3);
       
        calendar.alpha = 0.0;;

    } completion:^(BOOL finished) {
        if (finished) {
            // [self.popTblView removeFromSuperview];
            calendar.hidden = YES;
        }
    }];
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
        return playerArray.count;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(isplayerlist)
    {
        return 70;
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
        cell.playername_lbl.text = [[playerArray valueForKey:@"PLAYERNAME"] objectAtIndex:indexPath.row];
        //cell.title_lbl.text = [[playerArray valueForKey:@"RecoveryStatus"] objectAtIndex:indexPath.row];
        NSLog(@"RecoveryStatus:%@", cell.title_lbl.text);
//        NSString * imgStr1 = ([[playerArray objectAtIndex:indexPath.row] valueForKey:@"playerPhoto"]==[NSNull null])?@"":[[playerArray objectAtIndex:indexPath.row] valueForKey:@"playerPhoto"];
//        
//        
//        [self downloadImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",URL_FOR_AssessmentPlayer,imgStr1]] completionBlock:^(BOOL succeeded, UIImage *image) {
//            if (succeeded) {
//                // change the image in the cell
//                cell.player_Img.image = image;
//                
//                // cache the image for use later (when scrolling up)
//                cell.player_Img.image = image;
//            }
//        }];
        
        return cell;
    }
    
    else
    {
        static NSString *CellIdentifier = @"popCell";
        PopViewCell *cell = (PopViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(cell == nil){
            
            cell = [[PopViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.textLabel.font = [UIFont fontWithName:@"ArialMT" size:12];
//            cell.textLabel.textColor=[UIColor blackColor];
//            cell.textLabel.textAlignment = NSTextAlignmentCenter;
//            // [cell setBackgroundColor:[UIColor clearColor]];
        }
        
        //cell.imageView.image = [UIImage imageNamed:[thumbnails objectAtIndex:indexPath.row]];
        NSString * displayStr;
        if(isModule)
        {
            displayStr = [[commonArray valueForKey:@"ModuleName"] objectAtIndex:indexPath.row];
        }
        else if (isTeam)
        {
            displayStr = [[commonArray valueForKey:@"TeamName"] objectAtIndex:indexPath.row];
        }
        else if (isTittle)
        {
            displayStr = [[commonArray valueForKey:@"AssessmentName"] objectAtIndex:indexPath.row];
        }
        else if(isplayerlist)
        {
            displayStr = [[commonArray valueForKey:@"PLAYERNAME"] objectAtIndex:indexPath.row];
        }
        cell.popNameLbl.text=displayStr;
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
            NSString * moduleCode =  [[commonArray valueForKey:@"Module"] objectAtIndex:indexPath.row];
            //isModule =NO;
//            FetchAssessTitleArray = [[NSMutableArray alloc]init];
//            for(int i=0; i<_AssessmentTitleArray.count; i++)
//            {
//                NSDictionary * objDic = [_AssessmentTitleArray objectAtIndex:i];
//                if([[objDic valueForKey:@"Module"] isEqualToString:moduleCode])
//                {
//                    [FetchAssessTitleArray addObject:objDic];
//                }
//            }
            
            
        }
        else if (isTittle) {
            
            self.titleLbl.text = [[commonArray valueForKey:@"AssessmentName"] objectAtIndex:indexPath.row];
            
            
            NSString *membercode = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
            DBAConnection *Db = [[DBAConnection alloc]init];
            
            TeamArray = [[NSMutableArray alloc]init];
            TeamArray =  [Db AssessmentTeamListDetail:membercode];
            
            
            
            //isTittle =NO;
        }
        else if (isTeam)
        {
            self.teamLbl.text = [[commonArray valueForKey:@"TeamName"] objectAtIndex:indexPath.row];
            NSString *userref = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
            NSString *clientcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];

            DBAConnection *Db = [[DBAConnection alloc]init];

            playerArray = [[NSMutableArray alloc]init];
            playerArray =  [Db AssessmentPlayerListDetail:userref:clientcode];
            isplayerlist =YES;
            [self.playerTbl reloadData];
            
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

