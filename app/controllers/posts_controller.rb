require "blog"

class PostsController < ApplicationController
  def index
    posts = Blog.list_posts(store)
    render :index, locals: { posts: posts }
  end

  def new
    form = Blog.new_post_form
    render locals: { form: form }
  end

  def create
    status = Blog.create_post(params, store)

    if status.success?
      redirect_to posts_path
    else
      render :new, locals: { form: status.form }
    end
  end

  def show
    post = Blog.get_post(params[:id], store)
    render locals: { post: post }
  end

  def edit
    form = Blog.edit_post_form(params[:id], store)
    render locals: { form: form, post_id: params[:id] }
  end

  def update
    status = Blog.update_post(params[:id], params, store)

    if status.success?
      redirect_to posts_path
    else
      render :edit, locals: { form: status.form, post_id: params[:id] }
    end
  end

  def destroy
    Blog.delete_post(params[:id], store)
    redirect_to posts_path
  end

  private

  def store
    BlogStore
  end
end
