//
//  QuestionaryVC.h
//  AlphaProTracker
//
//  Created by Lexicon on 30/08/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionaryCell.h"

@interface QuestionaryVC : UIViewController

@property (nonatomic,strong) IBOutlet UILabel *onsetlbl;
@property (nonatomic,strong) IBOutlet UILabel *topiclbl;
@property (nonatomic,strong) IBOutlet UILabel *subtopiclbl;

@property (nonatomic,strong) IBOutlet UIView *onsetview;
@property (nonatomic,strong) IBOutlet UIView *topicview;
@property (nonatomic,strong) IBOutlet UIView *subtopicview;
@property (nonatomic,strong) IBOutlet UITableView *pop_view;
@property (nonatomic,strong) IBOutlet UITableView *Quetionlist;

@property (nonatomic,strong) IBOutlet UIButton *save;
@property (nonatomic,strong) IBOutlet UIButton *update;
@property (nonatomic,strong) IBOutlet UIButton *delet;

@property (nonatomic,strong)  NSString *modulecode;
@property (nonatomic,strong)  NSString *Scrname;
@property (nonatomic,strong)  NSString *editkey;
@property (nonatomic,strong)  IBOutlet NSString *menukey;


@property (nonatomic,strong) IBOutlet QuestionaryCell *QusCell;

@property (nonatomic,strong)  NSString *check;
@end
