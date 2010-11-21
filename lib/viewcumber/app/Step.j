@import <Foundation/CPObject.j>

@implementation Step : CPObject
{
  CPString _title @accessors(property=title, readonly);
  CPString _keyword @accessors(property=keyword, readonly);
  CPString _htmlFilename @accessors(property=htmlFilename, readonly);
}

+ (CPArray)stepsFromCucumberJSON:(Object)json
{
  var steps = [CPArray arrayWithArray:[]];

  for(var i = 0; i < json.length; i++) {
    [steps addObject:[[Step alloc] initWithCucumberJSON:json[i]]];
  }

  return steps;
}

- (id)initWithCucumberJSON:(Object)json
{
  self = [super init];
  if(self) {
	_title = json.name;
	_keyword = json.keyword;
	_htmlFilename = json.html_file;
  }
  return self;
}

@end

