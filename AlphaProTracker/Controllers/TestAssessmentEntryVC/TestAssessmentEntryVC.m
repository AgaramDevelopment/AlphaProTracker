//
//  TestAssessmentEntryVC.m
//  AlphaProTracker
//
//  Created by Lexicon on 01/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//


#define  SCREEN_CODE_Rom  @"ASTT001"
#define  SCREEN_CODE_SPECIAL  @"ASTT002"
#define  SCREEN_CODE_MMT  @"ASTT003"
#define  SCREEN_CODE_GAINT  @"ASTT004"
#define  SCREEN_CODE_POSTURE  @"ASTT005"
#define  SCREEN_CODE_COACHING  @"ASTT007"
#define  SCREEN_CODE_S_C  @"ASTT006"


#import "TestAssessmentEntryVC.h"
#import "CustomNavigation.h"
#import "AppCommon.h"
#import "HomeVC.h"
#import "DBAConnection.h"



@interface TestAssessmentEntryVC ()
{
    NSString *clientCode;
    NSString * usercode;
    BOOL isLeft;
    BOOL isRight;
    BOOL isDescription;
    BOOL isCentral;
    BOOL isValue;
    BOOL isInterface;
    UIView * objSandCView;
}
@property (nonatomic,strong) NSMutableArray * ObjSelectTestArray;
@property (nonatomic,strong) DBAConnection * objDBConnection;
@property (nonatomic,strong) NSString *version;
@property (nonatomic,strong) NSString * ingnoreStatus;

@property (nonatomic,strong) NSMutableArray * CommonCombArray;

@property (nonatomic,strong) NSMutableArray * AssessmentTypeMMT;
@property (nonatomic,strong) NSMutableArray * AssessmentTypeGaint;
@property (nonatomic,strong) NSMutableArray * assessmentTestTypePosture;
@property (nonatomic,strong) NSMutableArray * assessmentTestTypeSpecial;
@property (nonatomic,strong) NSMutableArray * assessmentTestTypeCoach;


@property (nonatomic,strong) IBOutlet UIButton * IngoreBtn;
@property (nonatomic,strong) IBOutlet UIButton * saveBtn;


@end

@implementation TestAssessmentEntryVC
@synthesize IsEdit;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[COMMON AddMenuView:self.view];
    
    self.version = @"1";
    [self HideView];
    
    self.AssessmentLbl.text = [self.selectAllValueDic valueForKey:@"AssessmentTitle"];
    self.SectionLbl.text    = self.SectionTestCodeStr;
    self.TestLbl.text       = self.SelectTestStr;
    self.PlayerNameLbl.text = [self.selectAllValueDic valueForKey:@"PlayerName"];
    self.dateLbl.text       = [self.selectAllValueDic valueForKey:@"SelectDate"];
    
    self.objDBConnection = [[DBAConnection alloc]init];
    
    [self TestTypeMethod];
    
    self.right1view.layer.borderWidth=0.5f;
    self.right1view.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.right2view.layer.borderWidth=0.5f;
    self.right2view.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.left1view.layer.borderWidth=0.5f;
    self.left1view.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.left2view.layer.borderWidth=0.5f;
    self.left2view.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.centrl1view.layer.borderWidth=0.5f;
    self.centrl1view.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.centrl2view.layer.borderWidth=0.5f;
    self.centrl2view.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.descview.layer.borderWidth=0.5f;
    self.descview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    //    self.valueview.layer.borderWidth=0.5f;
    //    self.valueview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    //
    self.remarksview.layer.borderWidth=0.5f;
    self.remarksview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    //    self.interfaceview.layer.borderWidth=0.5f;
    //    self.interfaceview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    [self customnavigationmethod];
    
    self.IngoreBtn.layer.cornerRadius = 5;
    self.IngoreBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.IngoreBtn.layer.borderWidth = 1;
    self.IngoreBtn.layer.masksToBounds= YES;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [COMMON AddMenuView:self.view];
}
-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    
    NSString * selectTilteStr = [NSString stringWithFormat:@"%@ - %@ \n %@",[self.selectAllValueDic valueForKey:@"Module"],[self.selectAllValueDic valueForKey:@"AssessmentTitle"],[self.selectAllValueDic valueForKey:@"Team"]];
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text= selectTilteStr;
    objCustomNavigation.btn_back.hidden =NO;
    objCustomNavigation.menu_btn.hidden = YES;
    [objCustomNavigation.btn_back addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)HideView
{
    self.rightCombview.hidden = YES;
    self.rightView.hidden =YES;
    self.leftCombView.hidden =YES;
    self.leftView.hidden =YES;
    self.centralcombView.hidden =YES;
    self.descriptionCombView.hidden =YES;
    self.centralview.hidden =YES;
    //self.interfaceview.hidden =YES;
    // self.valueview.hidden =YES;
    self.interfacecombView.hidden = YES;
    self.valueCombView.hidden = YES;
    self.popTbl.hidden = YES;
}
-(void)TestTypeMethod
{
    self.ObjSelectTestArray =[[NSMutableArray alloc]init];
    clientCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    usercode = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
    if([SCREEN_CODE_Rom  isEqualToString:self.SelectScreenId])
    {
        if(IsEdit == YES)
        {
            [self.saveBtn setTitle:@"Update" forState:UIControlStateNormal];
            self.ObjSelectTestArray =[self.objDBConnection GetRomWithEntry:self.version :[self.selectAllValueDic valueForKey:@"AssessmentCode"] :self.ModuleStr : self.SectionTestCodeStr :clientCode :usercode :[self.selectAllValueDic valueForKey:@"PlayerCode"] :[self.selectAllValueDic valueForKey:@"SelectDate"] :self.SelectTestTypecode];
        }
        else{
            [self.saveBtn setTitle:@"Save" forState:UIControlStateNormal];
            self.ObjSelectTestArray =[self.objDBConnection getRomWithoutEntry:self.version :[self.selectAllValueDic valueForKey:@"AssessmentCode"] :self.ModuleStr :self.SectionTestCodeStr :clientCode :self.SelectTestTypecode];
        }
    }
    else if([SCREEN_CODE_SPECIAL isEqualToString:self.SelectScreenId])
    {
        self.assessmentTestTypeSpecial = [[NSMutableArray alloc]init];
        self.assessmentTestTypeSpecial =[self.objDBConnection getPositiveNegative];
        if(IsEdit == YES)
        {
            [self.saveBtn setTitle:@"Update" forState:UIControlStateNormal];
            
            self.ObjSelectTestArray = [self.objDBConnection getSpecWithEnrty:self.version :[self.selectAllValueDic valueForKey:@"AssessmentCode"] :self.ModuleStr :self.SectionTestCodeStr :clientCode :usercode :[self.selectAllValueDic valueForKey:@"PlayerCode"] :[self.selectAllValueDic valueForKey:@"SelectDate"] :self.SelectTestTypecode]; //[self.objDBConnection
        }
        else
        {
            [self.saveBtn setTitle:@"Save" forState:UIControlStateNormal];
            
            self.ObjSelectTestArray = [self.objDBConnection getSpecWithoutEnrty:self.version :[self.selectAllValueDic valueForKey:@"AssessmentCode"] :self.ModuleStr :self.SectionTestCodeStr :clientCode :self.SelectTestTypecode];  //
        }
        
    }
    else if ([SCREEN_CODE_MMT  isEqual: self.SelectScreenId])
    {
        self.AssessmentTypeMMT = [[NSMutableArray alloc]init];
        self.AssessmentTypeMMT =[self.objDBConnection getWithMmtCombo];
        if(IsEdit == YES)
        {
            [self.saveBtn setTitle:@"Update" forState:UIControlStateNormal];
            
            self.ObjSelectTestArray = [self.objDBConnection getMMTWithEnrty:self.version :self.ModuleStr :self.SectionTestCodeStr :clientCode :[self.selectAllValueDic valueForKey:@"AssessmentCode"] :usercode :[self.selectAllValueDic valueForKey:@"PlayerCode"] :[self.selectAllValueDic valueForKey:@"SelectDate"] :self.SelectTestTypecode];
        }
        else
        {
            [self.saveBtn setTitle:@"Save" forState:UIControlStateNormal];
            
            self.ObjSelectTestArray = [self.objDBConnection getMMTWithoutEnrty:self.version :self.ModuleStr :self.SectionTestCodeStr :clientCode :[self.selectAllValueDic valueForKey:@"AssessmentCode"] :self.SelectTestTypecode];
        }
    }
    else if ([SCREEN_CODE_GAINT  isEqual: self.SelectScreenId])
    {
        self.AssessmentTypeGaint =[[NSMutableArray alloc]init];
        self.AssessmentTypeGaint =[self.objDBConnection getResultCombo];
        if(IsEdit == YES)
        {
            [self.saveBtn setTitle:@"Update" forState:UIControlStateNormal];
            
            self.ObjSelectTestArray =[self.objDBConnection getGaintWithEnrty:self.version :self.ModuleStr :self.SectionTestCodeStr :clientCode :[self.selectAllValueDic valueForKey:@"AssessmentCode"] :usercode :[self.selectAllValueDic valueForKey:@"SelectDate"] :[self.selectAllValueDic valueForKey:@"PlayerCode"] :self.SelectTestTypecode];
        }
        else
        {
            [self.saveBtn setTitle:@"Save" forState:UIControlStateNormal];
            
            self.ObjSelectTestArray =[self.objDBConnection getGaintWithoutEnrty:self.version :self.ModuleStr :self.SectionTestCodeStr :clientCode :[self.selectAllValueDic valueForKey:@"AssessmentCode"] :self.SelectTestTypecode];
        }
    }
    else if ([SCREEN_CODE_S_C  isEqual: self.SelectScreenId])
    {
        if(IsEdit == YES)
        {
            [self.saveBtn setTitle:@"Update" forState:UIControlStateNormal];
            
            self.ObjSelectTestArray = [self.objDBConnection getSCWithEnrty:self.version :self.ModuleStr :self.SectionTestCodeStr :clientCode :[self.selectAllValueDic valueForKey:@"AssessmentCode"] :usercode :[self.selectAllValueDic valueForKey:@"SelectDate"] :[self.selectAllValueDic valueForKey:@"PlayerCode"] :self.SelectTestTypecode];
        }
        else
        {
            [self.saveBtn setTitle:@"Save" forState:UIControlStateNormal];
            
            self.ObjSelectTestArray =[self.objDBConnection getSCWithoutEnrty:self.version :self.ModuleStr :self.SectionTestCodeStr :clientCode :[self.selectAllValueDic valueForKey:@"AssessmentCode"]  :self.SelectTestTypecode];
        }
    }
    else if ([SCREEN_CODE_POSTURE  isEqual: self.SelectScreenId])
    {
        self.assessmentTestTypePosture =[[NSMutableArray alloc]init];
        self.assessmentTestTypePosture =[self.objDBConnection getwithPostureRESULTS];
        
        if(IsEdit ==  YES)
        {
            [self.saveBtn setTitle:@"Update" forState:UIControlStateNormal];
            
            self.ObjSelectTestArray =[self.objDBConnection getPostureWithEnrty:self.version :self.ModuleStr :self.SectionTestCodeStr :clientCode :[self.selectAllValueDic valueForKey:@"AssessmentCode"] :usercode :[self.selectAllValueDic valueForKey:@"PlayerCode"] :[self.selectAllValueDic valueForKey:@"SelectDate"] :self.SelectTestTypecode];
        }
        else
        {
            [self.saveBtn setTitle:@"Save" forState:UIControlStateNormal];
            
            self.ObjSelectTestArray = [self.objDBConnection getPostureWithoutEnrty:self.version :self.ModuleStr :self.SectionTestCodeStr :clientCode :[self.selectAllValueDic valueForKey:@"AssessmentCode"] :self.SelectTestTypecode];
        }
    }
    else if ([SCREEN_CODE_COACHING  isEqual: self.SelectScreenId])
    {
        self.assessmentTestTypeCoach =[[NSMutableArray alloc]init];
        if(IsEdit == YES)
        {
            [self.saveBtn setTitle:@"Update" forState:UIControlStateNormal];
            
            self.ObjSelectTestArray =[self.objDBConnection getTestCoachWithEnrty:self.version :self.ModuleStr :self.SectionTestCodeStr :clientCode :[self.selectAllValueDic valueForKey:@"AssessmentCode"] :usercode :[self.selectAllValueDic valueForKey:@"PlayerCode"] :[self.selectAllValueDic valueForKey:@"SelectDate"]:self.SelectTestTypecode];
            
        }
        else
        {
            [self.saveBtn setTitle:@"Save" forState:UIControlStateNormal];
            
            self.ObjSelectTestArray =[self.objDBConnection getTestCoachWithoutEnrty:self.version :self.ModuleStr :self.SectionTestCodeStr :clientCode :[self.selectAllValueDic valueForKey:@"AssessmentCode"] :self.SelectTestTypecode];
        }
        self.assessmentTestTypeCoach = [self.objDBConnection getTestcode:[[self.ObjSelectTestArray valueForKey:@"Kpi"] objectAtIndex:0]];
        
    }
    if(self.ObjSelectTestArray.count>0)
    {
         [self DesignTextMethod];
    }
}
-(void)DesignTextMethod
{
    if([SCREEN_CODE_Rom  isEqualToString:self.SelectScreenId])
    {
        NSDictionary * objDic = [self.ObjSelectTestArray objectAtIndex:0];
        if([[objDic valueForKey:@"romSideName"] isEqualToString:@"RIGHT & LEFT"])
        {
            self.leftView.hidden =NO;
            self.rightView.hidden = NO;
            self.left_lbl.userInteractionEnabled = YES;
            self.right_lbl.userInteractionEnabled = YES;
            self.centeral_Txt.userInteractionEnabled = YES;
            self.left_Txt.text = [objDic valueForKey:@"romLeft"];
            self.right_Txt.text = [objDic valueForKey:@"romRight"];
            self.rightViewYposition.constant = -40;
            self.leftViewYposition.constant  = self.rightViewYposition.constant+2;
            self.RemarkViewYposition.constant = self.leftViewYposition.constant-180;
            
            if([objDic valueForKey:@"ignored"] != NULL && [[objDic valueForKey:@"ignored"] isEqualToString:@"true"])
            {
                [self.IngoreBtn setImage:[UIImage imageNamed:@"rightMark"] forState:UIControlStateNormal];
                self.ingnoreStatus =@"True";
                self.left_lbl.userInteractionEnabled = NO;
                self.right_lbl.userInteractionEnabled = NO;
                self.centeral_Txt.userInteractionEnabled = NO;

            }
            else
            {
                [self.IngoreBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                self.ingnoreStatus =@"False";

            }
        }
        else if ([[objDic valueForKey:@"romSideName"] isEqualToString:@"CENTRAL"])
        {
            self.centeral_Txt.text = [objDic valueForKey:@"romCenter"];
            
            self.centralview.hidden = NO;
        }
        //self.remarkView.hidden = NO;
        _remark_Txt.text = [objDic valueForKey:@"Remarks"];
        self.interface_Txt.text = [objDic valueForKey:@"romInference"];
        
    }
    else if([SCREEN_CODE_MMT isEqualToString:self.SelectScreenId])
    {
        
        NSDictionary * objDic = [self.ObjSelectTestArray objectAtIndex:0];
        if([[objDic valueForKey:@"MmtSideName"] isEqualToString:@"RIGHT & LEFT"])
        {
            self.rightCombview.hidden = NO;
            self.leftCombView.hidden = NO;
            self.popviewwidth.constant = self.view.frame.size.width/2;
            self.rightCombViewYposition.constant = 10;
            self.leftCombViewYposition.constant  = self.rightCombViewYposition.constant-30;
            self.RemarkViewYposition.constant = self.leftCombViewYposition.constant-220;
            self.left_lbl.userInteractionEnabled = YES;
            self.right_lbl.userInteractionEnabled = YES;
            self.centeral_Txt.userInteractionEnabled = YES;
            self.CommonCombArray =[[NSMutableArray alloc]init];
            self.CommonCombArray = self.AssessmentTypeMMT;
            if(self.ObjSelectTestArray.count > 0)
            {
                for(int i=0; i< _AssessmentTypeMMT.count; i++)
                {
                    if([[[_AssessmentTypeMMT valueForKey:@"RESULTNAME"]objectAtIndex:i] isEqualToString:[objDic valueForKey:@"MmtRight"]])
                    {
                        //setvalue
                        self.right_lbl.text = [[self.AssessmentTypeMMT valueForKey:@"RESULTNAME"] objectAtIndex:i];
                        
                        break;
                    }
                }
                for(int i=0; i<_AssessmentTypeMMT.count; i++)
                {
                    if([[[_AssessmentTypeMMT valueForKey:@"RESULTNAME"]objectAtIndex:i] isEqualToString:[objDic valueForKey:@"MmtLeft"]])
                    {
                        //setvalue
                        self.left_lbl.text = [[self.AssessmentTypeMMT valueForKey:@"RESULTNAME"] objectAtIndex:i];
                        
                        break;
                    }
                }
            }
        }
        else if([[objDic valueForKey:@"MmtSideName"] isEqualToString:@"CENTRAL"])
        {
            self.centralcombView.hidden = NO;
            self.CommonCombArray =[[NSMutableArray alloc]init];
            
            
            if(self.ObjSelectTestArray.count>0)
            {
                for(int i=0; i<_AssessmentTypeMMT.count; i++)
                {
                    if([[_AssessmentTypeMMT valueForKey:@"RESULTNAME"] isEqualToString:[objDic valueForKey:@"MmtCenter"]])
                    {
                        //setvalue
                        self.centeral_Txt.text = [[self.AssessmentTypeMMT valueForKey:@"RESULTNAME"] objectAtIndex:i];
                        
                        
                        break;
                    }
                }
            }
        }
        self.remark_Txt.text =[objDic valueForKey:@"Remark"];
        if([objDic valueForKey:@"ignored"] != NULL && [[objDic valueForKey:@"ignored"] isEqualToString:@"true"])
        {
            [self.IngoreBtn setImage:[UIImage imageNamed:@"rightMark"] forState:UIControlStateNormal];
            self.ingnoreStatus =@"true";
            self.left_lbl.userInteractionEnabled = NO;
            self.right_lbl.userInteractionEnabled = NO;
            self.centeral_Txt.userInteractionEnabled = NO;
        }
        else
        {
            [self.IngoreBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            self.ingnoreStatus =@"false";
        }
        
    }
    else if ([SCREEN_CODE_S_C isEqualToString:self.SelectScreenId])
    {
        NSDictionary * objDic = [self.ObjSelectTestArray objectAtIndex:0];
        
       
        
        self.remark_Txt.text =[objDic valueForKey:@"Remarks"];
        int noofTrails;
        NSString * count =[objDic valueForKey:@"Nooftrials"];
        noofTrails =[count intValue];

        objSandCView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,noofTrails*90)];
        if([[objDic valueForKey:@"SideName"] isEqualToString:@"RIGHT & LEFT"])
        {
            self.RemarkViewYposition.constant = noofTrails*80-400;

        for(int i=0; i< noofTrails; i++)
        {
            
            UILabel * Rightlbl = (i==0)?[[UILabel alloc]initWithFrame:CGRectMake(10, i*40,self.view.frame.size.width/2, 30)] : [[UILabel alloc]initWithFrame:CGRectMake(10, (i+1)*40,self.view.frame.size.width/2, 30)];
            Rightlbl.text = (i==0)?@"Right":[NSString stringWithFormat:@"Right%d",i+1];
            Rightlbl.textColor=[UIColor whiteColor];
            [objSandCView addSubview:Rightlbl];

            UITextField * trail1 = (i==0)?[[UITextField alloc]initWithFrame:CGRectMake(Rightlbl.frame.size.width+5,i*40,self.view.frame.size.width/2.1,30)] :[[UITextField alloc]initWithFrame:CGRectMake(Rightlbl.frame.size.width+5,(i+1)*40,self.view.frame.size.width/2.1,30)];
            trail1.textColor=[UIColor whiteColor];

            trail1.layer.borderColor = [UIColor lightGrayColor].CGColor;
            trail1.backgroundColor =[UIColor colorWithRed:(0/255.0f) green:(0/255.0f) blue:(0/255.0f) alpha:0.27];

            trail1.layer.borderWidth =0.5;
            trail1.layer.masksToBounds = YES;
            [objSandCView addSubview:trail1];
            
            UILabel * leftLbl = (i==0)?[[UILabel alloc]initWithFrame:CGRectMake(10, (i+1)*40,self.view.frame.size.width/2,30)]:[[UILabel alloc]initWithFrame:CGRectMake(10, (i+2)*40,self.view.frame.size.width/2,30)];
            leftLbl.textColor=[UIColor whiteColor];

            leftLbl.text = (i==0)? @"Left":[NSString stringWithFormat:@"Left%d",i+1];
            [objSandCView addSubview:leftLbl];
            
            UITextField * trail2 = (i==0)?[[UITextField alloc]initWithFrame:CGRectMake(leftLbl.frame.size.width+5, (i+1)*40, self.view.frame.size.width/2.1,30)]:[[UITextField alloc]initWithFrame:CGRectMake(leftLbl.frame.size.width+5, (i+2)*40, self.view.frame.size.width/2.1,30)];
            trail2.textColor=[UIColor whiteColor];
            trail2.backgroundColor =[UIColor colorWithRed:(0/255.0f) green:(0/255.0f) blue:(0/255.0f) alpha:0.27];
            trail2.layer.borderColor = [UIColor lightGrayColor].CGColor;
            trail2.layer.borderWidth =0.5;
            trail2.layer.masksToBounds = YES;
            [objSandCView addSubview:trail2];
            if(IsEdit == YES)
            {
                if(i==0)
                {
                    trail1.text =[objDic valueForKey:@"left"];
                    trail2.text = [objDic valueForKey:@"Right"];
                }
                else
                {
                    trail1.text =[objDic valueForKey:[NSString stringWithFormat:@"left%d",i]];
                    trail2.text = [objDic valueForKey:[NSString stringWithFormat:@"Right%d",i]];
                }
            }
        }

        }
        else if([[objDic valueForKey:@"SideName"] isEqualToString:@"CENTRAL"])
        {
            for(int i=0; i< noofTrails; i++)
            {
            UILabel * TitleLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, i*40,self.view.frame.size.width/2, 40)];
            TitleLbl.text = [NSString stringWithFormat:@"Center%d",i];
            [objSandCView addSubview:TitleLbl];
            
            UITextField * trail1 = [[UITextField alloc]initWithFrame:CGRectMake(TitleLbl.frame.size.width+5,i*40,self.view.frame.size.width/2.5,40)];
            trail1.layer.borderColor = [UIColor whiteColor].CGColor;
            trail1.layer.borderWidth =1;
            trail1.layer.masksToBounds = YES;
            [objSandCView addSubview:trail1];
                if(IsEdit == YES)
                {
                    if(i==0)
                    {
                        trail1.text =[objDic valueForKey:@"Cente"];
                        
                    }
                    else
                    {
                        trail1.text =[objDic valueForKey:[NSString stringWithFormat:@"Cente%d",i]];
                    }
                }
            }
        }
        if([objDic valueForKey:@"ignored"] != NULL && [[objDic valueForKey:@"ignored"] isEqualToString:@"true"])
        {
            [self.IngoreBtn setImage:[UIImage imageNamed:@"rightMark"] forState:UIControlStateNormal];
            self.ingnoreStatus =@"true";
        }
        else
        {
            [self.IngoreBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            self.ingnoreStatus =@"false";
        }
        [self.CommScroll addSubview:objSandCView];

    }
    else if ([SCREEN_CODE_GAINT isEqualToString:self.SelectScreenId])
    {
        NSDictionary * objDic = [self.ObjSelectTestArray objectAtIndex:0];
        self.left_lbl.userInteractionEnabled = YES;
        self.right_lbl.userInteractionEnabled = YES;
        self.centeral_Txt.userInteractionEnabled = YES;
        self.popviewwidth.constant = self.view.frame.size.width/2;
        self.rightCombViewYposition.constant = 10;
        self.leftCombViewYposition.constant  = self.rightCombViewYposition.constant-45;
        self.ValueViewYposition.constant     = self.leftCombViewYposition.constant-180;
        self.RemarkViewYposition.constant    = self.ValueViewYposition.constant+220;
        
        self.remark_Txt.text =[objDic valueForKey:@"ResultRemarks"];
        self.valueTxt.text =[objDic valueForKey:@"ResultValues"];
        if([[objDic valueForKey:@"SideName"] isEqualToString:@"RIGHT & LEFT"])
        {
            self.rightCombview.hidden = NO;
            self.leftCombView.hidden = NO;
            self.CommonCombArray = [[NSMutableArray alloc]init];
            self.CommonCombArray = self.AssessmentTypeGaint;
            
            if(self.ObjSelectTestArray.count>0)
            {
                for (int i = 0; i < self.AssessmentTypeGaint.count; i++) {
                    
                    if ([[[self.AssessmentTypeGaint valueForKey:@"ResultName"]objectAtIndex:i]isEqualToString:[objDic valueForKey:@"ResultRight"]]) {
                        self.right_lbl.text = [[self.AssessmentTypeGaint valueForKey:@"ResultName"] objectAtIndex:i];
                        break;
                    }
                }
                
                for (int j = 0; j < self.AssessmentTypeGaint.count; j++) {
                    
                    if ([[[self.AssessmentTypeGaint valueForKey:@"ResultName"] objectAtIndex:j] isEqualToString:[objDic valueForKey:@"ResultLeft"]]) {
                        
                        self.left_lbl.text = [[self.AssessmentTypeGaint valueForKey:@"ResultName"] objectAtIndex:j];
                        break;
                    }
                }
            }
        }
        else if ([[objDic valueForKey:@"SideName"] isEqualToString:@"CENTRAL"])
        {
            //relSpnCentral.setVisibility(View.VISIBLE);
            //spnCentral.setAdapter(new AssessmentResultAdapter(getActivity(), assessmentTestTypeGait));
            self.CommonCombArray =[[NSMutableArray alloc]init];
            self.CommonCombArray = self.AssessmentTypeGaint;
            if (self.ObjSelectTestArray.count>0) {
                
                for (int i = 0; i < self.AssessmentTypeGaint.count; i++) {
                    
                    if ([[[self.AssessmentTypeGaint valueForKey:@"ResultName"] objectAtIndex:i] isEqualToString:[objDic valueForKey:@"ResultCentral"]]) {
                        
                        //spnCentral.setSelection(i);
                        //[self.CommonCombArray addObject:[self.AssessmentTypeGaint objectAtIndex:i]];
                        self.centeral_Txt.text = [[self.AssessmentTypeGaint valueForKey:@"ResultName"] objectAtIndex:i];
                        
                        
                        break;
                    }
                }
            }
        }
        self.valueCombView.hidden = NO;
        if([objDic valueForKey:@"ignored"] != NULL && [[objDic valueForKey:@"ignored"] isEqualToString:@"true"])
        {
            [self.IngoreBtn setImage:[UIImage imageNamed:@"rightMark"] forState:UIControlStateNormal];
            self.ingnoreStatus =@"true";
            self.left_lbl.userInteractionEnabled = NO;
            self.right_lbl.userInteractionEnabled = NO;
            self.centeral_Txt.userInteractionEnabled = NO;
        }
        else
        {
            [self.IngoreBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            self.ingnoreStatus =@"false";
        }
    }
    else if([SCREEN_CODE_POSTURE isEqualToString:self.SelectScreenId])
    {
        NSDictionary * objDic = [self.ObjSelectTestArray objectAtIndex:0];
        self.popviewwidth.constant = self.view.frame.size.width/2;
        
        self.rightCombViewYposition.constant = 10;
        self.leftCombViewYposition.constant  = self.rightCombViewYposition.constant-45;
        self.ValueViewYposition.constant     = self.leftCombViewYposition.constant-180;
        self.RemarkViewYposition.constant    = self.ValueViewYposition.constant+220;
        self.remark_Txt.text =[objDic valueForKey:@"Remarks"];
        self.valueTxt.text =[objDic valueForKey:@"Values"];
        
        self.left_lbl.userInteractionEnabled = YES;
        self.right_lbl.userInteractionEnabled = YES;
        self.centeral_Txt.userInteractionEnabled = YES;
        
        if ([[objDic valueForKey:@"SideName"] isEqualToString:@"RIGHT & LEFT"]) {
            self.rightCombview.hidden = NO;
            self.leftCombView.hidden = NO;
            self.CommonCombArray = [[NSMutableArray alloc]init];
            self.CommonCombArray = self.assessmentTestTypePosture;
            if (self.ObjSelectTestArray.count >0) {
                
                for (int i = 0; i < self.assessmentTestTypePosture.count; i++) {
                    
                    if ([[[self.assessmentTestTypePosture valueForKey:@"ResultName"] objectAtIndex:i] isEqualToString:[objDic valueForKey:@"ResultRight"]]) {
                        self.right_lbl.text = [[self.assessmentTestTypePosture valueForKey:@"ResultName"] objectAtIndex:i];
                        
                        break;
                    }
                    
                }
                
                
                for (int j = 0; j < self.assessmentTestTypePosture.count; j++) {
                    
                    if ([[[self.assessmentTestTypePosture valueForKey:@"ResultName"] objectAtIndex:j] isEqualToString:[objDic valueForKey:@"ResultLeft"]]) {
                        // spnLeft.setSelection(j);
                        self.left_lbl.text = [[self.assessmentTestTypePosture valueForKey:@"ResultName"] objectAtIndex:j];
                        
                        break;
                    }
                    
                    
                }
                
            }
            
        } else if ([[objDic valueForKey:@"SideName"] isEqualToString:@"CENTRAL"]) {
            self.centralcombView.hidden = NO;
            self.CommonCombArray =[[NSMutableArray alloc]init];
            self.CommonCombArray = self.assessmentTestTypePosture;
            if (self.ObjSelectTestArray.count>0) {
                
                for (int i = 0; i < self.assessmentTestTypePosture.count; i++) {
                    
                    if ([[[self.assessmentTestTypePosture valueForKey:@"ResultName"] objectAtIndex:i] isEqualToString:[objDic valueForKey:@"ResultCenter"]]) {
                        
                        self.centeral_Txt.text = [[self.assessmentTestTypePosture valueForKey:@"ResultName"] objectAtIndex:i];
                        
                        break;
                    }
                    
                }
                
            }
            
        }
        
        self.valueCombView.hidden = NO;
        
        if([objDic valueForKey:@"ignored"] != NULL && [[objDic valueForKey:@"ignored"] isEqualToString:@"true"])
        {
            [self.IngoreBtn setImage:[UIImage imageNamed:@"rightMark"] forState:UIControlStateNormal];
            self.ingnoreStatus =@"true";
            self.left_lbl.userInteractionEnabled = NO;
            self.right_lbl.userInteractionEnabled = NO;
            self.centeral_Txt.userInteractionEnabled = NO;
        }
        else
        {
            [self.IngoreBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            self.ingnoreStatus =@"false";
        }
    }
    else if ([SCREEN_CODE_SPECIAL isEqualToString:self.SelectScreenId])
    {
        NSDictionary * objDic = [self.ObjSelectTestArray objectAtIndex:0];
        self.popviewwidth.constant = self.view.frame.size.width/2;
        self.left_lbl.userInteractionEnabled = YES;
        self.right_lbl.userInteractionEnabled = YES;
        self.centeral_Txt.userInteractionEnabled = YES;
        self.rightCombViewYposition.constant = 10;
        self.leftCombViewYposition.constant  = self.rightCombViewYposition.constant-30;
        self.RemarkViewYposition.constant = self.leftCombViewYposition.constant-220;
        self.right_Txt.text = [objDic valueForKey:@"Remarks"];
        if ([[objDic valueForKey:@"SpecialSideName"] isEqualToString:@"RIGHT & LEFT"]) {
            self.rightCombview .hidden = NO;
            self.leftCombView.hidden  = NO;
            
            
            self.CommonCombArray =[[NSMutableArray alloc]init];
            self.CommonCombArray = self.assessmentTestTypeSpecial;
            
            if (self.ObjSelectTestArray.count>0 ) {
                
                for (int i = 0; i < self.assessmentTestTypeSpecial.count; i++) {
                    
                    if ([[[self.assessmentTestTypeSpecial valueForKey:@"ResultName"] objectAtIndex:i] isEqualToString:[objDic valueForKey:@"SpecialResultRight"]]) {
                        self.right_lbl.text = [[self.assessmentTestTypeSpecial valueForKey:@"ResultName"] objectAtIndex:i];
                        break;
                    }
                    
                }
                
                
                for (int j = 0; j <self.assessmentTestTypeSpecial.count; j++) {
                    
                    if ([[[self.assessmentTestTypeSpecial valueForKey:@"ResultName"] objectAtIndex:j] isEqualToString:[objDic valueForKey:@"SpecialResultLeft"]]) {
                        
                        // spnLeft.setSelection(j);
                        self.left_lbl.text = [[self.assessmentTestTypeSpecial valueForKey:@"ResultName"] objectAtIndex:j];
                        
                        
                        break;
                    }
                }
            }
            
        } else if ([[objDic valueForKey:@"SpecialSideName"] isEqualToString:@"CENTRAL"]) {
            
            self.centralcombView.hidden = NO;
            //relSpnCentral.setVisibility(View.VISIBLE);
            self.CommonCombArray =[[NSMutableArray alloc]init];
            self.CommonCombArray = self.assessmentTestTypeSpecial;
            //  spnCentral.setAdapter(new AssessmentResultAdapter(getActivity(), assessmentTestTypeSpecial));
            
            if (self.ObjSelectTestArray.count>0) {
                
                for (int i = 0; i < self.assessmentTestTypeSpecial.count; i++) {
                    
                    if ([[[self.assessmentTestTypeSpecial valueForKey:@"ResultName"] objectAtIndex:i] isEqualToString:[objDic valueForKey:@"SpecialResultCenter"]]) {
                        
                        //spnCentral.setSelection(i);
                        self.centeral_Txt.text = [[self.assessmentTestTypeSpecial valueForKey:@"ResultName"] objectAtIndex:i];
                        break;
                    }
                    
                }
                
            }
            
        }
        
        self.remark_Txt.text = [objDic valueForKey:@"Remark"];
        // editRemarks.setText(selectTest.getRemarks());
        
        if([objDic valueForKey:@"ignored"] != NULL && [[objDic valueForKey:@"ignored"] isEqualToString:@"true"])
        {
            [self.IngoreBtn setImage:[UIImage imageNamed:@"rightMark"] forState:UIControlStateNormal];
            self.ingnoreStatus =@"true";
            self.left_lbl.userInteractionEnabled = NO;
            self.right_lbl.userInteractionEnabled = NO;
            self.centeral_Txt.userInteractionEnabled = NO;
        }
        else
        {
            [self.IngoreBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            self.ingnoreStatus =@"false";
        }
    }
    else if ([SCREEN_CODE_COACHING isEqualToString:self.SelectScreenId])
    {
        NSDictionary * objDic = [self.ObjSelectTestArray objectAtIndex:0];
        self.left_lbl.userInteractionEnabled = YES;
        self.right_lbl.userInteractionEnabled = YES;
        self.centeral_Txt.userInteractionEnabled = YES;
        self.CommonCombArray =[[NSMutableArray alloc]init];
        self.CommonCombArray = self.assessmentTestTypeCoach;
        self.descriptionCombView.hidden = NO;
        self.descriptionCombViewYposition.constant =-200;
        self.RemarkViewYposition.constant = self.descriptionCombViewYposition.constant+50;
        self.remark_Txt.text = [objDic valueForKey:@"Remark"];
        
        if (self.ObjSelectTestArray.count>0) {
            
            for (int j = 0; j < self.ObjSelectTestArray.count; j++) {
                
                if ([[[self.assessmentTestTypeCoach valueForKey:@"kpi"] objectAtIndex:j] isEqualToString:[objDic valueForKey:@"Kpi"]]) {
                    self.description_lbl.text =[[self.assessmentTestTypeCoach valueForKey:@"kpi"] objectAtIndex:j];
                    break;
                }
                
            }
            
        }
        
        if([objDic valueForKey:@"ignored"] != NULL && [[objDic valueForKey:@"ignored"] isEqualToString:@"true"])
        {
            [self.IngoreBtn setImage:[UIImage imageNamed:@"rightMark"] forState:UIControlStateNormal];
            self.ingnoreStatus =@"true";
            self.left_lbl.userInteractionEnabled = NO;
            self.right_lbl.userInteractionEnabled = NO;
            self.centeral_Txt.userInteractionEnabled = NO;
        }
        else
        {
            [self.IngoreBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            self.ingnoreStatus =@"false";
        }
        
    }
}

-(IBAction)backBtnAction:(id)sender
{
    //[COMMON ShowsideMenuView];
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)HomeBtnAction:(id)sender
{
    HomeVC  * objTabVC=[[HomeVC alloc]init];
    objTabVC = (HomeVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
    [self.navigationController pushViewController:objTabVC animated:YES];
    
}
-(IBAction)DidClickIngnoreBtnAction:(id)sender
{
    UIButton *myButton = sender;
    
    NSData *data1 = UIImagePNGRepresentation(myButton.currentImage);
    NSData *data2 = UIImagePNGRepresentation([UIImage imageNamed:@"rightMark"]);
    
    if ([data1 isEqual:data2])
    {
        NSLog(@"is the same image");
        [self.IngoreBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        self.ingnoreStatus =@"false";
    }else{
        NSLog(@"is not the same image");
        self.ingnoreStatus =@"true";
        [self.IngoreBtn setImage:[UIImage imageNamed:@"rightMark"] forState:UIControlStateNormal];
        
    }
}
-(IBAction)didClickSaveBtnAction:(id)sender
{
    if([SCREEN_CODE_Rom isEqualToString:self.SelectScreenId])
    {
        NSDictionary * objDic = [self.ObjSelectTestArray objectAtIndex:0];
        
        if(IsEdit == YES)
        {
            [self.objDBConnection UPDATEAssessmentEntry:clientCode :@"" :self.ModuleStr :[self.selectAllValueDic valueForKey:@"AssessmentCode"]  :self.SectionTestCodeStr :self.SelectTestTypecode :self.SelectScreenId :self.version :usercode :[self.selectAllValueDic valueForKey:@"PlayerCode"] :[self.selectAllValueDic valueForKey:@"SelectDate"] :[NSString stringWithFormat:@"%@",self.left_Txt.text] :[NSString stringWithFormat:@"%@",self.right_Txt.text] :[NSString stringWithFormat:@"%@",self.centeral_Txt.text] :self.valueTxt.text :self.remark_Txt.text :@"" :@"" :self.description_lbl.text :@"MSC001" :usercode :[objDic valueForKey:@"CreatedDate"] :usercode :[objDic valueForKey:@"ModifiedDate"] :self.ingnoreStatus :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@"0"];
        }
        else
        {
            [self.objDBConnection INSERTAssessmentEntry:clientCode :@"" :self.ModuleStr :[self.selectAllValueDic valueForKey:@"AssessmentCode"] :self.SectionTestCodeStr :self.SelectTestTypecode :self.SelectScreenId :self.version :usercode :[self.selectAllValueDic valueForKey:@"PlayerCode"] :[self.selectAllValueDic valueForKey:@"SelectDate"] :[NSString stringWithFormat:@"%@",self.left_Txt.text] :[NSString stringWithFormat:@"%@",self.right_Txt.text] :[NSString stringWithFormat:@"%@",self.centeral_Txt.text] :self.valueTxt.text :self.remark_Txt.text :@"" :@"" :self.description_lbl.text :@"MSC001" :usercode :[objDic valueForKey:@"CreatedDate"] :usercode :[objDic valueForKey:@"ModifiedDate"] :self.ingnoreStatus :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@"0"];
        }
        self.right_Txt.text = @"";
        self.left_Txt.text = @"";
        self.remark_Txt.text =@"";
    }
    else if ([SCREEN_CODE_MMT isEqualToString:self.SelectScreenId])
    {
        NSDictionary * objDic = [self.ObjSelectTestArray objectAtIndex:0];
        
        if(IsEdit == YES)
        {
            [self.objDBConnection UPDATEAssessmentEntry:clientCode :@"" :self.ModuleStr :[self.selectAllValueDic valueForKey:@"AssessmentCode"]  :self.SectionTestCodeStr :self.SelectTestTypecode :self.SelectScreenId :self.version :usercode :[self.selectAllValueDic valueForKey:@"PlayerCode"] :[self.selectAllValueDic valueForKey:@"SelectDate"] :[NSString stringWithFormat:@"%@",self.left_lbl.text] :[NSString stringWithFormat:@"%@",self.right_lbl.text] :[NSString stringWithFormat:@"%@",self.centeral_Txt.text] :self.valueTxt.text :self.remark_Txt.text :@"":@"" :self.description_lbl.text :@"MSC001" :usercode :[objDic valueForKey:@"CreatedDate"] :usercode :[objDic valueForKey:@"ModifiedDate"] :self.ingnoreStatus :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@"0"];
        }
        else
        {
            [self.objDBConnection INSERTAssessmentEntry:clientCode :@"" :self.ModuleStr :[self.selectAllValueDic valueForKey:@"AssessmentCode"] :self.SectionTestCodeStr :self.SelectTestTypecode :self.SelectScreenId :self.version :usercode :[self.selectAllValueDic valueForKey:@"PlayerCode"] :[self.selectAllValueDic valueForKey:@"SelectDate"] :[NSString stringWithFormat:@"%@",self.left_lbl.text] :[NSString stringWithFormat:@"%@",self.right_lbl.text] :[NSString stringWithFormat:@"%@",self.centeral_Txt.text] :self.valueTxt.text :self.remark_Txt.text :@"" :@"" :self.description_lbl.text :@"MSC001" :usercode :[objDic valueForKey:@"CreatedDate"] :usercode :[objDic valueForKey:@"ModifiedDate"] :self.ingnoreStatus :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@"0"];
        }
        self.left_lbl.text = @"";
        self.right_lbl.text = @"";
        self.remark_Txt.text =@"";
    }
    else if ([SCREEN_CODE_GAINT isEqualToString:self.SelectScreenId])
    {
        NSDictionary * objDic = [self.ObjSelectTestArray objectAtIndex:0];
        
        if(IsEdit == YES)
        {
            [self.objDBConnection UPDATEAssessmentEntry:clientCode :@"" :self.ModuleStr :[self.selectAllValueDic valueForKey:@"AssessmentCode"]  :self.SectionTestCodeStr :self.SelectTestTypecode :self.SelectScreenId :self.version :usercode :[self.selectAllValueDic valueForKey:@"PlayerCode"] :[self.selectAllValueDic valueForKey:@"SelectDate"] :[NSString stringWithFormat:@"%@",self.left_lbl.text] :[NSString stringWithFormat:@"%@",self.right_lbl.text] :[NSString stringWithFormat:@"%@",self.centeral_Txt.text] :self.valueTxt.text :self.remark_Txt.text :@"" :@"" :self.description_lbl.text :@"MSC001" :usercode :[objDic valueForKey:@"CreatedDate"] :usercode :[objDic valueForKey:@"ModifiedDate"] :self.ingnoreStatus :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@"0"];
        }
        else
        {
            [self.objDBConnection INSERTAssessmentEntry:clientCode :@"" :self.ModuleStr :[self.selectAllValueDic valueForKey:@"AssessmentCode"] :self.SectionTestCodeStr :self.SelectTestTypecode :self.SelectScreenId :self.version :usercode :[self.selectAllValueDic valueForKey:@"PlayerCode"] :[self.selectAllValueDic valueForKey:@"SelectDate"] :[NSString stringWithFormat:@"%@",self.left_lbl.text] :[NSString stringWithFormat:@"%@",self.right_lbl.text] :[NSString stringWithFormat:@"%@",self.centeral_Txt.text] :self.valueTxt.text :self.remark_Txt.text :@"":@"" :self.description_lbl.text :@"MSC001" :usercode :[objDic valueForKey:@"CreatedDate"] :usercode :[objDic valueForKey:@"ModifiedDate"] :self.ingnoreStatus :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@"0"];
        }
        self.left_lbl.text = @"";
        self.right_lbl.text = @"";
        self.valueTxt.text =@"";
        self.remark_Txt.text =@"";
    }
    else if ([SCREEN_CODE_POSTURE isEqualToString:self.SelectScreenId])
    {
        NSDictionary * objDic = [self.ObjSelectTestArray objectAtIndex:0];
        
        if(IsEdit == YES)
        {
            [self.objDBConnection UPDATEAssessmentEntry:clientCode :@"" :self.ModuleStr :[self.selectAllValueDic valueForKey:@"AssessmentCode"]  :self.SectionTestCodeStr :self.SelectTestTypecode :self.SelectScreenId :self.version :usercode :[self.selectAllValueDic valueForKey:@"PlayerCode"] :[self.selectAllValueDic valueForKey:@"SelectDate"] :[NSString stringWithFormat:@"%@",self.left_lbl.text] :[NSString stringWithFormat:@"%@",self.right_lbl.text] :[NSString stringWithFormat:@"%@",self.centeral_Txt.text] :self.valueTxt.text :self.remark_Txt.text :@"" :@"" :self.description_lbl.text :@"MSC001" :usercode :[objDic valueForKey:@"CreatedDate"] :usercode :[objDic valueForKey:@"ModifiedDate"] :self.ingnoreStatus :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@"0"];
        }
        else
        {
            [self.objDBConnection INSERTAssessmentEntry:clientCode :@"" :self.ModuleStr :[self.selectAllValueDic valueForKey:@"AssessmentCode"] :self.SectionTestCodeStr :self.SelectTestTypecode :self.SelectScreenId :self.version :usercode :[self.selectAllValueDic valueForKey:@"PlayerCode"] :[self.selectAllValueDic valueForKey:@"SelectDate"] :[NSString stringWithFormat:@"%@",self.left_lbl.text] :[NSString stringWithFormat:@"%@",self.right_lbl.text] :[NSString stringWithFormat:@"%@",self.centeral_Txt.text] :self.valueTxt.text :self.remark_Txt.text :@"" :@"" :self.description_lbl.text :@"MSC001" :usercode :[objDic valueForKey:@"CreatedDate"] :usercode :[objDic valueForKey:@"ModifiedDate"] :self.ingnoreStatus :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@"0"];
        }
        self.left_lbl.text = @"";
        self.right_lbl.text = @"";
        self.valueTxt.text =@"";
        self.remark_Txt.text =@"";
    }
    else if ([SCREEN_CODE_SPECIAL isEqualToString:self.SelectScreenId])
    {
        NSDictionary * objDic = [self.ObjSelectTestArray objectAtIndex:0];
        
        if(IsEdit == YES)
        {
            [self.objDBConnection UPDATEAssessmentEntry:clientCode :@"" :self.ModuleStr :[self.selectAllValueDic valueForKey:@"AssessmentCode"]  :self.SectionTestCodeStr :self.SelectTestTypecode :self.SelectScreenId :self.version :usercode :[self.selectAllValueDic valueForKey:@"PlayerCode"] :[self.selectAllValueDic valueForKey:@"SelectDate"] :[NSString stringWithFormat:@"%@",self.left_lbl.text] :[NSString stringWithFormat:@"%@",self.right_lbl.text] :[NSString stringWithFormat:@"%@",self.centeral_Txt.text] :self.valueTxt.text :self.remark_Txt.text :@"" :@"" :self.description_lbl.text :@"MSC001" :usercode :[objDic valueForKey:@"CreatedDate"] :usercode :[objDic valueForKey:@"ModifiedDate"] :self.ingnoreStatus :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@"0"];
        }
        else
        {
            [self.objDBConnection INSERTAssessmentEntry:clientCode :@"" :self.ModuleStr :[self.selectAllValueDic valueForKey:@"AssessmentCode"] :self.SectionTestCodeStr :self.SelectTestTypecode :self.SelectScreenId :self.version :usercode :[self.selectAllValueDic valueForKey:@"PlayerCode"] :[self.selectAllValueDic valueForKey:@"SelectDate"] :[NSString stringWithFormat:@"%@",self.left_lbl.text] :[NSString stringWithFormat:@"%@",self.right_lbl.text] :[NSString stringWithFormat:@"%@",self.centeral_Txt.text] :self.valueTxt.text :self.remark_Txt.text :@"" :@"" :self.description_lbl.text :@"MSC001" :usercode :[objDic valueForKey:@"CreatedDate"] :usercode :[objDic valueForKey:@"ModifiedDate"] :self.ingnoreStatus :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@"0"];
        }
        self.left_lbl.text = @"";
        self.right_lbl.text = @"";
        self.remark_Txt.text =@"";
    }
    else if ([SCREEN_CODE_COACHING isEqualToString:self.SelectScreenId])
    {
        NSDictionary * objDic = [self.ObjSelectTestArray objectAtIndex:0];
        
        if(IsEdit == YES)
        {
            [self.objDBConnection UPDATEAssessmentEntry:clientCode :@"" :self.ModuleStr :[self.selectAllValueDic valueForKey:@"AssessmentCode"]  :self.SectionTestCodeStr :self.SelectTestTypecode :self.SelectScreenId :self.version :usercode :[self.selectAllValueDic valueForKey:@"PlayerCode"] :[self.selectAllValueDic valueForKey:@"SelectDate"] :[NSString stringWithFormat:@"%@",self.left_lbl.text] :[NSString stringWithFormat:@"%@",self.right_lbl.text] :[NSString stringWithFormat:@"%@",self.centeral_Txt.text] :self.valueTxt.text :self.remark_Txt.text :@"" :@"" :self.description_lbl.text :@"MSC001" :usercode :[objDic valueForKey:@"CreatedDate"] :usercode :[objDic valueForKey:@"ModifiedDate"] :self.ingnoreStatus :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@"0"];
        }
        else
        {
            [self.objDBConnection INSERTAssessmentEntry:clientCode :@"" :self.ModuleStr :[self.selectAllValueDic valueForKey:@"AssessmentCode"] :self.SectionTestCodeStr :self.SelectTestTypecode :self.SelectScreenId :self.version :usercode :[self.selectAllValueDic valueForKey:@"PlayerCode"] :[self.selectAllValueDic valueForKey:@"SelectDate"] :[NSString stringWithFormat:@"%@",self.left_lbl.text] :[NSString stringWithFormat:@"%@",self.right_lbl.text] :[NSString stringWithFormat:@"%@",self.centeral_Txt.text] :self.valueTxt.text :self.remark_Txt.text :@"" :@"" :self.description_lbl.text :@"MSC001" :usercode :[objDic valueForKey:@"CreatedDate"] :usercode :[objDic valueForKey:@"ModifiedDate"] :self.ingnoreStatus :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@"0"];
        }
        self.description_lbl.text = @"";
        self.remark_Txt.text =@"";
    }
    else if ([SCREEN_CODE_S_C isEqualToString:self.SelectScreenId])
    {
        NSDictionary * objDic = [self.ObjSelectTestArray objectAtIndex:0];
        
        NSMutableArray * obj = [[NSMutableArray alloc]init];
        
        for (UIView *subview in  objSandCView.subviews)
        {
            if([subview isKindOfClass:[UITextField class]])
            {
                NSLog(@"%@",subview);
                UITextField * strText = subview;
                NSString * objStr = strText.text;
                [obj addObject:objStr];
            }
        }
        for(int i=0; i<obj.count;i++)
        {
            if(i==0)
            {
                NSString * objStr = ([[obj objectAtIndex:i] isEqualToString:@""])?@"0":[obj objectAtIndex:i];
                [objDic setValue:[NSNumber numberWithInteger:[objStr integerValue]] forKey:@"left"];

            }
            else if (i== 1)
            {
                NSString * objStr = ([[obj objectAtIndex:i] isEqualToString:@""])?@"0":[obj objectAtIndex:i];
                
                [objDic setValue:[NSNumber numberWithInteger:[objStr integerValue]] forKey:@"Right"];
            }
            if(i%2==0 && i!=0)
            {
                NSString * objStr = ([[obj objectAtIndex:i] isEqualToString:@""])?@"0":[obj objectAtIndex:i];

                [objDic setValue:[NSNumber numberWithInteger:[objStr integerValue]] forKey:[NSString stringWithFormat:@"left%d",i]];
                
            }
            else if(i%2 == 1 && i!=1)
            {
                NSString * objStr = ([[obj objectAtIndex:i] isEqualToString:@""])?@"0":[obj objectAtIndex:i];

                [objDic setValue:[NSNumber numberWithInteger:[objStr integerValue]] forKey:[NSString stringWithFormat:@"Right%d",i]];
            }
            
        }
        
        if(IsEdit == YES)
        {
            [self.objDBConnection UPDATEAssessmentEntry:clientCode :@"" :self.ModuleStr :[self.selectAllValueDic valueForKey:@"AssessmentCode"]  :self.SectionTestCodeStr :self.SelectTestTypecode :self.SelectScreenId :self.version :usercode :[self.selectAllValueDic valueForKey:@"PlayerCode"] :[self.selectAllValueDic valueForKey:@"SelectDate"] :[objDic valueForKey:@"left"] :[objDic valueForKey:@"Right"] :[objDic valueForKey:@"Center"] :self.valueTxt.text :self.remark_Txt.text :@"" :@"" :self.description_lbl.text :@"MSC001" :usercode :[objDic valueForKey:@"CreatedDate"] :usercode :[objDic valueForKey:@"ModifiedDate"] :self.ingnoreStatus :[objDic valueForKey:@"left1"] :[objDic valueForKey:@"Right1"] :[objDic valueForKey:@"Center1"] :[objDic valueForKey:@"left2"] :[objDic valueForKey:@"Right2"] :[objDic valueForKey:@"Center2"] :[objDic valueForKey:@"left3"] :[objDic valueForKey:@"Right3"] :[objDic valueForKey:@"Center3"] :[objDic valueForKey:@"left4"] :[objDic valueForKey:@"Right4"] :[objDic valueForKey:@"Center4"] :[objDic valueForKey:@"left5"] :[objDic valueForKey:@"Right5"] :[objDic valueForKey:@"Center5"] :[objDic valueForKey:@"left6"] :[objDic valueForKey:@"Right6"] :[objDic valueForKey:@"Center6"] :[objDic valueForKey:@"left7"] :[objDic valueForKey:@"Right7"] :[objDic valueForKey:@"Center7"] :[objDic valueForKey:@"left8"] :[objDic valueForKey:@"Right8"] :[objDic valueForKey:@"Center8"] :[objDic valueForKey:@"left9"] :[objDic valueForKey:@"Right9"] :[objDic valueForKey:@"Center9"] :@"0"];
        }
        else
        {
            [self.objDBConnection INSERTAssessmentEntry:clientCode :@"" :self.ModuleStr :[self.selectAllValueDic valueForKey:@"AssessmentCode"] :self.SectionTestCodeStr :self.SelectTestTypecode :self.SelectScreenId :self.version :usercode :[self.selectAllValueDic valueForKey:@"PlayerCode"] :[self.selectAllValueDic valueForKey:@"SelectDate"] :[objDic valueForKey:@"left"] :[objDic valueForKey:@"Right"] :[objDic valueForKey:@"Center"] :self.valueTxt.text :self.remark_Txt.text :@"" :@"" :self.description_lbl.text :@"MSC001" :usercode :[objDic valueForKey:@"CreatedDate"] :usercode :[objDic valueForKey:@"ModifiedDate"] :self.ingnoreStatus :[objDic valueForKey:@"left1"] :[objDic valueForKey:@"Right1"] :[objDic valueForKey:@"Center1"] :[objDic valueForKey:@"left2"] :[objDic valueForKey:@"Right2"] :[objDic valueForKey:@"Center2"] :[objDic valueForKey:@"left3"] :[objDic valueForKey:@"Right3"] :[objDic valueForKey:@"Center3"] :[objDic valueForKey:@"left4"] :[objDic valueForKey:@"Right4"] :[objDic valueForKey:@"Center4"] :[objDic valueForKey:@"left5"] :[objDic valueForKey:@"Right5"] :[objDic valueForKey:@"Center5"] :[objDic valueForKey:@"left6"] :[objDic valueForKey:@"Right6"] :[objDic valueForKey:@"Center6"] :[objDic valueForKey:@"left7"] :[objDic valueForKey:@"Right7"] :[objDic valueForKey:@"Center7"] :[objDic valueForKey:@"left8"] :[objDic valueForKey:@"Right8"] :[objDic valueForKey:@"Center8"] :[objDic valueForKey:@"left9"] :[objDic valueForKey:@"Right9"] :[objDic valueForKey:@"Center9"] :@"0" ];
        }
        self.description_lbl.text = @"";
        self.remark_Txt.text =@"";
    }
}



#pragma  mark Table DataSource Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  self.CommonCombArray.count;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

#pragma mark Table Delegate Methods
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString * AssessmentCellIdentifier = @"AssessmentcellIdentifier";
    
    // init the CRTableViewCell
    UITableViewCell * cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:AssessmentCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AssessmentCellIdentifier];
    }
    if([SCREEN_CODE_MMT isEqualToString:self.SelectScreenId])
    {
        cell.textLabel.text = [[self.CommonCombArray valueForKey:@"RESULTNAME"] objectAtIndex:indexPath.row];
        
    }
    else if ([SCREEN_CODE_GAINT isEqualToString:self.SelectScreenId])
    {
        cell.textLabel.text = [[self.CommonCombArray valueForKey:@"ResultName"] objectAtIndex:indexPath.row];
        
    }
    else if ([SCREEN_CODE_POSTURE isEqualToString:self.SelectScreenId])
    {
        cell.textLabel.text = [[self.CommonCombArray valueForKey:@"ResultName"] objectAtIndex:indexPath.row];
        
    }
    else if ([SCREEN_CODE_SPECIAL isEqualToString:self.SelectScreenId])
    {
        cell.textLabel.text = [[self.CommonCombArray valueForKey:@"ResultName"] objectAtIndex:indexPath.row];
        
    }
    else if ([SCREEN_CODE_COACHING isEqualToString:self.SelectScreenId])
    {
        cell.textLabel.text = [[self.CommonCombArray valueForKey:@"Description"] objectAtIndex:indexPath.row];
        
    }
    
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(isRight== YES && [SCREEN_CODE_MMT isEqualToString:self.SelectScreenId])
    {
        self.right_lbl.text = [[self.CommonCombArray valueForKey:@"RESULTNAME"] objectAtIndex:indexPath.row];
        isRight = NO;
    }
    else if (isLeft == YES && [SCREEN_CODE_MMT isEqualToString:self.SelectScreenId])
    {
        self.left_lbl.text = [[self.CommonCombArray valueForKey:@"RESULTNAME"] objectAtIndex:indexPath.row];
        isLeft = NO;
    }
    else if (isLeft== YES && [SCREEN_CODE_GAINT isEqualToString:self.SelectScreenId])
    {
        self.left_lbl.text = [[self.CommonCombArray valueForKey:@"ResultName"] objectAtIndex:indexPath.row];
    }
    else if (isRight == YES && [SCREEN_CODE_GAINT isEqualToString:self.SelectScreenId])
    {
        self.right_lbl.text = [[self.CommonCombArray valueForKey:@"ResultName"] objectAtIndex:indexPath.row];
        
    }
    else if (isRight == YES && [SCREEN_CODE_POSTURE isEqualToString:self.SelectScreenId])
    {
        self.right_lbl.text = [[self.CommonCombArray valueForKey:@"ResultName"] objectAtIndex:indexPath.row];
        
    }
    else if (isLeft== YES && [SCREEN_CODE_POSTURE isEqualToString:self.SelectScreenId])
    {
        self.left_lbl.text = [[self.CommonCombArray valueForKey:@"ResultName"] objectAtIndex:indexPath.row];
    }
    else if (isRight == YES && [SCREEN_CODE_SPECIAL isEqualToString:self.SelectScreenId])
    {
        self.right_lbl.text = [[self.CommonCombArray valueForKey:@"ResultName"] objectAtIndex:indexPath.row];
        
    }
    else if (isLeft== YES && [SCREEN_CODE_SPECIAL isEqualToString:self.SelectScreenId])
    {
        self.left_lbl.text = [[self.CommonCombArray valueForKey:@"ResultName"] objectAtIndex:indexPath.row];
    }
    else if ([SCREEN_CODE_COACHING isEqualToString:self.SelectScreenId])
    {
        self.description_lbl.text = [[self.CommonCombArray valueForKey:@"Description"] objectAtIndex:indexPath.row];
    }
    self.popTbl.hidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma DropDown Button Action
-(IBAction)didClickLeftBtnAction:(id)sender
{
    if(isLeft == NO)
    {
        isLeft = YES;
        self.popTbl.hidden = NO;
        self.popviewYposition.constant= self.leftView.frame.origin.y-50;
        
        
        [self.popTbl reloadData];
    }
    else
    {
        isLeft = NO;
        self.popTbl.hidden = YES;
        
    }
    isRight= NO;
    isDescription = NO;
    isCentral = NO;
    isValue = NO;
    isInterface = NO;
}
-(IBAction)didClickRightBtnAction:(id)sender
{
    if(isRight == NO)
    {
        isRight = YES;
        self.popTbl.hidden= NO;
        self.popviewYposition.constant= self.rightView.frame.origin.y-50;
        [self.popTbl reloadData];
    }
    else
    {
        isRight = NO;
        self.popTbl.hidden = YES;
    }
    isLeft= NO;
    isDescription = NO;
    isCentral = NO;
    isValue = NO;
    isInterface = NO;
}
-(IBAction)didClickCentralBtnAction:(id)sender
{
    if(isCentral == NO)
    {
        isCentral = YES;
        self.popTbl.hidden = NO;
        self.popviewYposition.constant= self.centralcombView.frame.origin.y;
        
        [self.popTbl reloadData];
    }
    else
    {
        isCentral = NO;
        self.popTbl.hidden = YES;
    }
    isLeft= NO;
    isDescription = NO;
    isRight = NO;
    isValue = NO;
    isInterface = NO;
}
-(IBAction)didClickDescriptionBtnAction:(id)sender
{
    if(isDescription == NO)
    {
        isDescription = YES;
        self.popTbl.hidden = NO;
        self.popviewYposition.constant = self.descriptionCombView.frame.origin.y;
        [self.popTbl reloadData];
    }
    else
    {
        isDescription = NO;
        self.popTbl.hidden = YES;
    }
    isLeft= NO;
    isCentral = NO;
    isRight = NO;
    isValue = NO;
    isInterface = NO;
}
-(IBAction)didClickInterfaceBtnAction:(id)sender
{
    if(isInterface == NO)
    {
        isInterface = YES;
        self.popTbl.hidden = NO;
        self.popviewYposition.constant = self.interfacecombView.frame.origin.y;
        [self.popTbl reloadData];
    }
    else
    {
        isInterface = NO;
        self.popTbl.hidden = YES;
    }
    isLeft= NO;
    isCentral = NO;
    isRight = NO;
    isValue = NO;
    isDescription = NO;
}
-(IBAction)didClickValueBtnAction:(id)sender
{
    if(isValue == NO)
    {
        isValue = YES;
        self.popTbl.hidden = NO;
        self.popviewYposition.constant = self.valueCombView.frame.origin.y;
        [self.popTbl reloadData];
    }
    else
    {
        isValue = NO;
        self.popTbl.hidden= YES;
    }
    isLeft= NO;
    isCentral = NO;
    isRight = NO;
    isInterface = NO;
    isDescription = NO;
}
@end

