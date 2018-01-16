//
//  ProgramVC.h
//  AlphaProTracker
//
//  Created by Lexicon on 29/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRTableViewCell.h"

@interface ProgramVC : UIViewController

@property (nonatomic,strong) IBOutlet UITableView *popList;
@property (nonatomic,strong) IBOutlet UITableView *ListTbl;

@property (nonatomic,strong)  NSString *ModuleCode;
@property (nonatomic,strong)  NSString *Screen;
@property (nonatomic,strong)  NSString *mmcode;

@property (nonatomic,strong) IBOutlet UITextField *Titlelbl;
@property (nonatomic,strong) IBOutlet UILabel *Exerciselbl;

@property (nonatomic,strong) IBOutlet UIButton *UpdateBtn;
@property (nonatomic,strong) IBOutlet UIButton *ClearBtn;
@property (nonatomic,strong) IBOutlet UIButton *RemoveBtn;
@property (nonatomic,strong) IBOutlet UIButton *SaveBtn;

@property (nonatomic,strong) IBOutlet UIView *TitleView;
@property (nonatomic,strong) IBOutlet UIView *ExerciseView;

@property (nonatomic,strong)  NSString *check;


@end
