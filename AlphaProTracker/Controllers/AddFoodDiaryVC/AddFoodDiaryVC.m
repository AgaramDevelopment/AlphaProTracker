//
//  AddFoodDiaryVC.m
//  AlphaProTracker
//
//  Created by Mac on 18/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "AddFoodDiaryVC.h"
#import "CustomNavigation.h"
#import "AppCommon.h"
#import "WebService.h"
#import "Config.h"

@interface AddFoodDiaryVC ()
{
    NSString * RoleCode;
    UIDatePicker * datePicker;
    NSString * cliendcode;
    NSString * usercode;
    NSString * selectMealsCode;
    NSString * playerCode;
    WebService * objWebservice;
    BOOL isStartTime;
    BOOL isDate;
    NSComparisonResult result;
}
@property (nonatomic,strong) IBOutlet UIView * dateview ;
@property (nonatomic,strong) IBOutlet UIView * startTimeview ;
@property (nonatomic,strong) IBOutlet UIView * endTimeview ;
@property (nonatomic,strong) IBOutlet UIView * mealsview ;
@property (nonatomic,strong) IBOutlet UIView * foodsizeview ;
@property (nonatomic,strong) IBOutlet UIView * fooddetailiew ;
@property (strong, nonatomic) IBOutlet UITextField *datelbl;
@property (strong, nonatomic) IBOutlet UITextField *starttimelbl;
@property (strong, nonatomic) IBOutlet UITextField *endTimelbl;

@property (nonatomic,strong) IBOutlet UILabel * mealslbl ;
@property (nonatomic,strong) IBOutlet UITextView * foodsizeTxv  ;
@property (nonatomic,strong) IBOutlet UITextView * fooddetailTxv  ;

@property (nonatomic,strong) IBOutlet UIButton * saveBtn  ;
@property (nonatomic,strong) IBOutlet UIButton * deleteBtn  ;
@property (nonatomic,strong) IBOutlet UIButton * updateBtn  ;

@property (nonatomic,strong) IBOutlet UIButton * dateBtn;
@property (nonatomic,strong) IBOutlet UIButton * starttimeBtn;
@property (nonatomic,strong) IBOutlet UIButton * endtimeBtn;
@property (nonatomic,strong) IBOutlet UIButton * mealsBtn;


@property (nonatomic,strong) NSMutableArray  * mealsListArray;



@end

@implementation AddFoodDiaryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customnavigationmethod];
    [self designViewMethod];
    objWebservice =[[WebService alloc]init];

    self.popviewTbl.hidden=YES;
    RoleCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"RoleCode"];
    cliendcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    usercode = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
    playerCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];

    //Veeresh
    datePicker = [[UIDatePicker alloc] init];

//    self.datelbl.tintColor = [UIColor clearColor];
//    self.starttimelbl.tintColor = [UIColor clearColor];
//    self.endTimelbl.tintColor = [UIColor clearColor];
    
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
    self.starttimelbl.inputAccessoryView = toolbar;
    self.endTimelbl.inputAccessoryView = toolbar;
    

    if([self.key isEqualToString:@"add"])
    {
//        self.datelbl.text= @"";
//        self.starttimelbl.text = @"";
//        self.endTimelbl.text =@"";
//        self.mealslbl.text =@"" ;
//        self.foodsizeTxv.text =@"";
//        self.fooddetailTxv.text=@"";
    }
    else
    {
    self.datelbl.text= [self.fooddiarydetailDic valueForKey:@"DATE"];
    self.starttimelbl.text = [self.fooddiarydetailDic valueForKey:@"STARTTIME"];
    self.endTimelbl.text =[self.fooddiarydetailDic valueForKey:@"ENDTIME"] ;
    self.mealslbl.text =[self.fooddiarydetailDic valueForKey:@"MEALNAME"] ;
    self.foodsizeTxv.text =[self.fooddiarydetailDic valueForKey:@"FOOD"];
    self.fooddetailTxv.text=[self.fooddiarydetailDic valueForKey:@"LOCATION"];
    selectMealsCode  =[self.fooddiarydetailDic valueForKey:@"MEALCODE"];
    }
    if([RoleCode isEqualToString:@"ROL0000003"])
    {
        

        self.saveBtn.hidden=YES;
        self.deleteBtn.hidden=YES;
        self.updateBtn.hidden=YES;
        self.mealsBtn.userInteractionEnabled=NO;
        self.fooddetailTxv.userInteractionEnabled=NO;
        self.foodsizeTxv.userInteractionEnabled=NO;
        self.dateBtn.userInteractionEnabled =NO;
        self.datelbl.userInteractionEnabled = NO;
        self.starttimeBtn.userInteractionEnabled=NO;
        self.starttimelbl.userInteractionEnabled = NO;
        self.endtimeBtn.userInteractionEnabled=NO;
        self.endTimelbl.userInteractionEnabled = NO;
        self.scrollView.scrollEnabled = NO;
    
    
    }
    else{
        if(_Isupdate ==YES)
        {
            self.saveBtn.hidden=YES;
            self.deleteBtn.hidden=NO;
            self.updateBtn.hidden=NO;
            self.scrollView.scrollEnabled = YES;
        }
        else{
            self.saveBtn.hidden=NO;
            self.deleteBtn.hidden=YES;
            self.updateBtn.hidden=YES;
            self.scrollView.scrollEnabled = YES;
        }
        
        self.mealsBtn.userInteractionEnabled=YES;
        self.fooddetailTxv.userInteractionEnabled=YES;
        self.foodsizeTxv.userInteractionEnabled=YES;
        self.dateBtn.userInteractionEnabled =YES;
        self.starttimeBtn.userInteractionEnabled=YES;
        self.endtimeBtn.userInteractionEnabled=YES;
        self.mealsListArray=[[NSMutableArray alloc]init];
        self.mealsListArray = self.mealsArray;
        
    }
}
-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    
    
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@" View Food Diary";
    objCustomNavigation.btn_back.hidden =NO;
    objCustomNavigation.menu_btn.hidden = YES;
    objCustomNavigation.home_btn.hidden =YES;
    [objCustomNavigation.btn_back addTarget:self action:@selector(BackBtn:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void) doneButtonAction {
    [self.view endEditing:true];
}

-(void) cancelButtonAction {
    if(isDate==YES) {
        self.datelbl.text = @"";
        [self.datelbl resignFirstResponder];
    } else if(isStartTime==YES) {
        self.starttimelbl.text = @"";
        [self.starttimelbl resignFirstResponder];
    } else {
        self.endTimelbl.text = @"";
        [self.endTimelbl resignFirstResponder];
    }
    [self.view endEditing:true];
}

-(void)designViewMethod
{
    self.dateview.layer.borderColor=[UIColor whiteColor].CGColor;
    self.dateview.layer.borderWidth=0.5;
    
    self.startTimeview.layer.borderColor=[UIColor whiteColor].CGColor;
    self.startTimeview.layer.borderWidth=0.5;
    
    self.endTimeview.layer.borderColor=[UIColor whiteColor].CGColor;
    self.endTimeview.layer.borderWidth=0.5;
    
    self.mealsview.layer.borderColor=[UIColor whiteColor].CGColor;
    self.mealsview.layer.borderWidth=0.5;
    
    self.foodsizeview.layer.borderColor=[UIColor whiteColor].CGColor;
    self.foodsizeview.layer.borderWidth=0.5;
    
    self.fooddetailiew.layer.borderColor=[UIColor whiteColor].CGColor;
    self.fooddetailiew.layer.borderWidth=0.5;

}
-(void)DisplaydatePicker
{
    datePicker.datePickerMode = UIDatePickerModeDate;
    self.datelbl.inputView = datePicker;
    [datePicker addTarget:self action:@selector(displaySelectedDateAndTime:) forControlEvents:UIControlEventValueChanged];
    [self.datelbl addTarget:self action:@selector(displaySelectedDateAndTime:) forControlEvents:UIControlEventEditingDidBegin];
    [self.datelbl becomeFirstResponder];
}

-(void)DisplayStartTime
{
    datePicker.datePickerMode = UIDatePickerModeTime;
    self.starttimelbl.inputView = datePicker;
    [datePicker addTarget:self action:@selector(displaySelectedDateAndTime:) forControlEvents:UIControlEventValueChanged];
    [self.starttimelbl addTarget:self action:@selector(displaySelectedDateAndTime:) forControlEvents:UIControlEventEditingDidBegin];
    [self.starttimelbl becomeFirstResponder];
}

-(void)DisplayEndTime
{
    datePicker.datePickerMode = UIDatePickerModeTime;
    self.endTimelbl.inputView = datePicker;
    [datePicker addTarget:self action:@selector(displaySelectedDateAndTime:) forControlEvents:UIControlEventValueChanged];
    [self.endTimelbl addTarget:self action:@selector(displaySelectedDateAndTime:) forControlEvents:UIControlEventEditingDidBegin];
    [self.endTimelbl becomeFirstResponder];
}

- (void) displaySelectedDateAndTime:(UIDatePicker*)sender {
    
    if(isDate==YES)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //   2016-06-25 12:00:00
        [dateFormatter setDateFormat:@"MM-dd-yyyy"];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [datePicker setLocale:locale];
        [datePicker reloadInputViews];
        self.datelbl.text = [dateFormatter stringFromDate:[datePicker date]];
        
        NSDate *today = [NSDate date];
        result = [today compare:datePicker.date]; // comparing two dates
        
    } else {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //   2016-06-25 12:00:00
        [dateFormatter setDateFormat:@"hh:mm a"];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [datePicker setLocale:locale];
        [datePicker reloadInputViews];
        
        if(isStartTime==YES)
        {
            self.starttimelbl.text=[dateFormatter stringFromDate:datePicker.date];
        }
        else
        {
            self.endTimelbl.text=[dateFormatter stringFromDate:datePicker.date];
        }
    }
}

-(IBAction)didClickDatepicker:(id)sender
{
    isDate =YES;
    [self DisplaydatePicker];
    
}

-(IBAction)didClickStartTime:(id)sender
{
    isDate =NO;
    isStartTime =YES;
    [self DisplayStartTime];
}
-(IBAction)didclickEndDatepicker:(id)sender
{
    isDate =NO;
    isStartTime =NO;
    [self DisplayEndTime];
}
-(IBAction)didclickSaveBtn:(id)sender
{
    [self validation ];
    //[self saveWebserviceMethod];
}

-(IBAction)didClickUpdateBtn:(id)sender
{
    [self validation ];
    //[self updateWebServiceMethod];
}

-(IBAction)didClickdeleteBtn:(id)sender
{
    //UIAlertView * objaltert =[[UIAlertView alloc]initWithTitle:@"Food Diary" message:@"Do you want to delete" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    UIAlertView *objAlter =[[UIAlertView alloc]initWithTitle:@"" message:@"Do you want to delete" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    objAlter.tag =110;
    [objAlter show];
    
}

-(void)ShowAlterMsg1:(NSString*) MsgStr
{
    UIAlertView *objAlter =[[UIAlertView alloc]initWithTitle:@"" message:MsgStr delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"Ok", nil];
    [objAlter show];
    
    // [self DeleteWebservice];
    
}

-(IBAction)didClickMeals:(id)sender
{
    self.popviewTbl.hidden=NO;
    [self.popviewTbl reloadData];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    if (alertView.tag == 110)
//    {
//        [self deletewebServiceMethod];
//    }
//    else
//    {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
    
    if (buttonIndex == [alertView cancelButtonIndex])
    {
        alertView.hidden=YES;
    }
    else if (alertView.tag == 110)
    {
        [self deletewebServiceMethod];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)validation
{
    if([self.datelbl.text isEqualToString:@""] || [self.datelbl.text isEqualToString:@"Select"])
    {
        [self altermsg:@"Please select date"];

    }
    else if ([self.starttimelbl.text isEqualToString:@""] || [self.starttimelbl.text isEqualToString:@"Select"])
    {
         [self altermsg:@"Please select StartTime"];
    }
    else if ([self.endTimelbl.text isEqualToString:@""] || [self.endTimelbl.text isEqualToString:@"Select"])
    {
        [self altermsg:@"Please select EndTime"];

    }
    else if ([self.mealslbl.text isEqualToString:@""] || [self.mealslbl.text isEqualToString:@"Select"])
    {
        [self altermsg:@"Please select Meals"];

    }
    else if ([self.foodsizeTxv.text isEqualToString:@""] || [self.foodsizeTxv.text isEqualToString:@"Select"])
    {
        [self altermsg:@"Please Enter Food and Portion Size"];

    }
    else if ([self.fooddetailTxv.text isEqualToString:@""] || [self.fooddetailTxv.text isEqualToString:@"Select"])
    {
        [self altermsg:@"Please Enter Where I eat"];

    }
    
    else if(result==NSOrderedAscending)
    {
        NSLog(@"today is less");
        
        [self altermsg:@"Future date not allowed"];
    }
    else
    {
        if(_Isupdate ==YES)
        {
             [self updateWebServiceMethod];
        }
        else{
            [self saveWebserviceMethod];
        }
        
    }

}
-(void)saveWebserviceMethod
{
    [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",FoodDiaryInsert]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(cliendcode)   [dic    setObject:cliendcode     forKey:@"CLIENTCODE"];
        if(playerCode)   [dic    setObject:playerCode     forKey:@"PLAYERCODE"];
        if(self.starttimelbl.text)   [dic    setObject:self.starttimelbl.text     forKey:@"STARTTIME"];
        if(self.endTimelbl.text)   [dic    setObject:self.endTimelbl.text     forKey:@"ENDTIME"];
        if(selectMealsCode)   [dic    setObject:selectMealsCode    forKey:@"MEALCODE"];
        
        if(self.foodsizeTxv.text)   [dic    setObject:self.foodsizeTxv.text     forKey:@"FOOD"];
        
        if(self.fooddetailTxv.text)   [dic    setObject:self.fooddetailTxv.text     forKey:@"LOCATION"];
        if(usercode)   [dic    setObject:usercode     forKey:@"CREATEDBY"];
       if(self.datelbl.text)   [dic    setObject:self.datelbl.text     forKey:@"DATE"];
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                NSLog(@"%@",responseObject);
                BOOL status=[responseObject valueForKey:@"STATUS"];
                if(status == YES)
                {
                    [self altermsg:[responseObject valueForKey:@"MESSAGE"]];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }
                else{
                    [self altermsg:@"Insert failed"];
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

-(void)updateWebServiceMethod
{
    [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",foodDairyUpdate]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(cliendcode)   [dic    setObject:cliendcode     forKey:@"CLIENTCODE"];
        if(playerCode)   [dic    setObject:playerCode     forKey:@"PLAYERCODE"];
        if(self.starttimelbl.text)   [dic    setObject:self.starttimelbl.text     forKey:@"STARTTIME"];
        if(self.endTimelbl.text)   [dic    setObject:self.endTimelbl.text     forKey:@"ENDTIME"];
        if(selectMealsCode)   [dic    setObject:selectMealsCode     forKey:@"MEALCODE"];

        if(self.foodsizeTxv.text)   [dic    setObject:self.foodsizeTxv.text     forKey:@"FOOD"];

        if(self.fooddetailTxv.text)   [dic    setObject:self.fooddetailTxv.text     forKey:@"LOCATION"];
        if(usercode)   [dic    setObject:usercode     forKey:@"MODIFIEDBY"];
        if([self.fooddiarydetailDic valueForKey:@"FOODDIARYCODE"])   [dic    setObject:[self.fooddiarydetailDic valueForKey:@"FOODDIARYCODE"]     forKey:@"FOODDIARYCODE"];
        if(self.datelbl.text)   [dic    setObject:self.datelbl.text     forKey:@"DATE"];

        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                NSLog(@"%@",responseObject);
                BOOL status=[responseObject valueForKey:@"STATUS"];
                if(status == YES)
                {
                    [self altermsg:[responseObject valueForKey:@"MESSAGE"]];
                     [self.navigationController popViewControllerAnimated:YES];
                    
                }
                else{
                    [self altermsg:@"Update failed"];
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
-(void)deletewebServiceMethod
{
    [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",FooddiaryDelete]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        

        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(cliendcode)   [dic    setObject:cliendcode     forKey:@"CLIENTCODE"];
        if(playerCode)   [dic    setObject:playerCode     forKey:@"PLAYERCODE"];
        if(usercode)   [dic    setObject:usercode     forKey:@"MODIFIEDBY"];
       
        if([self.fooddiarydetailDic valueForKey:@"FOODDIARYCODE"])   [dic    setObject:[self.fooddiarydetailDic valueForKey:@"FOODDIARYCODE"]     forKey:@"FOODDIARYCODE"];
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                NSLog(@"%@",responseObject);
                BOOL status=[responseObject valueForKey:@"STATUS"];
                if(status == YES)
                {
                    [self altermsg:[responseObject valueForKey:@"MESSAGE"]];
                    
                    //[self.navigationController popViewControllerAnimated:YES];
                    
                }
                else{
                    [self altermsg:@"Update failed"];
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
    
        return [self.mealsListArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *MyIdentifier = @"MyIdentifier";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:MyIdentifier];
        }
        
             NSDictionary * objDic = [self.mealsListArray  objectAtIndex:indexPath.row];
            cell.textLabel.text = [objDic valueForKey:@"MEALNAME"];
    
         cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
        self.mealslbl.text =[[self.mealsArray valueForKey:@"MEALNAME"] objectAtIndex:indexPath.row];
        selectMealsCode =[[self.mealsArray valueForKey:@"MEALCODE"] objectAtIndex:indexPath.row];
      
    self.popviewTbl.hidden =YES;
}

-(IBAction)BackBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
