/*
 * AppController.j
 * ViewCumber
 *
 * Created by You on November 20, 2010.
 * Copyright 2010, Your Company All rights reserved.
 */

@import <Foundation/Foundation.j>
@import <AppKit/CPOutlineView.j>
@import "FeatureFile.j"
@import "FeaturesOutlineViewController.j"
@import "Scenario.j"
@import "ScenarioTableViewController.j"
@import "MailViewController.j"

// Not sure why we need this, but the compiled version requires it
@import <Foundation/CPDate.j>

@implementation AppController : CPObject
{
    CPWindow    					theWindow; 
    CPSearchField 					searchField;
    CPWebView 						webView;
    ScenarioTableViewController 	stvc;
    CPTableView 					scenarioTableView;
    FeaturesOutlineViewController	fovc;
    CPOutlineView 					featuresOutlineView;
    CPWindow                        mailWindow;
    MailViewController              mailViewController;
}

/*
  Returns the base url for the ViewCumber Application
*/
+ (CPString)baseURL
{
  if (!window.ViewCumberBaseURL) {
    var urlChunks = window.location.href.split("/");
    urlChunks.pop();
    window.ViewCumberBaseURL = [CPString stringWithString:(urlChunks.join("/") + "/")];
  }
  return window.ViewCumberBaseURL;
}

/*
  Returns the url to the results directory where the pages and emails live
*/
+ (CPString)resultsDirURL
{
  if (!window.ViewCumberResultsDirURL) {
    window.ViewCumberResultsDirURL = [[AppController baseURL] stringByAppendingString:@"results/"];
  }
  return window.ViewCumberResultsDirURL;
}

- (void)awakeFromCib
{
    // Setup the FeatureOutlineViewController.
    fovc = [[FeaturesOutlineViewController alloc] initWithOutlineView:featuresOutlineView
                                                          searchField:searchField];
    [fovc setDelegate:self];

    // Setup the ScenarioTableViewController
    stvc = [[ScenarioTableViewController alloc] initWithTableView:scenarioTableView];
    [stvc setDelegate:self];

	// Start loading our data
    var url = [[AppController baseURL] stringByAppendingString:"results.json"];
	var request = [CPURLRequest requestWithURL:[CPURL URLWithString:url]];
	var connection = [[CPURLConnection alloc] initWithRequest:request delegate:self];

    // In this case, we want the window from Cib to become our full browser window
    [theWindow setFullBridge:YES];

    mailViewController = [[MailViewController alloc] initWithCibName:@"MailView" bundle:nil];

    mailWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() 
                  styleMask:CPClosableWindowMask | CPResizableWindowMask];
  

    var mailWindowWidth = 700;
    var mailWindowLeft = ([theWindow frame].size.width / 2 ) - (mailWindowWidth / 2);

    [mailWindow setFrameOrigin:CGPointMake(mailWindowLeft, 100)];
    [mailWindow setFrameSize:CGSizeMake(700, 600)];

    [[mailWindow contentView] addSubview:[mailViewController view]];
}

// Delegate method for FeaturesOutlineViewDelegate
- (void)scenarioWasSelected:(Scenario)scenario
{
  [stvc setScenario:scenario];
}


- (void)stepWasSelected:(Step)step
{
  var url = [[AppController resultsDirURL] stringByAppendingString:[step htmlFilename]];
  if(url != [webView mainFrameURL]) {
    [webView setMainFrameURL:url];
  }
  [mailViewController setStep:step];
}

- (void)stepWasDoubleClicked:(Step)step
{
  [mailWindow orderFront:self];
}


// URL Delegate Methods
-(void)connection:(CPURLConnection)connection didFailWithError:(id)error
{
  CPLog("ERROR: %@", error);
}

-(void)connection:(CPURLConnection)connection didReceiveData:(CPString)data;
{
  try {
    var featureFiles = [FeatureFile featureFilesFromCucumberJSON:JSON.parse(data)];
    [fovc setFeatureFiles:featureFiles];
  } catch(e) {

  }
}

@end
