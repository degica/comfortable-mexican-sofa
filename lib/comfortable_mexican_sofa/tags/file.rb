class ComfortableMexicanSofa::Tag::File
  include ComfortableMexicanSofa::Tag
  
  def self.regex_tag_signature(label = nil)
    label ||= /[\w\-\.]+/
    /\{\{\s*cms:file:(#{label}):?(.*?)\s*\}\}/
  end
  
  # Initializing Cms::File object
  def file
    page.site.files.detect{|f| f.file_file_name == self.label.to_s}
  end
  
  def content
    return unless file
    
    format  = params[0]
    text    = params[1] || label
    
    case format
    when 'link'
      "<a href='#{file.file.url}' target='_blank'>#{text}</a>"
    when 'image'
      "<img src='#{file.file.url}' alt='#{text}' />"
    else
      file.file.url
    end
  end
end