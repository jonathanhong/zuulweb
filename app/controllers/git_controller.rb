require 'cgi'
require 'json'
require 'git'
require 'fileutils'

class GitController < ApplicationController

  protect_from_forgery :secret => 'its_a_secret',  
                       :except => :deploy

  def deploy
    begin
      github_json = JSON.parse(params[:payload])
      #Ensure this is a GitHub post thing
      repo = github_json['repository']
      if repo['private'] == true and repo['name'] == 'zuulweb' and repo['language'] == 'Ruby'
        g = Git.open('/home/combscat/public_html/zuul', :log => Logger.new(File.open('/home/combscat/deploy.log', 'a')))
        g.pull
        FileUtils.touch('/home/combscat/public_html/zuul/tmp/restart.txt')
        head :ok, :content_type => 'text/plain'
      else
        redirect_to request.host
      end
    rescue Exception
      #TODO: Error log?
    end
  end
end
