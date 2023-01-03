	require 'sinatra'
	get "/" do
	content_type 'html'
	erb :index
end
get "/tasks" do
    @tasks = Task.all
    @tasks.to_json
end
post "/tasks/new" do
    @task = Task.new
    @task.complete = false
    @task.description = params[:description]
    @task.created_at = DateTime.now
    @task.updated_at = null
end
put "/tasks/:id" do
    @task = Task.find(params[:id])
    @task.complete = params[:complete]
    @task.description = params[:description]
    @task.updated_at = DateTime.now
    if @task.save
        {:task => @task, :status => "success"}.to_json
    else
        {:task => @task, :status => "failure"}.to_json
    end
end
delete "/tasks/:id" do
    @task = Task.find(params[:id])
    if @task.destroy
        {:task => @task, :status => "success"}.to_json
    else
        {:task => @task, :status => "failure"}.to_json
    end
end
