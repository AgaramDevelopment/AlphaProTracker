//
//  DropDownViewController.h
//  AlphaProTracker
//
//  Created by user on 30/01/18.
//  Copyright © 2018 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DropDownProtocol <NSObject>

@required
-(void)selectedtableValue:(NSString *)selectedValue andIndex:(NSIndexPath *)indexPath;
-(void)multiSelectedValue:(NSString *)MultiString andRelatedCollection:(NSArray *)array;

@end

@interface DropDownViewController : UIViewController

@property (strong,nonatomic) NSMutableArray* tableArray;
@property (strong,nonatomic) NSString* KeyName;

@property BOOL HeaderRequired;
@property (strong,nonatomic) id<DropDownProtocol> dropDownDelegate;


@property (weak, nonatomic) IBOutlet UITableView *tblDropDown;

@end
