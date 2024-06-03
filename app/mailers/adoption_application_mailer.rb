class AdoptionApplicationMailer < ApplicationMailer
    default from: 'notifications@petnetwork.com'
  
    def application_approved(adoption_application)
      @adoption_application = adoption_application
      @adopter = adoption_application.adopter
      @pet = adoption_application.pet
      mail(to: @adopter.user.email, subject: 'Your Adoption Application is Approved')
    end
  
    def application_denied(adoption_application)
      @adoption_application = adoption_application
      @adopter = adoption_application.adopter
      @pet = adoption_application.pet
      mail(to: @adopter.user.email, subject: 'Your Adoption Application is Denied')
    end
  
    def application_pending(adoption_application)
      @adoption_application = adoption_application
      @adopter = adoption_application.adopter
      @pet = adoption_application.pet
      mail(to: @adopter.user.email, subject: 'Your Adoption Application is Pending')
    end
  end
  