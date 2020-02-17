class Contact < MailForm::Base
    attribute :name,      :validate => true
    attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
    attribute :file,      :attachment => true
    attribute :message
    attribute :nickname,  :captcha  => true
    append :remote_ip, :user_agent, :session
  
    def headers
      {
        :subject => 'RDDB Contact Form Submitted',
        :to => 'me@herbertm.ca',
        :from => 'rddb@herbertm.ca'
      }
    end
  end