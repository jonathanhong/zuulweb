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
        cmd = 'for remote in `git branch -r`; do git branch --track $remote; done'
        `#{cmd}`
        #`git fetch --all`
        `git pull --all`
        FileUtils.touch("#{ENV['ZUUL']}/tmp/restart.txt")
        head :ok, :content_type => 'text/plain'
      else
        redirect_to request.host
      end
    rescue Exception
      #TODO: Error log?
    end
  end

  def branches
    begin
      g = Git.open(ENV['ZUUL'])
      @branches = g.branches
    rescue Exception
      @branches = []
      #TODO: Error log?
    end
  end

  def checkout
    begin
      g = Git.open(ENV['ZUUL'])
      exists = false
      g.branches.each do |branch|
        if branch.name == params[:branch]
          exists = true
          break
        end
      end 
      g.checkout params[:branch] if exists
      FileUtils.touch("#{ENV['ZUUL']}/tmp/restart.txt") if exists
      @success = exists
      @message = exists ? "Successfuly checked out branch '#{params[:branch]}'." : "Branch '#{params[:branch]}' was not found."
    rescue Exception => e
      @success = false
      @message = e.message
      #TODO: Error log? (e.backtrace.inspect)
    end
  end
end
