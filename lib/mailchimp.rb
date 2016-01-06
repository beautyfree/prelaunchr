require 'httparty'

class Mailchimp
  include HTTParty

  def initialize(api_key)
    # Do we have a valid API Key?
    unless api_key =~ /\w+-\w{3}/
      raise StandardError, "Invalid API Key"
    end

    domain = api_key.split('-')[1]
    @auth = {username: 'apikey', password: api_key}

    self.class.base_uri "https://#{domain}.api.mailchimp.com/3.0"
  end

  def list_subscribe(id, query)
    print self.class.post("/lists/#{id}/members", basic_auth: @auth, body: query.to_json)
  end

  def automations_emails_add(id_automation, id_email, query)
    print self.class.post("/automations/#{id_automation}/emails/#{id_email}/queue", basic_auth: @auth, body: query.to_json)
  end



end
