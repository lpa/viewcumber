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

@implementation AppController : CPObject
{
    CPWindow    					theWindow; 
    CPSearchField 					searchField;
    CPWebView 						webView;
    ScenarioTableViewController 	stvc;
    CPTableView 					scenarioTableView;
    FeaturesOutlineViewController	fovc;
    CPOutlineView 					featuresOutlineView;
    CPString                        baseURL;
}

- (void)awakeFromCib
{
    // Setup the FeatureOutlineViewController.
    fovc = [[FeaturesOutlineViewController alloc] initWithOutlineView:featuresOutlineView];
    [fovc setDelegate:self];

    // Setup the ScenarioTableViewController
    stvc = [[ScenarioTableViewController alloc] initWithTableView:scenarioTableView];
    [stvc setDelegate:self];

	// Start loading our data
    var url = [[self baseURL] stringByAppendingString:"results.json"];
	var request = [CPURLRequest requestWithURL:[CPURL URLWithString:url]];
	var connection = [[CPURLConnection alloc] initWithRequest:request delegate:self];

    // In this case, we want the window from Cib to become our full browser window
    [theWindow setFullBridge:YES];
}

// Delegate method for FeaturesOutlineViewDelegate
- (void)scenarioWasSelected:(Scenario)scenario
{
  [stvc setScenario:scenario];
}

- (void)baseURL
{
  if (!baseURL) {
    var urlChunks = window.location.href.split("/");
    urlChunks.pop();
    baseURL = [CPString stringWithString:(urlChunks.join("/") + "/")];
  }
  return baseURL;
}

- (void)stepWasSelected:(CPString)step
{
  CPLog("Received delegate message: %@", step);
  var url = [[self baseURL] stringByAppendingString:[step htmlFilename]];
  [webView setMainFrameURL:url];
}


// URL Delegate Methods
-(void)connection:(CPURLConnection)connection didFailWithError:(id)error
{
  CPLog("ERROR: %@", error);
}

-(void)connection:(CPURLConnection)connection didReceiveData:(CPString)data;
{
  var featureFiles = [FeatureFile featureFilesFromCucumberJSON:JSON.parse(data)];
  [fovc setFeatureFiles:featureFiles];
}

@end
