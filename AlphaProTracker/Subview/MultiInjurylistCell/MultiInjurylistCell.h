//
//  MultiInjurylistCell.h
//  AlphaProTracker
//
//  Created by Mac on 17/01/18.
//  Copyright © 2018 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultiInjurylistCell : UITableViewCell

@property (nonatomic,strong)IBOutlet UILabel * sitelbl;
@property (nonatomic,strong)IBOutlet UILabel * sidelbl;
@property (nonatomic,strong)IBOutlet UILabel * causelbl;
@property (nonatomic,strong)IBOutlet UILabel * locationlbl;
@property (nonatomic,strong)IBOutlet UILabel * typelbl;
@property (nonatomic,strong)IBOutlet UIButton * deleteBtn;
@end
