//
//  DropDownViewController.m
//  AlphaProTracker
//
//  Created by user on 30/01/18.
//  Copyright © 2018 agaraminfotech. All rights reserved.
//

#import "DropDownViewController.h"
#import "Config.h"

@interface DropDownViewController ()
{
    NSMutableArray* selectedPlayers;
}

@end

@implementation DropDownViewController

@synthesize tableArray,KeyName;

@synthesize HeaderRequired,tblDropDown;

@synthesize dropDownDelegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    selectedPlayers = [NSMutableArray new];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [tblDropDown reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    });

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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (HeaderRequired ? (IS_IPAD ? 50 : 44) : 0 );
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (HeaderRequired)
    {
        UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, tableView.rowHeight)];
        btn.backgroundColor = [UIColor yellowColor];
        [btn setTitle:@"Done" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(dismissView:) forControlEvents:UIControlEventTouchUpInside];

        return btn;
    }
    NSLog(@"BUTTON CALLED");
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"paramTVC";
    UITableViewCell * objCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (objCell == nil)
    {
        objCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    objCell.textLabel.text = [[tableArray objectAtIndex:indexPath.row] valueForKey:KeyName];

    if (HeaderRequired)
    {
        if ([[selectedPlayers valueForKey:KeyName]containsObject:objCell.textLabel.text]) {
            objCell.accessoryType = UITableViewCellAccessoryCheckmark;

        }
        else
        {
            objCell.accessoryType = UITableViewCellAccessoryNone;

        }
    }
    else
    {
        objCell.accessoryType = UITableViewCellAccessoryNone;
    }


    return objCell;
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (HeaderRequired)
    {
        [self buttonCheckAction:indexPath];
        return;
    }
    
    NSString* selectedValue = [[tableArray objectAtIndex:indexPath.row] valueForKey:KeyName];
    [dropDownDelegate selectedtableValue:selectedValue andIndex:indexPath];
    
    [self dismissViewControllerAnimated:YES completion:nil];

}


-(void)buttonCheckAction:(NSIndexPath *)indexPath
{
    id value = [tableArray objectAtIndex:indexPath.row];
    
    if (selectedPlayers.count == 0 && indexPath.row == 0)
    {
        [selectedPlayers removeAllObjects];
        [selectedPlayers addObjectsFromArray:tableArray];
        
    }else if (selectedPlayers.count > 0 && indexPath.row == 0)
    {
        [selectedPlayers removeAllObjects];
    }
    else if ([selectedPlayers containsObject:value])
    {
        [selectedPlayers removeObject:value];
    }
    else
    {
        [selectedPlayers addObject:value];
    }
    
    if (selectedPlayers.count > 0)
    {
//        if (selectedPlayers.count == tableArray.count) {
//            NSArray* arr = [selectedPlayers subarrayWithRange:NSMakeRange(1, selectedPlayers.count-1)];
//            NSString* value = [[arr valueForKey:KeyName] componentsJoinedByString:@","];
//            [dropDownDelegate multiSelectedValue:value];
//            return;
//        }
        NSString* value  = [[selectedPlayers valueForKey:KeyName] componentsJoinedByString:@","];
        [dropDownDelegate multiSelectedValue:value andRelatedCollection:selectedPlayers];

    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [tblDropDown reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    });
    
}


-(IBAction)dismissView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
