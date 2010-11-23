require 'cucumber'
require 'capybara'
require 'digest/sha1'

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
    make_output_dir
    super(step_mother, File.open(results_filename, 'w+'), options)
    copy_app
  end

  def after_step(step)
    html_file = html_filename_for_step(step)
    @current_step[:html_file] = html_file
    @current_step[:emails] = emails_for_step(step)
    write_step_html_to_file(html_file)
    super
  end

  private

  def emails_for_step(step)
    ActionMailer::Base.deliveries.collect{|mail| mail_as_json(mail) }
  end

  def mail_as_json(mail)
    html_filename = write_email_to_file('text/html', mail)
    text_filename = write_email_to_file('text/plain', mail)
    {
      :to => mail.to,
      :from => mail.from,
      :subject => mail.subject,
      :body => {
        :html => html_filename,
        :text => text_filename
      }
    }
  end

  # Writes the content of the given content type to disk and returns
  # the filename to access it.
  #
  # Returns nil if no file was written.
  def write_email_to_file(content_type, mail)
    mail_part = mail.parts.find{|part| part.content_type.to_s.include? content_type }
    return nil unless mail_part

    contents = mail_part.body.to_s
    filename = Digest::SHA1.hexdigest(contents) + content_type.gsub('/', '.') + ".email.html"

    full_file_path = File.join(output_dir, filename)
    unless File.exists?(full_file_path)
      File.open(full_file_path, 'w+') do |f|
        f << prepare_email_content(content_type, contents)
      end
    end

    filename
  end

  def prepare_email_content(content_type, contents)
    case content_type
    when 'text/html'
      Viewcumber.rewrite_css_and_image_references(contents)
    when 'text/plain'
      "<html><body><pre>#{contents}</pre></body></html>"
    else
      contents
    end
  end

  def write_step_html_to_file(filename)
    File.open(File.join(output_dir, filename), 'w+') do |f|
      f << self.class.last_step_html
    end
  end

  def html_filename_for_step(step)
    step.file_colon_line.gsub(/:|\//,'-') + ".html"
  end

  def results_filename
    @json_file ||= File.join(output_dir, 'results.json')
  end

  def output_dir
    @output_dir ||= File.expand_path("viewcumber")
  end

  def make_output_dir
    FileUtils.mkdir output_dir unless File.directory? output_dir
  end

  def copy_app
    app_dir = File.join(File.dirname(__FILE__), "viewcumber", "app")
    FileUtils.cp_r "#{app_dir}/.", output_dir
    FileUtils.cp_r File.join(Rails.root, "public"), File.join(output_dir, "public")
  end

end
