class PicturesController < ApplicationController
	def destroy
		@picture = ActiveStorage::Attachment.find(params[:id])
		@product = @picture.record
  	@picture.purge
  	respond_to do |format|
      format.js {render layout: false}
    end
	end
end
