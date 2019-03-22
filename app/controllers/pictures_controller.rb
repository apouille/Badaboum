class PicturesController < ApplicationController

	def create

      @product = Product.find(params[:product_id])
      @product.pictures.attach(params[:pictures])
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js {render layout: false}
    end
	end

	def destroy
		@picture = ActiveStorage::Attachment.find(params[:product_id])
		@product = @picture.record
  	@picture.purge
  	respond_to do |format|
      format.js {render layout: false}
    end
	end
end
