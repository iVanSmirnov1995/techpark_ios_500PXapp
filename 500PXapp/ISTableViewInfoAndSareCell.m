//
//  ISTableViewInfoAndSareCell.m
//  500PXapp
//
//  Created by Smirnov Ivan on 18.10.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import "ISTableViewInfoAndSareCell.h"
#import <MessageUI/MessageUI.h>
#import "UIImageView+AFNetworking.h"

@interface ISTableViewInfoAndSareCell ()<MFMailComposeViewControllerDelegate>


@end


@implementation ISTableViewInfoAndSareCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)infoAction:(UIButton *)sender {
    
    
    
}

- (IBAction)sareAction:(UIButton *)sender {
    
    MFMailComposeViewController *emailDialog = [[MFMailComposeViewController alloc] init];
    
    NSString *htmlMsg = @"<html><body><p>Крутое фото</p></body></html>";
    
    UIImageView* imV=[[UIImageView alloc]init];
    [imV setImageWithURL:[NSURL URLWithString:self.model.imageName]];
    
    NSData *jpegData = UIImageJPEGRepresentation(imV.image, 1.0);
    
    NSString *fileName = @"test";
    fileName = [fileName stringByAppendingPathExtension:@"jpeg"];
    [emailDialog addAttachmentData:jpegData mimeType:@"image/jpeg" fileName:fileName];
    
    [emailDialog setSubject:@"500 px"];
    [emailDialog setMessageBody:htmlMsg isHTML:YES];
    
    [self.homeVC presentViewController:emailDialog animated:YES completion:nil];
}


#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    // Check the result or perform other tasks.
    
    // Dismiss the mail compose view controller.
    [self.homeVC dismissViewControllerAnimated:YES completion:nil];
}

@end
