class ArticlesController < ApplicationController

	def show
		@article = Article.find(params[:id])
	end

	def index
		@articles = Article.all
	end

	def new 
		@article = Article.new
	end

	def create
		@article = Article.new(params.require(:article).permit(:title, :description))

		if @article.save
			# must to enable flash in application.html.erb to view flash message
			flash[:notice] = "Article was successfully created."

			# displays the 'show' page of the new article
			redirect_to @article
			
		else
			render 'new'
		end
	end
end