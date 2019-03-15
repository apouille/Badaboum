class PicturesController < ApplicationController
	def create
		puts "*"*100
		puts params
		puts "*"*100
    if (params[:pictures]) != nil
      @product = Product.find(params[:product_id])
      @product.pictures.attach(params[:pictures])
    end
    redirect_to root_path
    # respond_to do |format|
    #   format.js {render layout: false}
    # end
	end

	def destroy
		puts "*"*100
		puts params
		puts "*"*100
		@picture = ActiveStorage::Attachment.find(params[:product_id])
		@product = @picture.record
  	@picture.purge
  	respond_to do |format|
      format.js {render layout: false}
    end
	end
end
