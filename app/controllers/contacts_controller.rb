class ContactsController < ApplicationController

    def new 
      @contact = Contact.new
    end
  
    def create     
      @contact = Contact.new(params[:contact])
      @contact.request = request
      if @contact.deliver
        flash.now[:notice] = 'Thank you. Your message has been sent.'
        render :new
      else
        flash.now[:error] = 'Cannot send message. Please contact us directly at https://www.labs.chem-eng.utoronto.ca/edwards/contact/'
        render :new
      end
    end   
end  