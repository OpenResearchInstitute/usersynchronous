class GraphController < ApplicationController
  def index
  end

  def data

    data = {
      "stations":
        [
          # this is a kluge. Duration for the root node sets the diameter
          { "call": "AI4QR", "duration": 10, "mode": "root"},
          { "call": "N2NLY", "duration": 6, "mode": "data" },
          { "call": "N2NLY", "duration": 60, "mode": "voice"},
          { "call": "N2NLY", "duration": 30, "mode": "data"}
        ],
      "qsos":
        [
          { "source": 0, "target": 1},
          { "source": 0, "target": 2},
          { "source": 0, "target": 3}
        ]
    }

    # something needs to change here
    respond_to do |format|
      format.json {
        render json: data
      }
    end
  end
  
end
