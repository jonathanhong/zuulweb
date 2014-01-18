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

  def checkout
    begin
      g = Git.open('/home/combscat/public_html/zuul')
      exists = false
      g.branches.each do |branch|
        if branch.name == params[:branch]
          exists = true
          break
        end
      end 
      g.checkout params[:branch] if exists
      FileUtils.touch('/home/combscat/public_html/zuul/tmp/restart.txt') if exists
      @success = exists
      @message = exists ? "Successfuly checked out branch '#{params[:branch]}'." : "Branch '#{params[:branch]}' was not found."
    rescue Exception => e
      @success = false
      @message = e.message
      #TODO: Error log? (e.backtrace.inspect)
    end
  end
end
