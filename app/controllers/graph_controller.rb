class GraphController < ApplicationController
  def index
  end

  def data

#    qsos = [
#      {
#        'satellite': 'phase4'
#        'mode': 'voice'
#        'duration': 20
#        'station': 'N1NLY'
#      }
#      {
#        'satellite': 'phase4'
#        'mode': 'data'
#        'duration': 600
#        'station': 'N1CKC'
#      }
#      {
#        'satellite': 'phase4'
#        'mode': 'voice'
#        'duration': 60
#        'station': 'WA2WGY'
#      }
#    ]

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
