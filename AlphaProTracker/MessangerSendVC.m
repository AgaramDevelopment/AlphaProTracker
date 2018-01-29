//
//  MessangerSendVC.m
//  AlphaProTracker
//
//  Created by apple on 25/01/18.
//  Copyright © 2018 agaraminfotech. All rights reserved.
//

#import "MessangerSendVC.h"
#import "AppCommon.h"
#import "CustomNavigation.h"
#import "Config.h"
#import "WebService.h"
#import "MessangerTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MessangerSendVC () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSMutableArray* mainArray;
    NSMutableArray* chatArray;
    NSString *imgData,* imgFileName;
    NSMutableArray* contactList;
    NSMutableArray* multiSelect;
}

@end

@implementation MessangerSendVC
@synthesize viewTolist,tblContactLIst;

@synthesize ImgViewBottomConst,imgView,currentlySelectedImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self customnavigationmethod];
    
    if (!_isBroadCastMsg) {
        [self loadMessage];
    }
    else{
        [_btnToName sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];

    [self resetImageData];
    dispatch_async(dispatch_get_main_queue(), ^{
        ImgViewBottomConst.constant = -imgView.frame.size.height;
        [imgView updateConstraintsIfNeeded];
    });
    
    _tblChatList.estimatedRowHeight = UITableViewAutomaticDimension;
    
    multiSelect = [NSMutableArray new];
    

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

-(void)viewWillAppear:(BOOL)animated
{
    [COMMON AddMenuView:self.view];
    [_txtMessage becomeFirstResponder];
    
    [self.btnToName setTitle:_SelectedName forState:UIControlStateNormal];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSLog(@"%f", [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height);
    NSInteger keyboardHeight = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    self.viewBottomSpace.constant = keyboardHeight+1;
    
}

#pragma mark customnavigationmethod


-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation = [[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
        [self.topView addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"";
    objCustomNavigation.btn_back.hidden =NO;
    objCustomNavigation.menu_btn.hidden = YES;
    [objCustomNavigation.btn_back addTarget:self action:@selector(BackBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(IBAction)MenuBtnAction:(id)sender
{
    [COMMON ShowsideMenuView];
}

-(IBAction)BackBtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(IBAction)HomeBtnAction:(id)sender
{
    HomeVC  * objTabVC=[[HomeVC alloc]init];
    objTabVC = (HomeVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
    [self.navigationController pushViewController:objTabVC animated:YES];
    
    
}

#pragma mark UITableView Delagates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == tblContactLIst) {
        return contactList.count;
    }else
    {
        return [chatArray count]; // lstallmessages

    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tblContactLIst == tableView) {
        
        UITableViewCell *cell = [tblContactLIst dequeueReusableCellWithIdentifier:@"DEFAULT"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DEFAULT"];
        }
        cell.textLabel.text = [[contactList objectAtIndex:indexPath.row]valueForKey:@"receivername"];
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        return cell;
    }
    else{
        
        MessangerTableViewCell* cell = [_tblChatList dequeueReusableCellWithIdentifier:@"First"];
        NSArray* arr = [[NSBundle mainBundle] loadNibNamed:@"MessangerTableViewCell" owner:self options:nil];

        NSString* name=[[chatArray objectAtIndex:indexPath.row] valueForKey:@"receivefromname"];
        if ([[AppCommon GetUserName] isEqualToString:name]) // your message
        {
            cell = arr[0];
            cell.SenderMsg.text = [[chatArray objectAtIndex:indexPath.row] valueForKey:@"message"];
            cell.SenderDate.text = [[chatArray objectAtIndex:indexPath.row] valueForKey:@"msgDateTime"];
            NSString* IMG=[[chatArray objectAtIndex:indexPath.row] valueForKey:@"messagAttachment"];

            if (![IMG isEqualToString:@"MessagePhotos/"]) {
                cell.SenderIMGHeight.constant = cell.SenderIMG.frame.size.width;
                [cell.SenderIMG updateConstraintsIfNeeded];
                NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,IMG]];
                [cell.SenderIMG sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"default_image"]];
            }else
            {
                cell.SenderIMGHeight.constant = 20;
                [cell.SenderIMG updateConstraintsIfNeeded];
            }
            

        }
        else
        {
            cell = arr[1];
            cell.ReceiverName.text = [[chatArray objectAtIndex:indexPath.row] valueForKey:@"receivefromname"];
            cell.ReceiverDate.text = [[chatArray objectAtIndex:indexPath.row] valueForKey:@"msgDateTime"];
            cell.ReceiverMsg.text = [[chatArray objectAtIndex:indexPath.row] valueForKey:@"message"];
            
            NSString* IMG=[[chatArray objectAtIndex:indexPath.row] valueForKey:@"messagAttachment"];
            
            if (![IMG isEqualToString:@"MessagePhotos/"]) {
                cell.ReceiverIMGHeight.constant = cell.SenderIMG.frame.size.width;
                [cell.SenderIMG updateConstraintsIfNeeded];
                NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,IMG]];
                [cell.ReceiverIMG sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"default_image"]];
            }else
            {
                cell.ReceiverIMGHeight.constant = 40;
                [cell.ReceiverIMG updateConstraintsIfNeeded];
            }

        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tblContactLIst) {
        
        id value = [_arrReceiverCodes objectAtIndex:indexPath.row];
        UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [multiSelect removeObject:value];
            
        } else {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [multiSelect addObject:value];

        }
        NSString* names = [[multiSelect valueForKey:@"receivername"] componentsJoinedByString:@","];
        [_btnToName setTitle:([names isEqualToString:@""] ? @"Please Select Your Contacts" : names )forState:UIControlStateNormal];
    }
}

#pragma mark UIImagePickerController Delegates


//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo

{
//    NSDictionary * dict = [editingInfo valueForKey:UIImagePickerControllerOriginalImage];
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString * objPath =[[picker valueForKey:@"mediaTypes"] objectAtIndex:0];
//    NSString *savedImagePath =   [documentsDirectory stringByAppendingPathComponent:objPath];
    
    imgData = [self encodeToBase64String:image];
    imgFileName = [[editingInfo valueForKey:@"UIImagePickerControllerImageURL"] lastPathComponent];
    [self dismissViewControllerAnimated:YES completion:^{
        ImgViewBottomConst.constant = imgView.frame.size.height;
        [imgView updateConstraintsIfNeeded];
        currentlySelectedImage.image = image;

    }];


    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

#pragma mark Webservice and MSG Send Actions

- (IBAction)actionSendMessage:(id)sender {
    if ([sender tag]) {
        
        [self openAttachMentOptions:sender];
    }
    else
    {
        if (_isBroadCastMsg) {
            
            if (multiSelect.count == 0) {
                [AppCommon showAlertWithMessage:@"Please Select Atleast one contact to send message"];
            }
            else if([_txtMessage.text isEqualToString:@""] && [imgData isEqualToString:@""])
            {
                [AppCommon showAlertWithMessage:@"Please type Your message"];
            }
            else
            {
                [self sendBroadcatingMessage];
            }
        }
        else
        {
            if([_txtMessage.text isEqualToString:@""] && [imgData isEqualToString:@""])
            {
                [AppCommon showAlertWithMessage:@"Please type Your message"];
            }
            else
            {
                [self sendReplyMessageWebService];
            }

        }
    }
}

-(void)loadMessage
{
    /*
     API URL : http://192.168.1.84:8029/AGAPTSERVICE.svc/SHOWALLMESSAGES
     METHOD : POST
     INPUT PARAMS :
     
     {
     Clientcode :   CLI0000001
     commId     :   GRP0000001
     UserCode   :   AMR0000001
     unRead     :   YES/NO
     }
     
     "receivercode": "USM0000011",
     "receivername": "Rohan Kunnummal",
     "commId": "COM0000003",
     */
    if(![COMMON isInternetReachable])
        return;
    
    [AppCommon showLoading];
    NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",FetchAllMessageKey]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = requestSerializer;
    NSLog(@"Used API URL %@ ",URLString);
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if([AppCommon GetClientCode]) [dic setObject:[AppCommon GetClientCode] forKey:@"Clientcode"];
    if([AppCommon GetuserReference]) [dic setObject:[AppCommon GetuserReference] forKey:@"UserCode"];
    [dic setObject:_CommID forKey:@"commId"];
    [dic setObject:_iSread forKey:@"unRead"];
    
    
    NSLog(@"parameters : %@",dic);
    [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"response ; %@",responseObject);
        if(responseObject > 0)
        {
            mainArray = [NSMutableArray new];
            mainArray = responseObject;
            chatArray = [NSMutableArray new];
            chatArray = [mainArray valueForKey:@"lstallmessages"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tblChatList reloadData];
            });
            
            //            [self.tblChatList scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:chatArray.count inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            
        }
        [AppCommon hideLoading];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [AppCommon hideLoading];
    }];
    
    
}


-(void)sendReplyMessageWebService
{
    /*
     API URL : http://192.168.1.84:8029/AGAPTSERVICE.svc/SHOWALLMESSAGES
     METHOD : POST
     INPUT PARAMS :
     
     SENDREPLYMESSAGES_ANDROID
     
     Clientcode
     UserCode
     commId
     newmessage
     newmessagephoto
     fileName
     
     */
    if(![COMMON isInternetReachable])
        return;
    
    [AppCommon showLoading];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    if([AppCommon GetClientCode]) [dic setObject:[AppCommon GetClientCode] forKey:@"Clientcode"];
    if([AppCommon GetUsercode]) [dic setObject:[AppCommon GetUsercode] forKey:@"UserCode"];
    [dic setObject:_CommID forKey:@"commId"];
    [dic setObject:_txtMessage.text forKey:@"newmessage"];
    [dic setObject:imgData forKey:@"newmessagephoto"];
    [dic setObject:imgFileName  forKey:@"fileName"];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    NSString * url = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",SendMessageKey]];
    
    NSLog(@"USED API URL %@",url);
    NSLog(@"USED PARAMS %@ ",dic);
    NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];

    [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:filePath name:@"image" error:nil];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
        [self resetImageData];
        
        mainArray = [NSMutableArray new];
        mainArray = responseObject;
        chatArray = [NSMutableArray new];
        chatArray = [mainArray valueForKey:@"lstallmessages"];
        dispatch_async(dispatch_get_main_queue(), ^{
            ImgViewBottomConst.constant = -imgView.frame.size.height;
            [imgView updateConstraintsIfNeeded];
            currentlySelectedImage.image = nil;
            [self.tblChatList reloadData];
        });


        [AppCommon hideLoading];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [AppCommon hideLoading];
        [self resetImageData];
        NSLog(@"SEND MESSAGE ERROR %@ ",error.description);
        [COMMON webServiceFailureError];
    }];

    
}

-(void)sendBroadcatingMessage
{
    /*
     API URL : http://192.168.1.84:8029/AGAPTSERVICE.svc/SENDNEWMESSAGES_ANDROID
     METHOD : POST
     INPUT PARAMS :
     
     SENDNEWMESSAGES_ANDROID
     
     {
         Clientcode
         UserCode
         Userreferencecode
         receivercodes : [USM0000011,USM0000012,USM0000013]
         newmessage
         newmessagephoto
     }
     */
    if(![COMMON isInternetReachable])
        return;
    
    [AppCommon showLoading];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    if([AppCommon GetClientCode]) [dic setObject:[AppCommon GetClientCode] forKey:@"Clientcode"];
    if([AppCommon GetuserReference]) [dic setObject:[AppCommon GetuserReference] forKey:@"Userreferencecode"];
    if([AppCommon GetUsercode]) [dic setObject:[AppCommon GetUsercode] forKey:@"UserCode"];

    if (multiSelect.count > 0) {
        NSString* code= [[multiSelect valueForKey:@"receivercode"]componentsJoinedByString:@","];
        [dic setObject:code forKey:@"receivercodes"];

    }
    [dic setObject:_txtMessage.text forKey:@"newmessage"];
    [dic setObject:imgData forKey:@"newmessagephoto"];
    [dic setObject:imgFileName  forKey:@"fileName"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    //    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //    manager.requestSerializer = requestSerializer;
    
    //NSDictionary *parameters = @{@"foo": @"bar"};
    //    NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
    NSString * url = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",SendBroadCastMessageKey]];
    
    NSLog(@"USED API URL %@",url);
    NSLog(@"USED PARAMS %@ ",dic);
    NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
    
    [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:filePath name:@"image" error:nil];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
        [self resetImageData];
        [AppCommon hideLoading];
        
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [AppCommon hideLoading];
        [self resetImageData];
        NSLog(@"SEND MESSAGE ERROR %@ ",error.description);
        [COMMON webServiceFailureError];
    }];

}

-(void)resetImageData
{
    imgData = @"";
    imgFileName = @"";
    _txtMessage.text = @"";

}

#pragma mark UITextField Delagates

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
//    self.viewBottomSpace.constant = 0;

    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}// called when 'return' key pressed. return NO to ignore.

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.viewBottomSpace.constant = 0;

//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length == 0 && [string isEqualToString:@" "]) {
        return NO;
    }
    
    return YES;
}
// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

#pragma mark Attachments and Contact DropDowns

- (IBAction)actionShowContactList:(id)sender {
    
    if(_arrReceiverCodes.count == 0)
        return;
        
    
    if (![self.view.subviews containsObject:viewTolist]) {
        
        
        contactList = [NSMutableArray new];
        [contactList addObjectsFromArray:_arrReceiverCodes];
        [viewTolist setFrame:CGRectMake(0, [sender superview].frame.origin.y+[sender frame].size.height, self.view.frame.size.width, self.view.frame.size.height)];
        CGFloat height = (contactList.count > 5 ? 5*44 : contactList.count*44);
        [tblContactLIst setFrame:CGRectMake(0,0,viewTolist.frame.size.width, height)];
        
        for (UIView*  view in viewTolist.subviews) {
            if (view.tag == 1) {
                view.frame = viewTolist.frame;
            }
        }

        [self.view addSubview:viewTolist];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tblContactLIst reloadData];
        });
    }
    else
    {
        [viewTolist removeFromSuperview];
    }
    
}

-(IBAction)removeDropDown:(id)sender
{
    [viewTolist removeFromSuperview];
}

-(void)openAttachMentOptions:(id)sender
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;

    
    UIAlertController* alert =[UIAlertController alertControllerWithTitle:APP_NAME message:@"Choose Your Attachment" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* CameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imagePickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerController animated:YES completion:nil];

        
    }];
    UIAlertAction* GalleryAction = [UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerController animated:YES completion:nil];

        
    }];
    UIAlertAction* CancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];

    [alert addAction:CameraAction];
    [alert addAction:GalleryAction];
    [alert addAction:CancelAction];
    
    
    [alert setModalPresentationStyle:UIModalPresentationPopover];
    UIPopoverPresentationController *popPresenter = [alert popoverPresentationController];
    popPresenter.sourceView = sender;
    popPresenter.sourceRect = [sender bounds]; // You can set position of popover
    
    [self presentViewController:alert animated:TRUE completion:nil];

    
    
}
@end
