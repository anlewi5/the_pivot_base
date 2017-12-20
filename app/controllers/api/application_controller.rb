class Api::ApplicationController < ApplicationController
  skip_before_action :authorize!

end
