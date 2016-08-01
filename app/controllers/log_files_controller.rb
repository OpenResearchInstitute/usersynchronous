class LogFilesController < ApplicationController
  before_action :set_log_file, only: [:show, :edit, :update, :destroy]

  # GET /log_files
  # GET /log_files.json
  def index
    redirect_to user_path(current_user)
  end

  # GET /log_files/1
  # GET /log_files/1.json
  def show
  end

  # GET /log_files/new
  def new
    @log_file = LogFile.new
  end

  # GET /log_files/1/edit
  def edit
  end

  # POST /log_files
  # POST /log_files.json
  def create
    @log_file = LogFile.new(log_file_params)
    @log_file.loggable_type = "User"
    @log_file.loggable_id = current_user.id
        
    respond_to do |format|
      if @log_file.save
        format.html { redirect_to user_log_files(current_user), notice: 'Log file was successfully created.' }
        format.json { render :show, status: :created, location: @log_file }
      else
        format.html { render :new }
        format.json { render json: @log_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /log_files/1
  # PATCH/PUT /log_files/1.json
  def update
    respond_to do |format|
      if @log_file.update(log_file_params)
        format.html { redirect_to @log_file, notice: 'Log file was successfully updated.' }
        format.json { render :show, status: :ok, location: @log_file }
      else
        format.html { render :edit }
        format.json { render json: @log_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /log_files/1
  # DELETE /log_files/1.json
  def destroy
    @log_file.destroy
    respond_to do |format|
      format.html { redirect_to log_files_url, notice: 'Log file was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_log_file
      @log_file = LogFile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def log_file_params
      params.require(:log_file).permit(:log)
    end
end
