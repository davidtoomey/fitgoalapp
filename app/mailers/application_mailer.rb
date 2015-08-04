class ApplicationMailer < ActionMailer::Base
  default from: "d.toomey@temple.edu"
  layout 'mailer'
end
 
# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
end