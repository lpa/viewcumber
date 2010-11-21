require 'cucumber'
require 'capybara'

require 'cucumber/formatter/json'
require 'fileutils'

if respond_to? :AfterStep
  AfterStep do |scenario|
    begin
      if !@email.blank?
        Viewcumber.last_step_html = Viewcumber.rewrite_css_and_image_references(@email)
        @email = nil
      elsif Capybara.page.driver.respond_to? :html
        Viewcumber.last_step_html = Viewcumber.rewrite_css_and_image_references(Capybara.page.driver.html.to_s)
      end
    rescue Exception => e
      p e
    end
  end
end

class Viewcumber < Cucumber::Formatter::Json

 class << self
   attr_accessor :last_step_html

  def rewrite_css_and_image_references(response_html) # :nodoc:
     return response_html unless Capybara.asset_root
     directories = Dir.new(Capybara.asset_root).entries.inject([]) do |list, name|
       list << name if File.directory?(name) and not name.to_s =~ /^\./
       list
     end
     response_html.gsub!(/("|')\/(#{directories.join('|')})/, '\1public/\2')
     response_html.gsub(/("|')http:\/\/.*\/images/, '\1public/images') 
   end    
 end

 def initialize(step_mother, path_or_io, options)
   FileUtils.mkdir "viewcumber/" unless File.directory? "viewcumber/"
   super(step_mother, File.open("viewcumber/" + "results.json", 'w+'), options)
 end

end
