class ChecksumsController < ApplicationController
  def new
    @checksum = Checksum.new
  end

  def create
    @checksum = Checksum.new checksum_params.fetch(:original, '')

    respond_to do |format|
      format.json
    end
  end

  private

  def checksum_params
    params.require(:checksum).permit(:original)
  end
end
