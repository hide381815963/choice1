require 'rubygems'
require 'sinatra'

require 'haml'
require 'sqlite3'

require 'json'
db = SQLite3::Database.new("data.db")

get '/name' do
    #f = open("./public/list.txt","r")
    #name = f.read
    sql = "SELECT id,name FROM names ORDER BY RANDOM() limit 3;"
    data = db.query sql
    arr = data.to_a
    #p arr.class
    #name = arr.to_s.chomp
    #p name
    @name = arr
    haml :name
end

get '/name/none' do

    sql = "update names set favorite_flag = 0 where id = #{params};"
    p sql
    #data = db.query sql
end

get '/' do
  'Hello world!'
end

get '/index' do
  @title = "It's work."
  haml :index
end

put '/upload' do
  "Hello World"
    if params[:file]
      begin
        #new_filename = DateTime.now.strftime('%s') + File.extname(params[:file][:filename])
        new_filename = Time.now.strftime("%Y%m%d%H%M%S") + File.extname(params[:file][:filename])
        save_file = './public/files/' + new_filename
        File.open(save_file, 'wb'){ |f| f.write(params[:file][:tempfile].read) }
        sql = "insert into files values (?,?)"
        db.execute(sql,save_file.to_s,Date.today.to_s)
        @title = 'upload completed!'
        haml :finish
      rescue
        'error'
      ensure
      end
    else
      :file
      'no way'
    end
end

get '/tree' do
  @title = "It's tree sample."
  @folder = ["abc","def","ghi"]
  haml :tree
end


put '/csv' do
  if params[:file]
    #@csv = params[:file][:tempfile]
    f = params[:file][:tempfile]
    p @csv
    haml :csv
  end
end
