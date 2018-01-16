//
//  AssignPlayerVC.h
//  AlphaProTracker
//
//  Created by Mac on 07/10/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssignPlayerVC : UIViewController
@property (nonatomic,strong) IBOutlet UIView *ProgramView;
@property (nonatomic,strong) IBOutlet UIView *PlayersView;
@property (nonatomic,strong) IBOutlet UIView *commonView;

@property (nonatomic,strong) IBOutlet UITableView *popList;
@property (nonatomic,strong) IBOutlet UITableView *multiTbl;

@property (nonatomic,strong) IBOutlet UILabel *Plylbl;
@property (nonatomic,strong) IBOutlet UILabel *Prgmlbl;

@property (nonatomic,strong) IBOutlet UIButton *Save;
@property (nonatomic,strong) IBOutlet UIButton *Update;
@property (nonatomic,strong) IBOutlet UIButton *Delete;


@property (nonatomic,strong)  NSString *ModuleCode;

@property (nonatomic,strong)  NSString *Scrname;
@property (nonatomic,strong)  NSString *check;

@end
