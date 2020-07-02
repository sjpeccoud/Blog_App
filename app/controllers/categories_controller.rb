class CategoriesController < ApplicationController
	before_action :set_category, only: [:new]

	def new

	end

	def create
		@category = Category.new(category_params)
		if @category.save
			flash[:notice] = "Category was successfully created"
			redirect_to @category
		else
			render 'new'
		end
	end

	def index

	end

	private

	def set_category
		@category = Category.new
	end

	def category_params
		params.require(:category).permit(:name)
	end
end