//
//  AssessmentSinglePlayerReportVC.m
//  AlphaProTracker
//
//  Created by Lexicon on 01/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "AssessmentSinglePlayerReportVC.h"
#import "AppCommon.h"
#import "HomeVC.h"
#import "CustomNavigation.h"
#import "Config.h"
#import "WebService.h"


@interface AssessmentSinglePlayerReportVC ()
{
    NSMutableArray* dropdownArray;
    NSString* selectedDropDown;
    NSInteger selectedButton;
    NSMutableArray* GraphArray;

}

@end

@implementation AssessmentSinglePlayerReportVC
@synthesize lblGameName,lblTeamName,lblPlayerName;
@synthesize lblFromDate,lblToDate,lblAssessmentValue1,lblAssessmentValue2;

@synthesize gameview,teamview,playerview;
@synthesize fromview,toview,asv1view,asv2view;

@synthesize dropDownView,datePickerChang,customView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.chartView = [[AAChartView alloc]init];
    self.customChartView.backgroundColor = [UIColor clearColor];
    self.chartView.backgroundColor = [UIColor clearColor];
    self.chartView.frame = CGRectMake(0, 0, self.customChartView.frame.size.width, self.customChartView.frame.size.height);
    [self.chartView setContentMode:UIViewContentModeScaleAspectFit];
    [self.customChartView addSubview:self.chartView];

    //[COMMON AddMenuView:self.view];
//    self.teamview.layer.borderWidth=0.5f;
//    self.teamview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
//
//    self.gameview.layer.borderWidth=0.5f;
//    self.gameview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
//
//    self.playerview.layer.borderWidth=0.5f;
//    self.playerview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
//
//    self.fromview.layer.borderWidth=0.5f;
//    self.fromview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
//
//    self.toview.layer.borderWidth=0.5f;
//    self.toview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
//
//    self.asv1view.layer.borderWidth=0.5f;
//    self.asv1view.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
//
//    self.asv2view.layer.borderWidth=0.5f;
//    self.asv2view.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;

    [self customnavigationmethod];
    // Do any additional setup after loading the view.
    [self FetchDropDownValuesWebService];
}

-(void)viewWillAppear:(BOOL)animated
{
    [COMMON AddMenuView:self.view];
}
-(void)customnavigationmethod
{
    CustomNavigation *objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"";
    objCustomNavigation.btn_back.hidden =NO;
    objCustomNavigation.menu_btn.hidden = YES;
    [objCustomNavigation.btn_back addTarget:self action:@selector(MenuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(IBAction)MenuBtnAction:(id)sender
{
//    [COMMON ShowsideMenuView];
    [self.navigationController popViewControllerAnimated:YES];

}

-(IBAction)HomeBtnAction:(id)sender
{
    HomeVC  * objTabVC=[[HomeVC alloc]init];
    objTabVC = (HomeVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
    [self.navigationController pushViewController:objTabVC animated:YES];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)actionViewGraph:(id)sender {
    if ([lblGameName.text isEqualToString:@""]) {
        [AppCommon showAlertWithMessage:@"Please select Game"];
    }
    [self WebService];
}

- (IBAction)actionShowDropDown:(id)sender {
    dropDownView.frame = CGRectMake(dropDownView.frame.origin.x, dropDownView.frame.origin.x, dropDownView.frame.size.height,self.view.frame.size.height-60);
    [self.mainView.superview bringSubviewToFront:dropDownView];

    [dropDownView setHidden:NO];
    selectedButton = [sender tag];
    switch ([sender tag]) {
        case 0:
            [_tblDropDown setHidden:NO];
            [customView setHidden:YES];

            selectedDropDown = @"lstGame";
            _tblDropDown.frame = CGRectMake(lblGameName.superview.frame.origin.x, CGRectGetMaxY(gameview.frame)+2, lblGameName.frame.size.width, 100);
            break;
        case 1:
            [_tblDropDown setHidden:NO];
            [customView setHidden:YES];

            _tblDropDown.frame = CGRectMake(lblTeamName.superview.frame.origin.x, CGRectGetMaxY(teamview.frame)+2, lblGameName.frame.size.width, 100);

            selectedDropDown = @"lstTeam";
            break;
        case 2:
            [_tblDropDown setHidden:NO];
            [customView setHidden:YES];

            _tblDropDown.frame = CGRectMake(lblPlayerName.superview.frame.origin.x, CGRectGetMaxY(playerview.frame)+2, lblGameName.frame.size.width, 100);

            selectedDropDown = @"lstPlayer";
            break;
        case 3:
            [_tblDropDown setHidden:YES];
            [customView setHidden:NO];
            [self openDatePickerView];
            break;
        case 4:
            [_tblDropDown setHidden:YES];
            [customView setHidden:NO];
            [self openDatePickerView];
            break;
        case 5:
            [_tblDropDown setHidden:NO];
            [customView setHidden:YES];

            _tblDropDown.frame = CGRectMake(lblAssessmentValue1.superview.frame.origin.x, CGRectGetMaxY(asv1view.frame)+2, lblGameName.frame.size.width, 100);
            selectedDropDown = @"AssessmentTests";
            break;
        case 6:
            [_tblDropDown setHidden:NO];
            [customView setHidden:YES];

            _tblDropDown.frame = CGRectMake(lblAssessmentValue2.superview.frame.origin.x, CGRectGetMaxY(asv2view.frame)+2, lblGameName.frame.size.width, 100);
            selectedDropDown = @"AssessmentTests";
            break;


        default:
            break;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tblDropDown reloadData];
    });

    
}
-(void)FetchDropDownValuesWebService
{
    /*
     API URL : http://192.168.1.84:8029/AGAPTSERVICE.svc/FETCHSINGLEPLAYERCHART
     METHOD : POST
     INPUT PARAMS :
     {
     "ClientCode":"USM0000007",
     "Module":"MSC085" ,
     "Player": "USM0000012",
     "Userreferencecode":"AMR0000016"
     }
     */
    if(![COMMON isInternetReachable])
        return;
    
    [AppCommon showLoading];
    NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",FetchSinglePlayerKey]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = requestSerializer;
    NSLog(@"Used API URL %@ ",URLString);
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if([AppCommon GetClientCode]) [dic setObject:[AppCommon GetClientCode] forKey:@"ClientCode"];
    if([AppCommon GetUsercode]) [dic setObject:[AppCommon GetUsercode] forKey:@"Player"];
    if([AppCommon GetuserReference]) [dic setObject:[AppCommon GetuserReference] forKey:@"Userreferencecode"];
    if(self.ModuleCode) [dic setObject:self.ModuleCode forKey:@"ModuleCode"];

    

    
    NSLog(@"parameters : %@",dic);
    [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"response ; %@",responseObject);
        if(responseObject > 0)
        {
            dropdownArray = [NSMutableArray new];
            dropdownArray = responseObject;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [AppCommon hideLoading];
        });

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [AppCommon hideLoading];
    }];
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[dropdownArray valueForKey:selectedDropDown] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"paramTVC";
    
    UITableViewCell * objCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (objCell == nil)
    {
        objCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if ([selectedDropDown isEqualToString:@"lstGame"]) {
        objCell.textLabel.text = [[[dropdownArray valueForKey:selectedDropDown] objectAtIndex:indexPath.row]valueForKey:@"GameName"];
    }else if ([selectedDropDown isEqualToString:@"lstTeam"]) {
        objCell.textLabel.text = [[[dropdownArray valueForKey:selectedDropDown] objectAtIndex:indexPath.row]valueForKey:@"TeamName"];
    }else if ([selectedDropDown isEqualToString:@"lstPlayer"]) {
        objCell.textLabel.text = [[[dropdownArray valueForKey:selectedDropDown] objectAtIndex:indexPath.row]valueForKey:@"PlayerName"];
    }else if ([selectedDropDown isEqualToString:@"AssessmentTests"]) {
        objCell.textLabel.text = [[[dropdownArray valueForKey:selectedDropDown] objectAtIndex:indexPath.row]valueForKey:@"TestName"];
    }
    
    return objCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*  cell = [tableView cellForRowAtIndexPath:indexPath];
    switch (selectedButton) {
        case 0:
            lblGameName.text = cell.textLabel.text;
            lblGameName.tag = indexPath.row;
            break;
        case 1:
            lblTeamName.text = cell.textLabel.text;
            lblTeamName.tag = indexPath.row;

            break;
        case 2:
            lblPlayerName.text = cell.textLabel.text;
            lblPlayerName.tag = indexPath.row;

            break;
        case 5:
            lblAssessmentValue1.text = cell.textLabel.text;
            lblAssessmentValue1.tag = indexPath.row;

            break;
        case 6:
            lblAssessmentValue2.text = cell.textLabel.text;
            lblAssessmentValue2.tag = indexPath.row;

            break;
            
        default:
            break;
    }
    [dropDownView setHidden:YES];
//    [_tblDropDown setHidden:YES];

}

-(void)WebService
{
    /*
     API URL : http://192.168.1.84:8029/AGAPTSERVICE.svc/SINGLEPLAYERCHART
     METHOD : POST
     INPUT PARAMS :
     {
     "ClientCode":"USM0000007",
     "Module":"MSC085" ,
     "Player": "USM0000012",
     "Userreferencecode":"AMR0000016"
     }
     */
    if(![COMMON isInternetReachable])
        return;
    
    [AppCommon showLoading];
    NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",FetchSinglePlayerChartKey]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = requestSerializer;
    NSLog(@"Used API URL %@ ",URLString);
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if([AppCommon GetClientCode]) [dic setObject:[AppCommon GetClientCode] forKey:@"ClientCode"];
    if(self.ModuleCode) [dic setObject:self.ModuleCode forKey:@"ModuleCode"];
    
    if(lblPlayerName.text)
    {
        NSString* playerID = [[[dropdownArray valueForKey:@"lstPlayer"] objectAtIndex:lblPlayerName.tag] valueForKey:@"Player"];
        [dic setObject:playerID forKey:@"Player"];
        
    }
    
    NSDate* fromDate = [self str2Date:lblFromDate.text];
    if(fromDate) [dic setObject:lblFromDate.text forKey:@"FromDate"];
    
    NSDate* toDate = [self str2Date:lblToDate.text];
    if(toDate) [dic setObject:lblToDate.text forKey:@"ToDate"];
    
    if(lblAssessmentValue1.text)
    {
        NSString* AssIDone = [[[dropdownArray valueForKey:@"AssessmentTests"] objectAtIndex:lblAssessmentValue1.tag] valueForKey:@"TestCode"];
        [dic setObject:AssIDone forKey:@"AssessmentTestTypeBarCode"];
    }
    if(lblAssessmentValue2.text)
    {
        NSString* AssIDone = [[[dropdownArray valueForKey:@"AssessmentTests"] objectAtIndex:lblAssessmentValue2.tag] valueForKey:@"TestCode"];
        [dic setObject:AssIDone forKey:@"AssessmentTestTypeLineCode"];
    }

    
    NSLog(@"parameters : %@",dic);
    [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"response ; %@",responseObject);
        if(responseObject > 0)
        {
            GraphArray = [NSMutableArray new];
            GraphArray = responseObject;
            //            arrayExcersizeList = responseObject;
            //            dispatch_async(dispatch_get_main_queue(), ^{
            //                [self.excersizeCollection reloadData];
            //            });
            
            if (([[GraphArray valueForKey:@"BarValuelst"] count] && [[GraphArray valueForKey:@"LineValuelst"] count])||
                [[GraphArray valueForKey:@"BarValuelstleft"] count] || [[GraphArray valueForKey:@"BarValuelstright"] count]||
                [[GraphArray valueForKey:@"LineValuelstleft"] count] || [[GraphArray valueForKey:@"LineValuelstright"] count]) {
                
                [self configureTheChartView:@"mixed"];

            }
            

        }
        [AppCommon hideLoading];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [AppCommon hideLoading];
    }];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [dropDownView setHidden:YES];
    
}

-(IBAction)hideDropDownView:(id)sender
{
    [dropDownView setHidden:YES];
}

- (IBAction)HideDatePicker:(id)sender {
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyy-MM-dd"];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [datePickerChang setLocale:locale];
    
    switch (selectedButton) {
        case 3:
            lblFromDate.text = [dateFormatter stringFromDate:[datePickerChang date]];
            break;
        case 4:
            lblToDate.text = [dateFormatter stringFromDate:[datePickerChang date]];
            break;
            
        default:
            break;
    }

    
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.customView.frame = CGRectMake(0, -self.view.frame.size.height, self.customView.frame.size.width, self.customView.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [dropDownView setHidden:YES];
                     }];
}

-(void)openDatePickerView
{
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.customView.frame = CGRectMake(0, self.view.frame.size.height-self.customView.frame.size.height, self.customView.frame.size.width, self.customView.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         
                     }];

}
-(NSDate *)str2Date:(NSString *)str
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate* date = [dateFormatter dateFromString:str];
    NSLog(@"%@",date);
    return date;

}

- (void)configureTheChartView:(AAChartType)chartType
{
    self.chartModel = [self configureTheChartModel:chartType];
    [self.chartView aa_drawChartWithChartModel:self.chartModel];
}

- (AAChartModel *)configureTheChartModel:(NSString *)chartType {
    
    if ([chartType isEqualToString:@"mixed"]) {
        
        NSMutableArray* data = [[NSMutableArray alloc]init];
        NSMutableArray* line = [[NSMutableArray alloc]init];

//        [data addObject:@[@0.0,@2.0]];
//        [data addObject:@[@0.0,@1.0]];
//
//        [line addObject:@[@0.0,@2.0]];
//        [line addObject:@[@0.0,@1.0]];

        for (NSString* value in [GraphArray valueForKey:@"BarValuelstleft"]) {

            NSArray *vv = [[NSArray alloc]init];
            vv = @[@1.0,value];

            [data addObject:vv];

//            [data addObject:@[@0.0,value]];
        }

        for (NSString*  value in [GraphArray valueForKey:@"BarValuelstright"]) {
            NSArray *vv = [[NSArray alloc]init];
            vv = @[@1.0,value];

            [data addObject:vv];

//            [data addObject:@[@0.0,value]];
        }
//
        for (NSNumber*  value in [GraphArray valueForKey:@"LineValuelstleft"]) {
//            [line addObject:@[@0.0,value]];
            [line addObject:value];

        }

        for (NSNumber* value in [GraphArray valueForKey:@"LineValuelstright"]) {
//            [line addObject:@[@0.0,value]];
            [line addObject:value];

        }

        
//        for(int i=0;i < [[GraphArray valueForKey:@"BarValuelst"] count];i++)
//        {
//            NSString *str= [[GraphArray valueForKey:@"BarValuelst"] objectAtIndex:i];
//            NSArray *vv = [[NSArray alloc]init];
//
//            vv = @[@0.0,str];
//            [data addObject:vv];
//        }
//
//        if (![[GraphArray valueForKey:@"BarValuelst"] count])
//        {
//            for(int i=0;i < [[GraphArray valueForKey:@"BarValuelst"] count];i++)
//            {
//                NSString *str= [[GraphArray valueForKey:@"BarValuelst"] objectAtIndex:i];
//                NSArray *vv = [[NSArray alloc]init];
//
//                vv = @[@0.0,str];
//                [line addObject:vv];
//            }
//
//            for(int i=0;i < [[GraphArray valueForKey:@"BarValuelstleft"] count];i++)
//            {
//                NSString *str= [[GraphArray valueForKey:@"BarValuelstleft"] objectAtIndex:i];
//                NSArray *vv = [[NSArray alloc]init];
//
//                vv = @[@0.0,str];
//                [data addObject:vv];
//            }
//
//        }
//
//        if (![[GraphArray valueForKey:@"LineValuelst"] count])
//        {
//            for(int i=0;i < [[GraphArray valueForKey:@"LineValuelstleft"] count];i++)
//            {
//                NSString *str= [[GraphArray valueForKey:@"LineValuelstleft"] objectAtIndex:i];
//                int num = [str intValue];
//
//                [line addObject:[NSNumber numberWithInt:num]];
//            }
//
//
//            for(int i=0;i < [[GraphArray valueForKey:@"LineValuelstright"] count];i++)
//            {
//                NSString *str= [[GraphArray valueForKey:@"LineValuelstright"] objectAtIndex:i];
//                int num = [str intValue];
//
//                [line addObject:[NSNumber numberWithInt:num]];
//            }
//
//        }
//
//
//        for(int i=0;i < [[GraphArray valueForKey:@"LineValuelst"] count];i++)
//        {
//            NSString *str= [[GraphArray valueForKey:@"LineValuelst"] objectAtIndex:i];
//            int num = [str intValue];
//
//            [line addObject:[NSNumber numberWithInt:num]];
//        }



        if (!data.count || !line.count)
            return nil;
        

        NSString* axis1name = [[GraphArray valueForKey:@"xAxisBars"] objectAtIndex:0];
        NSString* axis2name = [[GraphArray valueForKey:@"xAxisLines"] objectAtIndex:0];
        NSString *title = [NSString  stringWithFormat:@"%@  Vs  %@" ,lblAssessmentValue1.text,lblAssessmentValue2.text];

        NSArray* arrCategoriesBars = ([[GraphArray valueForKey:@"xAxisBars"] count] > 0 ? [GraphArray valueForKey:@"xAxisBars"] : @"");
//        NSArray* arrCategoriesLines = ([[GraphArray valueForKey:@"xAxisLines"] count] > 0 ? [GraphArray valueForKey:@"xAxisLines"] : @"");

        AAChartModel *chartModel= AAObject(AAChartModel)
        .titleSet(title)
        .subtitleSet(@"")
        .yAxisTitleSet(@"")
        .categoriesSet(arrCategoriesBars)

        .dataLabelEnabledSet(true)

        .seriesSet(@[
                     AAObject(AASeriesElement)
                     .typeSet(AAChartTypeColumnrange)
                     .nameSet(axis1name)
                     .dataSet(data),
                     
                     AAObject(AASeriesElement)
                     .typeSet(AAChartTypeSpline)
                     .nameSet(axis2name)
                     .dataSet(line)
                     ]
                   );

        return chartModel;

    }
    return nil;
}



@end
