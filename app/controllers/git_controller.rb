require 'cgi'
require 'json'
require 'git'
require 'fileutils'

class GitController < ApplicationController

  protect_from_forgery :secret => 'its_a_secret',  
                       :except => :deploy

  def deploy
    log = Logger.new(open("#{ENV['ZUUL']}/log/deploy.log", 'a'))
    log.info('Deploying application')
    begin
      log.info('Recieved payload')
      github_json = JSON.parse(params[:payload])
      #Ensure this is a GitHub post thing
      repo = github_json['repository']
      if repo['private'] == true and repo['name'] == 'zuulweb' and repo['language'] == 'Ruby'
        log.info('Payload is authentic')
	log.info('Pulling remote branches...')
        cmd = 'for remote in `git branch -r`; do git branch --track $remote; done'
        `#{cmd}`
        #`git fetch --all`
        `git pull --all`
	log.info('Restarting application...')
        FileUtils.touch("#{ENV['ZUUL']}/tmp/restart.txt")
	log.info('Deployed')
        head :ok, :content_type => 'text/plain'
      else
        log.error('Payload is NOT authentic')
        redirect_to request.host
      end
    rescue Exception => e
      log.fatal("ERROR: #{e.message}")
    end
  end

  def branches
    begin
      g = Git.open(ENV['ZUUL'])
      @branches = g.branches
      @branches = @branches.select { |branch| not branch.name.to_s.include?('/') or not branch.name.to_s.include?('/')}
    rescue Exception
      @branches = []
    end
  end

  def checkout
    log = Logger.new(open("#{ENV['ZUUL']}/log/deploy.log", 'a'))
    begin
      log.info("Attempting to checkout changes on branch #{params[:branch]}")
      g = Git.open(ENV['ZUUL'])
      exists = false
      g.branches.each do |branch|
        if branch.name == params[:branch]
          exists = true
          break
        end
      end
      log.fatal("ERROR: Branch '#{params[:branch]}' does not exist and cannot be checked out") unless exists
      if exists
        g.checkout params[:branch]
	log.info('Pulling remote changes...')
	`git pull origin #{params[:branch]}`
        log.info('Restarting application...')
        FileUtils.touch("#{ENV['ZUUL']}/tmp/restart.txt")
	log.info("Successfully checked out changes on branch #{params[:branch]}")
        @success = exists
      end
      @message = exists ? "Successfuly checked out branch '#{params[:branch]}'." : "Branch '#{params[:branch]}' was not found."
    rescue Exception => e
      @success = false
      @message = e.message
      log.fatal("ERROR: #{e.message}")
    end
  end
end
