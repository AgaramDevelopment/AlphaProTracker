//
//  FoodDairyVC.m
//  AlphaProTracker
//
//  Created by Lexicon on 31/08/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "FoodDairyVC.h"
#import "CustomNavigation.h"
#import "HomeVC.h"
#import "AppCommon.h"
#import "WebService.h"
#import "Config.h"
#import "FoodDairy.h"
#import "AddFoodDiaryVC.h"
@interface FoodDairyVC ()
{
    WebService * objWebService;
    NSString * RoleCode;
    NSString * cliendcode;
    NSString * userref;
    NSString * selectGameCode;
    NSString * selectTeamCode;
    NSString* selectPlayerCode;
    
    UIDatePicker * datePicker;
    
    BOOL isGame;
    BOOL isTeam;
    BOOL isPlayer;
    BOOL isShowDetails;
    BOOL isDate;
    
    CustomNavigation * objCustomNavigation;
}
@property (nonatomic,strong) NSMutableArray * gameArray;
@property (nonatomic,strong) NSMutableArray * TeamArray;
@property (nonatomic,strong) NSMutableArray * PlayerArray;
@property (nonatomic,strong) NSMutableArray * commonArray;
@property (nonatomic,strong) NSMutableArray * fooddairyDetails;
@property (nonatomic,strong) NSMutableArray * MealsArray;



@property (nonatomic,strong) IBOutlet UITableView * popviewTbl;
@property (nonatomic,strong) IBOutlet UILabel * gameLbl;
@property (nonatomic,strong) IBOutlet UILabel * TeamLbl;
@property (nonatomic,strong) IBOutlet UILabel * playerLbl;
@property (strong, nonatomic) IBOutlet UITextField *datelbl;

//@property (nonatomic,strong) IBOutlet UILabel * datelbl;
@property (nonatomic,strong) IBOutlet UIView * mainGameView;
@property (nonatomic,strong) IBOutlet UIView * mainTeamView;
@property (nonatomic,strong) IBOutlet UIView * mainPlayerView;
@property (nonatomic,strong) IBOutlet UIView * maindateView;


@property (nonatomic,strong) IBOutlet NSLayoutConstraint * popviewYposition;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * popviewWidth;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * fooddiaryTblYposition;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * foodTblYposition;



@property (nonatomic,strong) IBOutlet UITableView * fooddetailTbl;

@property (nonatomic,strong) IBOutlet UIButton * addBtn;


@end

@implementation FoodDairyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //[COMMON AddMenuView:self.view];
    self.gameview.layer.borderWidth=0.5f;
    self.gameview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.teamview.layer.borderWidth=0.5f;
    self.teamview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.playerview.layer.borderWidth=0.5f;
    self.playerview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.daterview.layer.borderWidth=0.5f;
    self.daterview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    [self customnavigationmethod];
    
    self.popviewTbl.hidden =YES;
    

    
    RoleCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"RoleCode"];
    
    cliendcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    
    userref = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
    
    //Veeresh
    datePicker = [[UIDatePicker alloc] init];
    
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    
    //create left side empty space so that done button set on right side
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonAction)];
    
    //    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style: UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonAction)];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style: UIBarButtonItemStyleDone target:self action:@selector(doneButtonAction)];
    NSMutableArray *toolbarArray = [NSMutableArray new];
    [toolbarArray addObject:cancelBtn];
    [toolbarArray addObject:flexSpace];
    [toolbarArray addObject:doneBtn];
    
    [toolbar setItems:toolbarArray animated:false];
    [toolbar sizeToFit];
    
    //setting toolbar as inputAccessoryView
    self.datelbl.inputAccessoryView = toolbar;

    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
   
        [COMMON AddMenuView:self.view];
    
    if([RoleCode isEqualToString:@"ROL0000003"])
    {
//        self.addBtn.hidden=YES;
        objCustomNavigation.home_btn.hidden=YES;
        self.fooddiaryTblYposition.constant = self.daterview.frame.origin.y+5;
        self.maindateView.hidden =NO;
        self.mainPlayerView.hidden =NO;
        self.mainTeamView.hidden=NO;
        self.mainGameView.hidden=NO;
        
    }
    else{
        objCustomNavigation.home_btn.hidden=NO;
        
//        objCustomNavigation.home_btn.layer.cornerRadius =15;
//        objCustomNavigation.home_btn.layer.masksToBounds=YES;
//        objCustomNavigation.home_btn.layer.borderColor=[UIColor whiteColor].CGColor;
//        objCustomNavigation.home_btn.layer.borderWidth=1.0;
        
        self.maindateView.hidden =YES;
        self.mainGameView.hidden =YES;
        self.mainTeamView.hidden=YES;
        self.mainPlayerView.hidden=YES;
        self.fooddiaryTblYposition.constant = self.view.frame.origin.y-185;
        self.foodTblYposition.constant = self.fooddiaryTblYposition.constant+25;
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *comps = [NSDateComponents new];
        comps.day = -2;
        NSDate *sevenDays = [calendar dateByAddingComponents:comps toDate:[NSDate date] options:0];
        
        NSDateFormatter* dfs = [[NSDateFormatter alloc]init];
        [dfs setDateFormat:@"yyyy-MM-dd"];
        NSString * endDateStr = [dfs stringFromDate:sevenDays];
    }

    [self startFetchMetaDataService:cliendcode :userref :RoleCode];

}
-(void)customnavigationmethod
{
    
    
    
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"Food Diary";
    [objCustomNavigation.home_btn setImage:[UIImage imageNamed:@"ico_addWhite"]  forState:UIControlStateNormal];
     //objCustomNavigation.home_btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
    if([self.check isEqualToString:@"main"])
    {
        objCustomNavigation.btn_back.hidden =NO;
        objCustomNavigation.menu_btn.hidden =YES;
        [objCustomNavigation.btn_back addTarget:self action:@selector(didClickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
       // objCustomNavigation.btn_back.imageView.image = [UIImage imageNamed:@"ico_addWhite"];
        [objCustomNavigation.menu_btn addTarget:self action:@selector(MenuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [objCustomNavigation.home_btn addTarget:self action:@selector(didclickAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        objCustomNavigation.btn_back.hidden =YES;
        objCustomNavigation.menu_btn.hidden =NO;
        [objCustomNavigation.btn_back addTarget:self action:@selector(didClickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
        [objCustomNavigation.menu_btn addTarget:self action:@selector(MenuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [objCustomNavigation.home_btn addTarget:self action:@selector(didclickAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    }

    
//    objCustomNavigation.btn_back.hidden =YES;
//    objCustomNavigation.menu_btn.hidden = NO;
//    [objCustomNavigation.menu_btn addTarget:self action:@selector(MenuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void) doneButtonAction {

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.datelbl resignFirstResponder];
        [self.view endEditing:true];
        [self validation];
    });
}

-(void) cancelButtonAction {
    
    self.datelbl.text = @"";
    [self.datelbl resignFirstResponder];
    [self.view endEditing:true];
}


-(IBAction)didClickBackBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma Button action
-(IBAction)MenuBtnAction:(id)sender
{
    [COMMON ShowsideMenuView];
}

-(IBAction)HomeBtnAction:(id)sender
{
    HomeVC  * objTabVC=[[HomeVC alloc]init];
    objTabVC = (HomeVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
    [self.navigationController pushViewController:objTabVC animated:YES];

}

-(IBAction)didClickGameBtn:(id)sender
{
    if(isGame ==NO)
    {
        self.popviewTbl.hidden =NO;
        self.popviewYposition.constant =self.mainGameView.frame.origin.y-65;
        self.popviewWidth.constant =self.gameview.frame.size.width;
        
        self.commonArray =[[NSMutableArray alloc]init];
        
        NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc]init];
        [mutableDict setObject:@"" forKey:@"GAMECODE"];
        [mutableDict setObject:@"Select" forKey:@"GAMENAME"];
        
        [self.commonArray addObject:mutableDict];
        
        for(int i=0; self.gameArray.count>i;i++)
        {
            NSMutableDictionary * objDic =[self.gameArray objectAtIndex:i];
            [self.commonArray addObject:objDic];
        }
        
        
        // self.commonArray =self.TeamDetailArray;
        
        isGame=YES;
        isTeam =NO;
        isPlayer=NO;
        isShowDetails=NO;
        isDate =NO;
        [self.popviewTbl reloadData];
    }
    else{
        self.popviewTbl.hidden=YES;
        isGame =NO;
    }
    

}
-(IBAction)didClickTeamBtn:(id)sender
{
    if(isTeam ==NO)
    {
        self.popviewTbl.hidden =NO;
        self.popviewYposition.constant =self.mainTeamView.frame.origin.y-65;
        self.popviewWidth.constant =self.teamview.frame.size.width;
        
        self.commonArray =[[NSMutableArray alloc]init];
        
        NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc]init];
        [mutableDict setObject:@"" forKey:@"GAMECODE"];
        [mutableDict setObject:@"" forKey:@"TEAMCODE"];
        [mutableDict setObject:@"Select" forKey:@"TEAMNAME"];
        
        
        [self.commonArray addObject:mutableDict];
        
        for(int i=0; self.TeamArray.count>i;i++)
        {
            NSMutableDictionary * objDic =[self.TeamArray objectAtIndex:i];

            if([selectGameCode isEqualToString:[objDic valueForKey:@"GAMECODE"]])
            {
               [self.commonArray addObject:objDic];
            }
        }
        
        
        // self.commonArray =self.TeamDetailArray;
        
        
        isGame=NO;
        isTeam =YES;
        isPlayer=NO;
        isShowDetails=NO;
        isDate =NO;
        [self.popviewTbl reloadData];
    }
    else{
        self.popviewTbl.hidden=YES;
        isTeam =NO;
    }
    

}
-(IBAction)didClickPlayerBtn:(id)sender
{
    if(isPlayer ==NO)
    {
        self.popviewTbl.hidden =NO;
        self.popviewYposition.constant =self.mainPlayerView.frame.origin.y-60;
        self.popviewWidth.constant =self.playerview.frame.size.width;
        
        self.commonArray =[[NSMutableArray alloc]init];
        
        NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc]init];
        [mutableDict setObject:@"" forKey:@"ATHLETECODE"];
        [mutableDict setObject:@"" forKey:@"GAMECODE"];
        [mutableDict setObject:@"" forKey:@"TEAMCODE"];
        [mutableDict setObject:@"Select" forKey:@"ATHLETENAME"];
        
        
        [self.commonArray addObject:mutableDict];
        
        for(int i=0; self.PlayerArray.count>i;i++)
        {
            NSMutableDictionary * objDic =[self.PlayerArray objectAtIndex:i];
            if([selectGameCode isEqualToString:[objDic valueForKey:@"GAMECODE"]] && [selectTeamCode isEqualToString:[objDic valueForKey:@"TEAMCODE"]])
            {
              [self.commonArray addObject:objDic];
            }
        }
        
        
        // self.commonArray =self.TeamDetailArray;
        
        
        isGame=NO;
        isTeam =NO;
        isPlayer=YES;
        isShowDetails=NO;
        isDate =NO;
        [self.popviewTbl reloadData];
    }
    else{
        self.popviewTbl.hidden=YES;
        isPlayer =NO;
    }
    
}
-(IBAction)didClickDateBtn:(id)sender
{
//    isGame=NO;
//    isTeam =NO;
//    isPlayer=NO;rt
//    isShowDetails=NO;
//    isDate =YES;
    [self DisplaydatePicker];
}

-(void)DisplaydatePicker
{
    datePicker.datePickerMode = UIDatePickerModeDate;
    self.datelbl.inputView = datePicker;
    [datePicker addTarget:self action:@selector(datePickerDateValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.datelbl addTarget:self action:@selector(datePickerDateValueChanged:) forControlEvents:UIControlEventEditingDidBegin];
    [self.datelbl becomeFirstResponder];
    
    [datePicker reloadInputViews];
}


- (void) datePickerDateValueChanged:(UIDatePicker*)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //   2016-06-25 12:00:00
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [datePicker setLocale:locale];
    self.datelbl.text = [dateFormatter stringFromDate:[datePicker date]];
}

-(IBAction)showSelecteddate:(id)sender{
    
//    if(isDate==YES)
//    {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        NSDate *matchdate = [NSDate date];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        // for minimum date
        //[datePicker setMinimumDate:matchdate];
        
        // for maximumDate
        //int daysToAdd = 0;
        //NSDate *newDate1 = [matchdate dateByAddingTimeInterval:60*60*24*daysToAdd];
        
       // [datePicker setMaximumDate:newDate1];
        
        self.datelbl.text=[dateFormat stringFromDate:datePicker.date];
    
//    [self validation];
     //[self startFetchFoodDetailsService:selectPlayerCode :cliendcode :self.datelbl.text];
    
}
-(void)validation
{
    if([self.gameLbl.text isEqualToString:@"Select"] || [self.gameLbl.text isEqualToString:@""])
    {
        
    }
    else if ([self.TeamLbl.text isEqualToString:@"Select"] || [self.TeamLbl.text isEqualToString:@""])
    {
        
    }
    else if ([self.playerLbl.text isEqualToString:@"Select"] || [self.playerLbl.text isEqualToString:@""])
    {
        
    }
    else if ([self.datelbl.text isEqualToString:@"Select"] || [self.datelbl.text isEqualToString:@""])
    {
        
    }
    else
    {
        [self startFetchFoodDetailsService:selectPlayerCode :cliendcode :self.datelbl.text];

    }

}

-(void)startFetchMetaDataService:(NSString *)clientcode :(NSString *)playercode :(NSString *)rolecode
{
    [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",FetchInitfoodDiary]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(clientcode)   [dic    setObject:clientcode     forKey:@"CLIENTCODE"];
        if(playercode)   [dic    setObject:playercode     forKey:@"PLAYERCODE"];
        if(rolecode)   [dic    setObject:rolecode     forKey:@"ROLECODE"];
        
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {

                if([rolecode isEqualToString:@"ROL0000002"])
                {
                    self.MealsArray =[[NSMutableArray alloc]init];
                    self.fooddairyDetails =[[NSMutableArray alloc]init];
                    self.MealsArray  =[responseObject valueForKey:@"MEALS"];
                    self.fooddairyDetails =[responseObject valueForKey:@"FOODDIARYS"];
                    isShowDetails =YES;
                    [self.fooddetailTbl reloadData];

                }
                else{
                self.gameArray =[[NSMutableArray alloc]init];
                self.TeamArray =[[NSMutableArray alloc]init];
                self.PlayerArray =[[NSMutableArray alloc]init];
               

                self.gameArray =[responseObject valueForKey:@"GAMES"];
                self.TeamArray =[responseObject valueForKey:@"TEAMS"];
                self.PlayerArray =[responseObject valueForKey:@"PLAYERS"];
                


                self.gameLbl.text =@"Select";
                self.TeamLbl.text =@"Select";
                self.playerLbl.text =@"Select";
                    
                }
                
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

-(void)startFetchFoodDetailsService:(NSString *)playercoode :(NSString *)clientcode :(NSString *)date
{
    [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",FetchFooddetails]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(date)   [dic    setObject:date     forKey:@"DATE"];
        if(clientcode)   [dic    setObject:clientcode     forKey:@"CLIENTCODE"];
        if(playercoode)   [dic    setObject:playercoode     forKey:@"PLAYERCODE"];
        
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                NSLog(@"%@",responseObject);
                self.fooddairyDetails =[[NSMutableArray alloc]init];
                self.fooddairyDetails =[responseObject valueForKey:@"FOODDIARYS"];
                
                if(self.fooddairyDetails.count == 0)
                {
                    [self altermsg:@"No data Available"];
                }
                isShowDetails =YES;
                isPlayer =NO;
                isTeam =NO;
                isGame =NO;
                
                [self.fooddetailTbl reloadData];
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

-(void)altermsg:(NSString *) message
{
    UIAlertView * objaltert =[[UIAlertView alloc]initWithTitle:@"Food Diary" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [objaltert show];
}


#pragma Tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(isShowDetails==YES)
    {
        return [self.fooddairyDetails count];
    }
    else
    {
        return [self.commonArray count];
    }  //count number of row from counting array hear cataGorry is An Array
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(isShowDetails==YES)
    {
        return 40;
    } else if (tableView == self.popviewTbl)
    {
        return 60;
    }
    else
    {
        return 30;
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(isShowDetails==YES)
    {
        static NSString *CellIdentifier = @"FoodDairy";
        
        FoodDairy * objCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (objCell == nil)
        {
            [[NSBundle mainBundle] loadNibNamed:@"FoodDairy" owner:self options:nil];
            objCell = self.objFood;
        }
        
        objCell.datelbl.text =[[self.fooddairyDetails valueForKey:@"DATE"] objectAtIndex:indexPath.row];
        objCell.fromlbl.text =[[self.fooddairyDetails valueForKey:@"STARTTIME"] objectAtIndex:indexPath.row];
        objCell.tolbl.text= [[self.fooddairyDetails valueForKey:@"ENDTIME"] objectAtIndex:indexPath.row];
        objCell.mealslbl.text =[[self.fooddairyDetails valueForKey:@"MEALNAME"] objectAtIndex:indexPath.row];
        objCell.backgroundColor = [UIColor clearColor];
        objCell.selectionStyle=UITableViewCellSelectionStyleNone;
        return objCell;
    }
    else{
        static NSString *MyIdentifier = @"MyIdentifier";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:MyIdentifier];
        }
        
        if(isGame)
        {
            cell.textLabel.text = [[self.commonArray valueForKey:@"GAMENAME"] objectAtIndex:indexPath.row];
        }
        else if (isTeam)
        {
            cell.textLabel.numberOfLines = 2;
            cell.textLabel.text = [[self.commonArray valueForKey:@"TEAMNAME"] objectAtIndex:indexPath.row];
            
        }
        else if (isPlayer)
        {
            cell.textLabel.numberOfLines = 2;
            cell.textLabel.text = [[self.commonArray valueForKey:@"ATHLETENAME"] objectAtIndex:indexPath.row];
            
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(isGame)
    {
        self.gameLbl.text =[[self.commonArray valueForKey:@"GAMENAME"] objectAtIndex:indexPath.row];
        selectGameCode =[[self.commonArray valueForKey:@"GAMECODE"] objectAtIndex:indexPath.row];
    }
    else if (isTeam)
    {
        self.TeamLbl.text =[[self.commonArray valueForKey:@"TEAMNAME"] objectAtIndex:indexPath.row];
        selectTeamCode =[[self.commonArray valueForKey:@"TEAMCODE"] objectAtIndex:indexPath.row];
    }
    else if (isPlayer)
    {
        
        self.playerLbl.text =[[self.commonArray valueForKey:@"ATHLETENAME"] objectAtIndex:indexPath.row];
        selectPlayerCode =[[self.commonArray valueForKey:@"ATHLETECODE"] objectAtIndex:indexPath.row];
       // [self startFetchTeamByParticipantType:selectParticipantType];
    }
    else if (isShowDetails)
    {
        AddFoodDiaryVC  * objaddFooddiary=[[AddFoodDiaryVC alloc]init];
        objaddFooddiary = (AddFoodDiaryVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"AddFoodDiary"];
        if([RoleCode isEqualToString:@"ROL0000002"])
        {
            objaddFooddiary.mealsArray =self.MealsArray;
            objaddFooddiary.fooddiarydetailDic =[self.fooddairyDetails objectAtIndex:indexPath.row];

            objaddFooddiary.Isupdate =YES;
        }
        else
        {
       
        objaddFooddiary.fooddiarydetailDic =[self.fooddairyDetails objectAtIndex:indexPath.row];
            objaddFooddiary.Isupdate =NO;

        }
        [self.navigationController pushViewController:objaddFooddiary animated:YES];

    }
    [self validation];
    self.popviewTbl.hidden =YES;
    
}

-(IBAction)didclickAddBtn:(id)sender
{
    AddFoodDiaryVC  * objaddFooddiary=[[AddFoodDiaryVC alloc]init];
    objaddFooddiary = (AddFoodDiaryVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"AddFoodDiary"];
    objaddFooddiary.Isupdate =NO;
    objaddFooddiary.mealsArray =self.MealsArray;
    objaddFooddiary.key=@"add";
    [self.navigationController pushViewController:objaddFooddiary animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
