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
#import "IQKeyboardManager.h"

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
    
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];


    [self customnavigationmethod];
    
    if (!_isBroadCastMsg) {
        [self loadMessage];
    }
    else{
        [_btnToName sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    
    [self resetImageData];
    dispatch_async(dispatch_get_main_queue(), ^{
        ImgViewBottomConst.constant = -imgView.frame.size.height;
        [imgView updateConstraintsIfNeeded];
    });
    
    _tblChatList.estimatedRowHeight = UITableViewAutomaticDimension;
    
    multiSelect = [NSMutableArray new];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];

    
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
//    [_txtMessage becomeFirstResponder];
    
    [self.btnToName setTitle:_SelectedName forState:UIControlStateNormal];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSLog(@"%f", [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height);
    NSInteger keyboardHeight = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    if (notification.name == UIKeyboardWillShowNotification) {
        self.viewBottomSpace.constant = keyboardHeight;
        [imgView updateConstraintsIfNeeded];

    }else if (notification.name == UIKeyboardDidShowNotification)
    {
        if(chatArray.count > 0)
        {
            [self.tblChatList scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:chatArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }

    }

}

- (void)keyboardWillHide:(NSNotification *)notification {
//    NSLog(@"%f", [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height);
//    NSInteger keyboardHeight = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    
        self.viewBottomSpace.constant = 0;
        [imgView updateConstraintsIfNeeded];

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
        [_lblNodata setHidden:chatArray.count];
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
        
        if ([[multiSelect valueForKey:@"receivername"]containsObject:cell.textLabel.text]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;

        }
        
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
                [cell.SenderIMG updateConstraintsIfNeeded]; // http://192.168.1.84:8029
                NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.84:8029/%@",IMG]];

//                NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,IMG]];
                [cell.SenderIMG sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"default_image"]];
                [self calculateMsgSize:cell.SenderMsg];
//                [cell.SenderMsg sizeToFit];
//                [cell.SenderMsg updateConstraintsIfNeeded];
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

-(void)calculateMsgSize:(UILabel *)label
{
    [label invalidateIntrinsicContentSize];
    NSLog(@"TEXT %@ ",label.text);
    CGSize size = label.intrinsicContentSize;
    NSLog(@"calculateMsgSize %@",NSStringFromCGSize(size));
    
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:label.text attributes:@{NSFontAttributeName:label.font}];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){label.frame.size.width, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    
    NSLog(@"SenderMsg height %@ ",NSStringFromCGRect(rect));
    
    //    SenderMsg.layout
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tblContactLIst) {
        
        id value = [_arrReceiverCodes objectAtIndex:indexPath.row];
        
        UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];

        if (indexPath.row == 0 && cell.accessoryType == UITableViewCellAccessoryNone) // select all
        {
            [multiSelect removeAllObjects];
            [multiSelect addObjectsFromArray:_arrReceiverCodes];
        }
        else if (indexPath.row == 0 && cell.accessoryType == UITableViewCellAccessoryCheckmark)
        {
            [multiSelect removeAllObjects];

        }
        else if ([multiSelect containsObject:value]) {
            [multiSelect removeObject:value];

        }
        else {
            [multiSelect addObject:value];
            
        }
        

        if (multiSelect.count > 0) {
            
            NSMutableArray* arr = multiSelect;

            if ([[multiSelect valueForKey:@"receivername"] containsObject:@"Select All"]) {
                [arr removeObjectAtIndex:0];
            }
            NSString* names = [[arr valueForKey:@"receivername"] componentsJoinedByString:@","];
            [_btnToName setTitle:([names isEqualToString:@""] ? @"Please Select Your Contacts" : names )forState:UIControlStateNormal];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tblContactLIst reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        });

        
        
    }
}

#pragma mark UIImagePickerController Delegates


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
//- (void)imagePickerController:(UIImagePickerController *)picker
//        didFinishPickingImage:(UIImage *)image
//                  editingInfo:(NSDictionary *)editingInfo

{
//    NSDictionary * dict = [editingInfo valueForKey:UIImagePickerControllerOriginalImage];
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString * objPath =[[picker valueForKey:@"mediaTypes"] objectAtIndex:0];
//    NSString *savedImagePath =   [documentsDirectory stringByAppendingPathComponent:objPath];
    NSLog(@"info[UIImagePickerControllerMediaType] %@",info[UIImagePickerControllerMediaType]);
    UIImage* image;
    NSData* imgDatas; // = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:info[@"UIImagePickerControllerImageURL"]]];
    if([info[UIImagePickerControllerMediaType] isEqualToString:@"public.image"])
    {
//        image = info[UIImagePickerControllerReferenceURL];
        NSString* str = info[@"UIImagePickerControllerImageURL"];
//        NSURL* url = (NSURL *)[info valueForKey:UIImagePickerControllerImageURL];
        imgDatas = [[NSData alloc] initWithContentsOfFile:str];
        imgFileName = [[info valueForKey:@"UIImagePickerControllerImageURL"] lastPathComponent];

    }
    else
    {
        NSURL* url = (NSURL *)[info valueForKey:UIImagePickerControllerMediaURL];
        imgDatas = [[NSData alloc] initWithContentsOfURL:url];

//        imgDatas = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:info[@"UIImagePickerControllerMediaURL"]]];
        imgFileName = [[info valueForKey:@"UIImagePickerControllerMediaURL"] lastPathComponent];

        image = info[UIImagePickerControllerOriginalImage];
    }
    
//    imgData = [self encodeToBase64String:image];
    imgData = [imgDatas base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    if (!imgFileName) {
        
        imgFileName = [self getFileName];
    }
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
            else if(!_txtview.hasText && [imgData isEqualToString:@""])
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
            if(!_txtview.hasText && [imgData isEqualToString:@""])
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
    
    NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",FetchAllMessageKey]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = requestSerializer;
    NSLog(@"Used API URL %@ ",URLString);
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    if([AppCommon GetClientCode])
    {
        [dic setObject:[AppCommon GetClientCode] forKey:@"Clientcode"];
    }
    else
    {
        [AppCommon showAlertWithMessage:@"Client code missing in loadMessage API"];
        return;
    }
    
    if([AppCommon GetuserReference])
    {
        [dic setObject:[AppCommon GetuserReference] forKey:@"UserCode"];
    }
    else
    {
        [AppCommon showAlertWithMessage:@"UserCode missing in loadMessage API"];
        return;
    }
    if(self.CommID)
    {
        [dic setObject:_CommID forKey:@"commId"];
    }
    else
    {
        [AppCommon showAlertWithMessage:@"commId missing in loadMessage API"];
        return;
    }
    if(self.iSread)
    {
        [dic setObject:_iSread forKey:@"unRead"];
    }
    else
    {

        [dic setObject:@"NO" forKey:@"unRead"];
    }
    

    [AppCommon showLoading];

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
                NSLog(@"FIRST ");
                [self.tblChatList reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
            });

            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"SECOND ");
                [self.tblChatList scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:chatArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];

            });
            
            
//             dispatch_queue_t serialQueue = dispatch_queue_create("com.unique.name.queue", DISPATCH_QUEUE_SERIAL);
//
//             dispatch_async(serialQueue, ^{
//                 NSLog(@"FIRST ");
//                 [self.tblChatList reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
//             });
//             dispatch_async(serialQueue, ^{
//                 NSLog(@"SECOND ");
//                 [self.tblChatList scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:chatArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//             });
            

            

            
            
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
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
//    if([AppCommon GetClientCode]) [dic setObject:[AppCommon GetClientCode] forKey:@"Clientcode"];
//    if([AppCommon GetUsercode]) [dic setObject:[AppCommon GetUsercode] forKey:@"UserCode"];
//    [dic setObject:_CommID forKey:@"commId"];
    
    [dic setObject:_txtview.text forKey:@"newmessage"];
    [dic setObject:imgData forKey:@"newmessagephoto"];
    [dic setObject:imgFileName  forKey:@"fileName"];
    
    
    if([AppCommon GetClientCode])
    {
        [dic setObject:[AppCommon GetClientCode] forKey:@"Clientcode"];
    }
    else
    {
        [AppCommon showAlertWithMessage:@"Client code missing in loadMessage API"];
        return;
    }
    
    if([AppCommon GetUsercode])
    {
        [dic setObject:[AppCommon GetUsercode] forKey:@"UserCode"];
    }
    else
    {
        [AppCommon showAlertWithMessage:@"UserCode missing in loadMessage API"];
        return;
    }
    if(self.CommID)
    {
        [dic setObject:_CommID forKey:@"commId"];
    }
    else
    {
        [AppCommon showAlertWithMessage:@"commId missing in loadMessage API"];
        return;
    }
    

    [AppCommon showLoading];

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
            
            if (chatArray.count == 0) {
                return ;
            }
            
            [self.tblChatList insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:chatArray.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            [self.tblChatList scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:chatArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];

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
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    if([AppCommon GetClientCode]) [dic setObject:[AppCommon GetClientCode] forKey:@"Clientcode"];
    if([AppCommon GetuserReference]) [dic setObject:[AppCommon GetuserReference] forKey:@"Userreferencecode"];
    if([AppCommon GetUsercode]) [dic setObject:[AppCommon GetUsercode] forKey:@"UserCode"];

    if (multiSelect.count > 0) {
        
        if ([[multiSelect valueForKey:@"receivername"] containsObject:@"Select All"]) {
            [multiSelect removeObjectAtIndex:0];
        }
        
        NSString* code= [[multiSelect valueForKey:@"receivercode"]componentsJoinedByString:@","];
        [dic setObject:code forKey:@"receivercodes"];

    }
    [dic setObject:_txtview.text forKey:@"newmessage"];
    [dic setObject:imgData forKey:@"newmessagephoto"];
    [dic setObject:imgFileName  forKey:@"fileName"];
    [AppCommon showLoading];

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
    dispatch_async(dispatch_get_main_queue(), ^{
        _txtview.text = @"";
    });
//    _MsgToolHeight.constant = 40;
//    [_txtview updateConstraintsIfNeeded];
}

#pragma mark UITextView Delagates

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView.text.length == 0 && [text isEqualToString:@" "]) {
        return NO;
    }
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }

    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    
    [textView invalidateIntrinsicContentSize];
    [textView setScrollEnabled:NO];
    CGFloat MinHeight = 40.0;
    CGFloat MaxHeight = 200;
    
    CGFloat height;
    if (textView.intrinsicContentSize.height <= MinHeight) {
        NSLog(@"MIN");
        height = MAX(textView.intrinsicContentSize.height,MinHeight);
    }
    else  if (textView.intrinsicContentSize.height >= MaxHeight) {
        NSLog(@"MAX");
        height = MIN(textView.intrinsicContentSize.height,MaxHeight);
    }
    else
    {
        NSLog(@"NORMAL");
        height = textView.intrinsicContentSize.height;
    }
    
    _MsgToolHeight.constant = height;
    [textView updateConstraintsIfNeeded];
    [textView setScrollEnabled:YES];
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    NSLog(@"textViewDidEndEditing called");

    self.viewBottomSpace.constant = 0;

}
-(void)textFieldHeight:(NSString *)string
{
    
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName:_txtview.font}];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){_txtview.frame.size.width, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    NSLog(@"textfield height %@ ",NSStringFromCGRect(rect));
    
    
    CGFloat MinHeight = 40;
    CGFloat MaxHeight = 200;
    
    if (rect.size.height <= MinHeight) {
        
        _MsgToolHeight.constant = MAX(rect.size.height,MinHeight);
    }
    
    if (rect.size.height >= MaxHeight) {
        
        _MsgToolHeight.constant = MIN(rect.size.height,MaxHeight);
    }
    
    [_txtview updateConstraintsIfNeeded];


//    return rect;
}

// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

#pragma mark Attachments and Contact DropDowns

- (IBAction)actionShowContactList:(id)sender {
    
    if (!_isBroadCastMsg && chatArray.count > 0) // scroll for first message
    {
        [self.tblChatList scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }

    if(_arrReceiverCodes.count == 0)
        return;
    
    
    
    if (![self.view.subviews containsObject:viewTolist]) {
        
        
        contactList = [NSMutableArray new];
        [contactList addObjectsFromArray:_arrReceiverCodes];
//        [viewTolist setFrame:CGRectMake(0, [sender superview].frame.origin.y+[sender frame].size.height, self.view.frame.size.width, self.view.frame.size.height)];
        CGFloat height = (contactList.count > 5 ? 5*44 : contactList.count*44);
        [tblContactLIst setFrame:CGRectMake(0,[sender superview].frame.origin.y+[sender frame].size.height,self.view.frame.size.width, height)];
        
        
        [self.view addSubview:viewTolist];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tblContactLIst reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
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
        imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];

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
- (IBAction)actionCancelAttachment:(id)sender {
    imgData = @"";
    imgFileName = @"";
    currentlySelectedImage = nil;
    ImgViewBottomConst.constant = -imgView.frame.size.height;
    [imgView updateConstraintsIfNeeded];
    
}

-(NSString *)getFileName
{
    
    /*
     EEEE, MMM d, yyyy
     */
    
    NSString* filename;
    NSDateFormatter* df = [NSDateFormatter new];
    [df setDateFormat:@"EEEE_MMM_d_yyyy_HH_mm_ss"];
    
    filename = [df stringFromDate:[NSDate date]];
    filename=[filename stringByAppendingPathExtension:@"png"];
    NSLog(@"file name %@ ",filename);
    
    return filename;
}
@end
