class ArticlesController < ApplicationController
	before_action :set_article, only: [:show, :edit, :destroy, :update]

	def show
	end

	def index
		@articles = Article.all
	end

	def new 
		@article = Article.new
	end

	def create
		@article = Article.new(article_params)
		@article = User.first

		if @article.save
			# must to enable flash in application.html.erb to view flash message
			flash[:notice] = "Article was successfully created."

			# displays the 'show' page of the new article
			redirect_to @article

		else
			# refreshes the 'new' screen
			render 'new'
		end
	end

	def edit
	end

	def update
		if @article.update(article_params)
			flash[:notice] = "Article was successfully updated."
			redirect_to @article
		else
			render 'edit'
		end
	end

	def destroy
		@article.destroy
		redirect_to articles_path
	end


	private

	def set_article
		@article = Article.find(params[:id])
	end

	def article_params
		params.require(:article).permit(:title, :description)
	end
end