class FeedbackController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def message
    puts "get message============>>>>>>>>> #{params}"
    render :nothing => true
  end
end
