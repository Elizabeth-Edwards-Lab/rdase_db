class Contact < MailForm::Base
    attribute :name,      :validate => true
    attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
    attribute :file,      :attachment => true
    attribute :message
    attribute :nickname,  :captcha  => true
    append :remote_ip, :user_agent, :session
  
    def headers
      {
        :subject => 'RDaseDB Contact Form Submitted',
        :to => Rails.configuration.x.contact_to
      }
    end
  end