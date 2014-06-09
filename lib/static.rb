require 'sinatra/base'

class Static < Sinatra::Base
  #
  # General paths
  #
  get '/' do
    @questions = Question.paginated(params)
    haml :'questions/index', layout: :'layouts/application'
  end

  get '/404' do
    haml :'404'
  end

  get '/about' do
    @page_title = 'Ayuda con OmbuShop'
    haml :about, layout: :'layouts/application'
  end

  get '/preguntas' do
    @questions = Question.paginated(params)
    haml :'questions/index', layout: :'layouts/application'
  end

  get '/preguntas/search' do
    @query = params[:q]
    flash[:notice] = t(:searching_for, q: @query)

    @questions = Question.full_text_search(@query, params)
    haml :'questions/index', layout: :'layouts/application'
  end

  get %r{/preguntas/(.*)} do |permalink|
    @question = find_question(permalink)
    @description = @question.description
    @keywords = @question.keywords
    haml :'questions/show', layout: :'layouts/application'
  end

  get '/stylesheets/:name.css' do
    content_type 'text/css', :charset => 'utf-8'
    scss(:"stylesheets/#{params[:name]}", Compass.sass_engine_options)
  end

  get '/tags' do
    @tags = Tag.all

    haml :'tags/index', layout: :'layouts/application'
  end

  get '/tags/:permalink' do |permalink|
    @tag = find_tag(permalink)
    @questions = Question.paginated(dataset: @tag.questions_dataset)

    haml :'tags/show', layout: :'layouts/application'
  end
end
