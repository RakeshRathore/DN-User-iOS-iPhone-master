/*
 * Copyright (c) 2010, Dominic DiMarco (dominic@ReallyLongAddress.com)
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * -Redistributions of source code must retain the above copyright
 * notice, this list of conditions and the following disclaimer.
 * 
 * -Redistributions in binary form must reproduce the above copyright
 * notice, this list of conditions and the following disclaimer in the
 * documentation and/or other materials provided with the distribution.
 * 
 * -Neither the name of the author nor the
 * names of its contributors may be used to endorse or promote products
 * derived from this software without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. 
 */

//
//  FbGraph.h
//  oAuth2Test
//
//  Created by dominic dimarco (ddimarco@room214.com @dominicdimarco) on 5/23/10.
//

#import <Foundation/Foundation.h>
#import "FbGraphResponse.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

@interface FbGraph : NSObject <UIWebViewDelegate> {

	NSString *facebookClientID;
	NSString *redirectUri;
	NSString *accessToken;
    
    AppDelegate *AppDelegateObj;
	
	UIWebView *webView;
	UIActivityIndicatorView	*spinner;
	
	id callbackObject;
	SEL callbackSelector;
	NSURLConnection *objUrlConnection;
	UIView *_blockerView;
	
}

@property (nonatomic, retain) UIView *_blockerView;
@property (nonatomic, retain) NSString *facebookClientID;
@property (nonatomic, retain) NSString *redirectUri;
@property (nonatomic, retain) NSString *accessToken;
@property (nonatomic, retain) UIWebView *webView;
@property (assign) id callbackObject;
@property (assign) SEL callbackSelector;



- (id)initWithFbClientID:fbcid;
- (void)authenticateUserWithCallbackObject:(id)anObject andSelector:(SEL)selector andExtendedPermissions:(NSString *)extended_permissions andSuperView:(UIView *)super_view webFrame:(CGRect)webFrame;
- (FbGraphResponse *)doGraphGet:(NSString *)action withGetVars:(NSDictionary *)get_vars;
- (FbGraphResponse *)doGraphGetWithUrlString:(NSString *)url_string;
- (FbGraphResponse *)doGraphPost:(NSString *)action withPostVars:(NSDictionary *)post_vars;
@end
