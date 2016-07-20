class GraphController < ApplicationController
  def index
  end

  def data

    data = {
      "stations":
        [
          { "call": "AI4QR" },
          { "call": "N2NLY" },
          { "call": "N1CKC" },
          { "call": "WA2WGY"}
        ],
      "qsos":
        [
          { "source": 0, "target": 1, "duration": 6, "mode": "data" },
          { "source": 0, "target": 2, "duration": 60, "mode": "voice" },
          { "source": 0, "target": 3, "duration": 600, "mode": "data" }
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
