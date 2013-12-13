require 'cgi'
require 'json'
require 'git'

cgi = CGI.new
begin
  github_json = JSON.parse(cgi.params['payload'])
  #Ensure this is a GitHub post thing
  repo = github_json['repository']
  if repo['private'] == true and repo['name'] == 'zuulweb' and repo['language'] == 'Ruby'
    g = Git.open('/home/combscat/public_html/zuul', :log => Logger.new(File.open('deploy.log', 'a')))
    g.pull
  else
    raise Exception.new
  end
rescue Exception
  #TODO: Error log?
end
