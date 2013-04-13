$ ->
  
  type2action = (entry) ->
    entry.action = switch entry.type.replace(/Event$/, '')
      when "CommitComment"
        "commented on a commit"
      when "Create"
        "created a repo"
      when "Delete"
        "deleted a repo"
      when "Download"
        "downloaded something"
      when "Follow"
        "followed someone"
      when "Fork"
        "forked a repo"
      when "ForkApply"
        "applied a fork"
      when "Gist"
        "manipulated a gist"
      when "Gollum"
        "caressed his precious"
      when "IssueComment"
        "commented on an issue"
      when "Issues"
        "did something with an issue"
      when "Member"
        "did something with a team"
      when "Public"
        "did something public"
      when "PullRequest"
        "did something with a pull request"
      when "PullRequestReviewComment"
        "commented on a pull request"
      when "Push"
        "pushed to a repo"
      when "TeamAdd"
        "joined a team"
      when "Watch"
        "started to watch something"
    
    return entry
  
  
  entryModel = Handlebars.compile $("#entry-model").html()
  $.get "github.json", (feed) ->
    for entry in feed
      entry = type2action entry
      $("#feed").prepend entryModel entry
    
    $("time").timeago()
    $("time").each (i,t) ->
      $(t).attr "title", $(t).attr "datetime"
    return
  return
    
