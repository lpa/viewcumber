/*
 * FeatureFile.j
 * ViewCumber
 * 
 * Model object representing a Feature File
 */


@import <Foundation/CPObject.j>

@implementation FeatureFile : CPObject
{
  CPString _title @accessors(property=title);
  CPArray _scenarios;
}

+ (CPArray)featureFilesFromCucumberJSON:(Object)json
{
  var files = [CPArray arrayWithArray:[]];

  for(var i = 0; i < json.features.length; i++) {
    [files addObject:[FeatureFile featureFileFromCucumberJSON:json.features[i]]];
  }

  return files;
}

+ (id)featureFileFromCucumberJSON:(Object)json
{
  var scenarios = (json.elements) ? [Scenario scenariosFromCucumberJSON:json.elements] : [CPArray arrayWithArray:[]];  
  var title = json.name.split("\n")[0]; // name includes the business value
  var file = [FeatureFile featureFileWithTitle:title 
                                     scenarios:scenarios];
  return file;
}

+ (id)featureFileWithTitle:(CPString)title scenarios:(CPArray)scenarios
{
  var file = [[FeatureFile alloc] initWithScenarios:scenarios];
  [file setTitle: title];
  return file;
}

- (id)initWithScenarios:(CPArray)scenarios
{
  self = [super init];
  if(self) {
    _scenarios = scenarios;
  }
  return self;
}

- (CPArray)scenarios
{
  return _scenarios;
}

- (int)scenariosCount
{
  return [_scenarios count];
}


@end
