class ReportsController < ApplicationController
  def index
    @Report = Report.all
  end

  def new
    @Report = Report.new
  end

  def edit
    @Report = Report.find(params[:id])
  end

  def update
    @Report = Report.find(params[:id])

    if(@Report.update(Report_params))
      redirect_to @Report
    else
      render 'edit'
    end
  end

  def destroy
    @Report = Report.find(params[:id])

    @Report.destroy
    redirect_to :action => :index
  end

  def show
    @Report = Report.find(params[:id])
  end

  def create
    @Report = Report.new(Report_params)

    if(@Report.save)
      redirect_to @Report
    else
      render 'new'
    end
  end

  private def Report_params
    params.require(:Report).permit(:title, :description)
  end
end
