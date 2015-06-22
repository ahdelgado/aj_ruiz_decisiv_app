require "base64"

class Url < ActiveRecord::Base
    
  VALID_URL_REGEX = /\A((http|https):\/\/)?[a-z0-9]+([\-\.]
                      {1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix
                      
  validates :long_url,  presence: true, uniqueness: true,
                    format: { with: VALID_URL_REGEX }
                                          
  def self.generate(long_url)
    url = Url.where(long_url: long_url).create
    
    # Make sure 0 and O are treated identically
    url.long_url = url.long_url.gsub(/[0]/, 'O')
    
    url.short_url = Base64.urlsafe_encode64(long_url)[5..12]
    url.short_url = "www." << url.short_url << ".com" 
    
            
    url
  end
            
end
