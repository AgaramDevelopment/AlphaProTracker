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
}
@property (nonatomic,strong) NSMutableArray * ObjSelectTestArray;
@property (nonatomic,strong) DBAConnection * objDBConnection;
@property (nonatomic,strong) NSString *version;
@property (nonatomic,strong) NSString * ingnoreStatus;

@property (nonatomic,strong) NSMutableArray * AssessmentTypeMMT;
@property (nonatomic,strong) NSMutableArray * AssessmentTypeGaint;
@property (nonatomic,strong) NSMutableArray * assessmentTestTypePosture;
@property (nonatomic,strong) NSMutableArray * assessmentTestTypeSpecial;

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
    
    self.valueview.layer.borderWidth=0.5f;
    self.valueview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.remarksview.layer.borderWidth=0.5f;
    self.remarksview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
    self.interfaceview.layer.borderWidth=0.5f;
    self.interfaceview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    
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
    self.interfaceview.hidden =YES;
    self.valueview.hidden =YES;
    self.interfacecombView.hidden = YES;
    self.valueCombView.hidden = YES;
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
            
            self.ObjSelectTestArray = [self.objDBConnection getSCWithEnrty:self.version :[self.selectAllValueDic valueForKey:@"AssessmentCode"] :self.ModuleStr :self.SelectTestStr :clientCode :usercode :[self.selectAllValueDic valueForKey:@"PlayerCode"] :[self.selectAllValueDic valueForKey:@"SelectDate"] :self.SelectTestTypecode];
        }
        else
        {
            [self.saveBtn setTitle:@"Save" forState:UIControlStateNormal];
            
            self.ObjSelectTestArray = [self.objDBConnection getSCWithoutEnrty:self.version :[self.selectAllValueDic valueForKey:@"AssessmentCode"] :self.ModuleStr :self.SelectTestStr :clientCode :self.SelectTestTypecode];
        }
        
    }
    else if ([SCREEN_CODE_MMT  isEqual: self.SelectScreenId])
    {
        self.AssessmentTypeMMT = [[NSMutableArray alloc]init];
        self.AssessmentTypeMMT =[self.objDBConnection getWithMmtCombo];
        if(IsEdit == YES)
        {
            [self.saveBtn setTitle:@"Update" forState:UIControlStateNormal];
            
            self.ObjSelectTestArray = [self.objDBConnection getMMTWithEnrty:self.version :self.ModuleStr :self.SelectTestStr :clientCode :[self.selectAllValueDic valueForKey:@"AssessmentCode"] :usercode :[self.selectAllValueDic valueForKey:@"PlayerCode"] :[self.selectAllValueDic valueForKey:@"SelectDate"] :self.SelectTestTypecode];
        }
        else
        {
            [self.saveBtn setTitle:@"Save" forState:UIControlStateNormal];
            
            self.ObjSelectTestArray = [self.objDBConnection getMMTWithoutEnrty:self.version :self.ModuleStr :self.SelectTestStr :clientCode :[self.selectAllValueDic valueForKey:@"AssessmentCode"] :self.SelectTestTypecode];
        }
    }
    else if ([SCREEN_CODE_GAINT  isEqual: self.SelectScreenId])
    {
        self.AssessmentTypeGaint =[[NSMutableArray alloc]init];
        self.AssessmentTypeGaint =[self.objDBConnection getResultCombo];
        if(IsEdit == YES)
        {
            [self.saveBtn setTitle:@"Update" forState:UIControlStateNormal];
            
            self.ObjSelectTestArray =[self.objDBConnection getGaintWithEnrty:self.version :self.ModuleStr :self.SelectTestStr :clientCode :[self.selectAllValueDic valueForKey:@"AssessmentCode"] :usercode :[self.selectAllValueDic valueForKey:@"SelectDate"] :[self.selectAllValueDic valueForKey:@"PlayerCode"] :self.SelectTestTypecode];
        }
        else
        {
            [self.saveBtn setTitle:@"Save" forState:UIControlStateNormal];
            
            self.ObjSelectTestArray =[self.objDBConnection getGaintWithoutEnrty:self.version :self.ModuleStr :self.SelectTestStr :clientCode :[self.selectAllValueDic valueForKey:@"AssessmentCode"] :self.SelectTestTypecode];
        }
    }
    else if ([SCREEN_CODE_S_C  isEqual: self.SelectScreenId])
    {
        if(IsEdit == YES)
        {
            [self.saveBtn setTitle:@"Update" forState:UIControlStateNormal];
            
            self.ObjSelectTestArray = [self.objDBConnection getSCWithEnrty:self.version :self.ModuleStr :self.SelectTestStr :clientCode :[self.selectAllValueDic valueForKey:@"AssessmentCode"] :usercode :[self.selectAllValueDic valueForKey:@"SelectDate"] :[self.selectAllValueDic valueForKey:@"PlayerCode"] :self.SelectTestTypecode];
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
            
            self.ObjSelectTestArray =[self.objDBConnection getPostureWithEnrty:self.version :self.ModuleStr :self.SelectTestStr :clientCode :[self.selectAllValueDic valueForKey:@"AssessmentCode"] :usercode :[self.selectAllValueDic valueForKey:@"PlayerCode"] :[self.selectAllValueDic valueForKey:@"SelectDate"] :self.SelectTestTypecode];
        }
        else
        {
            [self.saveBtn setTitle:@"Save" forState:UIControlStateNormal];
            
            self.ObjSelectTestArray = [self.objDBConnection getPostureWithoutEnrty:self.version :self.ModuleStr :self.SelectTestStr :clientCode :[self.selectAllValueDic valueForKey:@"AssessmentCode"] :self.SelectTestTypecode];
        }
    }
    else if ([SCREEN_CODE_COACHING  isEqual: self.SelectScreenId])
    {
        if(IsEdit == YES)
        {
            [self.saveBtn setTitle:@"Update" forState:UIControlStateNormal];
            
            self.ObjSelectTestArray =[self.objDBConnection getTestCoachWithEnrty:self.version :self.ModuleStr :self.SelectTestStr :clientCode :[self.selectAllValueDic valueForKey:@"AssessmentCode"] :usercode :[self.selectAllValueDic valueForKey:@"SelectDate"] :[self.selectAllValueDic valueForKey:@"PlayerCode"] :self.SelectTestTypecode];
        }
        else
        {
            [self.saveBtn setTitle:@"Save" forState:UIControlStateNormal];
            
            self.ObjSelectTestArray =[self.objDBConnection getTestCoachWithoutEnrty:self.version :self.ModuleStr :self.SectionTestCodeStr :clientCode :[self.selectAllValueDic valueForKey:@"AssessmentCode"] :self.SelectTestTypecode];
        }
    }
    [self DesignTextMethod];
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
            self.left_Txt.text = [objDic valueForKey:@"romLeft"];
            self.right_Txt.text = [objDic valueForKey:@"romRight"];
            self.rightViewYposition.constant = -40;
            self.leftViewYposition.constant  = self.rightViewYposition.constant+2;
            self.RemarkViewYposition.constant = self.leftViewYposition.constant-180;
            
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
        if([[objDic valueForKey:@"romSideName"] isEqualToString:@"RIGHT & LEFT"])
        {
            self.rightCombview.hidden = NO;
            self.leftCombView.hidden = NO;
            [self.popTbl reloadData];
            if(self.ObjSelectTestArray.count > 0)
            {
                for(int i=0; i< _AssessmentTypeMMT.count; i++)
                {
                    if([[_AssessmentTypeMMT valueForKey:@"SpectialResultCode"] isEqualToString:[objDic valueForKey:@"MMTRight"]])
                    {
                        //setvalue
                        break;
                    }
                }
                for(int i=0; i<_AssessmentTypeMMT.count; i++)
                {
                    if([[_AssessmentTypeMMT valueForKey:@"SpectialResultCode"] isEqualToString:[objDic valueForKey:@"MMTLeft"]])
                    {
                        //setvalue
                        break;
                    }
                }
            }
        }
        else if([[objDic valueForKey:@"romSideName"] isEqualToString:@"CENTRAL"])
        {
            self.centralcombView.hidden = NO;
            [self.popTbl reloadData];
            if(self.ObjSelectTestArray.count>0)
            {
                for(int i=0; i<_AssessmentTypeMMT.count; i++)
                {
                    if([[_AssessmentTypeMMT valueForKey:@"SpectialResultCode"] isEqualToString:[objDic valueForKey:@"MMTCentral"]])
                    {
                        //setvalue
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
        self.remark_Txt.text =[objDic valueForKey:@"Remark"];
        int noofTrails;
        NSString * count =[objDic valueForKey:@"NoOfTrails"];
        noofTrails =[count intValue];
        for(int i=0; i< noofTrails; i++)
        {
            //setDesign
            if([[objDic valueForKey:@"Units"] isEqualToString:@"MSC320"])
            {
                
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
    }
    else if ([SCREEN_CODE_GAINT isEqualToString:self.SelectScreenId])
    {
        NSDictionary * objDic = [self.ObjSelectTestArray objectAtIndex:0];
        self.remark_Txt.text =[objDic valueForKey:@"Remark"];
        self.value_lbl.text =[objDic valueForKey:@"Value"];
        if([[objDic valueForKey:@"romSideName"] isEqualToString:@"RIGHT & LEFT"])
        {
            self.rightCombview.hidden = NO;
            self.leftCombView.hidden = NO;
            [self.popTbl reloadData];
            if(self.ObjSelectTestArray.count>0)
            {
                for (int i = 0; i < self.AssessmentTypeGaint.count; i++) {
                    
                    if ([[[self.AssessmentTypeGaint valueForKey:@"ResultCode"] objectAtIndex:i]isEqualToString:[objDic valueForKey:@"ResultRight"]]) {
                        
                        //spnRight.setSelection(i);
                        break;
                    }
                }
                
                for (int j = 0; j < self.AssessmentTypeGaint.count; j++) {
                    
                    if ([[[self.AssessmentTypeGaint valueForKey:@"ResultCode"] objectAtIndex:j] isEqualToString:[objDic valueForKey:@"ResultLeft"]]) {
                        
                        
                        //spnLeft.setSelection(j);
                        break;
                    }
                }
            }
        }
        else if ([[objDic valueForKey:@"SideName"] isEqualToString:@"CENTRAL"])
        {
            //relSpnCentral.setVisibility(View.VISIBLE);
            //spnCentral.setAdapter(new AssessmentResultAdapter(getActivity(), assessmentTestTypeGait));
            if (self.ObjSelectTestArray.count>0) {
                
                for (int i = 0; i < self.AssessmentTypeGaint.count; i++) {
                    
                    if ([[[self.AssessmentTypeGaint valueForKey:@"ResultCode"] objectAtIndex:i] isEqualToString:[objDic valueForKey:@"ResultCentral"]]) {
                        
                        //spnCentral.setSelection(i);
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
        self.remark_Txt.text =[objDic valueForKey:@"Remark"];
        self.value_lbl.text =[objDic valueForKey:@"Value"];
        
        if ([[objDic valueForKey:@"romSideName"] isEqualToString:@"RIGHT & LEFT"]) {
            self.rightCombview.hidden = NO;
            self.leftCombView.hidden = NO;
            
            //spnRight.setAdapter(new AssessmentResultAdapter(getActivity(), assessmentTestTypePosture));
            //spnLeft.setAdapter(new AssessmentResultAdapter(getActivity(), assessmentTestTypePosture));
            
            if (self.ObjSelectTestArray.count >0) {
                
                for (int i = 0; i < self.assessmentTestTypePosture.count; i++) {
                    
                    if ([[[self.assessmentTestTypePosture valueForKey:@"ResultCode"] objectAtIndex:i] isEqualToString:[objDic valueForKey:@"ResultRight"]]) {
                        
                        // spnRight.setSelection(i);
                        
                        break;
                    }
                    
                }
                
                
                for (int j = 0; j < self.assessmentTestTypePosture.count; j++) {
                    
                    if ([[[self.assessmentTestTypePosture valueForKey:@"ResultCode"] objectAtIndex:j] isEqualToString:[objDic valueForKey:@"ResultLeft"]]) {
                        // spnLeft.setSelection(j);
                        
                        break;
                    }
                    
                    
                }
                
            }
            
        } else if ([[objDic valueForKey:@"romSideName"] isEqualToString:@"CENTRAL"]) {
            self.centralcombView.hidden = NO;
            
            //spnCentral.setAdapter(new AssessmentResultAdapter(getActivity(), assessmentTestTypePosture));
            if (self.ObjSelectTestArray.count>0) {
                
                for (int i = 0; i < self.assessmentTestTypePosture.count; i++) {
                    
                    if ([[[self.assessmentTestTypePosture valueForKey:@"ResultCode"] objectAtIndex:i] isEqualToString:[objDic valueForKey:@"ResultCenter"]]) {
                        //spnCentral.setSelection(i);
                        break;
                    }
                    
                }
                
            }
            
        }
        
        self.valueview.hidden = NO;
        
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
    }
    else if ([SCREEN_CODE_SPECIAL isEqualToString:self.SelectScreenId])
    {
        NSDictionary * objDic = [self.ObjSelectTestArray objectAtIndex:0];
        
        if ([[objDic valueForKey:@"romSideName"] isEqualToString:@"RIGHT & LEFT"]) {
            self.rightCombview .hidden = NO;
            self.leftCombView.hidden  = NO;
            
            // spnRight.setAdapter(new AssessmentResultAdapter(getActivity(), assessmentTestTypeSpecial));
            // spnLeft.setAdapter(new AssessmentResultAdapter(getActivity(), assessmentTestTypeSpecial));
            
            if (self.ObjSelectTestArray.count>0 ) {
                
                for (int i = 0; i < self.assessmentTestTypeSpecial.count; i++) {
                    
                    if ([[[self.assessmentTestTypeSpecial valueForKey:@"ResultCode"] objectAtIndex:i] isEqualToString:[objDic valueForKey:@"ResultRight"]]) {
                        
                        //spnRight.setSelection(i);
                        
                        break;
                    }
                    
                }
                
                
                for (int j = 0; j <self.assessmentTestTypeSpecial.count; j++) {
                    
                    if ([[[self.assessmentTestTypeSpecial valueForKey:@"ResultCode"] objectAtIndex:j] isEqualToString:[objDic valueForKey:@"ResultLeft"]]) {
                        
                        // spnLeft.setSelection(j);
                        
                        break;
                    }
                }
            }
            
        } else if ([[objDic valueForKey:@"romSideName"] isEqualToString:@"CENTRAL"]) {
            
            self.centralcombView.hidden = NO;
            //relSpnCentral.setVisibility(View.VISIBLE);
            //  spnCentral.setAdapter(new AssessmentResultAdapter(getActivity(), assessmentTestTypeSpecial));
            
            if (self.ObjSelectTestArray.count>0) {
                
                for (int i = 0; i < self.assessmentTestTypeSpecial.count; i++) {
                    
                    if ([[self.assessmentTestTypeSpecial valueForKey:@"ResultCenter"] objectAtIndex:i]) {
                        
                        //spnCentral.setSelection(i);
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
        
        self.descriptionCombView.hidden = NO;
        self.remark_Txt.text = [objDic valueForKey:@"Remark"];
        //relSpnDsc.setVisibility(View.VISIBLE);
        // editRemarks.setText(selectTest.getRemarks());
        //spnDsc.setAdapter(new CoachDescriptionAdapter(getActivity(), selectTest.getCoachDescriptionList()));
        
        if (self.ObjSelectTestArray.count>0) {
            
            for (int j = 0; j < self.ObjSelectTestArray.count; j++) {
                
                if ([[[objDic valueForKey:@"TestCode"] objectAtIndex:j] isEqualToString:self.SectionTestCodeStr]) {
                    //spnDsc.setSelection(j);
                    break;
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
            [self.objDBConnection UPDATEAssessmentEntry:clientCode :@"" :self.ModuleStr :[self.selectAllValueDic valueForKey:@"AssessmentCode"]  :self.SectionTestCodeStr :self.SelectTestTypecode :self.SelectScreenId :self.version :usercode :[self.selectAllValueDic valueForKey:@"PlayerCode"] :[self.selectAllValueDic valueForKey:@"SelectDate"] :[NSString stringWithFormat:@"%@",self.left_Txt.text] :[NSString stringWithFormat:@"%@",self.right_Txt.text] :[NSString stringWithFormat:@"%@",self.centeral_Txt.text] :self.value_lbl.text :self.remark_Txt.text :self.interface_Txt.text :@"" :self.description_lbl.text :@"MSC001" :usercode :[objDic valueForKey:@"CreatedDate"] :usercode :[objDic valueForKey:@"ModifiedDate"] :self.ingnoreStatus :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@"0"];
        }
        else
        {
            [self.objDBConnection INSERTAssessmentEntry:clientCode :@"" :self.ModuleStr :[self.selectAllValueDic valueForKey:@"AssessmentCode"] :self.SectionTestCodeStr :self.SelectTestTypecode :self.SelectScreenId :self.version :usercode :[self.selectAllValueDic valueForKey:@"PlayerCode"] :[self.selectAllValueDic valueForKey:@"SelectDate"] :[NSString stringWithFormat:@"%@",self.left_Txt.text] :[NSString stringWithFormat:@"%@",self.right_Txt.text] :[NSString stringWithFormat:@"%@",self.centeral_Txt.text] :self.value_lbl.text :self.remark_Txt.text :self.interface_Txt.text :@"" :self.description_lbl.text :@"MSC001" :usercode :[objDic valueForKey:@"CreatedDate"] :usercode :[objDic valueForKey:@"ModifiedDate"] :self.ingnoreStatus :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@0 :@"0"];
        }
        self.right_Txt.text = @"";
        self.left_Txt.text = @"";
        self.remark_Txt.text =@"";
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

