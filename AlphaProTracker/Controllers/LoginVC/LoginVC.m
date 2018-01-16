//
//  LoginVC.m
//  AlphaProTracker
//
//  Created by Lexicon on 22/08/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "LoginVC.h"
#import "WebService.h"
#import "AppCommon.h"
#import "Config.h"
#import "HomeVC.h"
#import "PlayerVC.h"






@interface LoginVC ()<UITextFieldDelegate>
{
    WebService * objWebservice;
    PlayerVC *objpalyer;
    
}
@property (weak,nonatomic)  IBOutlet UIView *commonview;
@property (weak,nonatomic)  IBOutlet UIView *usernameview;
@property (weak,nonatomic)  IBOutlet UIView *passwordview;

@property (weak,nonatomic)  IBOutlet UITextField *userTxt;
@property (weak,nonatomic) IBOutlet UITextField * passwordTxt;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * commonViewHeight;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * usernameyposition;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * paswordyposition;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * signBtnyposition;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * liftsidewidth;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * rightsidewidth;

@end



@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.passwordTxt.secureTextEntry=YES;
    //self.swt.transform = CGAffineTransformMakeScale(0.75, 0.60);
    
    objWebservice=[[WebService alloc]init];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    if(!IS_IPHONE_DEVICE)
    {
        self.commonViewHeight.constant =self.view.frame.size.height/2;
        self.liftsidewidth.constant    =self.view.frame.size.width/7;
        self.rightsidewidth.constant  =self.view.frame.size.width/7;
        self.usernameyposition.constant =self.commonview.frame.size.height/4;
        self.paswordyposition.constant  =self.usernameview.frame.origin.y+5;
        self.signBtnyposition.constant  =self.passwordview.frame.origin.y-30;
    }
}
-(IBAction)didClickSubmitBtnAction:(id)sender
{
    
    [self validation];
    
    objpalyer.selectPlayerimg = [[NSUserDefaults standardUserDefaults]stringForKey:@"PhotoPath"];
}
-(void)validation
{
    if([self.userTxt.text isEqualToString:@""] || self.userTxt.text==nil)
    {
        [self ShowAlterMsg:@"Please Enter UserName"];
    }
    else if ([self.passwordTxt.text isEqualToString:@""] || self.passwordTxt.text==nil)
    {
        [self ShowAlterMsg:@"Please Enter Password"];
    }
    else
    {
        //[COMMON loadingIcon:self.view];
        [self LoginWebservice:self.userTxt.text:self.passwordTxt.text];
    }
}

-(void)ShowAlterMsg:(NSString*) MsgStr
{
    UIAlertView *objAlter =[[UIAlertView alloc]initWithTitle:@"Login" message:MsgStr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [objAlter show];
    
}

-(void)LoginWebservice :(NSString *) username :(NSString *) password
{
    [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",LoginKey]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(username)   [dic    setObject:username     forKey:@"username"];
        if(password)   [dic    setObject:password     forKey:@"password"];
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if([[responseObject valueForKey:@"Status"] isEqualToString:@"PSUCCESS"])
            {
                NSDictionary * objRole =[responseObject valueForKey:@"Roles"];
                
                NSString * objRoleCode =[[objRole valueForKey:@"Rolecode"] objectAtIndex:0];
                
                NSString * objRoleName =[[objRole valueForKey:@"RoleName"] objectAtIndex:0];
                [[NSUserDefaults standardUserDefaults] setObject:[responseObject valueForKey:@"UserCode"] forKey:@"UserCode"];
                [[NSUserDefaults standardUserDefaults] setObject:[responseObject valueForKey:@"ClientCode"] forKey:@"ClientCode"];
                
                [[NSUserDefaults standardUserDefaults] setObject:[responseObject valueForKey:@"Userreferencecode"] forKey:@"Userreferencecode"];
                
                [[NSUserDefaults standardUserDefaults] setObject:[responseObject valueForKey:@"Username"] forKey:@"Username"];
                
                [[NSUserDefaults standardUserDefaults] setObject:[responseObject valueForKey:@"PhotoPath"] forKey:@"PhotoPath"];
                [[NSUserDefaults standardUserDefaults] setObject:objRoleName forKey:@"RoleName"];
                
                [[NSUserDefaults standardUserDefaults] setObject:objRoleCode forKey:@"RoleCode"];
                
                [[NSUserDefaults standardUserDefaults] synchronize];

                
                HomeVC  * objTabVC=[[HomeVC alloc]init];
                objTabVC = (HomeVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
                [self.navigationController pushViewController:objTabVC animated:YES];
            }
            else{
                [self ShowAlterMsg:@"Invalid Login "];
                [COMMON RemoveLoadingIcon];
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

- (IBAction)switchAction:(id)sender {
    
    UISwitch *mySwitch = (UISwitch *)sender;
    
    if ([mySwitch isOn]) {
        
        self.passwordTxt.secureTextEntry=NO;
        
        [self.swt setThumbTintColor:[UIColor colorWithRed: (27/255.0f)  green:(25/255.0f) blue:(68/255.0f) alpha:1.0f]];
        [self.swt setOnTintColor:[UIColor colorWithRed: (164/255.0f)  green:(179/255.0f) blue:(184/255.0f) alpha:1.0f]];
        
        NSLog(@"ON");
        
    } else {
        
        self.passwordTxt.secureTextEntry=YES;
        
        [self.swt setThumbTintColor:[UIColor colorWithRed: (128/255.0f)  green:(128/255.0f) blue:(128/255.0f) alpha:0.3f]];
        [self.swt setOnTintColor:[UIColor colorWithRed: (164/255.0f)  green:(179/255.0f) blue:(184/255.0f) alpha:1.0f]];
        
        NSLog(@"Off");
        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
