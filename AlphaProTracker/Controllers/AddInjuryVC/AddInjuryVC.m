//
//  AddInjuryVC.m
//  AlphaProTracker
//
//  Created by Mac on 21/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "AddInjuryVC.h"
#import "WebService.h"
#import "Config.h"
#import "AppCommon.h"
#import "CustomNavigation.h"
#import "MultiInjuryVC.h"


@interface AddInjuryVC ()<UIImagePickerControllerDelegate,UINavigationBarDelegate>
{
    WebService * objWebservice;
    NSString *     cliendcode ;
    NSString * RoleCode;
    BOOL isGame;
    BOOL isTeam;
    BOOL isPlayer;
    BOOL isinjuryType;
    BOOL isinjuryCause;
    BOOL isAssessment;
    BOOL isOnset;
    BOOL isExpected;
    BOOL isoccurance;
    BOOL islocation;
    
    BOOL isXray;
    BOOL isCT;
    BOOL isMRI;
    BOOL isBlood;
    
    UIDatePicker * datePicker;
    NSString * selectGameCode;
    NSString * selectTeamCode;
    NSString * selectPlayerCode;
    
    NSString * selectOnsetTypeCode;
    NSString * selectInjuryOccuranceCode;
    NSString * selectInjurySideCode;
    NSString * selectInjuryLocationCode;
    NSString * selectInjurySiteCode;
    NSString * selectExpertOpinionCode;
    NSString * injuryTypeCode;
    NSString * injuryCausecode;
    NSString * selectoccurancecode;
    NSString * selectlocationCode;
    NSString * usercode;
    NSString * selectsliderValue;
    
    NSString * selectInjuryCode;
    NSString * VasValue;
    UIImage *imageToPost;
    CGSize dataSize;
}
@property (nonatomic,strong) NSMutableArray * gameArray;
@property (nonatomic,strong) NSMutableArray * TeamArray;
@property (nonatomic,strong) NSMutableArray * playerArray;


@property (nonatomic,strong) NSMutableArray * TrainingArray;
@property (nonatomic,strong) NSMutableArray * competitionArray;
@property (nonatomic,strong) NSMutableArray * headandtruckArray;
@property (nonatomic,strong) NSMutableArray * upperextremityArray;
@property (nonatomic,strong) NSMutableArray * lowerextremityArray;
@property (nonatomic,strong) NSMutableArray * injuryTypeArray;
@property (nonatomic,strong) NSMutableArray * injuryCauseArray;


@property (nonatomic,strong) NSMutableArray * SelectOccuranceArray;
@property (nonatomic,strong) NSMutableArray * SelectLocationArray;


@property (nonatomic,strong) IBOutlet UITableView * popview_Tbl;

@property (nonatomic,strong) NSMutableArray * commonArray;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * popviewYposition;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * popviewwidthSize;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * coachViewYposition;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * occurrenceviewHeight;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * locationviewHeight;


@property (nonatomic,strong) IBOutlet NSLayoutConstraint * allviewHeight;


@property (nonatomic,strong) IBOutlet UIView * coachView;
@property (nonatomic,strong) IBOutlet UIView * playerview;
@property (nonatomic,strong) IBOutlet UIView * gameView;
@property (nonatomic,strong) IBOutlet UIView * teamView;
@property (nonatomic,strong) IBOutlet UIView * playerView;
@property (nonatomic,strong) IBOutlet UIView * assessmentView;
@property (nonatomic,strong) IBOutlet UIView * onSetView;
@property (nonatomic,strong) IBOutlet UIView * injurysideView;
@property (nonatomic,strong) IBOutlet UIView * injuryTypeView;
@property (nonatomic,strong) IBOutlet UIView * injuryCauseView;
@property (nonatomic,strong) IBOutlet UIView * XRayView;
@property (nonatomic,strong) IBOutlet UIView * CTScansView;
@property (nonatomic,strong) IBOutlet UIView * MRIScansView;
@property (nonatomic,strong) IBOutlet UIView * BloodTestView;
@property (nonatomic,strong) IBOutlet UIView * ExpectedView;
@property (nonatomic,strong) IBOutlet UIView * occurranceView;
@property (nonatomic,strong) IBOutlet UIView * locationView;


@property (nonatomic,strong) IBOutlet UIView * gameSubView;
@property (nonatomic,strong) IBOutlet UIView * teamSubView;
@property (nonatomic,strong) IBOutlet UIView * playerSubView;
@property (nonatomic,strong) IBOutlet UIView * assessmentSubView;
@property (nonatomic,strong) IBOutlet UIView * onSetSubView;
@property (nonatomic,strong) IBOutlet UIView * injuryTypeSubView;
@property (nonatomic,strong) IBOutlet UIView * injuryCauseSubView;
@property (nonatomic,strong) IBOutlet UIView * XRaySubView;
@property (nonatomic,strong) IBOutlet UIView * CTScansSubView;
@property (nonatomic,strong) IBOutlet UIView * MRIScansSubView;
@property (nonatomic,strong) IBOutlet UIView * BloodTestSubView;
@property (nonatomic,strong) IBOutlet UIView * ExpectedSubView;
@property (nonatomic,strong) IBOutlet UIView * injuryNameSubView;
@property (nonatomic,strong) IBOutlet UIView * chiefSubView;



@property (nonatomic,strong) IBOutlet UILabel * gameLbl;
@property (nonatomic,strong) IBOutlet UILabel * TeamLbl;
@property (nonatomic,strong) IBOutlet UILabel * playerLbl;
@property (nonatomic,strong) IBOutlet UILabel * injurytypeLbl;
@property (nonatomic,strong) IBOutlet UILabel * injuryCauseLbl;
@property (nonatomic,strong) IBOutlet UILabel * assessmentLbl;
@property (nonatomic,strong) IBOutlet UILabel * onSetLbl;
@property (nonatomic,strong) IBOutlet UITextField * injuryNameTxt;
@property (nonatomic,strong) IBOutlet UITextField * cheifcomplientTxt;
@property (nonatomic,strong) IBOutlet UILabel * xrayLbl;
@property (nonatomic,strong) IBOutlet UILabel * CTScanLbl;
@property (nonatomic,strong) IBOutlet UILabel * MRILbl;
@property (nonatomic,strong) IBOutlet UILabel * BloodTestLbl;
@property (nonatomic,strong) IBOutlet UILabel * expectedLbl;
@property (nonatomic,strong) IBOutlet UIButton * updateBtn;
@property (nonatomic,strong) IBOutlet UIButton * deleteBtn;
@property (nonatomic,strong) IBOutlet UIButton * saveBtn;

@property (nonatomic,strong) IBOutlet UIButton * traumaticBtn;

@property (nonatomic,strong) IBOutlet UIButton * delayedBtn;

@property (nonatomic,strong) IBOutlet UIButton * TrainingBtn;

@property (nonatomic,strong) IBOutlet UIButton * CompetitionBtn;

@property (nonatomic,strong) IBOutlet UIButton * headerBtn;

@property (nonatomic,strong) IBOutlet UIButton * upperBtn;

@property (nonatomic,strong) IBOutlet UIButton * lowerBtn;

@property (nonatomic,strong) IBOutlet UIButton * anteriorBtn;

@property (nonatomic,strong) IBOutlet UIButton * posteriorBtn;

@property (nonatomic,strong) IBOutlet UIButton * medicalBtn;

@property (nonatomic,strong) IBOutlet UIButton * lateralBtn;

@property (nonatomic,strong) IBOutlet UIButton * rightBtn;

@property (nonatomic,strong) IBOutlet UIButton * leftBtn;

@property (nonatomic,strong) IBOutlet UIButton * expertYesBtn;

@property (nonatomic,strong) IBOutlet UIButton * expertNoBtn;


@property (nonatomic,strong) IBOutlet UIView * view_datepicker;

@property (nonatomic,strong) IBOutlet UIView * occurranceselectview;

@property (nonatomic,strong) IBOutlet UILabel * occurancelbl;

@property (nonatomic,strong) IBOutlet UIButton * occurranceBtn;

@property (nonatomic,strong) IBOutlet UIView * locationselectview;

@property (nonatomic,strong) IBOutlet UILabel * locationlbl;

@property (nonatomic,strong) IBOutlet UIButton * locationBtn;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * datepickerViewWidth;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * datepickerViewheight;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * popViewheight;



@end

@implementation AddInjuryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    objWebservice =[[WebService alloc]init];
    
    self.StSlider.labels = @[@"1", @"2", @"3", @"4", @"5",@"6",@"7"];
    self.StSlider.maxCount = 7;
    self.StSlider.trackHeight = 4;
    self.StSlider.trackCircleRadius = 5;
    self.StSlider.trackColor = [UIColor grayColor];
    self.StSlider.sliderCircleColor = [UIColor whiteColor];
    self.StSlider.labelColor = [UIColor whiteColor];
    self.StSlider.sliderCircleRadius = self.StSlider.trackCircleRadius+10;
    
    
    
    cliendcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    RoleCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"RoleCode"];
    usercode = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];

    
    self.TrainingArray =[[NSMutableArray alloc]init];
    self.competitionArray =[[NSMutableArray alloc]init];
    self.headandtruckArray =[[NSMutableArray alloc]init];
    self.upperextremityArray =[[NSMutableArray alloc]init];
    self.lowerextremityArray =[[NSMutableArray alloc]init];
    self.injuryTypeArray =[[NSMutableArray alloc]init];
    self.injuryCauseArray =[[NSMutableArray alloc]init];
    
    self.gameArray =[[NSMutableArray alloc]init];
    self.TeamArray =[[NSMutableArray alloc]init];
    self.playerArray =[[NSMutableArray alloc]init];
    
    [self.traumaticBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
    [self.delayedBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
    [self.TrainingBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
    [self.CompetitionBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
    [self.headerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
    [self.upperBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
    [self.lowerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
    [self.anteriorBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
    [self.posteriorBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
    [self.medicalBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
    [self.lateralBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
    [self.rightBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
    [self.leftBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
    [self.expertYesBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
    [self.expertNoBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
   
    [self startFetchTeamPlayerGameService];
    
    
    [self customnavigationmethod];
    [self allviewsetBordermethod];
    
    self.datepickerViewWidth.constant =self.view.frame.size.width/1.5;
    self.datepickerViewheight.constant =self.view.frame.size.height/3;
}

-(void)viewWillAppear:(BOOL)animated
{
    
    self.popview_Tbl.hidden =YES;
    self.view_datepicker.hidden =YES;
    
    
}

-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    
    
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"Add Injury";
    objCustomNavigation.btn_back.hidden =NO;
    objCustomNavigation.menu_btn.hidden = YES;
    [objCustomNavigation.btn_back addTarget:self action:@selector(BackBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    //[objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(IBAction)didClickMultiInjuryAction:(id)sender
{
    MultiInjuryVC  * objaddinjury=[[MultiInjuryVC alloc]init];
    objaddinjury = (MultiInjuryVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"MultiInjuryVC"];
    [self.navigationController pushViewController:objaddinjury animated:YES];
}

-(void)allviewsetBordermethod
{
    
    self.multiInjuryBtn.layer.borderWidth = 0.5f;
    self.multiInjuryBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
     self.gameSubView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.gameSubView.layer.borderWidth=0.5;
    self.gameSubView.layer.masksToBounds=YES;
    
    self.teamSubView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.teamSubView.layer.borderWidth=0.5;
    self.teamSubView.layer.masksToBounds=YES;

    self.playerSubView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.playerSubView.layer.borderWidth=0.5;
    self.playerSubView.layer.masksToBounds=YES;

    self.assessmentSubView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.assessmentSubView.layer.borderWidth=0.5;
    self.assessmentSubView.layer.masksToBounds=YES;

    self.onSetSubView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.onSetSubView.layer.borderWidth=0.5;
    self.onSetSubView.layer.masksToBounds=YES;

    self.injuryTypeSubView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.injuryTypeSubView.layer.borderWidth=0.5;
    self.injuryTypeSubView.layer.masksToBounds=YES;

    self.injuryCauseSubView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.injuryCauseSubView.layer.borderWidth=0.5;
    self.injuryCauseSubView.layer.masksToBounds=YES;

    self.XRaySubView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.XRaySubView.layer.borderWidth=0.5;
    self.XRaySubView.layer.masksToBounds=YES;

    
    self.CTScansSubView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.CTScansSubView.layer.borderWidth=0.5;
    self.CTScansSubView.layer.masksToBounds=YES;

    self.MRIScansSubView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.MRIScansSubView.layer.borderWidth=0.5;
    self.MRIScansSubView.layer.masksToBounds=YES;

    self.BloodTestSubView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.BloodTestSubView.layer.borderWidth=0.5;
    self.BloodTestSubView.layer.masksToBounds=YES;

    self.ExpectedSubView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.ExpectedSubView.layer.borderWidth=0.5;
    self.ExpectedSubView.layer.masksToBounds=YES;

    self.injuryNameSubView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.injuryNameSubView.layer.borderWidth=0.5;
    self.injuryNameSubView.layer.masksToBounds=YES;

    self.chiefSubView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.chiefSubView.layer.borderWidth=0.5;
    self.chiefSubView.layer.masksToBounds=YES;

    
    self.allviewHeight.constant =60;
    

}
-(void)FetchMetadatawebservice
{
    //[COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        [objWebservice getFetchMetadataList:FetchMetadata success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                
                
                
    
                self.TrainingArray =[responseObject valueForKey:@"Training"];
                
                self.competitionArray =[responseObject valueForKey:@"Competition"];

                self.headandtruckArray =[responseObject valueForKey:@"HeadAndTrunk"];

                self.upperextremityArray =[responseObject valueForKey:@"UpperExtremity"];

                self.lowerextremityArray =[responseObject valueForKey:@"LowerExtremity"];

                self.injuryTypeArray =[responseObject valueForKey:@"InjuryType"];

                self.injuryCauseArray =[responseObject valueForKey:@"InjuryCause"];
                
                if(self.isUpdate == YES)
                {
                
                selectInjuryOccuranceCode =[self.objSelectInjuryArray valueForKey:@"INJURYOCCURANCECODE"];//trainingarray,competion
                selectInjuryLocationCode = [self.objSelectInjuryArray valueForKey:@"INJURYLOCATIONCODE"];//headandtruckArray,upperextremityArray,lowerextremityArray
                injuryTypeCode =[self.objSelectInjuryArray valueForKey:@"INJURYTYPECODE"] ;
                injuryCausecode =[self.objSelectInjuryArray valueForKey:@"INJURYCAUSECODE"];
                
                selectoccurancecode=[self.objSelectInjuryArray valueForKey:@"INJURYOCCURANCESUBCODE"];
                selectlocationCode = [self.objSelectInjuryArray valueForKey:@"INJURYLOCATIONSUBCODE"];
            
                
                
                if([selectOnsetTypeCode isEqualToString:@"MSC127"])
                {
                    [self.traumaticBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                    [self.delayedBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    
                }
                else
                {
                    [self.traumaticBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.delayedBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                    
                }
                if([selectoccurancecode isEqualToString:@"MSC131"])
                {
                    [self.TrainingBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                    [self.CompetitionBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    
                    for(int i=0;i<self.TrainingArray.count;i++)
                    {
                        NSDictionary *dic = [[NSDictionary alloc]init];
                        dic=[self.TrainingArray objectAtIndex:i];
                        NSString *OccCode = [dic valueForKey:@"InjuryMetaSubCode"];
                        
                        if([selectoccurancecode isEqualToString:OccCode])
                        {
                            self.occurancelbl.text = [dic valueForKey:@"InjuryMetaDataTypeCode"];
                        }
                    }
                    
                }
                else if([selectoccurancecode isEqualToString:@"MSC132"])
                {
                    [self.TrainingBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                    [self.CompetitionBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    
                    for(int i=0;i<self.TrainingArray.count;i++)
                    {
                        NSDictionary *dic = [[NSDictionary alloc]init];
                        dic=[self.TrainingArray objectAtIndex:i];
                        NSString *OccCode = [dic valueForKey:@"InjuryMetaSubCode"];
                        
                        if([selectoccurancecode isEqualToString:OccCode])
                        {
                            self.occurancelbl.text = [dic valueForKey:@"InjuryMetaDataTypeCode"];
                        }
                    }
                    
                }
                else if([selectoccurancecode isEqualToString:@"MSC133"])
                {
                    [self.TrainingBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.CompetitionBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                    
                    for(int i=0;i<self.competitionArray.count;i++)
                    {
                        NSDictionary *dic = [[NSDictionary alloc]init];
                        dic=[self.competitionArray objectAtIndex:i];
                        NSString *OccCode = [dic valueForKey:@"InjuryMetaSubCode"];
                        
                        if([selectoccurancecode isEqualToString:OccCode])
                        {
                            self.occurancelbl.text = [dic valueForKey:@"InjuryMetaDataTypeCode"];
                        }

                    }
                    
                }
                else if([selectoccurancecode isEqualToString:@"MSC134"])
                {
                    [self.TrainingBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.CompetitionBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                    
                    for(int i=0;i<self.competitionArray.count;i++)
                    {
                        NSDictionary *dic = [[NSDictionary alloc]init];
                        dic=[self.competitionArray objectAtIndex:i];
                        NSString *OccCode = [dic valueForKey:@"InjuryMetaSubCode"];
                        
                        if([selectoccurancecode isEqualToString:OccCode])
                        {
                            self.occurancelbl.text = [dic valueForKey:@"InjuryMetaDataTypeCode"];
                        }
                        
                    }
                    
                }
                else if([selectoccurancecode isEqualToString:@"MSC135"])
                {
                    [self.TrainingBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.CompetitionBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                    
                    for(int i=0;i<self.competitionArray.count;i++)
                    {
                        NSDictionary *dic = [[NSDictionary alloc]init];
                        dic=[self.competitionArray objectAtIndex:i];
                        NSString *OccCode = [dic valueForKey:@"InjuryMetaSubCode"];
                        
                        if([selectoccurancecode isEqualToString:OccCode])
                        {
                            self.occurancelbl.text = [dic valueForKey:@"InjuryMetaDataTypeCode"];
                        }
                        
                    }
                    
                }
                else if([selectoccurancecode isEqualToString:@"MSC136"])
                {
                    [self.TrainingBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.CompetitionBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                    
                    for(int i=0;i<self.competitionArray.count;i++)
                    {
                        NSDictionary *dic = [[NSDictionary alloc]init];
                        dic=[self.competitionArray objectAtIndex:i];
                        NSString *OccCode = [dic valueForKey:@"InjuryMetaSubCode"];
                        
                        if([selectoccurancecode isEqualToString:OccCode])
                        {
                            self.occurancelbl.text = [dic valueForKey:@"InjuryMetaDataTypeCode"];
                        }
                        
                    }
                    
                }
                else if([selectoccurancecode isEqualToString:@"MSC137"])
                {
                    [self.TrainingBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.CompetitionBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                    
                    for(int i=0;i<self.competitionArray.count;i++)
                    {
                        NSDictionary *dic = [[NSDictionary alloc]init];
                        dic=[self.competitionArray objectAtIndex:i];
                        NSString *OccCode = [dic valueForKey:@"InjuryMetaSubCode"];
                        
                        if([selectoccurancecode isEqualToString:OccCode])
                        {
                            self.occurancelbl.text = [dic valueForKey:@"InjuryMetaDataTypeCode"];
                        }
                        
                    }
                    
                }




                
                if([selectlocationCode isEqualToString:@"MSC141"])
                {
                    [self.headerBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                    [self.upperBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.lowerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    
                    for(int i=0;i<self.headandtruckArray.count;i++)
                    {
                        NSDictionary *dic = [[NSDictionary alloc]init];
                        dic=[self.headandtruckArray objectAtIndex:i];
                        NSString *OccCode = [dic valueForKey:@"InjuryMetaSubCode"];
                        
                        if([selectlocationCode isEqualToString:OccCode])
                        {
                            self.locationlbl.text = [dic valueForKey:@"InjuryMetaDataTypeCode"];
                        }
                        
                    }

                    
                }
                else if([selectlocationCode isEqualToString:@"MSC142"])
                {
                    [self.headerBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                    [self.upperBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.lowerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    
                    for(int i=0;i<self.headandtruckArray.count;i++)
                    {
                        NSDictionary *dic = [[NSDictionary alloc]init];
                        dic=[self.headandtruckArray objectAtIndex:i];
                        NSString *OccCode = [dic valueForKey:@"InjuryMetaSubCode"];
                        
                        if([selectlocationCode isEqualToString:OccCode])
                        {
                            self.locationlbl.text = [dic valueForKey:@"InjuryMetaDataTypeCode"];
                        }
                        
                    }


                    
                }
                else if([selectlocationCode isEqualToString:@"MSC143"])
                {
                    [self.headerBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                    [self.upperBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.lowerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    
                    for(int i=0;i<self.headandtruckArray.count;i++)
                    {
                        NSDictionary *dic = [[NSDictionary alloc]init];
                        dic=[self.headandtruckArray objectAtIndex:i];
                        NSString *OccCode = [dic valueForKey:@"InjuryMetaSubCode"];
                        
                        if([selectlocationCode isEqualToString:OccCode])
                        {
                            self.locationlbl.text = [dic valueForKey:@"InjuryMetaDataTypeCode"];
                        }
                        
                    }

                    
                    
                }

                else if([selectlocationCode isEqualToString:@"MSC144"])
                {
                    [self.headerBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                    [self.upperBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.lowerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    
                    for(int i=0;i<self.headandtruckArray.count;i++)
                    {
                        NSDictionary *dic = [[NSDictionary alloc]init];
                        dic=[self.headandtruckArray objectAtIndex:i];
                        NSString *OccCode = [dic valueForKey:@"InjuryMetaSubCode"];
                        
                        if([selectlocationCode isEqualToString:OccCode])
                        {
                            self.locationlbl.text = [dic valueForKey:@"InjuryMetaDataTypeCode"];
                        }
                        
                    }

                    
                    
                }

                else if([selectlocationCode isEqualToString:@"MSC145"])
                {
                    [self.headerBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                    [self.upperBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.lowerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    
                    for(int i=0;i<self.headandtruckArray.count;i++)
                    {
                        NSDictionary *dic = [[NSDictionary alloc]init];
                        dic=[self.headandtruckArray objectAtIndex:i];
                        NSString *OccCode = [dic valueForKey:@"InjuryMetaSubCode"];
                        
                        if([selectlocationCode isEqualToString:OccCode])
                        {
                            self.locationlbl.text = [dic valueForKey:@"InjuryMetaDataTypeCode"];
                        }
                        
                    }

                    
                }

                else if([selectlocationCode isEqualToString:@"MSC146"])
                {
                    [self.headerBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                    [self.upperBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.lowerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    
                    
                    for(int i=0;i<self.headandtruckArray.count;i++)
                    {
                        NSDictionary *dic = [[NSDictionary alloc]init];
                        dic=[self.headandtruckArray objectAtIndex:i];
                        NSString *OccCode = [dic valueForKey:@"InjuryMetaSubCode"];
                        
                        if([selectlocationCode isEqualToString:OccCode])
                        {
                            self.locationlbl.text = [dic valueForKey:@"InjuryMetaDataTypeCode"];
                        }
                        
                    }

                }

                else if([selectlocationCode isEqualToString:@"MSC147"])
                {
                    [self.headerBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                    [self.upperBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.lowerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    
                    
                    for(int i=0;i<self.headandtruckArray.count;i++)
                    {
                        NSDictionary *dic = [[NSDictionary alloc]init];
                        dic=[self.headandtruckArray objectAtIndex:i];
                        NSString *OccCode = [dic valueForKey:@"InjuryMetaSubCode"];
                        
                        if([selectlocationCode isEqualToString:OccCode])
                        {
                            self.locationlbl.text = [dic valueForKey:@"InjuryMetaDataTypeCode"];
                        }
                        
                    }

                }

                else if([selectlocationCode isEqualToString:@"MSC148"])
                {
                    [self.headerBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                    [self.upperBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.lowerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    
                    
                    for(int i=0;i<self.headandtruckArray.count;i++)
                    {
                        NSDictionary *dic = [[NSDictionary alloc]init];
                        dic=[self.headandtruckArray objectAtIndex:i];
                        NSString *OccCode = [dic valueForKey:@"InjuryMetaSubCode"];
                        
                        if([selectlocationCode isEqualToString:OccCode])
                        {
                            self.locationlbl.text = [dic valueForKey:@"InjuryMetaDataTypeCode"];
                        }
                        
                    }

                }
                
                if([selectlocationCode isEqualToString:@"MSC149"])
                {
                    [self.headerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.upperBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                    [self.lowerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    
                    
                    for(int i=0;i<self.upperextremityArray.count;i++)
                    {
                        NSDictionary *dic = [[NSDictionary alloc]init];
                        dic=[self.upperextremityArray objectAtIndex:i];
                        NSString *OccCode = [dic valueForKey:@"InjuryMetaSubCode"];
                        
                        if([selectlocationCode isEqualToString:OccCode])
                        {
                            self.locationlbl.text = [dic valueForKey:@"InjuryMetaDataTypeCode"];
                        }
                        
                    }
                    
                }
                else if([selectlocationCode isEqualToString:@"MSC150"])
                {
                    [self.headerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.upperBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                    [self.lowerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    
                    
                    for(int i=0;i<self.upperextremityArray.count;i++)
                    {
                        NSDictionary *dic = [[NSDictionary alloc]init];
                        dic=[self.upperextremityArray objectAtIndex:i];
                        NSString *OccCode = [dic valueForKey:@"InjuryMetaSubCode"];
                        
                        if([selectlocationCode isEqualToString:OccCode])
                        {
                            self.locationlbl.text = [dic valueForKey:@"InjuryMetaDataTypeCode"];
                        }
                        
                    }
                    
                }
                else if([selectlocationCode isEqualToString:@"MSC151"])
                {
                    [self.headerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.upperBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                    [self.lowerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    
                    
                    for(int i=0;i<self.upperextremityArray.count;i++)
                    {
                        NSDictionary *dic = [[NSDictionary alloc]init];
                        dic=[self.upperextremityArray objectAtIndex:i];
                        NSString *OccCode = [dic valueForKey:@"InjuryMetaSubCode"];
                        
                        if([selectlocationCode isEqualToString:OccCode])
                        {
                            self.locationlbl.text = [dic valueForKey:@"InjuryMetaDataTypeCode"];
                        }
                        
                    }
                    
                }
                else if([selectlocationCode isEqualToString:@"MSC152"])
                {
                    [self.headerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.upperBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                    [self.lowerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    
                    
                    for(int i=0;i<self.upperextremityArray.count;i++)
                    {
                        NSDictionary *dic = [[NSDictionary alloc]init];
                        dic=[self.upperextremityArray objectAtIndex:i];
                        NSString *OccCode = [dic valueForKey:@"InjuryMetaSubCode"];
                        
                        if([selectlocationCode isEqualToString:OccCode])
                        {
                            self.locationlbl.text = [dic valueForKey:@"InjuryMetaDataTypeCode"];
                        }
                        
                    }
                    
                }
                else if([selectlocationCode isEqualToString:@"MSC153"])
                {
                    [self.headerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.upperBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                    [self.lowerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    
                    
                    for(int i=0;i<self.upperextremityArray.count;i++)
                    {
                        NSDictionary *dic = [[NSDictionary alloc]init];
                        dic=[self.upperextremityArray objectAtIndex:i];
                        NSString *OccCode = [dic valueForKey:@"InjuryMetaSubCode"];
                        
                        if([selectlocationCode isEqualToString:OccCode])
                        {
                            self.locationlbl.text = [dic valueForKey:@"InjuryMetaDataTypeCode"];
                        }
                        
                    }
                    
                }
                else if([selectlocationCode isEqualToString:@"MSC154"])
                {
                    [self.headerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.upperBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                    [self.lowerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    
                    
                    for(int i=0;i<self.upperextremityArray.count;i++)
                    {
                        NSDictionary *dic = [[NSDictionary alloc]init];
                        dic=[self.upperextremityArray objectAtIndex:i];
                        NSString *OccCode = [dic valueForKey:@"InjuryMetaSubCode"];
                        
                        if([selectlocationCode isEqualToString:OccCode])
                        {
                            self.locationlbl.text = [dic valueForKey:@"InjuryMetaDataTypeCode"];
                        }
                        
                    }
                    
                }
                else if([selectlocationCode isEqualToString:@"MSC155"])
                {
                    [self.headerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.upperBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                    [self.lowerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    
                    
                    for(int i=0;i<self.upperextremityArray.count;i++)
                    {
                        NSDictionary *dic = [[NSDictionary alloc]init];
                        dic=[self.upperextremityArray objectAtIndex:i];
                        NSString *OccCode = [dic valueForKey:@"InjuryMetaSubCode"];
                        
                        if([selectlocationCode isEqualToString:OccCode])
                        {
                            self.locationlbl.text = [dic valueForKey:@"InjuryMetaDataTypeCode"];
                        }
                        
                    }
                    
                }
                else if([selectlocationCode isEqualToString:@"MSC156"])
                {
                    [self.headerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.upperBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                    [self.lowerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    
                    
                    for(int i=0;i<self.upperextremityArray.count;i++)
                    {
                        NSDictionary *dic = [[NSDictionary alloc]init];
                        dic=[self.upperextremityArray objectAtIndex:i];
                        NSString *OccCode = [dic valueForKey:@"InjuryMetaSubCode"];
                        
                        if([selectlocationCode isEqualToString:OccCode])
                        {
                            self.locationlbl.text = [dic valueForKey:@"InjuryMetaDataTypeCode"];
                        }
                        
                    }
                    
                }
                
                
                if([selectlocationCode isEqualToString:@"MSC157"])
                {
                    [self.headerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.upperBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.lowerBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                    
                    
                    for(int i=0;i<self.lowerextremityArray.count;i++)
                    {
                        NSDictionary *dic = [[NSDictionary alloc]init];
                        dic=[self.lowerextremityArray objectAtIndex:i];
                        NSString *OccCode = [dic valueForKey:@"InjuryMetaSubCode"];
                        
                        if([selectlocationCode isEqualToString:OccCode])
                        {
                            self.locationlbl.text = [dic valueForKey:@"InjuryMetaDataTypeCode"];
                        }
                        
                    }
                    
                }
                 else if([selectlocationCode isEqualToString:@"MSC158"])
                 {
                     [self.headerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                     [self.upperBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                     [self.lowerBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                     
                     
                     for(int i=0;i<self.lowerextremityArray.count;i++)
                     {
                         NSDictionary *dic = [[NSDictionary alloc]init];
                         dic=[self.lowerextremityArray objectAtIndex:i];
                         NSString *OccCode = [dic valueForKey:@"InjuryMetaSubCode"];
                         
                         if([selectlocationCode isEqualToString:OccCode])
                         {
                             self.locationlbl.text = [dic valueForKey:@"InjuryMetaDataTypeCode"];
                         }
                         
                     }
                     
                 }
                 else if([selectlocationCode isEqualToString:@"MSC159"])
                 {
                     [self.headerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                     [self.upperBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                     [self.lowerBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                     
                     
                     for(int i=0;i<self.lowerextremityArray.count;i++)
                     {
                         NSDictionary *dic = [[NSDictionary alloc]init];
                         dic=[self.lowerextremityArray objectAtIndex:i];
                         NSString *OccCode = [dic valueForKey:@"InjuryMetaSubCode"];
                         
                         if([selectlocationCode isEqualToString:OccCode])
                         {
                             self.locationlbl.text = [dic valueForKey:@"InjuryMetaDataTypeCode"];
                         }
                         
                     }
                     
                 }
                 else if([selectlocationCode isEqualToString:@"MSC160"])
                 {
                     [self.headerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                     [self.upperBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                     [self.lowerBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                     
                     
                     for(int i=0;i<self.lowerextremityArray.count;i++)
                     {
                         NSDictionary *dic = [[NSDictionary alloc]init];
                         dic=[self.lowerextremityArray objectAtIndex:i];
                         NSString *OccCode = [dic valueForKey:@"InjuryMetaSubCode"];
                         
                         if([selectlocationCode isEqualToString:OccCode])
                         {
                             self.locationlbl.text = [dic valueForKey:@"InjuryMetaDataTypeCode"];
                         }
                         
                     }
                     
                 }
                 else if([selectlocationCode isEqualToString:@"MSC161"])
                 {
                     [self.headerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                     [self.upperBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                     [self.lowerBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                     
                     
                     for(int i=0;i<self.lowerextremityArray.count;i++)
                     {
                         NSDictionary *dic = [[NSDictionary alloc]init];
                         dic=[self.lowerextremityArray objectAtIndex:i];
                         NSString *OccCode = [dic valueForKey:@"InjuryMetaSubCode"];
                         
                         if([selectlocationCode isEqualToString:OccCode])
                         {
                             self.locationlbl.text = [dic valueForKey:@"InjuryMetaDataTypeCode"];
                         }
                         
                     }
                     
                 }
                 else if([selectlocationCode isEqualToString:@"MSC162"])
                 {
                     [self.headerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                     [self.upperBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                     [self.lowerBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                     
                     
                     for(int i=0;i<self.lowerextremityArray.count;i++)
                     {
                         NSDictionary *dic = [[NSDictionary alloc]init];
                         dic=[self.lowerextremityArray objectAtIndex:i];
                         NSString *OccCode = [dic valueForKey:@"InjuryMetaSubCode"];
                         
                         if([selectlocationCode isEqualToString:OccCode])
                         {
                             self.locationlbl.text = [dic valueForKey:@"InjuryMetaDataTypeCode"];
                         }
                         
                     }
                     
                 }
                 else if([selectlocationCode isEqualToString:@"MSC163"])
                 {
                     [self.headerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                     [self.upperBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                     [self.lowerBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                     
                     
                     for(int i=0;i<self.lowerextremityArray.count;i++)
                     {
                         NSDictionary *dic = [[NSDictionary alloc]init];
                         dic=[self.lowerextremityArray objectAtIndex:i];
                         NSString *OccCode = [dic valueForKey:@"InjuryMetaSubCode"];
                         
                         if([selectlocationCode isEqualToString:OccCode])
                         {
                             self.locationlbl.text = [dic valueForKey:@"InjuryMetaDataTypeCode"];
                         }
                         
                     }
                     
                 }
                 else if([selectlocationCode isEqualToString:@"MSC164"])
                 {
                     [self.headerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                     [self.upperBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                     [self.lowerBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                     
                     
                     for(int i=0;i<self.lowerextremityArray.count;i++)
                     {
                         NSDictionary *dic = [[NSDictionary alloc]init];
                         dic=[self.lowerextremityArray objectAtIndex:i];
                         NSString *OccCode = [dic valueForKey:@"InjuryMetaSubCode"];
                         
                         if([selectlocationCode isEqualToString:OccCode])
                         {
                             self.locationlbl.text = [dic valueForKey:@"InjuryMetaDataTypeCode"];
                         }
                         
                     }
                     
                 }


                
                
                
                if([selectInjurySiteCode isEqualToString:@"MSC165"])
                {
                    [self.anteriorBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                    [self.posteriorBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.medicalBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.lateralBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    
                }
                else if([selectInjurySiteCode isEqualToString:@"MSC167"])
                {
                    [self.anteriorBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.posteriorBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                    [self.medicalBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.lateralBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    
                }
                else if([selectInjurySiteCode isEqualToString:@"MSC166"])
                {
                    [self.anteriorBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.posteriorBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.medicalBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                    [self.lateralBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    
                }
                else if([selectInjurySiteCode isEqualToString:@"MSC168"])
                {
                    [self.anteriorBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.posteriorBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.medicalBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.lateralBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                    
                }
                
                
                
                if([selectInjurySideCode isEqualToString:@"MSC169"])
                {
                    [self.rightBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                    [self.leftBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                }
                else
                {
                    [self.rightBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.leftBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                }
                
                for(int i=0;i<self.injuryTypeArray.count;i++)
                {
                    NSDictionary *dic = [[NSDictionary alloc]init];
                    dic=[self.injuryTypeArray objectAtIndex:i];
                    NSString *OccCode = [dic valueForKey:@"InjuryMetaSubCode"];
                    
                    if([injuryTypeCode isEqualToString:OccCode])
                    {
                        self.injurytypeLbl.text = [dic valueForKey:@"InjuryMetaDataTypeCode"];

                    }
                }
                
                for(int i=0;i<self.injuryCauseArray.count;i++)
                {
                    NSDictionary *dic = [[NSDictionary alloc]init];
                    dic=[self.injuryCauseArray objectAtIndex:i];
                    NSString *OccCode = [dic valueForKey:@"InjuryMetaSubCode"];
                    
                    if([injuryCausecode isEqualToString:OccCode])
                    {
                        self.injuryCauseLbl.text = [dic valueForKey:@"InjuryMetaDataTypeCode"];
                        
                    }
                }


                if([selectExpertOpinionCode isEqualToString:@"MSC215"])
                {
                    [self.expertYesBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                    [self.expertNoBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                }
                else
                {
                    [self.expertYesBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
                    [self.expertNoBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
                }

                

                
                if([RoleCode isEqualToString:@"ROL0000003"])
                {
                    self.playerview.hidden=NO;
                    self.coachViewYposition.constant =10;
                    
                }
                else{
                    self.playerview.hidden=YES;
                    self.coachViewYposition.constant =self.playerView.frame.size.height+5;
                    
                    self.updateBtn.hidden = YES;
                    self.deleteBtn.hidden = YES;
                }
                
                if([self.TrainingBtn.currentImage isEqual:[UIImage imageNamed:@"radio_off"]] && [self.CompetitionBtn.currentImage isEqual:[UIImage imageNamed:@"radio_off"]])
                {
                    self.occurrenceviewHeight.constant =120;
                    self.locationviewHeight.constant  =130;
                    self.occurranceselectview.hidden =YES;
                    self.locationselectview.hidden =YES;
                }


             }
            }
            [COMMON RemoveLoadingIcon];
            [self.view setUserInteractionEnabled:YES];
        } failure:^(AFHTTPRequestOperation *operation, id error) {
            [COMMON webServiceFailureError];
            [self.view setUserInteractionEnabled:YES];
        }];
        
    }

}
-(void)startFetchTeamPlayerGameService
{
    [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        [objWebservice getFetchGameandTeam:FetchGameTeam :cliendcode  success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
               
                self.gameArray =[responseObject valueForKey:@"fetchGame"];
                self.TeamArray =[responseObject valueForKey:@"fetchTeam"];
                self.playerArray =[responseObject valueForKey:@"fetchAthlete"];
                
                if(self.isUpdate == YES)
                {
                    self.saveBtn.hidden=YES;
                    self.updateBtn.hidden =NO;
                    self.deleteBtn.hidden =NO;
                    
                    //        self.gameLbl.text =[self.objSelectInjuryArray valueForKey:@"PLAYERCODE"];
                    //        self.TeamLbl.text =[self.objSelectInjuryArray valueForKey:@"teamName"];
                    //        self.playerLbl.text =[self.objSelectInjuryArray valueForKey:@"playerName"];
                    NSString *plycode = [self.objSelectInjuryArray valueForKey:@"PLAYERCODE"];
                    
                    NSMutableArray *selectedPlayer;
                    selectedPlayer = [[NSMutableArray alloc]init];
                    for(int i=0;i<self.playerArray.count;i++)
                    {
                        NSDictionary *players = [[NSDictionary alloc]init];
                        players = [self.playerArray objectAtIndex:i];
                        NSString *plyscode = [players valueForKey:@"athleteCode"];
                        
                        if([plycode isEqualToString:plyscode])
                        {
                            [selectedPlayer addObject:players];
                        }
                    }
                    
                    
                    NSMutableArray *tt=[[NSMutableArray alloc]init];
                    tt=[selectedPlayer objectAtIndex:0];
                    self.playerLbl.text =[tt valueForKey:@"athleteName"];
                    NSString *teamcode = [tt valueForKey:@"teamCode"];
                    
                    NSMutableArray *selectedTeam;
                    for(int i=0;i<self.TeamArray.count;i++)
                    {
                        NSDictionary *Team = [[NSDictionary alloc]init];
                        Team = [self.TeamArray objectAtIndex:i];
                        NSString *tcode = [Team valueForKey:@"teamCode"];
                        
                        if([teamcode isEqualToString:tcode])
                        {
                            selectedTeam = [[NSMutableArray alloc]init];
                            [selectedTeam addObject:Team];
                        }
                    }
                    
                    
                    
                    NSMutableArray *gg=[[NSMutableArray alloc]init];
                    gg=[selectedTeam objectAtIndex:0];
                    self.TeamLbl.text =[gg valueForKey:@"teamName"];
                    NSString *gamecode = [gg valueForKey:@"gameCode"];
                    
                    NSMutableArray *selectedGame;
                    for(int i=0;i<self.gameArray.count;i++)
                    {
                        NSDictionary *game = [[NSDictionary alloc]init];
                        game = [self.gameArray objectAtIndex:i];
                        
                        NSString *gcode = [game valueForKey:@"gameCode"];
                        
                        if([gamecode isEqualToString:gcode])
                        {
                            selectedGame = [[NSMutableArray alloc]init];
                            [selectedGame addObject:game];
                        }
                    }
                    
                    NSMutableArray *ggg=[[NSMutableArray alloc]init];
                    ggg=[selectedGame objectAtIndex:0];

                    self.gameLbl.text =[ggg valueForKey:@"gameName"];
                    
                    
                    
                    self.assessmentLbl.text =[self.objSelectInjuryArray valueForKey:@"DATEOFASSESSMENT"];
                    
                    self.onSetLbl.text =[self.objSelectInjuryArray valueForKey:@"ONSETDATE"];
                    //self.injurytypeLbl.text =[self.objSelectInjuryArray valueForKey:@"mainSymptomName"];
                    //self.injuryCauseLbl.text =[self.objSelectInjuryArray valueForKey:@"causeOfIllnessName"];
                    self.expectedLbl.text =[self.objSelectInjuryArray valueForKey:@"EXPECTEDDATEOFRECOVERY"];
                    self.injuryNameTxt.text =[self.objSelectInjuryArray valueForKey:@"INJURYNAME"];
                    self.cheifcomplientTxt.text =[self.objSelectInjuryArray valueForKey:@"CHIEFCOMPLIANT"];
                    selectGameCode =[self.objSelectInjuryArray valueForKey:@"GAMECODE"];
                    selectTeamCode =[self.objSelectInjuryArray valueForKey:@"TEAMCODE"];
                    selectPlayerCode =[self.objSelectInjuryArray valueForKey:@"PLAYERCODE"];
                    injuryTypeCode =[self.objSelectInjuryArray valueForKey:@"INJURYTYPECODE"] ;
                    injuryCausecode =[self.objSelectInjuryArray valueForKey:@"INJURYCAUSECODE"];
                    //selectCauseCode =[self.objSelectInjuryArray valueForKey:@"causeOfIllnessCode"];
                    selectExpertOpinionCode =[self.objSelectInjuryArray valueForKey:@"EXPERTOPTIONTAKENCODE"];
                    selectOnsetTypeCode =[self.objSelectInjuryArray valueForKey:@"ONSETTYPE"];
                    selectInjuryOccuranceCode =[self.objSelectInjuryArray valueForKey:@"INJURYOCCURANCECODE"];
                    selectInjuryLocationCode = [self.objSelectInjuryArray valueForKey:@"INJURYLOCATIONCODE"];
                    selectInjurySiteCode = [self.objSelectInjuryArray valueForKey:@"INJURYSITECODE"];
                    selectInjurySideCode = [self.objSelectInjuryArray valueForKey:@"INJURYSIDECODE"];
                    
                    selectInjuryCode  = [self.objSelectInjuryArray valueForKey:@"INJURYCODE"];
                    
                    VasValue = [self.objSelectInjuryArray valueForKey:@"VAS"];
                    
                    int a = [VasValue intValue];
                    
                   // self.VasSlider.value = a;
                     self.StSlider.index = a-1;
                    [self didChandeslidervalue:0];
                    
                    
                    
                }
                else
                {
                    self.saveBtn.hidden=NO;
                    self.updateBtn.hidden =YES;
                    self.deleteBtn.hidden =YES;
                }
                
               [self FetchMetadatawebservice];
                
            }
            [COMMON RemoveLoadingIcon];
            [self.view setUserInteractionEnabled:YES];
        } failure:^(AFHTTPRequestOperation *operation, id error) {
            [COMMON webServiceFailureError];
            [self.view setUserInteractionEnabled:YES];
        }];
        
    }

}
-(void)startDeleteInjuryService :(NSString *) Usercode :(NSString *)selectinjuryCode
{
    [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        [objWebservice getinjuryDelete:injuryDelete :selectinjuryCode :Usercode success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                
                [self altermsg:@"Injury Deleted Successfully"];
                
                [self.navigationController popViewControllerAnimated:YES];
            }
            [COMMON RemoveLoadingIcon];
            [self.view setUserInteractionEnabled:YES];
        } failure:^(AFHTTPRequestOperation *operation, id error) {
            [COMMON webServiceFailureError];
            [self.view setUserInteractionEnabled:YES];
        }];
        
    }

}



-(void)InsertWebservice
{
    [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(cliendcode)   [dic    setObject:cliendcode     forKey:@"CLIENTCODE"];
        
        if([RoleCode isEqualToString:@"ROL0000003"])
        {
            if(selectGameCode)   [dic    setObject:selectGameCode     forKey:@"GAMECODE"];
            if(selectTeamCode)   [dic    setObject:selectTeamCode     forKey:@"TEAMCODE"];
            if(selectPlayerCode)   [dic    setObject:selectPlayerCode     forKey:@"PLAYERCODE"];
            
        }
        else{
            [dic    setObject:@""     forKey:@"GAMECODE"];
            [dic    setObject:@""     forKey:@"TEAMCODE"];
            [dic    setObject:@""     forKey:@"PLAYERCODE"];
        }
        
        if(self.assessmentLbl.text)   [dic    setObject:self.assessmentLbl.text     forKey:@"DATEOFASSESSMENT"];
        if(self.onSetLbl.text)   [dic    setObject:self.onSetLbl.text     forKey:@"ONSETDATE"];
        if(selectOnsetTypeCode)   [dic    setObject:selectOnsetTypeCode     forKey:@"ONSETTYPE"];
        if(self.injuryNameTxt.text)   [dic    setObject:self.injuryNameTxt.text    forKey:@"INJURYNAME"];
        
        if(self.cheifcomplientTxt.text)   [dic    setObject:self.cheifcomplientTxt.text     forKey:@"CHIEFCOMPLIANT"];
        
        if(selectsliderValue)   [dic    setObject:selectsliderValue     forKey:@"VAS"];
        if(selectInjuryOccuranceCode)   [dic    setObject:selectInjuryOccuranceCode     forKey:@"INJURYOCCURANCECODE"];
        if(selectoccurancecode)   [dic    setObject:selectoccurancecode     forKey:@"INJURYOCCURANCESUBCODE"];
        if(selectInjuryLocationCode)   [dic    setObject:selectInjuryLocationCode     forKey:@"INJURYLOCATIONCODE"];
        if(selectlocationCode)   [dic    setObject:selectlocationCode     forKey:@"INJURYLOCATIONSUBCODE"];
        if(selectInjurySiteCode)   [dic    setObject:selectInjurySiteCode     forKey:@"INJURYSITECODE"];
        if(selectInjurySideCode)   [dic    setObject:selectInjurySideCode     forKey:@"INJURYSIDECODE"];
        if(injuryTypeCode)   [dic    setObject:injuryTypeCode     forKey:@"INJURYTYPECODE"];
        if(injuryCausecode)   [dic    setObject:injuryCausecode     forKey:@"INJURYCAUSECODE"];
        if(selectExpertOpinionCode)   [dic    setObject:selectExpertOpinionCode     forKey:@"EXPERTOPTIONTAKENCODE"];
        [dic    setObject:@""     forKey:@"XRAYSFILE"];
        [dic    setObject:@""     forKey:@"XRAYSFILENAME"];
        [dic    setObject:@""     forKey:@"CTSCANSFILE"];
        [dic    setObject:@""     forKey:@"CTSCANSFILENAME"];
        [dic    setObject:@""     forKey:@"MRISCANSFILE"];
        [dic    setObject:@""     forKey:@"MRISCANSFILENAME"];
        [dic    setObject:@""     forKey:@"BLOODTESTFILE"];
        [dic    setObject:@""     forKey:@"BLOODTESTFILENAME"];
        if(self.expectedLbl.text)   [dic    setObject:self.expectedLbl.text     forKey:@"EXPECTEDDATEOFRECOVERY"];
        if(usercode)   [dic    setObject:usercode     forKey:@"CREATEDBY"];
        
        
        NSLog(@"parameters : %@",dic);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        //NSDictionary *parameters = @{@"foo": @"bar"};
        NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
        NSString * url = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",injuryInsert]];
        [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileURL:filePath name:@"image" error:nil];
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Success: %@", responseObject);
            BOOL status=[responseObject valueForKey:@"Status"];
            if(status == YES)
            {
                UIAlertView * objaltert =[[UIAlertView alloc]initWithTitle:@"Add Injury" message:[NSString stringWithFormat:@"Injury Inserted Successfully"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                objaltert.tag = 201;
                [objaltert show];
                
                self.xrayLbl.text = @"";
                self.CTScanLbl.text = @"";
                self.BloodTestLbl.text = @"";
                self.MRILbl.text = @"";
                
                [self.navigationController popViewControllerAnimated:YES];
                
                
                
            }
            else{
                [self altermsg:@"Injury Insert failed"];
            }
            [COMMON RemoveLoadingIcon];
            [self.view setUserInteractionEnabled:YES];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
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
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(cliendcode)   [dic    setObject:cliendcode     forKey:@"CLIENTCODE"];
        if(selectInjuryCode)   [dic    setObject:selectInjuryCode     forKey:@"INJURYCODE"];

        if([RoleCode isEqualToString:@"ROL0000003"])
        {
            if(selectGameCode)   [dic    setObject:selectGameCode     forKey:@"GAMECODE"];
            if(selectTeamCode)   [dic    setObject:selectTeamCode     forKey:@"TEAMCODE"];
            if(selectPlayerCode)   [dic    setObject:selectPlayerCode     forKey:@"PLAYERCODE"];
            
        }
        else{
            [dic    setObject:@""     forKey:@"GAMECODE"];
            [dic    setObject:@""     forKey:@"TEAMCODE"];
            [dic    setObject:@""     forKey:@"PLAYERCODE"];
        }
        
        if(self.assessmentLbl.text)   [dic    setObject:self.assessmentLbl.text     forKey:@"DATEOFASSESSMENT"];
        if(self.onSetLbl.text)   [dic    setObject:self.onSetLbl.text     forKey:@"ONSETDATE"];
        if(selectOnsetTypeCode)   [dic    setObject:selectOnsetTypeCode     forKey:@"ONSETTYPE"];
        if(self.injuryNameTxt.text)   [dic    setObject:self.injuryNameTxt.text    forKey:@"INJURYNAME"];
        
        if(self.cheifcomplientTxt.text)   [dic    setObject:self.cheifcomplientTxt.text     forKey:@"CHIEFCOMPLIANT"];
        
        if(selectsliderValue)   [dic    setObject:selectsliderValue     forKey:@"VAS"];
        if(selectInjuryOccuranceCode)   [dic    setObject:selectInjuryOccuranceCode     forKey:@"INJURYOCCURANCECODE"];
        if(selectoccurancecode)   [dic    setObject:selectoccurancecode     forKey:@"INJURYOCCURANCESUBCODE"];
        if(selectInjuryLocationCode)   [dic    setObject:selectInjuryLocationCode     forKey:@"INJURYLOCATIONCODE"];
        if(selectlocationCode)   [dic    setObject:selectlocationCode     forKey:@"INJURYLOCATIONSUBCODE"];
        if(selectInjurySiteCode)   [dic    setObject:selectInjurySiteCode     forKey:@"INJURYSITECODE"];
        if(selectInjurySideCode)   [dic    setObject:selectInjurySideCode     forKey:@"INJURYSIDECODE"];
        if(injuryTypeCode)   [dic    setObject:injuryTypeCode     forKey:@"INJURYTYPECODE"];
        if(injuryCausecode)   [dic    setObject:injuryCausecode     forKey:@"INJURYCAUSECODE"];
        if(selectExpertOpinionCode)   [dic    setObject:selectExpertOpinionCode     forKey:@"EXPERTOPTIONTAKENCODE"];
        [dic    setObject:@""     forKey:@"XRAYSFILE"];
        [dic    setObject:@""     forKey:@"XRAYSFILENAME"];
        [dic    setObject:@""     forKey:@"CTSCANSFILE"];
        [dic    setObject:@""     forKey:@"CTSCANSFILENAME"];
        [dic    setObject:@""     forKey:@"MRISCANSFILE"];
        [dic    setObject:@""     forKey:@"MRISCANSFILENAME"];
        [dic    setObject:@""     forKey:@"BLOODTESTFILE"];
        [dic    setObject:@""     forKey:@"BLOODTESTFILENAME"];
        if(self.expectedLbl.text)   [dic    setObject:self.expectedLbl.text     forKey:@"EXPECTEDDATEOFRECOVERY"];
        if(usercode)   [dic    setObject:usercode     forKey:@"UPDATEDBY"];
        
        
        NSLog(@"parameters : %@",dic);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        //NSDictionary *parameters = @{@"foo": @"bar"};
        NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
        NSString * url = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",injuryUpdate]];
        [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileURL:filePath name:@"XRAYSFILE" error:nil];
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Success: %@", responseObject);
            BOOL status=[responseObject valueForKey:@"Status"];
            if(status == YES)
            {
                [self altermsg:[NSString stringWithFormat:@"Injury Update %@",[responseObject valueForKey:@"Message"]]];
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            else{
                [self altermsg:@"Injury Update failed"];
            }
            [COMMON RemoveLoadingIcon];
            [self.view setUserInteractionEnabled:YES];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [COMMON webServiceFailureError];
            [self.view setUserInteractionEnabled:YES];
        }];

}
    
}

#pragma ButtonAction

-(IBAction)didClickGameBtn:(id)sender
{
    if(isGame == NO)
    {
        self.popviewYposition.constant = self.gameView.frame.origin.y+40;
        self.popviewwidthSize.constant =self.gameLbl.frame.size.width;
        isGame =YES;
        isPlayer =NO;
        isTeam =NO;
        isinjuryType =NO;
        isinjuryCause =NO;
        isoccurance   =NO;
        islocation    =NO;
        self.popview_Tbl.hidden=NO;
        self.commonArray =[[NSMutableArray alloc]init];
        self.commonArray = self.gameArray;
        [self.popview_Tbl reloadData];
    }
    else{
        isGame =NO;
        self.popview_Tbl.hidden=YES;
    }
}

-(IBAction)didClickTeamBtn:(id)sender
{
    NSMutableArray * objTeamArray =[[NSMutableArray alloc]init];
    if(isTeam == NO)
    {
        self.popviewYposition.constant = self.teamView.frame.origin.y+40;
        self.popviewwidthSize.constant =self.TeamLbl.frame.size.width;
        isGame =NO;
        isPlayer =NO;
        isTeam =YES;
        isinjuryType =NO;
        isinjuryCause =NO;
        isoccurance   =NO;
        islocation    =NO;
        self.popview_Tbl.hidden=NO;
        for(int i=0; self.TeamArray.count>i;i++)
        {
            NSDictionary * teamDic = [self.TeamArray objectAtIndex:i];
            if([selectGameCode isEqualToString:[teamDic valueForKey:@"gameCode"]])
            {
                [objTeamArray addObject:teamDic];
            }
        }
        
        self.commonArray =[[NSMutableArray alloc]init];
        self.commonArray = objTeamArray;
        [self.popview_Tbl reloadData];
    }
    else{
        isTeam =NO;
        self.popview_Tbl.hidden=YES;
    }

}

-(IBAction)didClickPlayerBtn:(id)sender
{
    NSMutableArray * objPlayerArray =[[NSMutableArray alloc]init];

    if(isPlayer == NO)
    {
        self.popviewYposition.constant = self.playerView.frame.origin.y+40;
        self.popviewwidthSize.constant =self.playerLbl.frame.size.width;
        isGame =NO;
        isPlayer =YES;
        isTeam =NO;
        isinjuryType =NO;
        isinjuryCause =NO;
        isoccurance   =NO;
        islocation    =NO;
        self.popview_Tbl.hidden=NO;
        for(int i=0; self.playerArray.count>i;i++)
        {
            NSDictionary * playerDic = [self.playerArray objectAtIndex:i];
            if([selectGameCode isEqualToString:[playerDic valueForKey:@"gameCode"]] && [selectTeamCode isEqualToString:[playerDic valueForKey:@"teamCode"]])
            {
                [objPlayerArray addObject:playerDic];
            }
        }

        
        self.commonArray =[[NSMutableArray alloc]init];
        self.commonArray = objPlayerArray;
        [self.popview_Tbl reloadData];
    }
    else{
        isPlayer =NO;
        self.popview_Tbl.hidden=YES;
    }

}

-(IBAction)didClickassessment:(id)sender
{
    self.view_datepicker.hidden =NO;
    isAssessment =YES;
    isExpected =NO;
    isOnset =NO;
    [self DisplaydatePicker];
}
-(IBAction)didClickOnset:(id)sender
{
    self.view_datepicker.hidden =NO;

    isAssessment =NO;
    isExpected =NO;
    isOnset =YES;
    [self DisplaydatePicker];
}
-(IBAction)didClickOnsetTypeTraumaticAction:(id)sender
{
    if([self.traumaticBtn.currentImage isEqual:[UIImage imageNamed:@"radio_off"]])
    {
        [self.traumaticBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
        [self.delayedBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];

        selectOnsetTypeCode=@"MSC127";
    }
    else{
        [self.traumaticBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
        [self.delayedBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
        
        selectOnsetTypeCode=@"MSC128";
    }
}
-(IBAction)didClickOccurrenceAction:(id)sender
{
    self.SelectOccuranceArray=[[NSMutableArray alloc]init];
    if([self.TrainingBtn.currentImage isEqual:[UIImage imageNamed:@"radio_off"]])
    {
        [self.TrainingBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
        [self.CompetitionBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
        
        selectInjuryOccuranceCode=@"MSC131";
        
        //self.SelectOccuranceArray = self.TrainingArray;
        //self.commonArray = self.TrainingArray;
        isoccurance = YES;
        [self.popview_Tbl reloadData];
    }
    else{
        [self.TrainingBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
        [self.CompetitionBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
        
        selectInjuryOccuranceCode=@"MSC133";
        
        //self.SelectOccuranceArray = self.competitionArray;
        //self.commonArray = self.competitionArray;
        isoccurance = YES;
        [self.popview_Tbl reloadData];
    }
    self.occurrenceviewHeight.constant =130;
    self.occurranceselectview.hidden =NO;
}
-(IBAction)didClickInjuryLocation:(id)sender
{
    self.SelectLocationArray =[[NSMutableArray alloc]init];
    if([self.headerBtn.currentImage isEqual:[UIImage imageNamed:@"radio_off"]])
    {
        [self.headerBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
        [self.upperBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
        [self.lowerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];

        selectInjuryLocationCode=@"MSC141";
        //self.SelectLocationArray = self.headandtruckArray;
        
        self.locationviewHeight.constant  =150;
        self.locationselectview.hidden =NO;
        islocation=YES;
        [self.popview_Tbl reloadData];
    }
//    else if([self.upperBtn.currentImage isEqual:[UIImage imageNamed:@"radio_off"]])
//    {
//        [self.headerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
//        [self.upperBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
//        [self.lowerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
//        
//        selectInjuryLocationCode=@"MSC149";
//        //self.SelectLocationArray = self.upperextremityArray;
//        
//        islocation=YES;
//        self.locationviewHeight.constant  =150;
//        self.locationselectview.hidden =NO;
//        [self.popview_Tbl reloadData];
//        
//    }
//    else if([self.lowerBtn.currentImage isEqual:[UIImage imageNamed:@"radio_off"]])
//    {
//        [self.headerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
//        [self.upperBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
//        [self.lowerBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
//        
//        selectInjuryLocationCode=@"MSC157";
//       // self.SelectLocationArray = self.lowerextremityArray;
//        
//        islocation=YES;
//        self.locationviewHeight.constant  =150;
//        self.locationselectview.hidden =NO;
//        [self.popview_Tbl reloadData];
//        
//    }


}
-(IBAction)didClickuperbtnAction:(id)sender
{
    self.SelectLocationArray =[[NSMutableArray alloc]init];

    if([self.upperBtn.currentImage isEqual:[UIImage imageNamed:@"radio_off"]]){
        [self.upperBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
        [self.headerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
        [self.lowerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
        
        selectInjuryLocationCode=@"MSC149";
        
        //self.SelectLocationArray =self.upperextremityArray;
        self.locationviewHeight.constant  =150;
        self.locationselectview.hidden =NO;

    }
    }
-(IBAction)didClickLowerBtnAction:(id)sender
{
    self.SelectLocationArray =[[NSMutableArray alloc]init];

    if([self.lowerBtn.currentImage isEqual:[UIImage imageNamed:@"radio_off"]]){
        [self.lowerBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
        [self.headerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
        [self.upperBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
        
        selectInjuryLocationCode=@"MSC157";
        
        //self.SelectLocationArray =self.lowerextremityArray;
        
        self.locationviewHeight.constant  =150;
        self.locationselectview.hidden =NO;
    }
   
}
-(IBAction)didClickInjurySite:(id)sender
{
    if([self.anteriorBtn.currentImage isEqual:[UIImage imageNamed:@"radio_off"]])
    {
        [self.anteriorBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
        [self.posteriorBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
        [self.medicalBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
        [self.lateralBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];

        selectInjurySiteCode=@"MSC165";
    }
    
}
-(IBAction)didClickposteriorBtn:(id)sender
{
    if([self.posteriorBtn.currentImage isEqual:[UIImage imageNamed:@"radio_off"]]){
        [self.posteriorBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
        [self.anteriorBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
        [self.medicalBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
        [self.lateralBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
        selectInjurySiteCode=@"MSC167";
    }

}

-(IBAction)didClickmedicalBtn:(id)sender
{
    if([self.medicalBtn.currentImage isEqual:[UIImage imageNamed:@"radio_off"]]){
        [self.medicalBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
        [self.anteriorBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
        [self.posteriorBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
        [self.lateralBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
        selectInjurySiteCode=@"MSC166";
    }

}
-(IBAction)didclicklateral:(id)sender
{
    if([self.lateralBtn.currentImage isEqual:[UIImage imageNamed:@"radio_off"]]){
        [self.lateralBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
        [self.anteriorBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
        [self.posteriorBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
        [self.medicalBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
        selectInjurySiteCode=@"MSC168";
    }

}
-(IBAction)didClickinjurySideBtn:(id)sender
{
    
    if([self.rightBtn.currentImage isEqual:[UIImage imageNamed:@"radio_off"]])
    {
        [self.rightBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
        [self.leftBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
        
        selectInjurySideCode=@"MSC169";
    }
    else{
        [self.rightBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
        [self.leftBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
        
        selectInjurySideCode=@"MSC170";
    }
}

-(IBAction)didClickExpertOpinion:(id)sender
{
    if([self.expertYesBtn.currentImage isEqual:[UIImage imageNamed:@"radio_off"]])
    {
        [self.expertYesBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
        [self.expertNoBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
        
        selectExpertOpinionCode=@"MSC215";
    }
    else{
        [self.expertYesBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
        [self.expertNoBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
        
        selectExpertOpinionCode=@"MSC216";
    }

}
-(IBAction)didClickInjuryTypeBtn:(id)sender
{
    if(isinjuryType == NO)
    {
        self.popviewYposition.constant = self.injuryTypeView.frame.origin.y+210;
        self.popviewwidthSize.constant =self.injurytypeLbl.frame.size.width;
        isGame =NO;
        isPlayer =NO;
        isTeam =NO;
        isinjuryType =YES;
        isinjuryCause =NO;
        isoccurance   =NO;
        islocation    =NO;
        self.popview_Tbl.hidden=NO;
        self.commonArray =[[NSMutableArray alloc]init];
        self.commonArray = self.injuryTypeArray;
        [self.popview_Tbl reloadData];
    }
    else{
        isinjuryType =NO;
        self.popview_Tbl.hidden=YES;
    }

}

-(IBAction)didClickInjuryCauseBtn:(id)sender
{
    if(isinjuryCause == NO)
    {
        self.popviewYposition.constant =self.injuryCauseView.frame.origin.y+210;
        self.popviewwidthSize.constant =self.injuryCauseLbl.frame.size.width;
        isGame =NO;
        isPlayer =NO;
        isTeam =NO;
        isinjuryType =NO;
        isinjuryCause =YES;
        isoccurance   =NO;
        islocation    =NO;
        self.popview_Tbl.hidden=NO;
        self.commonArray =[[NSMutableArray alloc]init];
        self.commonArray = self.injuryCauseArray;
        [self.popview_Tbl reloadData];
    }
    else{
        isinjuryCause =NO;
        self.popview_Tbl.hidden=NO;
    }

}
-(IBAction)didChandeslidervalue:(UISlider *)sender
{
    //NSLog(@"slider value = %f", sender.value);
    //selectsliderValue =[NSString stringWithFormat:@"%f",sender.value];
    selectsliderValue = [NSString stringWithFormat:@"%lu",(unsigned long)self.StSlider.index];
}
-(IBAction)didClickxrayBtn:(id)sender
{
    isXray =YES;
    isCT =NO;
    isMRI =NO;
    isBlood =NO;   [self opengallery];
}

-(IBAction)didClickctScan:(id)sender
{
    isXray =NO;
    isCT =YES;
    isMRI =NO;
    isBlood =NO;
    [self opengallery];

}
-(IBAction)didClickMRIScan:(id)sender
{
    isXray =NO;
    isCT =NO;
    isMRI =YES;
    isBlood =NO;
    [self opengallery];
}

-(IBAction)didClickBloodTest:(id)sender
{
    isXray =NO;
    isCT =NO;
    isMRI =NO;
    isBlood =YES;
    [self opengallery];
}

-(IBAction)didClickExpected:(id)sender
{
    //self.view_datepicker.hidden =NO;

    isAssessment =NO;
    isExpected =YES;
    isOnset =NO;
    //[self DisplaydatePicker];
    
    if(datePicker!= nil)
    {
        [datePicker removeFromSuperview];
        
    }
    self.view_datepicker.hidden=NO;
    //isStartDate =YES;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    //   2016-06-25 12:00:00
    [dateFormat setDateFormat:@"MM-dd-yyyy"];
    
    datePicker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,50,self.view_datepicker.frame.size.width,100)];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [datePicker setLocale:locale];
    
    // [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    [datePicker reloadInputViews];
    [self.view_datepicker addSubview:datePicker];

}
-(void)opengallery
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString * objPath =[[picker valueForKey:@"mediaTypes"] objectAtIndex:0];
    NSString *savedImagePath =   [documentsDirectory stringByAppendingPathComponent:objPath];
    if(isXray ==YES)
    {
        self.xrayLbl.text =savedImagePath;
    }
    else if (isCT ==YES)
    {
        self.CTScanLbl.text =savedImagePath;
        
    }
    else if (isMRI ==YES)
    {
        self.MRILbl.text =savedImagePath;
        
    }
    else if (isBlood ==YES)
    {
        self.BloodTestLbl.text =savedImagePath;
        
    }
    imageToPost = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

-(IBAction)didClickSave:(id)sender
{
    [self validation];
}

-(IBAction)didClickupdate:(id)sender
{
    [self validation];
}
-(IBAction)didClickDelete:(id)sender
{
    
    //UIAlertView * objaltert =[[UIAlertView alloc]initWithTitle:@"Add Illness" message:@"Do you want to delete" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    UIAlertView *objAlter =[[UIAlertView alloc]initWithTitle:@"Add Illness" message:@"Do you want to delete" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    objAlter.tag = 200;
    [objAlter show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [alertView cancelButtonIndex])
    {
        alertView.hidden=YES;
    }
    else
    {
        if (alertView.tag == 200)
        {
            [self startDeleteInjuryService:usercode :selectInjuryCode];
        }
        else if (alertView.tag == 201)
        {
            self.gameLbl.text =@"";
            self.TeamLbl.text =@"";
            self.playerLbl.text =@"";
            self.assessmentLbl.text =@"";
            
            self.onSetLbl.text =@"";
            self.injurytypeLbl.text =@"";
            self.injuryCauseLbl.text =@"";
            self.expectedLbl.text =@"";
            self.injuryNameTxt.text =@"";
            self.cheifcomplientTxt.text =@"";
            selectGameCode =@"";
            selectTeamCode =@"";
            selectPlayerCode =@"";
            injuryTypeCode =@"" ;
            injuryCausecode =@"";
            //selectCauseCode =[self.objSelectInjuryArray valueForKey:@"causeOfIllnessCode"];
            selectExpertOpinionCode =@"";
            selectOnsetTypeCode =@"";
            selectInjuryOccuranceCode =@"";
            selectInjuryLocationCode = @"";
            selectInjurySiteCode = @"";
            selectInjurySideCode = @"";
            self.occurancelbl.text=@"";
            self.locationlbl.text =@"";
            
            selectInjuryCode  = @"";
            [self.traumaticBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
            [self.delayedBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
            
            
            [self.TrainingBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
            [self.CompetitionBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
            
            
            
            [self.headerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
            [self.upperBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
            [self.lowerBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
            
            
            
            
            [self.anteriorBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
            [self.posteriorBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
            [self.medicalBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
            [self.lateralBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
            
            
            
            [self.rightBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
            [self.leftBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
            
            
        }
        else
        {
            //Do something else
        }

        
        
        
    }

}


-(void)DisplaydatePicker
{
    if(datePicker!= nil)
    {
        [datePicker removeFromSuperview];
        
    }
    self.view_datepicker.hidden=NO;
    //isStartDate =YES;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    //   2016-06-25 12:00:00
    [dateFormat setDateFormat:@"MM-dd-yyyy"];
    
    datePicker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,50,self.view_datepicker.frame.size.width,100)];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [datePicker setLocale:locale];
    
    // [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    [datePicker reloadInputViews];
    [self.view_datepicker addSubview:datePicker];
    
}

-(IBAction)showSelecteddate:(id)sender{
    
    
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        NSDate *matchdate = [NSDate date];
        [dateFormat setDateFormat:@"MM-dd-yyyy"];
        // for minimum date
       // [datePicker setMinimumDate:matchdate];
        
        // for maximumDate
        //int daysToAdd = 1;
        //NSDate *newDate1 = [matchdate dateByAddingTimeInterval:60*60*24*daysToAdd];
        
        //[datePicker setMaximumDate:newDate1];
        
        if(isAssessment ==YES)
        {
           self.assessmentLbl.text=[dateFormat stringFromDate:datePicker.date];
        }
    else if (isOnset == YES)
    {
        self.onSetLbl.text=[dateFormat stringFromDate:datePicker.date];

    }
    else if (isExpected == YES)
    {
        self.expectedLbl.text=[dateFormat stringFromDate:datePicker.date];
        
    }
    [self.view_datepicker setHidden:YES];
    
}
-(IBAction)didclickoccuranceSelectBtn:(id)sender
{
    if(isoccurance == NO)
    {
        self.popviewYposition.constant = self.occurranceView.frame.origin.y+230;
        self.popviewwidthSize.constant =self.occurranceselectview.frame.size.width;
        isGame =NO;
        isPlayer =NO;
        isTeam =NO;
        isinjuryType =NO;
        isinjuryCause =NO;
        isoccurance   =YES;
        islocation    =NO;
        self.popview_Tbl.hidden=NO;
        self.commonArray =[[NSMutableArray alloc]init];
        
        if(self.isUpdate == YES)
        {
            if([selectInjuryOccuranceCode isEqual: @"MSC131"])
            {
                self.commonArray = self.TrainingArray;
            }
            else
            {
                self.commonArray = self.competitionArray;
            }

        }
        else
        {
            if([selectInjuryOccuranceCode isEqual: @"MSC131"])
            {
                self.commonArray = self.TrainingArray;
            }
            else
            {
                self.commonArray = self.competitionArray;
            }

        }
        
                //self.commonArray = self.SelectOccuranceArray;
        
        [self.popview_Tbl reloadData];
    }
    else{
        isoccurance =NO;
        self.popview_Tbl.hidden=YES;
    }

}

-(IBAction)didClicklocationselectBtn:(id)sender
{
    if(islocation == NO)
    {
        self.popviewYposition.constant = self.locationView.frame.origin.y+230;
        self.popviewwidthSize.constant =self.locationselectview.frame.size.width;
        isGame =NO;
        isPlayer =NO;
        isTeam =NO;
        isinjuryType =NO;
        isinjuryCause =NO;
        isoccurance   =NO;
        islocation    =YES;
        self.popview_Tbl.hidden=NO;
        self.commonArray =[[NSMutableArray alloc]init];
        //self.commonArray = self.SelectLocationArray;
        if(self.isUpdate == YES)
        {
            if([selectInjuryLocationCode isEqual: @"MSC141"])
            {
                self.commonArray = self.headandtruckArray;
            }
            else if([selectInjuryLocationCode isEqual: @"MSC149"])
            {
                self.commonArray = self.upperextremityArray;
            }
            else if([selectInjuryLocationCode isEqual: @"MSC157"])
            {
                self.commonArray = self.lowerextremityArray;
            }
            
        }
        else
        {
            if([selectInjuryLocationCode isEqual: @"MSC141"])
            {
                self.commonArray = self.headandtruckArray;
            }
            else if([selectInjuryLocationCode isEqual: @"MSC149"])
            {
                self.commonArray = self.upperextremityArray;
            }
            else if([selectInjuryLocationCode isEqual: @"MSC157"])
            {
                self.commonArray = self.lowerextremityArray;
            }
            
        }

        
        
        [self.popview_Tbl reloadData];
    }
    else{
        islocation =NO;
        self.popview_Tbl.hidden=YES;
    }

}

-(void)validation
{
    if([self.gameLbl.text isEqualToString:@"Select"] || [self.gameLbl.text isEqualToString:@""])
    {
        [self altermsg:@"Please select Game"];
        
    }
    else if ([self.TeamLbl.text isEqualToString:@"Select"] || [self.TeamLbl.text isEqualToString:@""])
    {
        [self altermsg:@"Please select Team"];
    }
    else if ([self.playerLbl.text isEqualToString:@"Select"] || [self.playerLbl.text isEqualToString:@""])
    {
        [self altermsg:@"Please select Player"];
        
    }
    else if ([self.assessmentLbl.text isEqualToString:@"Select"] || [self.assessmentLbl.text isEqualToString:@""])
    {
        [self altermsg:@"Please select Date of Assessment"];
        
    }
    else if ([self.onSetLbl.text isEqualToString:@"Select"] || [self.onSetLbl.text isEqualToString:@""])
    {
        [self altermsg:@"Please select Date of Onset"];
        
    }
    else if ([self.onSetLbl.text isEqualToString:@"Select"] || [self.onSetLbl.text isEqualToString:@""])
    {
        [self altermsg:@"Please select Date of Onset"];
        
    }
    else if (selectsliderValue == nil  || [selectsliderValue isEqualToString:@""])
    {
        [self altermsg:@"Please select VAS"];
        
    }
    else if (selectOnsetTypeCode == nil || [selectOnsetTypeCode isEqualToString:@""])
    {
        [self altermsg:@"Please select Onset Type"];
        
    }
    else if ([self.injuryNameTxt.text isEqualToString:@""])
    {
        [self altermsg:@"Please Enter InjuryName"];
        
    }
    else if ([self.cheifcomplientTxt.text isEqualToString:@""])
    {
        [self altermsg:@"Please Enter Chief Compliant"];
        
    }
    
    else if (selectInjuryOccuranceCode == nil  || [selectInjuryOccuranceCode isEqualToString:@""] || [self.occurancelbl.text isEqualToString:@""] )
    {
        [self altermsg:@"Please select Injury Occurrence"];
        
    }
    else if (selectInjuryLocationCode== nil  || [selectInjuryLocationCode isEqualToString:@""] || [self.locationlbl.text isEqualToString:@""])
    {
        [self altermsg:@"Please select Injury Location"];
        
    }
    else if (selectInjurySiteCode == nil || [selectInjurySiteCode isEqualToString:@""])
    {
        [self altermsg:@"Please select Injury Site"];
        
    }
    else if (selectInjurySideCode == nil || [selectInjurySideCode isEqualToString:@""])
    {
        [self altermsg:@"Please select Injury Side"];
        
    }
    else if ([self.injurytypeLbl.text isEqualToString:@""])
    {
        [self altermsg:@"Please select Injury Type"];
        
    }
    else if ([self.injuryCauseLbl.text isEqualToString:@""])
    {
        [self altermsg:@"Please select Injury Cause"];
        
    }
    
    else if (selectExpertOpinionCode == nil || [selectExpertOpinionCode isEqualToString:@""])
    {
        [self altermsg:@"Please select Expert Opinion Taken"];
        
    }
    else if ([self.expectedLbl.text isEqualToString:@""] || [self.expectedLbl.text isEqualToString:@"Select"])
    {
        [self altermsg:@"Please Select Expected Date of Recovery"];
        
    }
    else
    {
        if(self.isUpdate ==YES)
        {
            [self UpdateWebservice];
        }
        else{
            [self InsertWebservice];
        }
        
    }

}
-(void)altermsg:(NSString *) message
{
    UIAlertView * objaltert =[[UIAlertView alloc]initWithTitle:@"Add Injury" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [objaltert show];
}
#pragma Tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.commonArray count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *str;   //= [[latestNewsArray objectAtIndex:indexPath.row] valueForKey:@"NewsTittle"];
    
    if(isGame ==YES)
    {
        str =[[self.commonArray valueForKey:@"gameName"] objectAtIndex:indexPath.row];
    }
    else if (isTeam ==YES)
    {
        str =[[self.commonArray valueForKey:@"teamName"] objectAtIndex:indexPath.row];
        
    }
    else if (isPlayer ==YES)
    {
       str =[[self.commonArray valueForKey:@"athleteName"] objectAtIndex:indexPath.row];
        
    }
    else if (isinjuryType ==YES)
    {
        str =[[self.commonArray valueForKey:@"InjuryMetaDataTypeCode"] objectAtIndex:indexPath.row];
        
    }
    else if (isinjuryCause ==YES)
    {
        str =[[self.commonArray valueForKey:@"InjuryMetaDataTypeCode"] objectAtIndex:indexPath.row];
        
    }
    else if (isoccurance ==YES)
    {
        str =[[self.commonArray valueForKey:@"InjuryMetaDataTypeCode"] objectAtIndex:indexPath.row];
        
    }
    else if (islocation ==YES)
    {
        str =[[self.commonArray valueForKey:@"InjuryMetaDataTypeCode"] objectAtIndex:indexPath.row];
        
    }

    
    dataSize = [COMMON getControlHeight:str withFontName:@"Helvetica" ofSize:10.0 withSize:CGSizeMake(150,tableView.frame.size.height+60)];
    
    NSLog(@"%f",dataSize.height);
    return dataSize.height+20;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AddInjury";
    
    UITableViewCell * Cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (Cell == nil)
    {
        Cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
        //objCell = self.injuryCell;
    }
    if(isGame ==YES)
    {
        Cell.textLabel.text =[[self.commonArray valueForKey:@"gameName"] objectAtIndex:indexPath.row];
    }
    else if (isTeam ==YES)
    {
        Cell.textLabel.text =[[self.commonArray valueForKey:@"teamName"] objectAtIndex:indexPath.row];

    }
    else if (isPlayer ==YES)
    {
        Cell.textLabel.text =[[self.commonArray valueForKey:@"athleteName"] objectAtIndex:indexPath.row];
        
    }
    else if (isinjuryType ==YES)
    {
        Cell.textLabel.text =[[self.commonArray valueForKey:@"InjuryMetaDataTypeCode"] objectAtIndex:indexPath.row];
        
    }
    else if (isinjuryCause ==YES)
    {
        Cell.textLabel.text =[[self.commonArray valueForKey:@"InjuryMetaDataTypeCode"] objectAtIndex:indexPath.row];
        
    }
    else if (isoccurance ==YES)
    {
        Cell.textLabel.text =[[self.commonArray valueForKey:@"InjuryMetaDataTypeCode"] objectAtIndex:indexPath.row];
        
    }
    else if (islocation ==YES)
    {
        Cell.textLabel.text =[[self.commonArray valueForKey:@"InjuryMetaDataTypeCode"] objectAtIndex:indexPath.row];
        
    }
    
    dataSize =[COMMON getControlHeight:Cell.textLabel.text withFontName:@"Helvetica" ofSize:10.0 withSize:CGSizeMake(150,tableView.frame.size.height+60)];
    Cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if(self.popview_Tbl.contentSize.height < 150)
    {
    self.popViewheight.constant = self.popview_Tbl.contentSize.height+20;
    }
    else
    {
        self.popViewheight.constant = 200;

    }

    return Cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(isGame ==YES)
    {
        self.gameLbl.text =[[self.commonArray valueForKey:@"gameName"] objectAtIndex:indexPath.row];
        selectGameCode =[[self.commonArray valueForKey:@"gameCode"] objectAtIndex:indexPath.row];
    }
    else if (isTeam ==YES)
    {
        self.TeamLbl.text =[[self.commonArray valueForKey:@"teamName"] objectAtIndex:indexPath.row];
        selectTeamCode =[[self.commonArray valueForKey:@"teamCode"] objectAtIndex:indexPath.row];

    }
    else if (isPlayer ==YES)
    {
        self.playerLbl.text =[[self.commonArray valueForKey:@"athleteName"] objectAtIndex:indexPath.row];
        selectPlayerCode = [[self.commonArray valueForKey:@"athleteCode"] objectAtIndex:indexPath.row];
    }
    else if (isinjuryType ==YES)
    {
        self.injurytypeLbl.text =[[self.commonArray valueForKey:@"InjuryMetaDataTypeCode"] objectAtIndex:indexPath.row];
        injuryTypeCode =[[self.commonArray valueForKey:@"InjuryMetaSubCode"] objectAtIndex:indexPath.row];
    }
    else if (isinjuryCause ==YES)
    {
        self.injuryCauseLbl.text =[[self.commonArray valueForKey:@"InjuryMetaDataTypeCode"] objectAtIndex:indexPath.row];
        injuryCausecode=[[self.commonArray valueForKey:@"InjuryMetaSubCode"] objectAtIndex:indexPath.row];
    }
    else if (isoccurance ==YES)
    {
        self.occurancelbl.text =[[self.commonArray valueForKey:@"InjuryMetaDataTypeCode"] objectAtIndex:indexPath.row];
        selectoccurancecode=[[self.commonArray valueForKey:@"InjuryMetaSubCode"] objectAtIndex:indexPath.row];
    }
    else if (islocation ==YES)
    {
        self.locationlbl.text =[[self.commonArray valueForKey:@"InjuryMetaDataTypeCode"] objectAtIndex:indexPath.row];
        selectlocationCode=[[self.commonArray valueForKey:@"InjuryMetaSubCode"] objectAtIndex:indexPath.row];
    }


    self.popview_Tbl.hidden=YES;
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(IBAction)BackBtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
