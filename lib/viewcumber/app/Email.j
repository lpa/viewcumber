@import <Foundation/CPObject.j>

@implementation Email : CPObject
{
  CPArray   to;
  CPArray   from;
  CPString  subject @accessors;
  CPString  htmlFilename;
  CPString  textFilename;

  CPString  _fromStringValue;
  CPString  _toStringValue;
}

+ (CPArray)emailsFromCucumberJSON:(Object)json
{
  var emails = [CPArray arrayWithArray:[]];

  for(var i = 0; i < json.length; i++) {
    [emails addObject:[[Email alloc] initWithCucumberJSON:json[i]]];
  }

  return emails;
}

- (id)initWithCucumberJSON:(Object)json
{
  self = [super init];
  if(self) {
    to = [CPArray arrayWithArray:json.to];
    from = [CPArray arrayWithArray:json.from];
    subject = json.subject;
    htmlFilename = json.body.html;
    textFilename = json.body.text;
  }
  return self;
}

- (CPString)fromStringValue
{
  if(!_fromStringValue) {
    _fromStringValue = [to componentsJoinedByString:@", "];
  }
  return _fromStringValue;
}

- (CPString)toStringValue
{
  if(!_toStringValue) {
    _toStringValue = [to componentsJoinedByString:@", "];
  }
  return _toStringValue;
}

- (CPString)htmlURL
{
  return [[AppController baseURL] stringByAppendingString:htmlFilename];
}

@end
