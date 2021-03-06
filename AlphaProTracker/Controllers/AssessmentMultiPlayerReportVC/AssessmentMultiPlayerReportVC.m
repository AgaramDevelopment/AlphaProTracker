//
//  AssessmentMultiPlayerReportVC.m
//  AlphaProTracker
//
//  Created by Lexicon on 01/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "AssessmentMultiPlayerReportVC.h"
#import "AppCommon.h"
#import "HomeVC.h"
#import "CustomNavigation.h"
#import "Config.h"
#import "WebService.h"
#import "DatePickerViewController.h"
#import "MultiSelectTableViewCell.h"
#import "DropDownViewController.h"

@interface AssessmentMultiPlayerReportVC () <DatePickerProtocol,DropDownProtocol,AAChartViewDidFinishLoadDelegate>
{
    NSMutableArray* dropdownArray;
    NSInteger selectedButton;
    NSMutableArray* GraphArray;
    NSMutableArray* selectedPlayers;
    NSDictionary* DropdownKeyValue;
    NSMutableArray* playerDropDown;

}

@end

@implementation AssessmentMultiPlayerReportVC

@synthesize lblGameName,lblTeamName;
@synthesize lblPlayersName,lblFromDate;

@synthesize lblAssValue1,lblAssValue2;
@synthesize gameview,teamview,playerview;

@synthesize dateview,asv1view,asv2view;

@synthesize chartModel,chartView;

- (void)viewDidLoad {
    [super viewDidLoad];
    //[COMMON AddMenuView:self.view];
    self.gameview.layer.borderWidth=0.5f;
    self.gameview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.teamview.layer.borderWidth=0.5f;
    self.teamview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.playerview.layer.borderWidth=0.5f;
    self.playerview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.dateview.layer.borderWidth=0.5f;
    self.dateview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.asv1view.layer.borderWidth=0.5f;
    self.asv1view.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.asv2view.layer.borderWidth=0.5f;
    self.asv2view.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    

    [self customnavigationmethod];
    // Do any additional setup after loading the view.
    
    [self FetchDropDownValuesWebService];
    self.chartView = [[AAChartView alloc]init];
    self.chartView.delegate = self;
    self.customChartView.backgroundColor = [UIColor clearColor];
    self.chartView.backgroundColor = [UIColor clearColor];
//    [self.chartView setContentMode:UIViewContentModeScaleAspectFit];
    self.chartView.contentWidth = self.view.frame.size.width;
    self.chartView.contentHeight = self.view.frame.size.height-250;
    self.chartView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-self.customChartView.frame.origin.y);
    [self.customChartView addSubview:self.chartView];
    
    selectedPlayers = [NSMutableArray new];
    playerDropDown = [NSMutableArray new];

    
    
    /*
     CGFloat chartViewWidth  = self.view.frame.size.width;
     CGFloat chartViewHeight = self.view.frame.size.height-250;
     self.aaChartView = [[AAChartView alloc]init];
     self.aaChartView.frame = CGRectMake(0, 60, chartViewWidth, chartViewHeight);
     self.aaChartView.delegate = self;

     */
    
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
    objCustomNavigation.tittle_lbl.text=@"";
    objCustomNavigation.btn_back.hidden =NO;
    objCustomNavigation.menu_btn.hidden = YES;
    [objCustomNavigation.btn_back addTarget:self action:@selector(MenuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];

}
-(IBAction)MenuBtnAction:(id)sender
{
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDragging %ld",(long)scrollView.tag);
    if(scrollView.tag == 0)
    {
        
    }else
    {
        
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (selectedButton == 2)
    {
        return playerDropDown.count;

    }

    return [[dropdownArray valueForKey:[DropdownKeyValue allKeys].firstObject] count];
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (selectedButton == 2)
    {
        UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, tableView.rowHeight)];
        btn.backgroundColor = [UIColor yellowColor];
        [btn setTitle:@"Done" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(closeMultiselect) forControlEvents:UIControlEventTouchUpInside];
        
        return btn;
    }
    NSLog(@"BUTTON CALLED");
    return nil;
}

-(void)closeMultiselect
{
    [_tblDropDown setHidden:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (selectedButton == 2)
    {
        return  30;
    }
        return 0;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"paramTVC";
    UITableViewCell * objCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (objCell == nil)
    {
        objCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (selectedButton == 2)
    {
        objCell.textLabel.text = [[playerDropDown objectAtIndex:indexPath.row]valueForKey:@"PlayerName"];

        if ([[selectedPlayers valueForKey:@"PlayerName"] containsObject:objCell.textLabel.text]) {
            objCell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else
        {
            objCell.accessoryType = UITableViewCellAccessoryNone;
        }

    }
    else
    {
        objCell.accessoryType = UITableViewCellAccessoryNone;
        objCell.textLabel.text = [[[dropdownArray valueForKey:[DropdownKeyValue allKeys].firstObject] objectAtIndex:indexPath.row]valueForKey:[DropdownKeyValue allValues].firstObject];
    }


    return objCell;
}

-(void)buttonCheckAction:(NSIndexPath *)indexPath
{
    id value = [playerDropDown objectAtIndex:indexPath.row];
    
    if (selectedPlayers.count == 0 && indexPath.row == 0)
    {
        [selectedPlayers removeAllObjects];
        [selectedPlayers addObjectsFromArray:playerDropDown];
        
    }else if (selectedPlayers.count > 0 && indexPath.row == 0)
    {
        [selectedPlayers removeAllObjects];
    }
    else if ([selectedPlayers containsObject:value])
    {
        [selectedPlayers removeObject:value];
    }
    else
    {
        [selectedPlayers addObject:value];
    }
    
    if (selectedPlayers.count > 0)
    {
        if (selectedPlayers.count == playerDropDown.count) {
            NSArray* arr = [selectedPlayers subarrayWithRange:NSMakeRange(1, selectedPlayers.count-1)];
            lblPlayersName.text = [[arr valueForKey:@"PlayerName"] componentsJoinedByString:@","];
            return;
        }
        lblPlayersName.text = [[selectedPlayers valueForKey:@"PlayerName"] componentsJoinedByString:@","];
    }
    

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*  cell = [tableView cellForRowAtIndexPath:indexPath];
    switch (selectedButton) {
        case 0:
            lblGameName.text = cell.textLabel.text;
            lblGameName.tag = indexPath.row;
            [self closeMultiselect];

            break;
        case 1:
            lblTeamName.text = cell.textLabel.text;
            lblTeamName.tag = indexPath.row;
            [self closeMultiselect];

            break;
        case 2:
            lblPlayersName.text = cell.textLabel.text;
            lblPlayersName.tag = indexPath.row;
            [self buttonCheckAction:indexPath];
            
            break;
        case 4:
            lblAssValue1.text = cell.textLabel.text;
            lblAssValue1.tag = indexPath.row;
            [self closeMultiselect];

            break;
        case 5:
            lblAssValue2.text = cell.textLabel.text;
            lblAssValue2.tag = indexPath.row;
            [self closeMultiselect];

            
            break;
            
        default:
            break;
    }
    
        [self.scrollView setScrollEnabled:YES];
    
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
         "ClientCode" :"CLI0000001",
         "ModuleId" : "MSC086",
         "Userreferencecode":"AMR0000001"
     }
     */
    if(![COMMON isInternetReachable])
        return;
    
    [AppCommon showLoading];
    NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",FetchMultiPlayerKey]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = requestSerializer;
    NSLog(@"Used API URL %@ ",URLString);
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if([AppCommon GetClientCode]) [dic setObject:[AppCommon GetClientCode] forKey:@"ClientCode"];
    if([AppCommon GetuserReference]) [dic setObject:[AppCommon GetuserReference] forKey:@"Userreferencecode"];
    if(self.ModuleCode) [dic setObject:self.ModuleCode forKey:@"ModuleId"];
    
    NSLog(@"parameters : %@",dic);
    [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"response ; %@",responseObject);
        if(responseObject > 0)
        {
            dropdownArray = [NSMutableArray new];
            dropdownArray = responseObject;
        }
        [AppCommon hideLoading];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [AppCommon hideLoading];
    }];
    
}
-(void)GraphWebService
{
    /*
     API URL : http://192.168.1.84:8029/AGAPTSERVICE.svc/SINGLEPLAYERCHART
     METHOD : POST
     INPUT PARAMS :
     {
         ClientCode
         AssessmentTestTypeBarCode
         AssessmentTestTypeLineCode
         FromDate
         ToDate // no need here
         PlayerCodes // separated by comma
     }
     */
    if(![COMMON isInternetReachable])
        return;
    
    [AppCommon showLoading];
    NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",FetchMultiPlayerChartKey]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = requestSerializer;
    NSLog(@"Used API URL %@ ",URLString);
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if([AppCommon GetClientCode]) [dic setObject:[AppCommon GetClientCode] forKey:@"ClientCode"];
//    if(self.ModuleCode) [dic setObject:self.ModuleCode forKey:@"ModuleCode"];
    
    if(lblPlayersName.text)
    {
        NSString* playerID = [[selectedPlayers valueForKey:@"PlayerCode"] componentsJoinedByString:@","];
        [dic setObject:playerID forKey:@"PlayerCodes"];
        
    }
    
    if(lblFromDate.text) [dic setObject:lblFromDate.text forKey:@"FromDate"];
    
    if(lblAssValue1.text)
    {
        NSString* AssIDone = [[[dropdownArray valueForKey:@"AssessmentTests"] objectAtIndex:lblAssValue1.tag] valueForKey:@"TestCode"];
        [dic setObject:AssIDone forKey:@"AssessmentTestTypeBarCode"];
    }
    if(lblAssValue2.text)
    {
        NSString* AssIDone = [[[dropdownArray valueForKey:@"AssessmentTests"] objectAtIndex:lblAssValue2.tag] valueForKey:@"TestCode"];
        [dic setObject:AssIDone forKey:@"AssessmentTestTypeLineCode"];
    }
    
    
    NSLog(@"parameters : %@",dic);
    [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"response ; %@",responseObject);
        if(responseObject > 0)
        {
            GraphArray = [NSMutableArray new];
            GraphArray = responseObject;
            
//            if (([[GraphArray valueForKey:@"BarValuelst"] count] && [[GraphArray valueForKey:@"LineValuelst"] count])||
//                [[GraphArray valueForKey:@"BarValuelstleft"] count] || [[GraphArray valueForKey:@"BarValuelstright"] count]||
//                [[GraphArray valueForKey:@"LineValuelstleft"] count] || [[GraphArray valueForKey:@"LineValuelstright"] count]) {
//
////                [self configureTheChartView:@"mixed"];
//
//            }
            
            
        }
        [AppCommon hideLoading];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [AppCommon hideLoading];
    }];
    
}

-(IBAction)closeView:(id)sender
{
    [_tblDropDown.superview setHidden:YES];
}

- (IBAction)actionShowDropDown:(id)sender {
    
    DropDownViewController* VC = (DropDownViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"DropDownVC"];
    VC.dropDownDelegate = self;
    VC.view.frame = _scrollView.frame;
    
    
    CGFloat tableHeight = (IS_IPAD ? 250 : 150);
    selectedButton = [sender tag];
    switch ([sender tag]) {
        case 0:
            VC.tableArray = [dropdownArray valueForKey:@"GameMultiPlayer"];
            VC.KeyName = @"GameName";
            VC.tblDropDown.frame = CGRectMake(gameview.frame.origin.x, CGRectGetMaxY(gameview.frame)+80+2, lblGameName.frame.size.width, tableHeight);
            

            break;
        case 1:
            VC.tableArray = [dropdownArray valueForKey:@"TeamMultiPlayers"];
            VC.KeyName = @"TeamName";

            VC.tblDropDown.frame = CGRectMake(teamview.frame.origin.x, CGRectGetMaxY(teamview.frame)+80+2, lblGameName.frame.size.width, tableHeight);


            break;
        case 2:
            VC.tblDropDown.frame = CGRectMake(playerview.frame.origin.x, CGRectGetMaxY(playerview.frame)+80+2, lblGameName.frame.size.width, tableHeight);
            VC.HeaderRequired = YES;
            VC.KeyName = @"PlayerName";

            DropdownKeyValue = @{@"PlayerMultiPlayers":@"PlayerName"};
        {
            [playerDropDown removeAllObjects];
            [playerDropDown addObjectsFromArray:[dropdownArray valueForKey:@"PlayerMultiPlayers"]];
            NSDictionary* dict = @{@"PlayerCode":@"",@"PlayerName":@"Select All"};
            [playerDropDown insertObject:dict atIndex:0];

        }
            VC.tableArray = playerDropDown;

            break;
        case 3:
            [self closeMultiselect];
            [self openDatePickerVC];
            
            break;
        case 4:
            VC.tblDropDown.frame = CGRectMake(asv1view.frame.origin.x, CGRectGetMaxY(asv1view.frame)+80+2, lblGameName.frame.size.width, tableHeight);

            VC.tableArray = [dropdownArray valueForKey:@"AssessmentTests"];
            VC.KeyName = @"TestName";

            DropdownKeyValue = @{@"AssessmentTests":@"TestName"};

            break;
        case 5:
            VC.tableArray = [dropdownArray valueForKey:@"AssessmentTests"];
            VC.KeyName = @"TestName";

            VC.tblDropDown.frame = CGRectMake(asv2view.frame.origin.x, CGRectGetMaxY(asv2view.frame)+80, lblGameName.frame.size.width, tableHeight);

            DropdownKeyValue = @{@"AssessmentTests":@"TestName"};

            break;
            
            
        default:
            break;
    }
    [self presentViewController:VC animated:YES completion:nil];
}

-(void)openDatePickerVC
{
    DatePickerViewController  * objTabVC = (DatePickerViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"DatePickerVC"];
    objTabVC.datePickerFormat = @"yyy-MM-dd";
    objTabVC.datePickerDelegate = self;
    [self presentViewController:objTabVC animated:YES completion:nil];

}

- (IBAction)actionViewMultiPlayerChart:(id)sender {
    
    [self GraphWebService];
    
//    self.chartModel = [self configureTheChartModel];
//    [self.chartView aa_drawChartWithChartModel:self.chartModel];
    [self combinedMultibarChart];
    
}

-(void)selectedDate:(NSString *)Date
{
    if (selectedButton == 3) {
        lblFromDate.text = Date;
    }
    NSLog(@"selcted date %@",Date);

}

- (AAChartModel *)configureTheChartModel
{
    AAChartModel *aaChartModel= AAObject(AAChartModel)
    .titleSet(@"城市气温指数")
    .subtitleSet(@"虚拟数据")
    .yAxisTitleSet(@"摄氏度")
    .markerRadiusSet(@6)
//    .yAxisVisibleSet(true)
    .yAxisGridLineWidthSet(@0)
//    .symbolStyleSet(AAChartSymbolStyleTypeBorderBlank)
    .chartTypeSet(AAChartTypeLine)
    .categoriesSet(@[@"一月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月", @"九月", @"十月", @"十一月", @"十二月"])
    .dataLabelEnabledSet(true)
    .colorsThemeSet(@[@"#1e90ff",@"#EA007B", @"#49C1B6", @"#FDC20A", @"#F78320", @"#068E81",])
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .typeSet(AAChartTypeColumnrange)
                 .nameSet(@"温度")
                 .dataSet(@[
                            @[@(-9.7), @9.4],
                            @[@(-8.7), @6.5],
                            @[@(-3.5), @9.4],
                            @[@(-1.4),@19.9],
                            @[@0.0 ,  @22.6],
                            @[@2.9 ,  @29.5],
                            @[@9.2 ,  @30.7],
                            @[@7.3 ,  @26.5],
                            @[@4.4 ,  @18.0],
                            @[@(-3.1),@11.4],
                            @[@(-5.2),@10.4],
                            @[@(-9.9),@16.8]
                            ]),
                 
                 AAObject(AASeriesElement)
                 .typeSet(AAChartTypeSpline)
                 .nameSet(@"东京")
                 .dataSet(@[@7.0, @6.9, @9.5, @14.5, @18.2, @21.5, @25.2, @26.5, @23.3, @18.3, @13.9, @9.6]),
                 
                 AAObject(AASeriesElement)
                 .typeSet(AAChartTypeBar)
                 .nameSet(@"Pandian")
                 .dataSet(@[
                            @[@(-9.7), @9.4],
                            @[@(-8.7), @6.5],
                            @[@(-3.5), @9.4],
                            @[@(-1.4),@19.9],
                            @[@0.0 ,  @22.6],
                            @[@2.9 ,  @29.5],
                            @[@9.2 ,  @30.7],
                            @[@7.3 ,  @26.5],
                            @[@4.4 ,  @18.0],
                            @[@(-3.1),@11.4],
                            @[@(-5.2),@10.4],
                            @[@(-9.9),@16.8]
                            ]),
                  AAObject(AASeriesElement)
                  .typeSet(AAChartTypeLine)
                  .nameSet(@"纽约")
                  .dataSet(@[@-0.2, @0.8, @5.7, @11.3, @17.0, @22.0, @24.8, @24.1, @20.1, @14.1, @8.6, @2.5]),

                  AAObject(AASeriesElement)
                  .typeSet(AAChartTypeLine)
                  .nameSet(@"柏林")
                  .dataSet(@[@-0.9, @0.6, @3.5, @8.4, @13.5, @17.0, @18.6, @17.9, @14.3, @9.0, @3.9, @1.0]),

                  AAObject(AASeriesElement)
                  .typeSet(AAChartTypeLine)
                  .nameSet(@"伦敦")
                  .dataSet(@[@3.9, @4.2, @5.7, @8.5, @11.9, @15.2, @17.0, @16.6, @14.2, @10.3, @6.6, @4.8]),
                 ]
               );
    return aaChartModel;
                 
}
-(void)combinedMultibarChart
{
    AAChartModel *aaChartModel= AAObject(AAChartModel)
    .chartTypeSet(@"column")//图表类型
    .titleSet(@"")//图表主标题
    .subtitleSet(@"")//图表副标题
//    .yAxisVisibleSet(true)//设置 Y 轴是否可见
    .colorsThemeSet(@[@"#fe117c",@"#ffc069",@"#06caf4",@"#7dffc0"])//设置主体颜色数组
    .yAxisTitleSet(@"")//设置 Y 轴标题
//    .tooltipValueSuffixSet(@"℃")//设置浮动提示框单位后缀
    .backgroundColorSet(@"#4b2b7f")
    .yAxisGridLineWidthSet(@0.3)//y轴横向分割线宽度
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .typeSet(AAChartTypeColumnrange)
                 .nameSet(@"2017")
                 .dataSet(@[@7.0, @6.9, @9.5, @14.5, @18.2, @21.5, @25.2, @26.5, @23.3, @18.3, @13.9, @9.6]),
                 AAObject(AASeriesElement)
                 .typeSet(AAChartTypeSpline)
                 .nameSet(@"2018")
                 .dataSet(@[@0.2, @0.8, @5.7, @11.3, @17.0, @22.0, @24.8, @24.1, @20.1, @14.1, @8.6, @2.5]),
                 AAObject(AASeriesElement)
                 .nameSet(@"2019")
                 .dataSet(@[@0.9, @0.6, @3.5, @8.4, @13.5, @17.0, @18.6, @17.9, @14.3, @9.0, @3.9, @1.0]),
                 AAObject(AASeriesElement)
                 .nameSet(@"2020")
                 .dataSet(@[@3.9, @4.2, @5.7, @8.5, @11.9, @15.2, @17.0, @16.6, @14.2, @10.3, @6.6, @4.8]),
                 ]
               );
    
    aaChartModel.categories = @[@"Java", @"Swift", @"Python", @"Ruby", @"PHP", @"Go", @"C", @"C#", @"C++", @"Perl", @"R", @"MATLAB", @"SQL"];//设置 X 轴坐标内容
//    [self.aaChartView aa_drawChartWithChartModel:aaChartModel];
    [self.chartView aa_drawChartWithChartModel:aaChartModel];



}

-(void)selectedtableValue:(NSString *)selectedValue andIndex:(NSIndexPath *)indexPath
{
    NSLog(@"VALUE %@ ",selectedValue);
    
    switch (selectedButton) {
        case 0:
            lblGameName.text = selectedValue;
            lblGameName.tag = indexPath.row;
            
            break;
        case 1:
            lblTeamName.text = selectedValue;
            lblTeamName.tag = indexPath.row;
            
            break;
        case 2:
            lblPlayersName.text = selectedValue;
            lblPlayersName.tag = indexPath.row;
            
            break;
        case 4:
            lblAssValue1.text = selectedValue;
            lblAssValue1.tag = indexPath.row;
            
            break;
        case 5:
            lblAssValue2.text = selectedValue;
            lblAssValue2.tag = indexPath.row;
            
            break;
            
        default:
            break;
    }

}

-(void)multiSelectedValue:(NSString *)MultiString andRelatedCollection:(NSArray *)array
{
    [selectedPlayers removeAllObjects];
    [selectedPlayers addObjectsFromArray:array];
    [selectedPlayers removeObjectAtIndex:0];
    NSLog(@"multiSelectedValue %@",MultiString);
    lblPlayersName.text = MultiString;
}

@end
