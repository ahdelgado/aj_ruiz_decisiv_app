require "base64"

class Url < ActiveRecord::Base
    
  VALID_URL_REGEX = /\A((http|https):\/\/)?[a-z0-9]+([\-\.]
                      {1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix
                      
  validates :long_url,  presence: true, uniqueness: true,
                    format: { with: VALID_URL_REGEX }
                                          
  
  # Hash long URL into short URL
  def self.generate(long_url)
    url = Url.where(long_url: long_url).create
    
    # Make sure 0 and O are treated identically
    url.long_url = url.long_url.gsub(/[0]/, 'O')
    
    
    short_url = Base64.urlsafe_encode64(long_url)[5..12]
    while short_url.scan(/foo|bar/).size > 0
      short_url = clean(short_url)
    end
    
    url.short_url = "www." << short_url << ".com" 
    url
  end
  
  #Remove inappropriate words (foo and bar) from short URL
  def self.clean(short_url)
      short_url = short_url.split("").shuffle.join
      short_url
  end
            
end
