//
//  ViewProfile.m
//  AlphaProTracker
//
//  Created by Lexicon on 06/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "ViewProfile.h"
#import "AppCommon.h"
#import "HomeVC.h"
#import "CustomNavigation.h"
#import "Config.h"
#import "WebService.h"
#import "TrainingLoadCell.h"

@interface ViewProfile ()
{
    NSString * SelectClientCode;
    NSString * Selectteamcode;
    NSString * Selectplayercode;
    NSString * Selectusercode;
    
}
@property (nonatomic,strong) IBOutlet NSMutableArray *detailslist;
@end

@implementation ViewProfile

- (void)viewDidLoad {
    [super viewDidLoad];
    self.colorlbl.hidden = YES;
    [self profileWebservice:SelectClientCode :Selectteamcode:Selectplayercode:Selectusercode];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)profileWebservice :(NSString *) cliendcode :(NSString *) PlyCode :(NSString *) TmeCode :(NSString *) usercode
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
        
        NSString *usercode;
        if( [rolecode isEqualToString:@"ROL0000002"] )
        {
            usercode = usercode1;
        }
        else
            
        {
            usercode = self.UserCode;
        }
        
        
        
        NSString * PlyCode = self.Playercode;
        NSString * TmeCode = self.Teamcode;
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(cliendcode)   [dic    setObject:cliendcode     forKey:@"Clientcode"];
        if(PlyCode)   [dic    setObject:PlyCode     forKey:@"PlayerCode"];
        if(TmeCode)   [dic    setObject:TmeCode     forKey:@"TeamCode"];
        
        if(usercode)   [dic    setObject:usercode     forKey:@"Usercode"];
        
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            if(responseObject >0)
            {
                
                
                self.detailslist = [[NSMutableArray alloc]init];
                self.detailslist = [responseObject valueForKey:@"lstPlayerProfile"];
                if(self.detailslist.count>0)
                {
                    self.teamslbl.text = [[self.detailslist objectAtIndex:0] valueForKey:@"PlayerTeam"];
                    self.doblbl.text = [[self.detailslist objectAtIndex:0] valueForKey:@"PlayerDOB"];
                    self.heightlbl.text = [[self.detailslist objectAtIndex:0] valueForKey:@"PlayerHeight"];
                    self.weightlbl.text = [[self.detailslist objectAtIndex:0] valueForKey:@"PlayerWeight"];
                    self.nativelbl.text = [[self.detailslist objectAtIndex:0] valueForKey:@"PlayerBirthPlace"];
                    self.nationalitylbl.text = [[self.detailslist objectAtIndex:0] valueForKey:@"PlayerNationality"];
                    self.gameslbl.text = [[self.detailslist objectAtIndex:0] valueForKey:@"PlayerGame"];
                    
                }
                
            }
            NSLog(@"%@", self.detailslist);
            
            
            //[COMMON RemoveLoadingIcon];
            [self.view setUserInteractionEnabled:YES];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed");
            [COMMON webServiceFailureError];
            [self.view setUserInteractionEnabled:YES];
            
        }];
    }
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
