//
//  AddIllnessVC.m
//  AlphaProTracker
//
//  Created by Mac on 26/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "AddIllnessVC.h"
#import "WebService.h"
#import "CustomNavigation.h"
#import "AppCommon.h"
#import "Config.h"

@interface AddIllnessVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    WebService * objWebservice;
    NSString *     cliendcode ;
    NSString * RoleCode;
    NSString * usercode;
    NSString * selectIllnessCode;
    
    BOOL isGame;
    BOOL isTeam;
    BOOL isPlayer;
    BOOL isOnset;
    BOOL isExpected;
    BOOL isAffect;
    BOOL isCause;
    BOOL isMainSymptom;
    BOOL isXray;
    BOOL isCT;
    BOOL isMRI;
    BOOL isBlood;
    
    UIDatePicker * datePicker;
    NSString * selectGameCode;
    NSString * selectTeamCode;
    NSString * selectPlayerCode;
    
    NSString * selectOnsetTypeCode;
    
    NSString * selectaffectersystemCode;
    NSString * selectMainSyntromCode;
    NSString * selectCauseCode;
    NSString * selectExpertOpinionCode;
    UIImage *imageToPost;
}


@property (nonatomic,strong) NSMutableArray * gameArray;
@property (nonatomic,strong) NSMutableArray * TeamArray;
@property (nonatomic,strong) NSMutableArray * playerArray;
@property (nonatomic,strong) NSMutableArray * commonArray;

@property (nonatomic,strong) NSMutableArray *AffectArray;
@property (nonatomic,strong) NSMutableArray* mainsyptomArray;
@property (nonatomic,strong) NSMutableArray *causeillnessArray;



@property (nonatomic,strong) IBOutlet UIView * coachView;
@property (nonatomic,strong) IBOutlet UIView * playerview;
@property (nonatomic,strong) IBOutlet UIView * gameView;
@property (nonatomic,strong) IBOutlet UIView * teamView;
@property (nonatomic,strong) IBOutlet UIView * playerView;
@property (nonatomic,strong) IBOutlet UIView * onSetView;
@property (nonatomic,strong) IBOutlet UIView * affectView;
@property (nonatomic,strong) IBOutlet UIView * mainsyntomView;
@property (nonatomic,strong) IBOutlet UIView * CauseView;
@property (nonatomic,strong) IBOutlet UIView * XRayView;
@property (nonatomic,strong) IBOutlet UIView * CTScansView;
@property (nonatomic,strong) IBOutlet UIView * MRIScansView;
@property (nonatomic,strong) IBOutlet UIView * BloodTestView;
@property (nonatomic,strong) IBOutlet UIView * ExpectedView;


@property (nonatomic,strong) IBOutlet UIView * gameSubView;
@property (nonatomic,strong) IBOutlet UIView * teamSubView;
@property (nonatomic,strong) IBOutlet UIView * playerSubView;
@property (nonatomic,strong) IBOutlet UIView * onSetSubView;
@property (nonatomic,strong) IBOutlet UIView * affectSubView;
@property (nonatomic,strong) IBOutlet UIView * mainsyntomSubView;
@property (nonatomic,strong) IBOutlet UIView * CauseSubView;
@property (nonatomic,strong) IBOutlet UIView * XRaySubView;
@property (nonatomic,strong) IBOutlet UIView * CTScansSubView;
@property (nonatomic,strong) IBOutlet UIView * MRIScansSubView;
@property (nonatomic,strong) IBOutlet UIView * BloodTestSubView;
@property (nonatomic,strong) IBOutlet UIView * ExpectedSubView;
@property (nonatomic,strong) IBOutlet UIView * illnessnameSubView;
@property (nonatomic,strong) IBOutlet UIView * chiefSubView;




@property (nonatomic,strong) IBOutlet UILabel * gameLbl;
@property (nonatomic,strong) IBOutlet UILabel * TeamLbl;
@property (nonatomic,strong) IBOutlet UILabel * playerLbl;
@property (nonatomic,strong) IBOutlet UILabel * affectLbl;
@property (nonatomic,strong) IBOutlet UILabel * CauseLbl;
@property (nonatomic,strong) IBOutlet UILabel * mainSyntomLbl;

@property (strong, nonatomic) IBOutlet UITextField *onSetLbl;

//@property (nonatomic,strong) IBOutlet UILabel * onSetLbl;
@property (nonatomic,strong) IBOutlet UITextField * illnessNameTxt;
@property (nonatomic,strong) IBOutlet UITextField * cheifcomplientTxt;
@property (nonatomic,strong) IBOutlet UILabel * xrayLbl;
@property (nonatomic,strong) IBOutlet UILabel * CTScanLbl;
@property (nonatomic,strong) IBOutlet UILabel * MRILbl;
@property (nonatomic,strong) IBOutlet UILabel * BloodTestLbl;
@property (strong, nonatomic) IBOutlet UITextField *expectedLbl;

//@property (nonatomic,strong) IBOutlet UILabel * expectedLbl;
@property (nonatomic,strong) IBOutlet UIButton * updateBtn;
@property (nonatomic,strong) IBOutlet UIButton * deleteBtn;
@property (nonatomic,strong) IBOutlet UIButton * saveBtn;

@property (nonatomic,strong) IBOutlet UITableView * popview_Tbl;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * popviewYposition;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * popviewwidthSize;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * coachViewYposition;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * datepickerViewWidth;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * datepickerViewheight;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * allViewheight;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * popviewheight;


@property (nonatomic,strong) IBOutlet UIButton * expertYesBtn;

@property (nonatomic,strong) IBOutlet UIButton * expertNoBtn;

@property (strong, nonatomic) IBOutlet UIView *documentsView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *documentViewHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *playerViewHeightConstraint;


@end

@implementation AddIllnessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    objWebservice =[[WebService alloc]init];
    cliendcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    RoleCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"RoleCode"];
    usercode = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
    
    [self customnavigationmethod];
    
//    if(!IS_IPHONE_DEVICE)
//    {
//        self.datepickerViewWidth.constant =self.view.frame.size.width/1.5;
//        self.datepickerViewheight.constant =self.view.frame.size.height/3;
    //}
    
    //Veeresh
    datePicker = [[UIDatePicker alloc] init];
    
    self.onSetLbl.tintColor = [UIColor clearColor];
    self.expectedLbl.tintColor = [UIColor clearColor];
    
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
    self.onSetLbl.inputAccessoryView = toolbar;
    self.expectedLbl.inputAccessoryView = toolbar;
    
    [self allviewSetbordermethod];
    [self startFetchTeamPlayerGameService];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.popview_Tbl.hidden =YES;
}
-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    
    
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"Add Illness";
    objCustomNavigation.btn_back.hidden =NO;
    objCustomNavigation.menu_btn.hidden = YES;
    [objCustomNavigation.btn_back addTarget:self action:@selector(BackBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    //[objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void) doneButtonAction {
    [self.view endEditing:true];
}

-(void) cancelButtonAction {
    if(isExpected==YES) {
        [self.expectedLbl resignFirstResponder];
    } else if(isOnset==YES) {
        [self.onSetLbl resignFirstResponder];
    }
    [self.view endEditing:true];
}

-(void)allviewSetbordermethod
{
    self.gameSubView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.gameSubView.layer.borderWidth =0.5;
    self.gameSubView.layer.masksToBounds=YES;
    
    self.teamSubView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.teamSubView.layer.borderWidth =0.5;
    self.teamSubView.layer.masksToBounds=YES;
    
    self.ExpectedSubView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.ExpectedSubView.layer.borderWidth =0.5;
    self.ExpectedSubView.layer.masksToBounds=YES;
    
    self.playerSubView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.playerSubView.layer.borderWidth =0.5;
    self.playerSubView.layer.masksToBounds=YES;
    
    self.onSetSubView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.onSetSubView.layer.borderWidth =0.5;
    self.onSetSubView.layer.masksToBounds=YES;
    
    self.affectSubView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.affectSubView.layer.borderWidth =0.5;
    self.affectSubView.layer.masksToBounds=YES;
    
    self.mainsyntomSubView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.mainsyntomSubView.layer.borderWidth =0.5;
    self.mainsyntomSubView.layer.masksToBounds=YES;
    
    self.CauseSubView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.CauseSubView.layer.borderWidth =0.5;
    self.CauseSubView.layer.masksToBounds=YES;
    
    self.XRaySubView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.XRaySubView.layer.borderWidth =0.5;
    self.XRaySubView.layer.masksToBounds=YES;
    
    self.CTScansSubView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.CTScansSubView.layer.borderWidth =0.5;
    self.CTScansSubView.layer.masksToBounds=YES;
    
    self.MRIScansSubView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.MRIScansSubView.layer.borderWidth =0.5;
    self.MRIScansSubView.layer.masksToBounds=YES;
    
    self.BloodTestSubView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.BloodTestSubView.layer.borderWidth =0.5;
    self.BloodTestSubView.layer.masksToBounds=YES;
    
    self.illnessnameSubView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.illnessnameSubView.layer.borderWidth =0.5;
    self.illnessnameSubView.layer.masksToBounds=YES;
    
    self.chiefSubView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.chiefSubView.layer.borderWidth =0.5;
    self.chiefSubView.layer.masksToBounds=YES;
    
    if(!IS_IPHONE_DEVICE)
    {
        self.allViewheight.constant =100;
    }
}
-(void)startFetchTeamPlayerGameService
{
    [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        [objWebservice getFetchGameandTeam :FetchGameTeam :cliendcode  success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                self.gameArray =[[NSMutableArray alloc]init];
                self.TeamArray =[[NSMutableArray alloc]init];
                self.playerArray =[[NSMutableArray alloc]init];
                self.gameArray =[responseObject valueForKey:@"fetchGame"];
                self.TeamArray =[responseObject valueForKey:@"fetchTeam"];
                self.playerArray =[responseObject valueForKey:@"fetchAthlete"];
                
                if(self.isUpdate == YES)
                {
                    self.saveBtn.hidden=YES;
                    self.updateBtn.hidden =NO;
                    self.deleteBtn.hidden =NO;
                    self.gameLbl.text =[self.objSelectobjIllnessArray valueForKey:@"gameName"];
                    self.TeamLbl.text =[self.objSelectobjIllnessArray valueForKey:@"teamName"];
                    
                    NSString *plycode = [self.objSelectobjIllnessArray valueForKey:@"playerCode"];
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
                    
                    //self.playerLbl.text =[self.objSelectobjIllnessArray valueForKey:@"playerName"];
                    
                    NSString *DateTime = [self.objSelectobjIllnessArray valueForKey:@"dateOnSet"];
                    
                    NSArray *components = [DateTime componentsSeparatedByString:@" "];
                    
                    NSString *Date = components[0];
                    self.onSetLbl.text =Date;
                    
                    self.affectLbl.text =[self.objSelectobjIllnessArray valueForKey:@"affectedSystemName"];
                    self.mainSyntomLbl.text =[self.objSelectobjIllnessArray valueForKey:@"mainSymptomName"];
                    //self.CauseLbl.text =[self.objSelectobjIllnessArray valueForKey:@"causeOfIllnessName"];
                    
                    
                    
                    NSString *Dt = [self.objSelectobjIllnessArray valueForKey:@"expertedDateofRecovery"];
                    
                    NSArray *components1 = [Dt componentsSeparatedByString:@" "];
                    
                    NSString *Dat = components1[0];
                    self.expectedLbl.text =Dat;
                    self.illnessNameTxt.text =[self.objSelectobjIllnessArray valueForKey:@"illnessName"];
                    self.cheifcomplientTxt.text =[self.objSelectobjIllnessArray valueForKey:@"chiefCompliant"];
                    selectGameCode =[self.objSelectobjIllnessArray valueForKey:@"gameCode"];
                    selectTeamCode =[self.objSelectobjIllnessArray valueForKey:@"teamCode"];
                    selectPlayerCode =[self.objSelectobjIllnessArray valueForKey:@"playerCode"];
                    selectaffectersystemCode =[self.objSelectobjIllnessArray valueForKey:@"affectedSystemCode"] ;
                    selectMainSyntromCode =[self.objSelectobjIllnessArray valueForKey:@"mainSymptomCode"];
                    selectCauseCode =[self.objSelectobjIllnessArray valueForKey:@"causeOfIllnessCode"];
                    selectExpertOpinionCode =[self.objSelectobjIllnessArray valueForKey:@"expertOpinionTaken"];
                    selectIllnessCode =[self.objSelectobjIllnessArray valueForKey:@"illnessCode"];
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
                    
                    
                }
                else
                {
                    self.saveBtn.hidden=NO;
                    self.updateBtn.hidden =YES;
                    self.deleteBtn.hidden =YES;
                }
                
                if([RoleCode isEqualToString:@"ROL0000002"])
                {
                    
                    self.playerview.hidden=YES;
                    self.playerViewHeightConstraint.constant = 0;
//                    self.coachViewYposition.constant =self.playerView.frame.size.height+5;
                    self.documentsView.hidden = YES;
                    self.documentViewHeightConstraint.constant = 0;
                    self.updateBtn.hidden = YES;
                    self.deleteBtn.hidden = YES;
                }
                else{
                    self.playerview.hidden=NO;
//                    self.coachViewYposition.constant =10;
                    self.documentsView.hidden = NO;
                }

                [self Fetchillnessloadingwebservice];
            }
            [COMMON RemoveLoadingIcon];
            [self.view setUserInteractionEnabled:YES];
        } failure:^(AFHTTPRequestOperation *operation, id error) {
            [COMMON webServiceFailureError];
            [self.view setUserInteractionEnabled:YES];
        }];
        
    }
    
}
-(void)Fetchillnessloadingwebservice
{
    //[COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        [objWebservice getFetchMetadataList :illnessFetchload success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                
                self.AffectArray =[[NSMutableArray alloc]init];
                self.mainsyptomArray =[[NSMutableArray alloc]init];
                self.causeillnessArray =[[NSMutableArray alloc]init];
                
                
                
                self.AffectArray =[responseObject valueForKey:@"AffectedSystem"];
                
                self.mainsyptomArray =[responseObject valueForKey:@"MainSymptoms"];
                
                self.causeillnessArray =[responseObject valueForKey:@"CauseOfIllness"];
                
                
                if(self.isUpdate == YES)
                {

                
                NSString *CauseOfillnessCode = [self.objSelectobjIllnessArray valueForKey:@"causeOfIllnessCode"];
                
                NSMutableArray *selectedCause;
                selectedCause = [[NSMutableArray alloc]init];
                for(int i=0;i<self.causeillnessArray.count;i++)
                {
                    NSDictionary *players = [[NSDictionary alloc]init];
                    players = [self.causeillnessArray objectAtIndex:i];
                    NSString *Cascode = [players valueForKey:@"IllnessMetaSubCode"];
                    
                    if([CauseOfillnessCode isEqualToString:Cascode])
                    {
                        [selectedCause addObject:players];
                    }
                }
                
                NSMutableArray *tt=[[NSMutableArray alloc]init];
                tt=[selectedCause objectAtIndex:0];
                
                self.CauseLbl.text =[tt valueForKey:@"IlnessMetaDataTypeCode"];

                
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
        isAffect =NO;
        isMainSymptom =NO;
        isCause   =NO;
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
        isAffect =NO;
        isMainSymptom =NO;
        isCause   =NO;
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
        isAffect =NO;
        isMainSymptom =NO;
        isCause   =NO;
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
-(IBAction)didClickOnset:(id)sender
{
    isExpected =NO;
    isOnset =YES;
    [self DisplaydatePicker];
}

-(IBAction)didClickAffect:(id)sender
{
    if(isAffect == NO)
    {
        self.popviewYposition.constant = self.affectView.frame.origin.y+210;
        self.popviewwidthSize.constant =self.affectLbl.frame.size.width;
        isGame =NO;
        isPlayer =NO;
        isTeam =NO;
        isAffect =YES;
        isMainSymptom =NO;
        isCause   =NO;
        self.popview_Tbl.hidden=NO;
        self.commonArray =[[NSMutableArray alloc]init];
        self.commonArray = self.AffectArray;
        [self.popview_Tbl reloadData];
    }
    else{
        isAffect =NO;
        self.popview_Tbl.hidden=YES;
    }
    

}
-(IBAction)didClickCauseillness:(id)sender
{
    if(isCause == NO)
    {
        self.popviewYposition.constant = self.CauseView.frame.origin.y+210;
        self.popviewwidthSize.constant =self.CauseLbl.frame.size.width;
        isGame =NO;
        isPlayer =NO;
        isTeam =NO;
        isAffect =NO;
        isMainSymptom =NO;
        isCause   =YES;
        self.popview_Tbl.hidden=NO;
        self.commonArray =[[NSMutableArray alloc]init];
        self.commonArray = self.causeillnessArray;
        [self.popview_Tbl reloadData];
    }
    else{
        isCause =NO;
        self.popview_Tbl.hidden=YES;
    }
    

}
-(IBAction)didClickMainsymptom:(id)sender
{
    if(isMainSymptom == NO)
    {
        self.popviewYposition.constant = self.mainsyntomView.frame.origin.y+210;
        self.popviewwidthSize.constant =self.mainSyntomLbl.frame.size.width;
        isGame =NO;
        isPlayer =NO;
        isTeam =NO;
        isAffect =NO;
        isMainSymptom =YES;
        self.popview_Tbl.hidden=NO;
        self.commonArray =[[NSMutableArray alloc]init];
        self.commonArray = self.mainsyptomArray;
        [self.popview_Tbl reloadData];
    }
    else{
        isMainSymptom =NO;
        self.popview_Tbl.hidden=YES;
    }
    

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
    objAlter.tag = 300;
    [objAlter show];
    
}
-(IBAction)didClickExpected:(id)sender
{
    
    
    isExpected =YES;
    isOnset =NO;
    
    datePicker.datePickerMode = UIDatePickerModeDate;
    self.expectedLbl.inputView = datePicker;
    datePicker.date = [NSDate date];

    [datePicker addTarget:self action:@selector(displaySelectedDate:) forControlEvents:UIControlEventValueChanged];
    [self.expectedLbl addTarget:self action:@selector(displaySelectedDate:) forControlEvents:UIControlEventEditingDidBegin];
    [self.onSetLbl becomeFirstResponder];
    
  /*
    if(datePicker!= nil)
    {
        [datePicker removeFromSuperview];
        
    }
    self.view_datepicker.hidden=NO;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM-dd-yyyy"]; // dd/MM/yyyy
    
    datePicker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,50,self.view_datepicker.frame.size.width,100)];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [datePicker setLocale:locale];
    
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    [datePicker reloadInputViews];
    [self.view_datepicker addSubview:datePicker];
    */
}

-(IBAction)didClickctXScan:(id)sender
{
    isXray =YES;
    isCT =NO;
    isMRI =NO;
    isBlood =NO;
    [self opengallery];
    
}
-(IBAction) didClickCTScans:(id)sender
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
-(IBAction)didClickBloodScan:(id)sender
{
    isXray =NO;
    isCT =NO;
    isMRI =NO;
    isBlood =YES;
    [self opengallery];
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
-(void)DisplaydatePicker
{
    
    datePicker.datePickerMode = UIDatePickerModeDate;
    self.onSetLbl.inputView = datePicker;
    datePicker.date = [NSDate date];
    
    [datePicker addTarget:self action:@selector(displaySelectedDate:) forControlEvents:UIControlEventValueChanged];
    [self.onSetLbl addTarget:self action:@selector(displaySelectedDate:) forControlEvents:UIControlEventEditingDidBegin];
    [self.onSetLbl becomeFirstResponder];
    
    /*
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
    */
}
//-(IBAction)showSelecteddate:(id)sender{
- (void)displaySelectedDate:(UIDatePicker*)sender {
    

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM-dd-yyyy"];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [datePicker setLocale:locale];
    [datePicker reloadInputViews];
    
    if (isOnset == YES)
    {
        self.onSetLbl.text=[dateFormat stringFromDate:datePicker.date];
        
    }
    else if (isExpected == YES)
    {
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"MM-dd-yyyy"];
//        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
//        [datePicker setLocale:locale];
//        [datePicker reloadInputViews];
        NSString *actDate = [dateFormat stringFromDate:datePicker.date];
        NSDate *onsetDate = [dateFormat dateFromString:self.onSetLbl.text];
        NSDate *ExpectedDate = [dateFormat dateFromString:actDate];
        
        
        NSComparisonResult result;
        //has three possible values: NSOrderedSame,NSOrderedDescending, NSOrderedAscending
        
        result = [onsetDate compare:ExpectedDate]; // comparing two dates
        NSLog(@"onsetDate:%@", onsetDate);
        NSLog(@"ExpectedDate:%@", ExpectedDate);
        
        if(result==NSOrderedAscending || result == NSOrderedSame)
        {
            NSLog(@"today is less OR equall");
            self.expectedLbl.text=[dateFormat stringFromDate:datePicker.date];
            
        } else if(result==NSOrderedDescending) {
            [self altermsg:@"Past Date not allowed"];
        }

    }
}

-(void)validation
{
    bool flag = false;
    if(![RoleCode isEqualToString:@"ROL0000002"])
    {
        
        if([self.gameLbl.text isEqualToString:@"Select"] || [self.gameLbl.text isEqualToString:@""])
        {
            [self altermsg:@"Please select Game"];
            flag = true;

        }
        else if ([self.TeamLbl.text isEqualToString:@"Select"] || [self.TeamLbl.text isEqualToString:@""])
        {
            [self altermsg:@"Please select Team"];
            flag = true;
        }
        else if ([self.playerLbl.text isEqualToString:@"Select"] || [self.playerLbl.text isEqualToString:@""])
        {
            [self altermsg:@"Please select Player"];
            flag = true;
            
        }
    }
    
    if(flag){
    }else if ([self.onSetLbl.text isEqualToString:@"Select"] || [self.onSetLbl.text isEqualToString:@""])
    {
        [self altermsg:@"Please select Date of Onset"];
        
    }
    else if ([self.illnessNameTxt.text isEqualToString:@""])
    {
        [self altermsg:@"Please Enter IllnessName"];
        
    }
    else if ([self.cheifcomplientTxt.text isEqualToString:@""])
    {
        [self altermsg:@"Please Enter Chief Compliant"];
        
    }
    
    else if ([self.affectLbl.text isEqualToString:@"Select"] || [self.affectLbl.text isEqualToString:@""])
    {
        [self altermsg:@"Please select Affect System"];
        
    }
    else if ([self.mainSyntomLbl.text isEqualToString:@"Select"] || [self.mainSyntomLbl.text isEqualToString:@""])
    {
        [self altermsg:@"Please select Main Syptom"];
        
    }
    else if ([self.CauseLbl.text isEqualToString:@"Select"] || [self.CauseLbl.text isEqualToString:@""])
    {
        [self altermsg:@"Please select Cause Illness"];
        
    }
    
    else if ([selectExpertOpinionCode isEqualToString:@"Select"] || [selectExpertOpinionCode isEqualToString:@""])
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
    UIAlertView * objaltert =[[UIAlertView alloc]initWithTitle:@"Add Illness" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [objaltert show];
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
//        [[NSUserDefaults standardUserDefaults] setObject:[responseObject valueForKey:@"Userreferencecode"] forKey:@"Userreferencecode"];
    
        [dic    setObject:@""     forKey:@"GAMECODE"];
        [dic    setObject:@""     forKey:@"TEAMCODE"];
        [dic    setObject: [[NSUserDefaults standardUserDefaults] valueForKey:@"Userreferencecode"]    forKey:@"PLAYERCODE"];
    }
    
    if(self.onSetLbl.text)   [dic    setObject:self.onSetLbl.text     forKey:@"DATEONSET"];
    if(self.illnessNameTxt.text)   [dic    setObject:self.illnessNameTxt.text    forKey:@"ILLNESSNAME"];
    
    if(self.cheifcomplientTxt.text)   [dic    setObject:self.cheifcomplientTxt.text     forKey:@"CHIEFCOMPLIANT"];
    if(selectaffectersystemCode)   [dic    setObject:selectaffectersystemCode     forKey:@"AFFECTEDSYSTEMCODE"];
    if(selectMainSyntromCode)   [dic    setObject:selectMainSyntromCode     forKey:@"MAINSYMPTOMCODE"];
    if(selectCauseCode)   [dic    setObject:selectCauseCode     forKey:@"CAUSEOFILLNESSSYMPTOMCODE"];
    if(selectExpertOpinionCode)   [dic    setObject:selectExpertOpinionCode     forKey:@"EXPERTOPINIONTAKEN"];
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
    NSString * url = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",inesertIllness]];
    [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:filePath name:@"image" error:nil];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
        
        if(responseObject >0)
        {
        BOOL status=[responseObject valueForKey:@"Status"];
        if(status == YES)
        {
            UIAlertView * objaltert =[[UIAlertView alloc]initWithTitle:@"Add Illness" message:[NSString stringWithFormat:@"Illness Inserted Successfully"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            objaltert.tag = 301;
            [objaltert show];
//            [self altermsg:[NSString stringWithFormat:@"Illness Insert %@",[responseObject valueForKey:@"Message"]]];
//            
//            [self.navigationController popViewControllerAnimated:YES];
            
        }
        else{
            [self altermsg:@"Illness Insert failed"];
        }
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
        
        if(self.onSetLbl.text)   [dic    setObject:self.onSetLbl.text     forKey:@"DATEONSET"];
        if(self.illnessNameTxt.text)   [dic    setObject:self.illnessNameTxt.text    forKey:@"ILLNESSNAME"];
        
        if(self.cheifcomplientTxt.text)   [dic    setObject:self.cheifcomplientTxt.text     forKey:@"CHIEFCOMPLIANT"];
        if(selectaffectersystemCode)   [dic    setObject:selectaffectersystemCode     forKey:@"AFFECTEDSYSTEMCODE"];
        if(selectMainSyntromCode)   [dic    setObject:selectMainSyntromCode     forKey:@"MAINSYMPTOMCODE"];
        if(selectCauseCode)   [dic    setObject:selectCauseCode     forKey:@"CAUSEOFILLNESSSYMPTOMCODE"];
        if(selectExpertOpinionCode)   [dic    setObject:selectExpertOpinionCode     forKey:@"EXPERTOPINIONTAKEN"];
        if(selectIllnessCode)   [dic    setObject:selectIllnessCode     forKey:@"ILLNESSCODE"];

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
        NSString * url = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",UpdateIllness]];
        [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileURL:filePath name:@"XRAYSFILE" error:nil];
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Success: %@", responseObject);
            BOOL status=[responseObject valueForKey:@"Status"];
            if(status == YES)
            {
               // Illness Updated Successfully
                [self altermsg:@"Illness Updated Successfully"];
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            else{
                [self altermsg:@"Illness Update failed"];
            }
            [COMMON RemoveLoadingIcon];
            [self.view setUserInteractionEnabled:YES];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [COMMON webServiceFailureError];
            [self.view setUserInteractionEnabled:YES];
        }];
    }
    
}

-(void)startDeleteInjuryService :(NSString *) Usercode :(NSString *)selectillnessCode
{
    [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        [objWebservice getinjuryDelete:deleteIllness :selectillnessCode :Usercode success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {

                NSLog(@"%@",responseObject);
                BOOL status=[responseObject valueForKey:@"Status"];
                if(status == YES)
                {
                    [self altermsg:[NSString stringWithFormat:@"Illness Deleted Successfully"]];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }
                else{
                    [self altermsg:@"Delete failed"];
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    
    if (buttonIndex == [alertView cancelButtonIndex])
    {
        alertView.hidden=YES;
    }
    else if (alertView.tag == 300)
    {
        [self startDeleteInjuryService:usercode :selectIllnessCode];
    }
    else if (alertView.tag == 301)
    {
//        self.saveBtn.hidden=YES;
//        self.updateBtn.hidden =NO;
//        self.deleteBtn.hidden =NO;
        self.gameLbl.text =@"";
        self.TeamLbl.text =@"";
        self.playerLbl.text =@"";
        self.onSetLbl.text =@"";
        
        self.affectLbl.text =@"";
        self.mainSyntomLbl.text =@"";
        self.CauseLbl.text =@"";
        self.expectedLbl.text =@"";
        self.illnessNameTxt.text =@"";
        self.cheifcomplientTxt.text =@"";
        selectGameCode =@"";
        selectTeamCode =@"";
        selectPlayerCode =@"";
        selectaffectersystemCode =@"" ;
        selectMainSyntromCode =@"";
        selectCauseCode =@"";
        selectExpertOpinionCode =@"";
        selectIllnessCode = @"";
        selectExpertOpinionCode=@"";
//        if([selectExpertOpinionCode isEqualToString:@"MSC215"])
//        {
//            [self.expertYesBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
//            [self.expertNoBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
//            
//        }
//        else
//        {
            [self.expertYesBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
            [self.expertNoBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
            
        //}
        self.xrayLbl.text =@"";
        self.mainSyntomLbl.text =@"";
        self.CTScanLbl.text =@"";
        self.MRILbl.text =@"";
        self.BloodTestLbl.text=@"";

    }
    else
    {
        //Do something else
    }
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
    return 50;
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
    
    Cell.textLabel.numberOfLines = 2;
    
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
    else if (isAffect ==YES)
    {
        Cell.textLabel.text =[[self.commonArray valueForKey:@"IlnessMetaDataTypeCode"] objectAtIndex:indexPath.row];
        
    }
    else if (isCause ==YES)
    {
        Cell.textLabel.text =[[self.commonArray valueForKey:@"IlnessMetaDataTypeCode"] objectAtIndex:indexPath.row];
        
    }
    else if (isMainSymptom ==YES)
    {
        Cell.textLabel.text =[[self.commonArray valueForKey:@"IlnessMetaDataTypeCode"] objectAtIndex:indexPath.row];
        
    }
    if(self.popview_Tbl.contentSize.height < 150)
    {
        self.popviewheight.constant = self.popview_Tbl.contentSize.height+20;
    }
    else
    {
        self.popviewheight.constant = 200;
        
    }
    Cell.selectionStyle=UITableViewCellSelectionStyleNone;
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
    else if (isAffect ==YES)
    {
        self.affectLbl.text =[[self.commonArray valueForKey:@"IlnessMetaDataTypeCode"] objectAtIndex:indexPath.row];
        selectaffectersystemCode = [[self.commonArray valueForKey:@"IllnessMetaSubCode"] objectAtIndex:indexPath.row];
    }
    else if (isCause ==YES)
    {
        self.CauseLbl.text =[[self.commonArray valueForKey:@"IlnessMetaDataTypeCode"] objectAtIndex:indexPath.row];
        selectCauseCode = [[self.commonArray valueForKey:@"IllnessMetaSubCode"] objectAtIndex:indexPath.row];
    }
    else if (isMainSymptom ==YES)
    {
        self.mainSyntomLbl.text =[[self.commonArray valueForKey:@"IlnessMetaDataTypeCode"] objectAtIndex:indexPath.row];
        selectMainSyntromCode = [[self.commonArray valueForKey:@"IllnessMetaSubCode"] objectAtIndex:indexPath.row];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
