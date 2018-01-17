//
//  QuestionaryVC.m
//  AlphaProTracker
//
//  Created by Lexicon on 30/08/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "QuestionaryVC.h"
#import "CustomNavigation.h"
#import "AppCommon.h"
#import "SACalendar.h"
#import "HomeVC.h"
#import "Config.h"
#import "WebService.h"



@interface QuestionaryVC ()
{
    NSString * SelectClientCode;
    NSString * SelectModuleCode;
    NSString * SelectCreatedby;
    NSString * SelectUserref;
    NSString * Selecttopic;
    NSString * Selectsubtopic;
    NSString * Selectdte;
    
    NSString * topicCode;
    NSString *actualDate;
    
    NSString * ButtonType;
    
    NSString * AnswerKey;
    
    
    BOOL isTopic;
    BOOL isSubtopic;
    
    
    BOOL isDate;
  
    
}

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * pop_viewTblXposition;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * pop_viewTblYposition;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * tableWidth;

@property (nonatomic,strong)  NSMutableArray *topicsliist;
@property (nonatomic,strong)  NSMutableArray *subtopicsliist;
@property (nonatomic,strong)  NSMutableArray *topics;
@property (nonatomic,strong)  NSMutableArray *subtopics;

@property (nonatomic,strong)  NSMutableArray *mainliist;

@property (nonatomic,strong)  NSMutableArray *questionlist;
@property (nonatomic,strong)  NSMutableArray *question;
@property (nonatomic,strong)  NSMutableArray *questionCode;
@property (nonatomic,strong)  NSMutableArray *questionreCode;
@property (nonatomic,strong)  NSMutableArray *answer;

@property (nonatomic,strong)  NSMutableArray *TextFieldanswer;


@end

@implementation QuestionaryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //[COMMON AddMenuView:self.view];
    self.question = [[NSMutableArray alloc]init];
    self.questionCode = [[NSMutableArray alloc]init];
    
    self.questionreCode = [[NSMutableArray alloc]init];
    
    self.TextFieldanswer = [[NSMutableArray alloc]init];
    
    self.onsetview.layer.borderWidth=0.5f;
    self.onsetview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.topicview.layer.borderWidth=0.5f;
    self.topicview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.subtopicview.layer.borderWidth=0.5f;
    self.subtopicview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.pop_view.hidden=YES;
    self.save.hidden=YES;
    self.update.hidden=YES;
    self.delet.hidden=YES;
    
    self.topicsliist =[[NSMutableArray alloc]init];
    self.subtopicsliist =[[NSMutableArray alloc]init];
    self.mainliist =[[NSMutableArray alloc]init];
    
    
    
    if([self.Scrname isEqualToString:@"Physio"])
    {
        self.modulecode = @"MSC084";
    }
    else if([self.Scrname isEqualToString:@"S and C"])
    {
        self.modulecode = @"MSC085";
    }
    else if([self.Scrname isEqualToString:@"Coach"])
    {
        self.modulecode = @"MSC086";
    }
    
    NSLog(@"%@", self.modulecode);
    
    
    
    [self questionWebservice:SelectCreatedby :SelectClientCode :SelectUserref :SelectModuleCode];
    
    [self customnavigationmethod];
    // Do any additional setup after loading the view.
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
    objCustomNavigation.tittle_lbl.text=[NSString stringWithFormat:@"%@ Questionnaire",self.Scrname];
    
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

-(IBAction)didClickcalBtn:(id)sender
{
    
    isTopic=NO;
    isSubtopic =NO;
    isDate=YES;
    
    SACalendar *calendar = [[SACalendar alloc]initWithFrame:CGRectMake(self.onsetview.frame.origin.x-135,self.onsetview.frame.origin.y+self.onsetview.frame.size.height+5,self.view.frame.size.width,self.view.frame.size.height-340) scrollDirection:ScrollDirectionVertical pagingEnabled:NO];
    
    calendar.delegate = self;
    //    NSString * currentDate =[NSString stringWithFormat:@"%d-%02d-%02d",year,month,day];
    //    self.callbl.text = currentDate;
    
    [self.view addSubview:calendar];
    
}
-(void) SACalendar:(SACalendar*)calendar didSelectDate:(int)day month:(int)month year:(int)year
{
    NSString * selectdate =[NSString stringWithFormat:@"%d-%02d-%02d",year,month,day];
    
    self.onsetlbl.text = selectdate;
    
    actualDate = selectdate;
    calendar.hidden = YES;
    
    if( ![self.onsetlbl.text isEqualToString:@""] && ![self.topiclbl.text isEqualToString:@""])
    {
        [self dateWebservice:SelectCreatedby :SelectClientCode :SelectUserref :SelectModuleCode:Selecttopic:Selectsubtopic:Selectdte];
    }
}

-(IBAction)didClicktopic:(id)sender
{
    if(isTopic==NO)
    {
    isTopic=YES;
    isSubtopic =NO;
    isDate=NO;
    
    self.pop_view.hidden=NO;

//    NSString *ss = @"Select";
//    [self.mainliist addObject:ss];
//    for(int i=0; self.topics.count>i;i++)
//    {
//        NSMutableDictionary * objDic =[self.topics objectAtIndex:i];
//        [self.mainliist addObject:objDic];
//    }
     self.mainliist = self.topics;
    //self.pop_viewTblXposition.constant = self.topicview.frame.origin.x;
    self.pop_viewTblYposition.constant = self.topicview.frame.origin.y+self.subtopicview.frame.size.height-160;
    
    self.tableWidth.constant = self.topicview.frame.size.width;
    
    [self.pop_view reloadData];
    }
    else{
        
        isTopic=NO;
        isSubtopic =YES;
        self.pop_view.hidden=YES;
        [self.pop_view reloadData];
        //[self.popList setUserInteractionEnabled:NO];
    }

    
}
-(IBAction)didClickSubtopic:(id)sender
{
    if(isSubtopic==NO)
    {
    isTopic=NO;
    isSubtopic =YES;
    isDate=NO;
    self.pop_view.hidden=NO;
    self.mainliist = self.subtopics;
    //self.pop_viewTblXposition.constant = self.subtopicview.frame.origin.x;
    self.pop_viewTblYposition.constant = self.subtopicview.frame.origin.y+self.subtopicview.frame.size.height-160;
    self.tableWidth.constant = self.subtopicview.frame.size.width;
    [self.pop_view reloadData];
    }
    else{
        
        isTopic=YES;
        isSubtopic =NO;
        self.pop_view.hidden=YES;
        [self.pop_view reloadData];
        //[self.popList setUserInteractionEnabled:NO];
    }

}

-(void)questionWebservice :(NSString *) createdby :(NSString *) cliendcode :(NSString *)userref:(NSString*)module
{
    [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",questionaryKey]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        
        NSString *cliendcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
        NSString *createdby = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
        NSString *userrefcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(createdby)   [dic    setObject:createdby     forKey:@"Createdby"];
        if(cliendcode)   [dic    setObject:cliendcode     forKey:@"Clientcode"];
        if(userrefcode)   [dic    setObject:userrefcode     forKey:@"Userreferencecode"];
        if(self.modulecode)   [dic    setObject:self.modulecode     forKey:@"Modulecode"];
        
        
        NSLog(@"parameters : %@",dic);
        [manager POST: URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            if(responseObject >0)
            {
                
                
                self.topicsliist = [[NSMutableArray alloc]init];
                self.topicsliist = [responseObject valueForKey:@"lsttopic"];
                
                self.topics = [[NSMutableArray alloc]init];
                self.topics = [self.topicsliist valueForKey:@"Topic"];

                self.subtopicsliist = [[NSMutableArray alloc]init];
                self.subtopicsliist = [responseObject valueForKey:@"lstsubtopic"];
                
                self.subtopics = [[NSMutableArray alloc]init];
                self.subtopics = [self.subtopicsliist valueForKey:@"Subtopic"];

                

                
                
                
            }
            
            [self.pop_view reloadData];
            
            [COMMON RemoveLoadingIcon];
            [self.view setUserInteractionEnabled:YES];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed");
            [COMMON webServiceFailureError];
            [self.view setUserInteractionEnabled:YES];
            
        }];
    }
    
}

-(void)validation
{
    if([self.topiclbl.text isEqualToString:@"Select"] || [self.topiclbl.text isEqualToString:@""])
    {
        
    }
}


-(void)dateWebservice :(NSString *) createdby :(NSString *) cliendcode :(NSString *)userref:(NSString*)module :(NSString*)topiccde :(NSString*)subTopiccde :(NSString*)date
{
    [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",DatequestionaryKey]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        
        NSString *cliendcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
        NSString *createdby = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
        NSString *userrefcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
        
        NSString *subTopiccode =@"";
        
        
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(createdby)   [dic    setObject:createdby     forKey:@"Createdby"];
        if(cliendcode)   [dic    setObject:cliendcode     forKey:@"Clientcode"];
        if(userrefcode)   [dic    setObject:userrefcode     forKey:@"Playercode"];
        if(self.modulecode)   [dic    setObject:self.modulecode     forKey:@"Modulecode"];
        if(topicCode)   [dic    setObject:topicCode     forKey:@"Topiccode"];
        if(subTopiccode)   [dic    setObject:subTopiccode     forKey:@"SubtopicCode"];
        if(actualDate)   [dic    setObject:actualDate     forKey:@"Date"];
        
        
        NSLog(@"parameters : %@",dic);
        [manager POST: URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            if(responseObject >0)
            {
                
                ButtonType = [responseObject valueForKey:@"ButtonType"];
                
                if([[responseObject valueForKey:@"ButtonType"] isEqualToString:@"Save"])
                {
                    NSMutableArray *arr = [[NSMutableArray alloc]init];
                    
                    arr = [responseObject valueForKey:@"lstQuestion"];
                    
                    if (arr == (id)[NSNull null] || [arr count] == 0)
                    {
                        
                        self.save.hidden=YES;
                        self.update.hidden=YES;
                        self.delet.hidden=YES;
                        self.Quetionlist.hidden = YES;
                        [self.Quetionlist reloadData];
                    }
                    
                    else
                    {

                        self.save.hidden=NO;
                        self.update.hidden=YES;
                        self.delet.hidden=YES;
                    
                        self.questionlist = [[NSMutableArray alloc]init];
                        self.questionlist = [responseObject valueForKey:@"lstQuestion"];
                        self.question = [self.questionlist valueForKey:@"QuestionName"];
                    
                        self.questionCode = [self.questionlist valueForKey:@"Questioncode"];
                        self.Quetionlist.hidden =NO;
                        [self.Quetionlist reloadData];
                    }
                    
                }
                if([[responseObject valueForKey:@"ButtonType"] isEqualToString:@"Update"])
                {
                    
                    self.questionlist = [[NSMutableArray alloc]init];
                    self.answer = [[NSMutableArray alloc]init];
                    
                    NSMutableArray *arr = [[NSMutableArray alloc]init];
                    
                    arr = [responseObject valueForKey:@"lstQuestion"];
                    
                    if (arr == (id)[NSNull null] || [arr count] == 0)
                    {
                    
                        self.save.hidden=YES;
                        self.update.hidden=YES;
                        self.delet.hidden=YES;
                       [self.Quetionlist reloadData];
                    }
                    else
                    {
                        
                        self.questionlist = [responseObject valueForKey:@"lstQuestion"];
                        self.question = [self.questionlist valueForKey:@"QuestionName"];
                        self.answer = [self.questionlist valueForKey:@"Answer"];
                        
                        self.questionCode = [self.questionlist valueForKey:@"Questioncode"];
                        self.questionreCode = [self.questionlist valueForKey:@"Questionairecode"];
                        self.save.hidden=YES;
                        self.update.hidden=NO;
                        self.delet.hidden=NO;
                        self.Quetionlist.hidden =NO;
                        [self.Quetionlist reloadData];
                        
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






- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    
    if(isDate)
    {
       return self.questionlist.count;
    }
   if(isTopic)
    {
        return self.mainliist.count;
    }
    if(isSubtopic)
    {
        return self.mainliist.count;
    }

    return nil;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(isDate)
    {
        isDate =YES;
        static NSString *cellid = @"cell";

        QuestionaryCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        
        if (cell == nil) {
            
            [[NSBundle mainBundle] loadNibNamed:@"QuestionaryCell" owner:self options:nil];
    
            cell = self.QusCell;
            
        }

        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.q1.text = self.question[indexPath.row];
        
        NSMutableArray *numArray = [[NSMutableArray alloc]init];
        
        for(int i=0;self.question.count>i;i++)
        {
            int  num = i+1;
            
            NSString *numStr = [NSString stringWithFormat:@"%d", num];
            [numArray addObject:numStr];
        }
        cell.sno.text = numArray[indexPath.row] ;
        
        if([ButtonType isEqualToString:@"Save"])
        {
            cell.editTxt.text = @"";
            
            
        }
        
        if([ButtonType isEqualToString:@"Update"])
        {
            cell.editTxt.text = self.answer[indexPath.row];
        }
    
//        for(int i=0;self.question.count>i;i++)
//        {
//            AnswerKey = cell.editTxt.text;
//            
//            [self.TextFieldanswer addObject:AnswerKey];
//        }
//

        
           // self.TextFieldanswer = cell.retArray1;
        
        return cell;
        
    }
  
    else if(isTopic)
    {
    
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell==nil) {
        //[[NSBundle mainBundle] loadNibNamed:@"assemntCell" owner:self options:nil];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier];
        
    }
        
        
    
    cell.textLabel.text = self.mainliist[indexPath.row];
    
    
        return cell;
    }
    else if(isSubtopic)
    {
        
        static NSString *MyIdentifier = @"MyIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        if (cell==nil) {
            //[[NSBundle mainBundle] loadNibNamed:@"assemntCell" owner:self options:nil];
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:MyIdentifier];
            
        }
        
        cell.textLabel.text = self.mainliist[indexPath.row];
        
        
        return cell;
    }

    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    if(isDate)
//    {
//        static NSString *cellid = @"cell";
//        
//        QuestionaryCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
//        
//        if(indexPath.row == 0)
//        {
//            AnswerKey = cell.editTxt.text;
//        }
//        
//        if(indexPath.row == 1)
//        {
//            AnswerKey = cell.editTxt.text;
//        }
//        
////        for(int i=0;self.question.count>i;i++)
////        {
////              AnswerKey = cell.editTxt.text;
////            
////        [self.TextFieldanswer addObject:AnswerKey];
////        }
//    }
//
    
    if(isTopic)
    {
        
        
        self.topiclbl.text = self.mainliist[indexPath.row];
            
            self.pop_view.hidden=YES;
        
        
        self.topiclbl.text = self.mainliist[indexPath.row];
       
        
            NSMutableArray *codeArray = [[NSMutableArray alloc]init];
            codeArray = [self.topicsliist valueForKey:@"Topiccode"];
            topicCode = [codeArray objectAtIndex:indexPath.row];
        
        self.pop_view.hidden=YES;
        
        isDate=YES;
        isTopic=NO;
        isSubtopic=NO;
        
        
        if( ![self.onsetlbl.text isEqualToString:@""] && ![self.topiclbl.text isEqualToString:@""])
        {
            [self dateWebservice :SelectCreatedby :SelectClientCode :SelectUserref :SelectModuleCode:Selecttopic:Selectsubtopic:Selectdte];
        }
      
        
    }
    
    if(isSubtopic)
    {
        self.subtopiclbl.text = self.mainliist[indexPath.row];
        self.pop_view.hidden=YES;
    }

    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if(isDate)
    {
       return 80;
    }
    
    else
    {
        return 30;
    }
    
}




-(IBAction)SaveAction:(id)sender
{
    isDate = YES;
    ButtonType = @"SAVE";
    
        [self SaveWebservice:SelectCreatedby :SelectClientCode :SelectUserref :SelectModuleCode:Selecttopic:Selectsubtopic:Selectdte:Selectdte:Selectdte];
        [self.Quetionlist reloadData];

    
}
-(IBAction)UpdateAction:(id)sender
{
    isDate = YES;
    ButtonType = @"UPDATE";
    [self UpdateWebservice:SelectCreatedby :SelectClientCode :SelectUserref :SelectModuleCode:Selecttopic:Selectsubtopic:Selectdte:Selectdte:Selectdte];
    [self.Quetionlist reloadData];
}
-(IBAction)DeleteAction:(id)sender
{
    isDate = YES;
    ButtonType = @"DELETE";
    [self DeleteWebservice:SelectCreatedby :SelectClientCode :SelectUserref :SelectModuleCode:Selecttopic:Selectsubtopic:Selectdte:Selectdte:Selectdte];
    [self.Quetionlist reloadData];
}

-(void)SaveWebservice :(NSString *) createdby :(NSString *) cliendcode :(NSString *)userref:(NSString*)module :(NSString*)topiccde :(NSString*)subTopiccde :(NSString*)date :(NSString*)date :(NSString*)date
{
    [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        
        NSMutableArray *userDetails = [[NSMutableArray alloc] init];
        for(int i=0;i<self.question.count;i++){
            QuestionaryCell *cell = [self.Quetionlist cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            //NSDictionary *userDictionary = [[NSDictionary alloc] initWithObjectsAndKeys: cell.editTxt.text, nil];
            
            AnswerKey = cell.editTxt.text;
            [userDetails addObject:AnswerKey];
        }
        NSLog(@"%@", userDetails);
        
    
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",SavequestionaryKey]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        
        NSString *cliendcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
        NSString *createdby = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
        NSString *userrefcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
        
        NSString *subTopiccode =@"0";
        
        NSString *QsCode =@"";

        
        NSMutableArray *codeArray = [[NSMutableArray alloc]init];
        
        codeArray = [self.topicsliist valueForKey:@"Topiccode"];
        topicCode = [codeArray objectAtIndex:0];
        
        NSMutableArray * objArray =[[NSMutableArray alloc]init];
        for (int i=0; i<self.questionCode.count;i++)
        {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            
            if([userDetails objectAtIndex:i])   [dic    setObject:[userDetails objectAtIndex:i]     forKey:@"Answer"];
            
            if([self.questionCode objectAtIndex:i])   [dic    setObject:[self.questionCode objectAtIndex:i]     forKey:@"Questioncode"];
            
            if(createdby)   [dic    setObject:createdby      forKey:@"Createdby"];
            //NSString *QScode = [self.questionCode objectAtIndex:i];
            
            [objArray addObject:dic];
        }

        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(createdby)   [dic    setObject:createdby     forKey:@"Createdby"];
        if(cliendcode)   [dic    setObject:cliendcode     forKey:@"Clientcode"];
        if(userrefcode)   [dic    setObject:userrefcode     forKey:@"Playercode"];
        if(self.modulecode)   [dic    setObject:self.modulecode     forKey:@"Modulecode"];
        if(topicCode)   [dic    setObject:topicCode     forKey:@"Topiccode"];
        if(subTopiccode)   [dic    setObject:subTopiccode     forKey:@"SubtopicCode"];
        if(actualDate)   [dic    setObject:actualDate     forKey:@"Date"];
        if(QsCode)   [dic    setObject:QsCode     forKey:@"Questionairecode"];
        if(ButtonType)   [dic    setObject:ButtonType     forKey:@"Status"];
        if(objArray)   [dic    setObject:objArray     forKey:@"lstQuestion"];
        
        
        NSLog(@"parameters : %@",dic);
        [manager POST: URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            if(responseObject >0)
            {
                
                
                self.onsetlbl.text = @"";
                self.subtopiclbl.text = @"";
                self.Quetionlist.hidden = YES;
                self.save.hidden=YES;
                self.update.hidden=YES;
                self.delet.hidden=YES;
                
                [self ShowAlterMsg:@" Saved Successfully "];
            }
            
            [self.Quetionlist reloadData];
            
            [COMMON RemoveLoadingIcon];
            [self.view setUserInteractionEnabled:YES];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed");
            [COMMON webServiceFailureError];
            [self.view setUserInteractionEnabled:YES];
            
        }];
    }
    
}

-(void)UpdateWebservice :(NSString *) createdby :(NSString *) cliendcode :(NSString *)userref:(NSString*)module :(NSString*)topiccde :(NSString*)subTopiccde :(NSString*)date :(NSString*)date :(NSString*)date
{
    [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        
        NSMutableArray *userDetails = [[NSMutableArray alloc] init];
        for(int i=0;i<self.question.count;i++){
            QuestionaryCell *cell = [self.Quetionlist cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            //NSDictionary *userDictionary = [[NSDictionary alloc] initWithObjectsAndKeys: cell.editTxt.text, nil];
            
            AnswerKey = cell.editTxt.text;
            [userDetails addObject:AnswerKey];
        }
        NSLog(@"%@", userDetails);
        
        
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",SavequestionaryKey]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        
        NSString *cliendcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
        NSString *createdby = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
        NSString *userrefcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
        
        NSString *subTopiccode =@"0";
        
        NSString *QsCode = [self.questionreCode objectAtIndex:0];
        
        
        NSMutableArray *codeArray = [[NSMutableArray alloc]init];
        
        codeArray = [self.topicsliist valueForKey:@"Topiccode"];
        topicCode = [codeArray objectAtIndex:0];
        
        NSMutableArray * objArray =[[NSMutableArray alloc]init];
        for (int i=0; i<self.questionCode.count;i++)
        {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            
            if([userDetails objectAtIndex:i])   [dic    setObject:[userDetails objectAtIndex:i]     forKey:@"Answer"];
            
            if([self.questionCode objectAtIndex:i])   [dic    setObject:[self.questionCode objectAtIndex:i]     forKey:@"Questioncode"];
            
            if(createdby)   [dic    setObject:createdby      forKey:@"Createdby"];
            //NSString *QScode = [self.questionCode objectAtIndex:i];
            
            [objArray addObject:dic];
        }
        
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(createdby)   [dic    setObject:createdby     forKey:@"Createdby"];
        if(cliendcode)   [dic    setObject:cliendcode     forKey:@"Clientcode"];
        if(userrefcode)   [dic    setObject:userrefcode     forKey:@"Playercode"];
        if(self.modulecode)   [dic    setObject:self.modulecode     forKey:@"Modulecode"];
        if(topicCode)   [dic    setObject:topicCode     forKey:@"Topiccode"];
        if(subTopiccode)   [dic    setObject:subTopiccode     forKey:@"SubtopicCode"];
        if(actualDate)   [dic    setObject:actualDate     forKey:@"Date"];
        if(QsCode)   [dic    setObject:QsCode     forKey:@"Questionairecode"];
        if(ButtonType)   [dic    setObject:ButtonType     forKey:@"Status"];
        if(objArray)   [dic    setObject:objArray     forKey:@"lstQuestion"];
        
        
        NSLog(@"parameters : %@",dic);
        [manager POST: URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            if(responseObject >0)
            {
                
                self.onsetlbl.text = @"";
                self.subtopiclbl.text = @"";
                self.Quetionlist.hidden = YES;
                self.save.hidden=YES;
                self.update.hidden=YES;
                self.delet.hidden=YES;
                [self ShowAlterMsg:@" Updated Successfully "];
                
            }
            
            [self.Quetionlist reloadData];
            
            [COMMON RemoveLoadingIcon];
            [self.view setUserInteractionEnabled:YES];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed");
            [COMMON webServiceFailureError];
            [self.view setUserInteractionEnabled:YES];
            
        }];
    }
    
}
-(void)DeleteWebservice :(NSString *) createdby :(NSString *) cliendcode :(NSString *)userref:(NSString*)module :(NSString*)topiccde :(NSString*)subTopiccde :(NSString*)date :(NSString*)date :(NSString*)date
{
    [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        
        NSMutableArray *userDetails = [[NSMutableArray alloc] init];
        for(int i=0;i<self.question.count;i++){
            QuestionaryCell *cell = [self.Quetionlist cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            //NSDictionary *userDictionary = [[NSDictionary alloc] initWithObjectsAndKeys: cell.editTxt.text, nil];
            
            AnswerKey = cell.editTxt.text;
            [userDetails addObject:AnswerKey];
        }
        NSLog(@"%@", userDetails);
        
        
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",SavequestionaryKey]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        
        NSString *cliendcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
        NSString *createdby = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
        NSString *userrefcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
        
        NSString *subTopiccode =@"0";
        
        NSString *QsCode = [self.questionreCode objectAtIndex:0];
        
        
        NSMutableArray *codeArray = [[NSMutableArray alloc]init];
        
        codeArray = [self.topicsliist valueForKey:@"Topiccode"];
        topicCode = [codeArray objectAtIndex:0];
        
        NSMutableArray * objArray =[[NSMutableArray alloc]init];
        for (int i=0; i<self.questionCode.count;i++)
        {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            
            if([userDetails objectAtIndex:i])   [dic    setObject:[userDetails objectAtIndex:i]     forKey:@"Answer"];
            
            if([self.questionCode objectAtIndex:i])   [dic    setObject:[self.questionCode objectAtIndex:i]     forKey:@"Questioncode"];
            
            if(createdby)   [dic    setObject:createdby      forKey:@"Createdby"];
            //NSString *QScode = [self.questionCode objectAtIndex:i];
            
            [objArray addObject:dic];
        }
        
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(createdby)   [dic    setObject:createdby     forKey:@"Createdby"];
        if(cliendcode)   [dic    setObject:cliendcode     forKey:@"Clientcode"];
        if(userrefcode)   [dic    setObject:userrefcode     forKey:@"Playercode"];
        if(self.modulecode)   [dic    setObject:self.modulecode     forKey:@"Modulecode"];
        if(topicCode)   [dic    setObject:topicCode     forKey:@"Topiccode"];
        if(subTopiccode)   [dic    setObject:subTopiccode     forKey:@"SubtopicCode"];
        if(actualDate)   [dic    setObject:actualDate     forKey:@"Date"];
        if(QsCode)   [dic    setObject:QsCode     forKey:@"Questionairecode"];
        if(ButtonType)   [dic    setObject:ButtonType     forKey:@"Status"];
        if(objArray)   [dic    setObject:objArray     forKey:@"lstQuestion"];
        
        
        NSLog(@"parameters : %@",dic);
        [manager POST: URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            if(responseObject >0)
            {
                self.onsetlbl.text = @"";
                self.subtopiclbl.text = @"";
                self.Quetionlist.hidden = YES;
                self.save.hidden=YES;
                self.update.hidden=YES;
                self.delet.hidden=YES;
                [self ShowAlterMsg:@" Deleted Successfully "];
            }
            
            [self.Quetionlist reloadData];
            
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




-(IBAction)MenuBtnAction:(id)sender
{
   [COMMON ShowsideMenuView];
}
-(IBAction)btn_back:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
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

@end
