//
//  TrainingLoad.m
//  AlphaProTracker
//
//  Created by Lexicon on 07/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "TrainingLoad.h"
#import "AppCommon.h"
#import "HomeVC.h"
#import "CustomNavigation.h"
#import "Config.h"
#import "WebService.h"
#import "SummaryOfInjuries.h"


@interface TrainingLoad ()
{
    NSString * SelectClientCode;
    NSString * Selectteamcode;
    NSString * Selectplayercode;
    
    SummaryOfInjuries *objInjury;
    
}
@property (nonatomic,strong) IBOutlet NSMutableArray *traininglist;

@end

@implementation TrainingLoad

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
                
                
                self.traininglist = [[NSMutableArray alloc]init];
                self.traininglist = [responseObject valueForKey:@"lstPlayerDashBoardTR"];
                
            }
            
            
            
            NSLog(@"%@", self.traininglist);
            
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
    
    
    return self.traininglist.count;
    
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
    
    
    cell.date.text = [[self.traininglist valueForKey:@"trainingdate"] objectAtIndex:indexPath.row];
    cell.value.text = [[self.traininglist valueForKey:@"trainingrating"] objectAtIndex:indexPath.row];
    
    
    
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





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
