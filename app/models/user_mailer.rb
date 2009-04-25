class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'  
    @body[:url]  = activate_url(:activation_code => user.activation_code, :host => $DEFAULT_HOST)  
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = base_url(:host => $DEFAULT_HOST)
  end
  
  protected
    def setup_email(user)
      @recipients  = "#{user.login} <#{user.email}>"
      @from        = "Rosettasaurus <feedback@rosettasaurus.com>"
      @subject     = "rosettasaurus | "
      @sent_on     = Time.now
      @body[:user] = user
    end
end
