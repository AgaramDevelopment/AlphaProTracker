//
//  BowlingLoad.m
//  AlphaProTracker
//
//  Created by Lexicon on 07/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "BowlingLoad.h"

#import "AppCommon.h"
#import "HomeVC.h"
#import "CustomNavigation.h"
#import "Config.h"
#import "WebService.h"


@interface BowlingLoad ()
{
    NSString * SelectClientCode;
    NSString * Selectteamcode;
    NSString * Selectplayercode;
    
    BOOL isdaily;
    BOOL isweekly;
    BOOL ismonthly;
    
    
}

@property (nonatomic,strong) IBOutlet NSMutableArray *arraylist;

@property (nonatomic,strong) IBOutlet NSMutableArray *dailylist;
@property (nonatomic,strong) IBOutlet NSMutableArray *weeklylist;
@property (nonatomic,strong) IBOutlet NSMutableArray *monthlylist;

@end

@implementation BowlingLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    [self profileWebservice:SelectClientCode :Selectteamcode:Selectplayercode];
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)profileWebservice :(NSString *) cliendcode :(NSString *) PlyCode :(NSString *) TmeCode
{
    //[COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",playerDetailsKey]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        
        NSString *cliendcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
        
        NSString *rolecode = [[NSUserDefaults standardUserDefaults]stringForKey:@"RoleCode"];
        
        NSString *usercode1 = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
        
        NSString *TmeCode;
        if( [rolecode isEqualToString:@"ROL0000002"] )
        {
            TmeCode = usercode1;
        }
        else
            
        {
            TmeCode = self.UserCode;
        }
        NSString * PlyCode = self.Playercode;
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(cliendcode)   [dic    setObject:cliendcode     forKey:@"Clientcode"];
        if(PlyCode)   [dic    setObject:PlyCode     forKey:@"PlayerCode"];
        if(TmeCode)   [dic    setObject:TmeCode     forKey:@"Usercode"];
        
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            if(responseObject >0)
            {
                
                
                self.dailylist = [[NSMutableArray alloc]init];
                self.dailylist = [responseObject valueForKey:@"lstBowlingLoadDaily"];
                
                self.weeklylist = [[NSMutableArray alloc]init];
                self.weeklylist = [responseObject valueForKey:@"lstBowlingLoadWeek"];
                
                self.monthlylist = [[NSMutableArray alloc]init];
                self.monthlylist = [responseObject valueForKey:@"lstBowlingLoadMonth"];
                
                
                
            }
            
            
            
            [self.DAILY sendActionsForControlEvents:UIControlEventTouchUpInside];
            [self.detailsTbl reloadData];
            
            //[COMMON RemoveLoadingIcon];
            [self.view setUserInteractionEnabled:YES];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed");
            [COMMON webServiceFailureError];
            [self.view setUserInteractionEnabled:YES];
            
        }];
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.arraylist.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *batCellIdentifier = @"cell";
    
    
    TrainingLoadCell  * cell = [tableView dequeueReusableCellWithIdentifier:batCellIdentifier];
    
    if (cell == nil) {
        if(IS_IPHONE_DEVICE)
        {
            [[NSBundle mainBundle] loadNibNamed:@"TrainingLoadCell" owner:self options:nil];
            
        }else{
            [[NSBundle mainBundle] loadNibNamed:@"TrainingLoadCell" owner:self options:nil];
            
        }
        cell = self.trload;
        
    }
    
    if(isdaily == YES)
    {
        cell.date.text = [[self.arraylist valueForKey:@"BLDailyDate"] objectAtIndex:indexPath.row];
        cell.value.text = [[self.arraylist valueForKey:@"BLDailyBallCount"] objectAtIndex:indexPath.row];
    }
    
    if(isweekly == YES)
    {
        cell.date.text = [[self.arraylist valueForKey:@"BLWeek"] objectAtIndex:indexPath.row];
        cell.value.text = [[self.arraylist valueForKey:@"BLWeekCount"] objectAtIndex:indexPath.row];
    }
    if(ismonthly == YES)
    {
        cell.date.text = [[self.arraylist valueForKey:@"BLMonth"] objectAtIndex:indexPath.row];
        cell.value.text = [[self.arraylist valueForKey:@"BLMonthBallCount"] objectAtIndex:indexPath.row];
    }
    
    
    
    return cell;
}
- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
{
    
    if(indexPath.row % 2 == 0)
        cell.backgroundColor = [UIColor whiteColor];
    else
        cell.backgroundColor = [UIColor colorWithRed:(209/255.0f) green:(220/255.0f) blue:(233/255.0f) alpha:1.0f];
    cell.layer.borderWidth = 0.3f;
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    return 30;
}

- (IBAction)DailyBtn:(id)sender {
    [self setInningsBySelection:@"1"];
    
    isdaily = YES;
    isweekly = NO;
    ismonthly = NO;
    
    self.arraylist = self.dailylist;
    [self.detailsTbl reloadData];
    
    
}
- (IBAction)WeeklyBtn:(id)sender {
    [self setInningsBySelection:@"2"];
    
    isdaily = NO;
    isweekly = YES;
    ismonthly = NO;
    self.arraylist = self.weeklylist;
    [self.detailsTbl reloadData];
    
}
- (IBAction)MonthlyBtn:(id)sender {
    [self setInningsBySelection:@"3"];
    
    isdaily = NO;
    isweekly = NO;
    ismonthly = YES;
    
    self.arraylist = self.monthlylist;
    [self.detailsTbl reloadData];
}
-(void) setInningsBySelection: (NSString*) innsNo{
    
    [self setInningsButtonUnselect:self.DAILY];
    [self setInningsButtonUnselect:self.WEEKLY];
    [self setInningsButtonUnselect:self.MONTHLY];
    
    if([innsNo isEqualToString:@"1"]){
        
        [self setInningsButtonSelect:self.DAILY];
        
    }else if([innsNo isEqualToString:@"2"]){
        
        [self setInningsButtonSelect:self.WEEKLY];
    }
    else if([innsNo isEqualToString:@"3"]){
        
        [self setInningsButtonSelect:self.MONTHLY];
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
    UIColor *extrasBrushBG = [self colorWithHexString : @"#0073FF"];
    
    innsBtn.layer.backgroundColor = extrasBrushBG.CGColor;
    
}

-(void) setInningsButtonUnselect : (UIButton*) innsBtn{
    //  innsBtn.layer.cornerRadius = 25;
    UIColor *extrasBrushBG = [self colorWithHexString : @"#FFFFFF"];
    
    innsBtn.layer.backgroundColor = extrasBrushBG.CGColor;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
