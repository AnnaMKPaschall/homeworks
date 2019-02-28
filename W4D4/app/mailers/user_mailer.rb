class UserMailer < ApplicationMailer
    default from: "from@example.com"
    def welcome_email 
        @user = user 
        @url = from@example.com 
        mail(to: everybody@appacademy.io subject: "This is a test")
    end 
end
