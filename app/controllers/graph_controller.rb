class GraphController < ApplicationController
  def index
  end

  def data

    qsos = [
      {
        'satellite': 'phase4',
        'mode': 'voice',
        'duration': 20,
        'station': 'N1NLY'
      },
      {
        'satellite': 'phase4',
        'mode': 'data',
        'duration': 600,
        'station': 'N1NLY'
      },
      {
        'satellite': 'phase4',
        'mode': 'voice',
        'duration': 60,
        'station': 'N1NLY'
      }
    ]

    respond_to do |format|
      format.json {
        render json: qsos
      }
    end
  end
  
end
