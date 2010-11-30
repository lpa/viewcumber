@STATIC;1.0;p;6;main.jt;267;@STATIC;1.0;I;23;Foundation/Foundation.jI;15;AppKit/AppKit.ji;15;AppController.jt;181;
objj_executeFile("Foundation/Foundation.j",NO);
objj_executeFile("AppKit/AppKit.j",NO);
objj_executeFile("AppController.j",YES);
main=function(_1,_2){
CPApplicationMain(_1,_2);
};
p;15;AppController.jt;3873;@STATIC;1.0;I;23;Foundation/Foundation.jI;22;AppKit/CPOutlineView.ji;13;FeatureFile.ji;31;FeaturesOutlineViewController.ji;10;Scenario.ji;29;ScenarioTableViewController.ji;20;MailViewController.jI;19;Foundation/CPDate.jt;3647;
objj_executeFile("Foundation/Foundation.j",NO);
objj_executeFile("AppKit/CPOutlineView.j",NO);
objj_executeFile("FeatureFile.j",YES);
objj_executeFile("FeaturesOutlineViewController.j",YES);
objj_executeFile("Scenario.j",YES);
objj_executeFile("ScenarioTableViewController.j",YES);
objj_executeFile("MailViewController.j",YES);
objj_executeFile("Foundation/CPDate.j",NO);
var _1=objj_allocateClassPair(CPObject,"AppController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("theWindow"),new objj_ivar("searchField"),new objj_ivar("webView"),new objj_ivar("stvc"),new objj_ivar("scenarioTableView"),new objj_ivar("fovc"),new objj_ivar("featuresOutlineView"),new objj_ivar("mailWindow"),new objj_ivar("mailViewController")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("awakeFromCib"),function(_3,_4){
with(_3){
fovc=objj_msgSend(objj_msgSend(FeaturesOutlineViewController,"alloc"),"initWithOutlineView:searchField:",featuresOutlineView,searchField);
objj_msgSend(fovc,"setDelegate:",_3);
stvc=objj_msgSend(objj_msgSend(ScenarioTableViewController,"alloc"),"initWithTableView:",scenarioTableView);
objj_msgSend(stvc,"setDelegate:",_3);
var _5=objj_msgSend(objj_msgSend(AppController,"baseURL"),"stringByAppendingString:","results.json");
var _6=objj_msgSend(CPURLRequest,"requestWithURL:",objj_msgSend(CPURL,"URLWithString:",_5));
var _7=objj_msgSend(objj_msgSend(CPURLConnection,"alloc"),"initWithRequest:delegate:",_6,_3);
objj_msgSend(theWindow,"setFullBridge:",YES);
mailViewController=objj_msgSend(objj_msgSend(MailViewController,"alloc"),"initWithCibName:bundle:","MailView",nil);
mailWindow=objj_msgSend(objj_msgSend(CPWindow,"alloc"),"initWithContentRect:styleMask:",CGRectMakeZero(),CPClosableWindowMask|CPResizableWindowMask);
var _8=700;
var _9=(objj_msgSend(theWindow,"frame").size.width/2)-(_8/2);
objj_msgSend(mailWindow,"setFrameOrigin:",CGPointMake(_9,100));
objj_msgSend(mailWindow,"setFrameSize:",CGSizeMake(700,600));
objj_msgSend(objj_msgSend(mailWindow,"contentView"),"addSubview:",objj_msgSend(mailViewController,"view"));
}
}),new objj_method(sel_getUid("scenarioWasSelected:"),function(_a,_b,_c){
with(_a){
objj_msgSend(stvc,"setScenario:",_c);
}
}),new objj_method(sel_getUid("stepWasSelected:"),function(_d,_e,_f){
with(_d){
var url=objj_msgSend(objj_msgSend(AppController,"resultsDirURL"),"stringByAppendingString:",objj_msgSend(_f,"htmlFilename"));
if(url!=objj_msgSend(webView,"mainFrameURL")){
objj_msgSend(webView,"setMainFrameURL:",url);
}
objj_msgSend(mailViewController,"setStep:",_f);
}
}),new objj_method(sel_getUid("stepWasDoubleClicked:"),function(_10,_11,_12){
with(_10){
objj_msgSend(mailWindow,"orderFront:",_10);
}
}),new objj_method(sel_getUid("connection:didFailWithError:"),function(_13,_14,_15,_16){
with(_13){
CPLog("ERROR: %@",_16);
}
}),new objj_method(sel_getUid("connection:didReceiveData:"),function(_17,_18,_19,_1a){
with(_17){
try{
var _1b=objj_msgSend(FeatureFile,"featureFilesFromCucumberJSON:",JSON.parse(_1a));
objj_msgSend(fovc,"setFeatureFiles:",_1b);
}
catch(e){
}
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("baseURL"),function(_1c,_1d){
with(_1c){
if(!window.ViewCumberBaseURL){
var _1e=window.location.href.split("/");
_1e.pop();
window.ViewCumberBaseURL=objj_msgSend(CPString,"stringWithString:",(_1e.join("/")+"/"));
}
return window.ViewCumberBaseURL;
}
}),new objj_method(sel_getUid("resultsDirURL"),function(_1f,_20){
with(_1f){
if(!window.ViewCumberResultsDirURL){
window.ViewCumberResultsDirURL=objj_msgSend(objj_msgSend(AppController,"baseURL"),"stringByAppendingString:","results/");
}
return window.ViewCumberResultsDirURL;
}
})]);
p;13;FeatureFile.jt;1796;@STATIC;1.0;I;21;Foundation/CPObject.jt;1751;
objj_executeFile("Foundation/CPObject.j",NO);
var _1=objj_allocateClassPair(CPObject,"FeatureFile"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("_title"),new objj_ivar("_scenarios")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("title"),function(_3,_4){
with(_3){
return _title;
}
}),new objj_method(sel_getUid("setTitle:"),function(_5,_6,_7){
with(_5){
_title=_7;
}
}),new objj_method(sel_getUid("initWithScenarios:"),function(_8,_9,_a){
with(_8){
_8=objj_msgSendSuper({receiver:_8,super_class:objj_getClass("FeatureFile").super_class},"init");
if(_8){
_scenarios=_a;
}
return _8;
}
}),new objj_method(sel_getUid("scenarios"),function(_b,_c){
with(_b){
return _scenarios;
}
}),new objj_method(sel_getUid("scenariosCount"),function(_d,_e){
with(_d){
return objj_msgSend(_scenarios,"count");
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("featureFilesFromCucumberJSON:"),function(_f,_10,_11){
with(_f){
var _12=objj_msgSend(CPArray,"arrayWithArray:",[]);
for(var i=0;i<_11.features.length;i++){
objj_msgSend(_12,"addObject:",objj_msgSend(FeatureFile,"featureFileFromCucumberJSON:",_11.features[i]));
}
return _12;
}
}),new objj_method(sel_getUid("featureFileFromCucumberJSON:"),function(_13,_14,_15){
with(_13){
var _16=(_15.elements)?objj_msgSend(Scenario,"scenariosFromCucumberJSON:",_15.elements):objj_msgSend(CPArray,"arrayWithArray:",[]);
var _17=_15.name.split("\n")[0];
var _18=objj_msgSend(FeatureFile,"featureFileWithTitle:scenarios:",_17,_16);
return _18;
}
}),new objj_method(sel_getUid("featureFileWithTitle:scenarios:"),function(_19,_1a,_1b,_1c){
with(_19){
var _1d=objj_msgSend(objj_msgSend(FeatureFile,"alloc"),"initWithScenarios:",_1c);
objj_msgSend(_1d,"setTitle:",_1b);
return _1d;
}
})]);
p;10;Scenario.jt;1377;@STATIC;1.0;I;21;Foundation/CPObject.ji;6;Step.jt;1322;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("Step.j",YES);
var _1=objj_allocateClassPair(CPObject,"Scenario"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("_title"),new objj_ivar("_steps")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("title"),function(_3,_4){
with(_3){
return _title;
}
}),new objj_method(sel_getUid("setTitle:"),function(_5,_6,_7){
with(_5){
_title=_7;
}
}),new objj_method(sel_getUid("steps"),function(_8,_9){
with(_8){
return _steps;
}
}),new objj_method(sel_getUid("setSteps:"),function(_a,_b,_c){
with(_a){
_steps=_c;
}
}),new objj_method(sel_getUid("stepsCount"),function(_d,_e){
with(_d){
return objj_msgSend(_steps,"count");
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("scenariosFromCucumberJSON:"),function(_f,_10,_11){
with(_f){
var _12=objj_msgSend(CPArray,"arrayWithArray:",[]);
for(var i=0;i<_11.length;i++){
objj_msgSend(_12,"addObject:",objj_msgSend(Scenario,"scenarioFromCucumberJSON:",_11[i]));
}
return _12;
}
}),new objj_method(sel_getUid("scenarioFromCucumberJSON:"),function(_13,_14,_15){
with(_13){
var _16=objj_msgSend(Step,"stepsFromCucumberJSON:",_15.steps);
var _17=objj_msgSend(objj_msgSend(Scenario,"alloc"),"init");
objj_msgSend(_17,"setTitle:",_15.name);
objj_msgSend(_17,"setSteps:",_16);
return _17;
}
})]);
p;6;Step.jt;1368;@STATIC;1.0;I;21;Foundation/CPObject.ji;7;Email.jt;1312;
objj_executeFile("Foundation/CPObject.j",NO);
objj_executeFile("Email.j",YES);
var _1=objj_allocateClassPair(CPObject,"Step"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("_title"),new objj_ivar("_keyword"),new objj_ivar("_htmlFilename"),new objj_ivar("_emails")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("title"),function(_3,_4){
with(_3){
return _title;
}
}),new objj_method(sel_getUid("keyword"),function(_5,_6){
with(_5){
return _keyword;
}
}),new objj_method(sel_getUid("htmlFilename"),function(_7,_8){
with(_7){
return _htmlFilename;
}
}),new objj_method(sel_getUid("emails"),function(_9,_a){
with(_9){
return _emails;
}
}),new objj_method(sel_getUid("initWithCucumberJSON:"),function(_b,_c,_d){
with(_b){
_b=objj_msgSendSuper({receiver:_b,super_class:objj_getClass("Step").super_class},"init");
if(_b){
_title=_d.name;
_keyword=_d.keyword;
_htmlFilename=_d.html_file;
_emails=objj_msgSend(Email,"emailsFromCucumberJSON:",_d.emails);
}
return _b;
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("stepsFromCucumberJSON:"),function(_e,_f,_10){
with(_e){
var _11=objj_msgSend(CPArray,"arrayWithArray:",[]);
for(var i=0;i<_10.length;i++){
objj_msgSend(_11,"addObject:",objj_msgSend(objj_msgSend(Step,"alloc"),"initWithCucumberJSON:",_10[i]));
}
return _11;
}
})]);
p;7;Email.jt;1850;@STATIC;1.0;I;21;Foundation/CPObject.jt;1805;
objj_executeFile("Foundation/CPObject.j",NO);
var _1=objj_allocateClassPair(CPObject,"Email"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("to"),new objj_ivar("from"),new objj_ivar("subject"),new objj_ivar("htmlFilename"),new objj_ivar("textFilename"),new objj_ivar("_fromStringValue"),new objj_ivar("_toStringValue")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("subject"),function(_3,_4){
with(_3){
return subject;
}
}),new objj_method(sel_getUid("setSubject:"),function(_5,_6,_7){
with(_5){
subject=_7;
}
}),new objj_method(sel_getUid("initWithCucumberJSON:"),function(_8,_9,_a){
with(_8){
_8=objj_msgSendSuper({receiver:_8,super_class:objj_getClass("Email").super_class},"init");
if(_8){
to=objj_msgSend(CPArray,"arrayWithArray:",_a.to);
from=objj_msgSend(CPArray,"arrayWithArray:",_a.from);
subject=_a.subject;
htmlFilename=_a.body.html;
textFilename=_a.body.text;
}
return _8;
}
}),new objj_method(sel_getUid("fromStringValue"),function(_b,_c){
with(_b){
if(!_fromStringValue){
_fromStringValue=objj_msgSend(to,"componentsJoinedByString:",", ");
}
return _fromStringValue;
}
}),new objj_method(sel_getUid("toStringValue"),function(_d,_e){
with(_d){
if(!_toStringValue){
_toStringValue=objj_msgSend(to,"componentsJoinedByString:",", ");
}
return _toStringValue;
}
}),new objj_method(sel_getUid("htmlURL"),function(_f,_10){
with(_f){
return objj_msgSend(objj_msgSend(AppController,"resultsDirURL"),"stringByAppendingString:",htmlFilename);
}
})]);
class_addMethods(_2,[new objj_method(sel_getUid("emailsFromCucumberJSON:"),function(_11,_12,_13){
with(_11){
var _14=objj_msgSend(CPArray,"arrayWithArray:",[]);
for(var i=0;i<_13.length;i++){
objj_msgSend(_14,"addObject:",objj_msgSend(objj_msgSend(Email,"alloc"),"initWithCucumberJSON:",_13[i]));
}
return _14;
}
})]);
p;31;FeaturesOutlineViewController.jt;5802;@STATIC;1.0;I;21;Foundation/CPObject.jt;5757;
objj_executeFile("Foundation/CPObject.j",NO);
var _1=objj_allocateClassPair(CPObject,"FeaturesOutlineViewController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("_outlineView"),new objj_ivar("_searchField"),new objj_ivar("_featureFiles"),new objj_ivar("_allFeatures"),new objj_ivar("_isSearching"),new objj_ivar("_searchResults"),new objj_ivar("_delegate")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("outlineView"),function(_3,_4){
with(_3){
return _outlineView;
}
}),new objj_method(sel_getUid("searchField"),function(_5,_6){
with(_5){
return _searchField;
}
}),new objj_method(sel_getUid("featureFiles"),function(_7,_8){
with(_7){
return _featureFiles;
}
}),new objj_method(sel_getUid("setFeatureFiles:"),function(_9,_a,_b){
with(_9){
_featureFiles=_b;
}
}),new objj_method(sel_getUid("delegate"),function(_c,_d){
with(_c){
return _delegate;
}
}),new objj_method(sel_getUid("setDelegate:"),function(_e,_f,_10){
with(_e){
_delegate=_10;
}
}),new objj_method(sel_getUid("initWithOutlineView:searchField:"),function(_11,_12,_13,_14){
with(_11){
_11=objj_msgSendSuper({receiver:_11,super_class:objj_getClass("FeaturesOutlineViewController").super_class},"init");
if(_11){
_featureFiles=objj_msgSend(CPArray,"arrayWithArray:",[]);
_isSearching=NO;
_searchField=_14;
objj_msgSend(_searchField,"setTarget:",_11);
objj_msgSend(_searchField,"setAction:",sel_getUid("didTypeSearch:"));
_outlineView=_13;
objj_msgSend(_outlineView,"setDelegate:",_11);
objj_msgSend(_outlineView,"setDataSource:",_11);
objj_msgSend(_outlineView,"setBackgroundColor:",objj_msgSend(CPColor,"colorWithHexString:","eef2f8"));
objj_msgSend(objj_msgSend(objj_msgSend(_outlineView,"enclosingScrollView"),"superview"),"setBackgroundColor:",objj_msgSend(CPColor,"colorWithHexString:","eef2f8"));
var _15=objj_msgSend(_outlineView,"tableColumnWithIdentifier:","name");
var _16=objj_msgSend(_15,"dataView");
objj_msgSend(_16,"setValue:forThemeAttribute:inState:",objj_msgSend(CPColor,"colorWithCalibratedRed:green:blue:alpha:",71/255,90/255,102/255,1),"text-color",CPThemeStateTableDataView);
objj_msgSend(_16,"setValue:forThemeAttribute:inState:",objj_msgSend(CPColor,"colorWithCalibratedWhite:alpha:",1,1),"text-shadow-color",CPThemeStateTableDataView);
objj_msgSend(_16,"setValue:forThemeAttribute:inState:",CGSizeMake(0,1),"text-shadow-offset",CPThemeStateTableDataView);
objj_msgSend(_16,"setValue:forThemeAttribute:inState:",objj_msgSend(CPColor,"colorWithCalibratedWhite:alpha:",1,1),"text-color",CPThemeStateTableDataView|CPThemeStateSelectedTableDataView);
objj_msgSend(_16,"setValue:forThemeAttribute:inState:",objj_msgSend(CPColor,"colorWithCalibratedWhite:alpha:",0,0.5),"text-shadow-color",CPThemeStateTableDataView|CPThemeStateSelectedTableDataView);
objj_msgSend(_16,"setValue:forThemeAttribute:inState:",CGSizeMake(0,-1),"text-shadow-offset",CPThemeStateTableDataView|CPThemeStateSelectedTableDataView);
objj_msgSend(_15,"setDataView:",_16);
}
return _11;
}
}),new objj_method(sel_getUid("setFeatureFiles:"),function(_17,_18,_19){
with(_17){
_featureFiles=_19;
var _1a=objj_msgSend(objj_msgSend(CPSortDescriptor,"alloc"),"initWithKey:ascending:","title",YES);
objj_msgSend(_featureFiles,"sortUsingDescriptors:",[_1a]);
objj_msgSend(_17,"reloadAllFeatures");
objj_msgSend(_outlineView,"reloadData");
}
}),new objj_method(sel_getUid("didTypeSearch:"),function(_1b,_1c,_1d){
with(_1b){
var _1e=objj_msgSend(_searchField,"stringValue");
if(_1e==""){
_isSearching=NO;
}else{
var _1f=[];
var _20=objj_msgSend(_allFeatures,"count");
console.log(_20);
for(var i=0;i<_20;i++){
var obj=objj_msgSend(_allFeatures,"objectAtIndex:",i);
if(objj_msgSend(obj,"title").match(new RegExp(_1e,"i"))){
_1f.push(obj);
}
}
_searchResults=_1f;
_isSearching=YES;
}
objj_msgSend(_outlineView,"reloadData");
}
}),new objj_method(sel_getUid("reloadAllFeatures"),function(_21,_22){
with(_21){
_allFeatures=objj_msgSend(CPArray,"arrayWithArray:",[]);
for(var i=0;i<objj_msgSend(_featureFiles,"count");i++){
objj_msgSend(_allFeatures,"addObjectsFromArray:",objj_msgSend(objj_msgSend(_featureFiles,"objectAtIndex:",i),"scenarios"));
}
var _23=objj_msgSend(objj_msgSend(CPSortDescriptor,"alloc"),"initWithKey:ascending:","title",YES);
objj_msgSend(_allFeatures,"sortUsingDescriptors:",[_23]);
}
}),new objj_method(sel_getUid("outlineView:child:ofItem:"),function(_24,_25,_26,_27,_28){
with(_24){
if(_isSearching){
return objj_msgSend(_searchResults,"objectAtIndex:",_27);
}else{
if(_28==NULL){
return objj_msgSend(_featureFiles,"objectAtIndex:",_27);
}else{
return objj_msgSend(objj_msgSend(_28,"scenarios"),"objectAtIndex:",_27);
}
}
}
}),new objj_method(sel_getUid("outlineView:isItemExpandable:"),function(_29,_2a,_2b,_2c){
with(_29){
return objj_msgSend(_2c,"isKindOfClass:",objj_msgSend(FeatureFile,"class"));
}
}),new objj_method(sel_getUid("outlineView:numberOfChildrenOfItem:"),function(_2d,_2e,_2f,_30){
with(_2d){
if(_isSearching){
return objj_msgSend(_searchResults,"count");
}else{
if(_30==NULL){
return objj_msgSend(_featureFiles,"count");
}else{
if(objj_msgSend(_30,"isKindOfClass:",objj_msgSend(FeatureFile,"class"))){
return objj_msgSend(_30,"scenariosCount");
}
}
}
}
}),new objj_method(sel_getUid("outlineView:objectValueForTableColumn:byItem:"),function(_31,_32,_33,_34,_35){
with(_31){
return objj_msgSend(_35,"title");
}
}),new objj_method(sel_getUid("outlineViewSelectionDidChange:"),function(_36,_37,_38){
with(_36){
var _39=objj_msgSend(_38,"object");
var _3a=objj_msgSend(_39,"itemAtRow:",objj_msgSend(_39,"selectedRow"));
if(_delegate&&objj_msgSend(_delegate,"respondsToSelector:",sel_getUid("scenarioWasSelected:"))&&objj_msgSend(_3a,"isKindOfClass:",objj_msgSend(Scenario,"class"))){
objj_msgSend(_delegate,"scenarioWasSelected:",_3a);
}
}
})]);
p;29;ScenarioTableViewController.jt;2951;@STATIC;1.0;I;21;Foundation/CPObject.jt;2906;
objj_executeFile("Foundation/CPObject.j",NO);
var _1=objj_allocateClassPair(CPObject,"ScenarioTableViewController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("tableView"),new objj_ivar("_scenario"),new objj_ivar("_delegate")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("tableView"),function(_3,_4){
with(_3){
return tableView;
}
}),new objj_method(sel_getUid("scenario"),function(_5,_6){
with(_5){
return _scenario;
}
}),new objj_method(sel_getUid("setScenario:"),function(_7,_8,_9){
with(_7){
_scenario=_9;
}
}),new objj_method(sel_getUid("delegate"),function(_a,_b){
with(_a){
return _delegate;
}
}),new objj_method(sel_getUid("setDelegate:"),function(_c,_d,_e){
with(_c){
_delegate=_e;
}
}),new objj_method(sel_getUid("initWithTableView:"),function(_f,_10,_11){
with(_f){
_f=objj_msgSend(_f,"init");
if(_f){
tableView=_11;
objj_msgSend(tableView,"setDelegate:",_f);
objj_msgSend(tableView,"setDataSource:",_f);
objj_msgSend(tableView,"setTarget:",_f);
objj_msgSend(tableView,"setDoubleAction:",sel_getUid("rowDoubleClicked:"));
}
return _f;
}
}),new objj_method(sel_getUid("setScenario:"),function(_12,_13,_14){
with(_12){
_scenario=_14;
objj_msgSend(tableView,"reloadData");
var _15=objj_msgSend(CPIndexSet,"indexSetWithIndex:",0);
objj_msgSend(tableView,"selectRowIndexes:byExtendingSelection:",_15,NO);
objj_msgSend(_12,"sendDelegateStepWasSelected:",objj_msgSend(objj_msgSend(_scenario,"steps"),"objectAtIndex:",0));
}
}),new objj_method(sel_getUid("numberOfRowsInTableView:"),function(_16,_17,_18){
with(_16){
return objj_msgSend(_scenario,"stepsCount");
}
}),new objj_method(sel_getUid("tableView:objectValueForTableColumn:row:"),function(_19,_1a,_1b,_1c,_1d){
with(_19){
var _1e=objj_msgSend(objj_msgSend(_scenario,"steps"),"objectAtIndex:",_1d);
if(objj_msgSend(_1c,"identifier")==="title"){
return objj_msgSend(_1e,"title");
}else{
if(objj_msgSend(_1c,"identifier")==="keyword"){
return objj_msgSend(_1e,"keyword");
}
}
}
}),new objj_method(sel_getUid("tableViewSelectionDidChange:"),function(_1f,_20,_21){
with(_1f){
objj_msgSend(_1f,"sendDelegateStepWasSelected:",objj_msgSend(objj_msgSend(_scenario,"steps"),"objectAtIndex:",objj_msgSend(tableView,"selectedRow")));
}
}),new objj_method(sel_getUid("sendDelegateStepWasSelected:"),function(_22,_23,_24){
with(_22){
if(_delegate&&objj_msgSend(_delegate,"respondsToSelector:",(sel_getUid("stepWasSelected:")))){
objj_msgSend(_delegate,"stepWasSelected:",objj_msgSend(objj_msgSend(_scenario,"steps"),"objectAtIndex:",objj_msgSend(tableView,"selectedRow")));
}
}
}),new objj_method(sel_getUid("rowDoubleClicked:"),function(_25,_26,_27){
with(_25){
if(_delegate&&objj_msgSend(_delegate,"respondsToSelector:",(sel_getUid("stepWasDoubleClicked:")))){
objj_msgSend(_delegate,"stepWasDoubleClicked:",objj_msgSend(objj_msgSend(_scenario,"steps"),"objectAtIndex:",objj_msgSend(tableView,"selectedRow")));
}
}
})]);
p;20;MailViewController.jt;1747;@STATIC;1.0;I;25;AppKit/CPViewController.ji;6;Step.jt;1688;
objj_executeFile("AppKit/CPViewController.j",NO);
objj_executeFile("Step.j",YES);
var _1=objj_allocateClassPair(CPViewController,"MailViewController"),_2=_1.isa;
class_addIvars(_1,[new objj_ivar("tableView"),new objj_ivar("webView"),new objj_ivar("_step")]);
objj_registerClassPair(_1);
class_addMethods(_1,[new objj_method(sel_getUid("step"),function(_3,_4){
with(_3){
return _step;
}
}),new objj_method(sel_getUid("setStep:"),function(_5,_6,_7){
with(_5){
_step=_7;
}
}),new objj_method(sel_getUid("init"),function(_8,_9){
with(_8){
objj_msgSend(_8,"initWithCibName:bundle:","MailView",nil);
}
}),new objj_method(sel_getUid("setStep:"),function(_a,_b,_c){
with(_a){
console.log("Setting step: "+objj_msgSend(_c,"emails"));
_step=_c;
objj_msgSend(tableView,"reloadData");
}
}),new objj_method(sel_getUid("numberOfRowsInTableView:"),function(_d,_e,_f){
with(_d){
return objj_msgSend(objj_msgSend(_step,"emails"),"count");
}
}),new objj_method(sel_getUid("tableView:objectValueForTableColumn:row:"),function(_10,_11,_12,_13,_14){
with(_10){
var _15;
var _16=objj_msgSend(objj_msgSend(_step,"emails"),"objectAtIndex:",_14);
var cid=objj_msgSend(_13,"identifier");
console.log(objj_msgSend(_16,"htmlURL"));
if(cid==="to"){
_15=objj_msgSend(_16,"toStringValue");
}else{
if(cid==="from"){
_15=objj_msgSend(_16,"fromStringValue");
}else{
if(cid==="subject"){
_15=objj_msgSend(_16,"subject");
}
}
}
return _15;
}
}),new objj_method(sel_getUid("tableViewSelectionDidChange:"),function(_17,_18,_19){
with(_17){
var _1a=objj_msgSend(objj_msgSend(_step,"emails"),"objectAtIndex:",objj_msgSend(tableView,"selectedRow"));
objj_msgSend(webView,"setMainFrameURL:",objj_msgSend(_1a,"htmlURL"));
}
})]);
