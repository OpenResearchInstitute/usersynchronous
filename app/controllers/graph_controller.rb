class GraphController < ApplicationController
  def index
  end

  def data

    data_values = []
    
    (1..5).each do
      data_values << rand(10) + 1
    end
    
    respond_to do |format|
      format.json {
        render json: data_values
      }
    end
  end
  
end
