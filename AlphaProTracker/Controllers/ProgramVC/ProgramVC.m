//
//  ProgramVC.m
//  AlphaProTracker
//
//  Created by Lexicon on 29/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "ProgramVC.h"
#import "CustomNavigation.h"
#import "AppCommon.h"
#import "HomeVC.h"
#import "Config.h"
#import "WebService.h"


@interface ProgramVC ()
{
    BOOL isPoPlist;
    BOOL isExlist;
    
    NSString *Excode;
    NSString *Programcode;
}

@property (strong, nonatomic)  NSMutableArray *ExerciseList;

@property (strong, nonatomic)  NSMutableArray *ExerciseCode;

@property (strong, nonatomic)  NSMutableArray *ExerciseTitle;

@property (strong, nonatomic)  NSMutableArray *ProgramsList;

@property (strong, nonatomic)  NSMutableArray *TableList;

@property (strong, nonatomic)  NSMutableArray *ProgramCodeList;

@property (strong, nonatomic)  NSMutableArray *ArrayEX;


@property (strong, nonatomic)  NSMutableArray *selectedMarks;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableWidth;

@property (strong, nonatomic) IBOutlet UIView *commonView;
@end

@implementation ProgramVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[COMMON AddMenuView:self.view];
    
    self.ExerciseList = [[NSMutableArray alloc]init];
    self.ExerciseCode = [[NSMutableArray alloc]init];
    self.ExerciseTitle = [[NSMutableArray alloc]init];
    self.ProgramsList = [[NSMutableArray alloc]init];
    
    
    self.ProgramCodeList = [[NSMutableArray alloc]init];
    
     self.selectedMarks = [[NSMutableArray alloc]init];
    
    self.ArrayEX = [[NSMutableArray alloc]init];
    
    self.popList.hidden = YES;
    //self.ListTbl.hidden = YES;
    self.UpdateBtn.hidden = YES;
    self.ClearBtn.hidden = YES;
    self.RemoveBtn.hidden = YES;
    
    self.commonView.hidden=YES;
    
    self.TitleView.layer.borderWidth=0.5f;
    self.TitleView.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.ExerciseView.layer.borderWidth=0.5f;
    self.ExerciseView.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    if([self.Screen isEqualToString:@"Physio"])
    {
        self.ModuleCode = @"MSC084";
    }
    else if([self.Screen isEqualToString:@"S and C"])
    {
        self.ModuleCode = @"MSC085";
    }
    else if([self.Screen isEqualToString:@"Coach"])
    {
        self.ModuleCode = @"MSC086";
    }
    
    NSLog(@"%@", self.ModuleCode);
    
    [self ExerciseWebservice];
    
    
    
    
    
    [self customnavigationmethod];
}
-(void)viewWillAppear:(BOOL)animated
{
    [COMMON AddMenuView:self.view];
}

-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=[NSString stringWithFormat:@"%@ Program",self.Screen];
    
    if([self.check isEqualToString:@"main"])
    {
        
        objCustomNavigation.btn_back.hidden =NO;
        objCustomNavigation.menu_btn.hidden = YES;
        [objCustomNavigation.menu_btn addTarget:self action:@selector(MenuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [objCustomNavigation.btn_back addTarget:self action:@selector(btn_back:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        objCustomNavigation.btn_back.hidden =YES;
        objCustomNavigation.menu_btn.hidden = NO;
        [objCustomNavigation.menu_btn addTarget:self action:@selector(MenuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [objCustomNavigation.btn_back addTarget:self action:@selector(btn_back:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
}
-(void)ExerciseWebservice
{
   // [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",programKey]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        
        NSString *createdby = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
        NSString *clientcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
       
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(createdby)   [dic    setObject:createdby     forKey:@"CreatedBy"];
        if(clientcode)   [dic    setObject:clientcode     forKey:@"ClientCode"];
        if(self.ModuleCode) [dic    setObject:self.ModuleCode     forKey:@"Modulecode"];
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                self.ExerciseList = [responseObject valueForKey:@"ExerciseMasters"];
                
                if(![self.ExerciseList isEqual:[NSNull null]])
                {
                self.ExerciseCode = [self.ExerciseList valueForKey:@"ExerciseCode"];
                
                self.ExerciseTitle = [self.ExerciseList valueForKey:@"Title"];
                }
                
                self.ProgramsList = [responseObject valueForKey:@"Programs"];
                
                
                self.TableList = [[NSMutableArray alloc]init];
                
                if(![self.ProgramsList isEqual:[NSNull null]])
                {
                self.TableList = [self.ProgramsList valueForKey:@"ProgramName"];
                self.ProgramCodeList = [self.ProgramsList valueForKey:@"ProgramCode"];
                }
                
                
                isExlist = YES;
                [self.popList reloadData];
                [self.ListTbl reloadData];
                
                
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


- (void)viewDidUnload
{
    [super viewDidUnload];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(isPoPlist)
    {
       return  self.ExerciseTitle.count;
    }
    if(isExlist)
    {
        return self.TableList.count;
    }
    return nil;
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    if(isPoPlist)
    {
       // cell.textLabel.text = [self.ExerciseTitle objectAtIndex:indexPath.row];
        static NSString *CRTableViewCellIdentifier = @"cellIdentifier";
        
        // init the CRTableViewCell
        CRTableViewCell *cell = (CRTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CRTableViewCellIdentifier];
        
        if (cell == nil) {
            cell = [[CRTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CRTableViewCellIdentifier];
        }
        
        //self.selectedMarks = [[NSMutableArray alloc]init];
        Excode = [self.ExerciseCode objectAtIndex:indexPath.row];
        
        // Check if the cell is currently selected (marked)
        NSString *text = [self.ExerciseTitle objectAtIndex:[indexPath row]];
        cell.isSelected = [self.selectedMarks containsObject:Excode] ? YES : NO;
        cell.textLabel.text = text;
        return cell;

        
    }
    
    if(isExlist)
    {
        static NSString *MyIdentifier = @"MyIdentifier";
        
        //static NSString *Identifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:nil];
        }

        cell.textLabel.text = [self.TableList objectAtIndex:indexPath.row];
        cell.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

    
   
    return nil;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:nil];
    }
   
    
    if(isPoPlist)
    {
    
        
         Excode = [self.ExerciseCode objectAtIndex:indexPath.row];
        if ([self.selectedMarks containsObject:Excode])// Is selected?
            [self.selectedMarks removeObject:Excode];
        else
            [self.selectedMarks addObject:Excode];
        
        static NSString *CRTableViewCellIdentifier = @"cellIdentifier";
        
        CRTableViewCell *cell = (CRTableViewCell *)[self.popList dequeueReusableCellWithIdentifier:CRTableViewCellIdentifier];
        cell.isSelected = [self.selectedMarks containsObject:Excode] ? YES : NO;
        

        
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
       
        int a = self.selectedMarks.count;
        if(a == 0)
        {
            //NSString *b = [NSString stringWithFormat:@"%d", a];
            self.Exerciselbl.text = @"";
        }
        if(a == 1)
        {
            //NSString *b = [NSString stringWithFormat:@"%d", a];
            self.Exerciselbl.text = [NSString stringWithFormat:@"%d item selected", a];
        }
        else
        {
            self.Exerciselbl.text = [NSString stringWithFormat:@"%d items selected", a];
        }
        
        
    }
    
    if(isExlist)
    {
        
        Programcode = [self.ProgramCodeList objectAtIndex:indexPath.row];
        
        [self ExerciseWebservice];
        
        [self EditWebservice];
        
        //Excode = [self.ExerciseCode objectAtIndex:indexPath.row];
        
        //[self.ArrayEX addObject:Excode];
        
        isExlist=YES;
        
        
       
    }


    
}


-(IBAction)ExerciseAction:(id)sender
{
    
    if(isPoPlist==NO)
    {
    
    isPoPlist = YES;
    isExlist = NO;
    //self.popList.hidden = NO;
    
    //self.tableWidth.constant = self.ExerciseView.frame.size.width;
        
        
        
    self.commonView.hidden=NO;
    self.popList.hidden=NO;
      // [self.popList setUserInteractionEnabled:YES];
    [self.popList reloadData];
        //isPoPlist=NO ;
    }
    else{
        self.commonView.hidden=YES;
        self.popList.hidden=YES;
        isPoPlist = NO;
        isExlist = YES;
        [self.popList reloadData];
        //[self.popList setUserInteractionEnabled:NO];
    }

}

-(IBAction)SaveAction:(id)sender
{
    
    if([self.Titlelbl.text isEqualToString:@""] || [self.Exerciselbl.text isEqualToString: @""])
    {
        [self ShowAlterMsg:@"Please enter Title & Exercise"];
    }
    else if( [self.Titlelbl.text isEqualToString:@""] )
    {
        [self ShowAlterMsg:@"Please enter Title"];
    }
    else if( [self.Exerciselbl.text isEqualToString:@""] || [self.Exerciselbl.text isEqualToString: @"0 items selected"])
    {
        [self ShowAlterMsg:@"Please enter Exercise"];
    }
    else if( ![self.Titlelbl.text isEqualToString:@""] || ![self.Exerciselbl.text isEqualToString: @""])
    {
      [self SaveWebservice];
        
        isPoPlist = NO;
        isExlist = YES;
        self.ListTbl.hidden = NO;
        self.Titlelbl.text = @"";
        self.Exerciselbl.text = @"";
        [self.selectedMarks removeAllObjects];
        [self ExerciseWebservice];
    }
    
    
    //[self.ListTbl reloadData];
}
//- (void)Done:(id)sender
//{
//    NSLog(@"%@", self.selectedMarks);
//    self.commonView.hidden = YES;
//    isPoPlist=NO;
//    isExlist =YES;
//    
//}
-(IBAction)SubmitAction:(id)sender
{
    
    NSLog(@"%@", self.selectedMarks);
    
    self.commonView.hidden = YES;
    isPoPlist=NO;
    isExlist =YES;
    
    static NSString *CRTableViewCellIdentifier = @"cellIdentifier";
    
    CRTableViewCell *cell = (CRTableViewCell *)[self.popList dequeueReusableCellWithIdentifier:CRTableViewCellIdentifier];
    cell.isSelected = [self.selectedMarks containsObject:Excode] ? YES : NO;

    
    [self.popList reloadData];
}

-(IBAction)cancelAction:(id)sender
{
    
    NSLog(@"%@", self.selectedMarks);
    
    self.commonView.hidden = YES;
    isPoPlist=NO;
    isExlist =YES;
    [self.popList reloadData];
}

-(IBAction)UpadteAction:(id)sender
{
    
    if([self.Titlelbl.text isEqualToString:@""] || [self.Exerciselbl.text isEqualToString: @""])
    {
        [self ShowAlterMsg:@"Please enter Title & Exercise"];
    }
    else if( [self.Titlelbl.text isEqualToString:@""] )
    {
        [self ShowAlterMsg:@"Please enter Title"];
    }
    else if( [self.Exerciselbl.text isEqualToString:@""] || [self.Exerciselbl.text isEqualToString: @"0 items selected"])
    {
        [self ShowAlterMsg:@"Please enter Exercise"];
    }
    else if( ![self.Titlelbl.text isEqualToString:@""] || ![self.Exerciselbl.text isEqualToString: @""])
    {
        [self UpdateWebservice];
        
        isPoPlist = NO;
        isExlist = YES;
        
        self.SaveBtn.hidden = NO;
        self.UpdateBtn.hidden = YES;
        self.ClearBtn.hidden = YES;
        self.RemoveBtn.hidden = YES;
        
        self.Titlelbl.text = @"";
        self.Exerciselbl.text = @"";
        [self.selectedMarks removeAllObjects];

        
    }

    
    
}

-(IBAction)DeleteAction:(id)sender
{
    
    [self DeleteWebservice];
    
    
    
    isPoPlist = NO;
    isExlist = YES;


    self.SaveBtn.hidden = NO;
    self.UpdateBtn.hidden = YES;
    self.ClearBtn.hidden = YES;
    self.RemoveBtn.hidden = YES;
    self.Titlelbl.text = @"";
    self.Exerciselbl.text = @"";
    [self.selectedMarks removeAllObjects];
    
}

-(IBAction)ClearAction:(id)sender
{
    
    
    self.SaveBtn.hidden = NO;
    self.UpdateBtn.hidden = YES;
    self.ClearBtn.hidden = YES;
    self.RemoveBtn.hidden = YES;
    self.Titlelbl.text = @"";
    self.Exerciselbl.text = @"";
    [self.selectedMarks removeAllObjects];
    
}




-(void)EditWebservice
{
    [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",ProgarmEditKey]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        
        NSString *createdby = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
        NSString *clientcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(createdby)   [dic    setObject:createdby     forKey:@"CreatedBy"];
        if(clientcode)   [dic    setObject:clientcode     forKey:@"ClientCode"];
        if(self.ModuleCode) [dic    setObject:self.ModuleCode     forKey:@"Modulecode"];
        if(Programcode) [dic    setObject:Programcode    forKey:@"ProgramCode"];
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                
                NSMutableArray *res=[[NSMutableArray alloc]init];
                //self.selectedMarks = [[NSMutableArray alloc]init];
                if(responseObject>0)
                {
                    NSMutableArray *sample = [[NSMutableArray alloc]init];
                    sample = responseObject;
                    if(!(sample.count==0))
                    {
                        self.SaveBtn.hidden = YES;
                        self.UpdateBtn.hidden = NO;
                        self.ClearBtn.hidden = NO;
                        self.RemoveBtn.hidden = NO;
                        res = [responseObject objectAtIndex:0];
                   
                        self.Titlelbl.text = [res valueForKey:@"ProgramName"];
                 
                        self.ArrayEX = [res valueForKey:@"ExerciseCodes"];
                        NSLog(@"%lu", (unsigned long)self.ArrayEX.count);
                        int a = self.ArrayEX.count;
                        if(a == 0)
                        {
                            //NSString *b = [NSString stringWithFormat:@"%d", a];
                            self.Exerciselbl.text = @"";
                        }
                        if(a==1)
                        {
                            self.Exerciselbl.text = [NSString stringWithFormat:@"%d item selected",a];
                        }
                        else
                        {
                            self.Exerciselbl.text = [NSString stringWithFormat:@"%d items selected",a];
                        }
                        self.selectedMarks = [[NSMutableArray alloc]init];
                        for( int i=0;i<self.ArrayEX.count;i++)
                        {
                            Excode = [self.ArrayEX objectAtIndex:i];
                        
                        
                            if ([self.selectedMarks containsObject:Excode])// Is selected?
                                [self.selectedMarks removeObject:Excode];
                            else
                                [self.selectedMarks addObject:Excode];
                        }
                    
                    
                        static NSString *CRTableViewCellIdentifier = @"cellIdentifier";
                        CRTableViewCell *cell = (CRTableViewCell *)[self.popList dequeueReusableCellWithIdentifier:CRTableViewCellIdentifier];
                        cell.isSelected = [self.selectedMarks containsObject:Excode] ? YES : NO;
                    
                        [self.popList reloadData];
                    }
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
-(void)DeleteWebservice
{
    [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",ProgarmDeleteKey]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        
        NSString *createdby = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
        NSString *clientcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(createdby)   [dic    setObject:createdby     forKey:@"CreatedBy"];
        if(clientcode)   [dic    setObject:clientcode     forKey:@"ClientCode"];
        if(self.ModuleCode) [dic    setObject:self.ModuleCode     forKey:@"Modulecode"];
        if(Programcode) [dic    setObject:Programcode    forKey:@"ProgramCode"];
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                
                //NSMutableArray *res=[[NSMutableArray alloc]init];
                if(responseObject>0)
                {
                    [self ShowAlterMsg:@"Deleted Successfully "];
                    
                    [self ExerciseWebservice];
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



-(void)SaveWebservice
{
    [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",ProgarmSaveKey]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        
        NSString *createdby = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
        NSString *clientcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
        
        //NSString * value =[NSString  stringWithFormat:@""%@"" ,Exercisecode];
        //NSString * value1 =[NSString  stringWithFormat:@"[%@]" ,value];
        

        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(createdby)   [dic    setObject:createdby     forKey:@"CreatedBy"];
        if(clientcode)   [dic    setObject:clientcode     forKey:@"ClientCode"];
        if(self.ModuleCode) [dic    setObject:self.ModuleCode     forKey:@"Modulecode"];
        if(self.Titlelbl.text) [dic    setObject:self.Titlelbl.text    forKey:@"ProgramName"];
        
        if(self.selectedMarks)   [dic    setObject:self.selectedMarks      forKey:@"ExerciseCodes"];
        
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                
                NSString * st = [responseObject valueForKey:@"Status"];
                int status =[st intValue];
                
                if(status == 1)
                {
                [self ShowAlterMsg:@"Inserted Successfully "];
                
                [self ExerciseWebservice];
                }
                else
                {
                    NSString * msgg = [responseObject valueForKey:@"Message"];
                    
                    [self ShowAlterMsg2:msgg];
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
-(void)UpdateWebservice
{
    [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",ProgarmUpadteKey]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        
        NSString *createdby = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
        NSString *clientcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
        
        //NSString * value =[NSString  stringWithFormat:@""%@"" ,Exercisecode];
        //NSString * value1 =[NSString  stringWithFormat:@"[%@]" ,value];
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(createdby)   [dic    setObject:createdby     forKey:@"CreatedBy"];
        if(clientcode)   [dic    setObject:clientcode     forKey:@"ClientCode"];
        if(self.ModuleCode) [dic    setObject:self.ModuleCode     forKey:@"Modulecode"];
        if(self.Titlelbl.text) [dic    setObject:self.Titlelbl.text    forKey:@"ProgramName"];
        
        if(Programcode) [dic    setObject:Programcode    forKey:@"ProgramCode"];
        
        if(self.selectedMarks)   [dic    setObject:self.selectedMarks      forKey:@"ExerciseCodes"];
        
        
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                [self ShowAlterMsg:@"Updated Successfully "];
                [self ExerciseWebservice];
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

-(void)ShowAlterMsg:(NSString*) MsgStr
{
    UIAlertView *objAlter =[[UIAlertView alloc]initWithTitle:@"" message:MsgStr delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [objAlter show];
    
}

-(void)ShowAlterMsg2:(NSString*) MsgStr
{
    UIAlertView *objAlter =[[UIAlertView alloc]initWithTitle:@"Insert Failed" message:MsgStr delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [objAlter show];
    
}





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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(IBAction)btn_back:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
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
